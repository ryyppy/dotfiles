return {
  {
    'pi-send',
    virtual = true,
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
      local pickers = require('telescope.pickers')
      local finders = require('telescope.finders')
      local actions = require('telescope.actions')
      local action_state = require('telescope.actions.state')
      local conf = require('telescope.config').values

      local function shorten_path(path)
        return (path or ''):gsub('^/Users/[^/]+/Projects/', ''):gsub('^/Users/[^/]+/', '~/')
      end

      local function has_herdr()
        return vim.env.HERDR_ENV == '1' and vim.env.HERDR_PANE_ID ~= nil and vim.fn.executable 'herdr' == 1
      end

      local function has_tmux()
        return vim.env.TMUX ~= nil and vim.fn.executable 'tmux' == 1
      end

      local function run(args)
        local result = vim.system(args, { text = true }):wait()
        if result.code ~= 0 then
          local message = vim.trim(result.stderr or result.stdout or '')
          if message == '' then
            message = table.concat(args, ' ') .. ' failed with exit code ' .. result.code
          end
          return false, message
        end
        return true, result.stdout or ''
      end

      local function get_herdr_pi_agents()
        if not has_herdr() then
          return {}
        end

        local ok, output = run { 'herdr', 'agent', 'list' }
        if not ok then
          vim.notify('Failed to list Herdr agents: ' .. output, vim.log.levels.WARN)
          return {}
        end

        local decoded_ok, decoded = pcall(vim.json.decode, output)
        if not decoded_ok then
          vim.notify('Failed to parse Herdr agent list', vim.log.levels.WARN)
          return {}
        end

        local agents = vim.tbl_get(decoded, 'result', 'agents') or {}
        local targets = {}
        for _, agent in ipairs(agents) do
          if agent.agent == 'pi' and agent.pane_id then
            local title = agent.terminal_title_stripped or agent.terminal_title or 'pi'
            local path = agent.foreground_cwd or agent.cwd or ''
            local status = agent.agent_status or 'unknown'
            table.insert(targets, {
              backend = 'herdr',
              id = agent.pane_id,
              path = path,
              title = title,
              status = status,
              display = string.format('[herdr:%s] %s [%s] (%s)', agent.pane_id, title, status, shorten_path(path)),
            })
          end
        end

        return targets
      end

      local function get_tmux_pi_panes()
        if not has_tmux() then
          return {}
        end

        -- List panes running pi (detected by π in pane title)
        local ok, output = run {
          'tmux',
          'list-panes',
          '-s',
          '-F',
          '#{pane_id}|#{session_name}|#{window_index}.#{pane_index}|#{pane_current_path}|#{pane_title}',
        }
        if not ok then
          vim.notify('Failed to list tmux panes: ' .. output, vim.log.levels.WARN)
          return {}
        end

        local targets = {}
        for line in output:gmatch('[^\n]+') do
          local id, session, pane_idx, path, title = line:match('([^|]+)|([^|]+)|([^|]+)|([^|]+)|([^|]*)')
          -- Detect pi by π symbol in pane title
          if id and title and title:find('π') then
            table.insert(targets, {
              backend = 'tmux',
              id = id,
              session = session,
              pane_idx = pane_idx,
              path = path,
              title = title,
              display = string.format('[tmux:%s:%s] %s (%s)', session, pane_idx, title, shorten_path(path)),
            })
          end
        end

        return targets
      end

      local function get_pi_targets()
        local targets = {}

        -- Prefer Herdr when Neovim is running inside a Herdr-managed pane, but
        -- keep tmux as a fallback/secondary backend for non-Herdr sessions.
        vim.list_extend(targets, get_herdr_pi_agents())
        vim.list_extend(targets, get_tmux_pi_panes())

        return targets
      end

      local function send_to_tmux_pane(pane_id, text, no_enter)
        -- Use temp file and bracketed paste mode (-p) so newlines aren't interpreted as Enter
        local tmpfile = os.tmpname()
        vim.fn.writefile(vim.split(text, '\n'), tmpfile)

        local ok, err = run { 'tmux', 'load-buffer', tmpfile }
        if ok then
          ok, err = run { 'tmux', 'paste-buffer', '-p', '-t', pane_id }
        end
        if ok and not no_enter then
          ok, err = run { 'tmux', 'send-keys', '-t', pane_id, 'Enter' }
        end

        os.remove(tmpfile)
        return ok, err
      end

      local function send_to_herdr_agent(pane_id, text, no_enter)
        if no_enter then
          return run { 'herdr', 'pane', 'send-text', pane_id, text }
        end

        return run { 'herdr', 'agent', 'prompt', pane_id, text }
      end

      local function send_to_target(target, text, no_enter)
        if target.backend == 'herdr' then
          return send_to_herdr_agent(target.id, text, no_enter)
        elseif target.backend == 'tmux' then
          return send_to_tmux_pane(target.id, text, no_enter)
        end

        return false, 'Unknown Pi target backend: ' .. tostring(target.backend)
      end

      local function send_to_pi(text, no_enter)
        local targets = get_pi_targets()

        if #targets == 0 then
          vim.notify('No pi sessions found', vim.log.levels.WARN)
          return
        end

        local action_word = no_enter and 'Appended to ' or 'Sent to '

        local function send_and_notify(target)
          local ok, err = send_to_target(target, text, no_enter)
          if ok then
            vim.notify(action_word .. target.title, vim.log.levels.INFO)
          else
            vim.notify('Failed to send to ' .. target.title .. ': ' .. err, vim.log.levels.ERROR)
          end
        end

        if #targets == 1 then
          -- Only one pi session, send directly
          send_and_notify(targets[1])
          return
        end

        -- Multiple sessions: show picker
        pickers.new({}, {
          prompt_title = 'Select pi session',
          finder = finders.new_table({
            results = targets,
            entry_maker = function(entry)
              return { value = entry, display = entry.display, ordinal = entry.display }
            end,
          }),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              send_and_notify(selection.value)
            end)
            return true
          end,
        }):find()
      end

      -- Get file context (filename, lines)
      local function get_file_context(line_start, line_end)
        local filename = vim.fn.expand('%:~') -- relative to home
        if line_start == line_end then
          return string.format('%s:%d', filename, line_start)
        else
          return string.format('%s:%d-%d', filename, line_start, line_end)
        end
      end

      -- Send visual selection
      vim.keymap.set('v', '<leader>ps', function()
        -- Exit visual mode first to set marks, then get lines
        vim.cmd('normal! "vy')
        local line_start = vim.fn.line "'<"
        local line_end = vim.fn.line "'>"
        local selection = vim.fn.getreg 'v'
        local file_ctx = get_file_context(line_start, line_end)
        local filetype = vim.bo.filetype
        local text = file_ctx .. '\n```' .. filetype .. '\n' .. selection .. '```'
        send_to_pi(text)
      end, { desc = 'Send selection to pi' })

      -- Send visual selection with prompt context
      vim.keymap.set('v', '<leader>pp', function()
        -- Exit visual mode first to set marks, then get lines
        vim.cmd('normal! "vy')
        local line_start = vim.fn.line "'<"
        local line_end = vim.fn.line "'>"
        local selection = vim.fn.getreg 'v'
        local file_ctx = get_file_context(line_start, line_end)
        local filetype = vim.bo.filetype

        -- Capture everything before async input
        vim.ui.input({ prompt = 'Context: ' }, function(input)
          if input and input ~= '' then
            local text = input .. '\n\n' .. file_ctx .. '\n```' .. filetype .. '\n' .. selection .. '\n```'
            send_to_pi(text)
          end
        end)
      end, { desc = 'Send selection to pi with prompt' })

      -- Send current line with prompt context
      vim.keymap.set('n', '<leader>pp', function()
        local line = vim.api.nvim_get_current_line()
        local line_nr = vim.fn.line '.'
        local file_ctx = get_file_context(line_nr, line_nr)
        local filetype = vim.bo.filetype

        vim.ui.input({ prompt = 'Context: ' }, function(input)
          if input and input ~= '' then
            local text = input .. '\n\n' .. file_ctx .. '\n```' .. filetype .. '\n' .. line .. '\n```'
            send_to_pi(text)
          end
        end)
      end, { desc = 'Send current line to pi with prompt' })

      -- Send current line
      vim.keymap.set('n', '<leader>ps', function()
        local line = vim.api.nvim_get_current_line()
        local line_nr = vim.fn.line '.'
        local file_ctx = get_file_context(line_nr, line_nr)
        local text = file_ctx .. '\n```' .. vim.bo.filetype .. '\n' .. line .. '\n```'
        send_to_pi(text)
      end, { desc = 'Send line to pi' })

      -- Send whole buffer
      vim.keymap.set('n', '<leader>pS', function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        send_to_pi(table.concat(lines, '\n'))
      end, { desc = 'Send buffer to pi' })

      -- Append visual selection (no Enter)
      vim.keymap.set('v', '<leader>pa', function()
        vim.cmd('normal! "vy')
        local line_start = vim.fn.line "'<"
        local line_end = vim.fn.line "'>"
        local selection = vim.fn.getreg 'v'
        local file_ctx = get_file_context(line_start, line_end)
        local filetype = vim.bo.filetype
        -- Leading newlines for nicer formatting when appending
        local text = '\n\n' .. file_ctx .. '\n```' .. filetype .. '\n' .. selection .. '```'
        send_to_pi(text, true)
      end, { desc = 'Append selection to pi input' })
    end,
  },
}
