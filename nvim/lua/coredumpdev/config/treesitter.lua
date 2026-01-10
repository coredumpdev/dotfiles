local config = require('nvim-treesitter')
config.setup({
  ensure_installed = { "lua", "javascript", "bash" },
  highlight = { enable = true },
  indent = { enable = true }
})
