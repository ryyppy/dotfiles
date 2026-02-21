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

      local function get_pi_panes()
        -- List panes running pi (detected by π in pane title)
        local output = vim.fn.system([[
          tmux list-panes -s -F '#{pane_id}|#{session_name}|#{window_index}.#{pane_index}|#{pane_current_path}|#{pane_title}'
        ]])
        local panes = {}
        for line in output:gmatch('[^\n]+') do
          local id, session, pane_idx, path, title = line:match('([^|]+)|([^|]+)|([^|]+)|([^|]+)|([^|]*)')
          -- Detect pi by π symbol in pane title
          if id and title and title:find('π') then
            -- Shorten path: ~/Projects/foo/bar -> foo/bar
            local short_path = path:gsub('^/Users/[^/]+/Projects/', ''):gsub('^/Users/[^/]+/', '~/')
            table.insert(panes, {
              id = id,
              session = session,
              pane_idx = pane_idx,
              path = path,
              title = title,
              display = string.format('[%s:%s] %s (%s)', session, pane_idx, title, short_path),
            })
          end
        end
        return panes
      end

      local function send_to_pane(pane_id, text, no_enter)
        -- Use temp file and bracketed paste mode (-p) so newlines aren't interpreted as Enter
        local tmpfile = os.tmpname()
        vim.fn.writefile(vim.split(text, '\n'), tmpfile)
        vim.fn.system(string.format('tmux load-buffer %s', tmpfile))
        vim.fn.system(string.format('tmux paste-buffer -p -t %s', pane_id))
        if not no_enter then
          vim.fn.system(string.format('tmux send-keys -t %s Enter', pane_id))
        end
        os.remove(tmpfile)
      end

      local function send_to_pi(text, no_enter)
        local panes = get_pi_panes()

        if #panes == 0 then
          vim.notify('No pi sessions found', vim.log.levels.WARN)
          return
        end

        local action_word = no_enter and 'Appended to ' or 'Sent to '

        if #panes == 1 then
          -- Only one pi session, send directly
          send_to_pane(panes[1].id, text, no_enter)
          vim.notify(action_word .. panes[1].title, vim.log.levels.INFO)
          return
        end

        -- Multiple sessions: show picker
        pickers.new({}, {
          prompt_title = 'Select pi session',
          finder = finders.new_table({
            results = panes,
            entry_maker = function(entry)
              return { value = entry, display = entry.display, ordinal = entry.display }
            end,
          }),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              send_to_pane(selection.value.id, text, no_enter)
              vim.notify(action_word .. selection.value.title, vim.log.levels.INFO)
            end)
            return true
          end,
        }):find()
      end

      -- Get file context (filename, lines)
      local function get_file_context(line_start, line_end)
        local filename = vim.fn.expand('%:~')  -- relative to home
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
        local line_start = vim.fn.line("'<")
        local line_end = vim.fn.line("'>")
        local selection = vim.fn.getreg('v')
        local file_ctx = get_file_context(line_start, line_end)
        local filetype = vim.bo.filetype
        local text = file_ctx .. '\n```' .. filetype .. '\n' .. selection .. '```'
        send_to_pi(text)
      end, { desc = 'Send selection to pi' })

      -- Send visual selection with prompt context
      vim.keymap.set('v', '<leader>pp', function()
        -- Exit visual mode first to set marks, then get lines
        vim.cmd('normal! "vy')
        local line_start = vim.fn.line("'<")
        local line_end = vim.fn.line("'>")
        local selection = vim.fn.getreg('v')
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

      -- Send current line
      vim.keymap.set('n', '<leader>ps', function()
        local line = vim.api.nvim_get_current_line()
        local line_nr = vim.fn.line('.')
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
        local line_start = vim.fn.line("'<")
        local line_end = vim.fn.line("'>")
        local selection = vim.fn.getreg('v')
        local file_ctx = get_file_context(line_start, line_end)
        local filetype = vim.bo.filetype
        -- Leading newlines for nicer formatting when appending
        local text = '\n\n' .. file_ctx .. '\n```' .. filetype .. '\n' .. selection .. '```'
        send_to_pi(text, true)
      end, { desc = 'Append selection to pi input' })
    end,
  },
}
