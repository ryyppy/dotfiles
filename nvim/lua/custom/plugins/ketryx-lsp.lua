return {
  {
    'ketryx-lsp',
    virtual = true,
    config = function()
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'markdown', 'cucumber', 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
        callback = function()
          local root = vim.fs.find('ketryx.json', { upward = true })[1]
          if root then
            vim.lsp.start({
              name = 'ketryx',
              cmd = { 'ketryx', 'lsp' },
              root_dir = vim.fs.dirname(root),
            })
          end
        end,
      })
    end,
  },
}
