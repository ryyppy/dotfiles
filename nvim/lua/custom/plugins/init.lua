-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'prisma/vim-prisma' },
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      local ctx = require 'treesitter-context'
      ctx.setup { max_lines = 3 }

      vim.keymap.set('n', '<leader>tc', function()
        ctx.toggle()
        vim.notify('Treesitter context ' .. (ctx.enabled() and 'enabled' or 'disabled'))
      end, { desc = '[T]oggle [C]ontext' })

      vim.keymap.set('n', '[c', function()
        ctx.go_to_context(vim.v.count1)
      end, { desc = 'Jump to context' })
    end,
  },
}
