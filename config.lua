-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.plugins = {
  "EdenEast/nightfox.nvim",
  "rebelot/kanagawa.nvim",
  "ChristianChiarulli/swenv.nvim",
  "stevearc/dressing.nvim",
  "mfussenegger/nvim-dap-python",
  "Mofiqul/vscode.nvim",
  "catppuccin/nvim",
  "craftzdog/solarized-osaka.nvim",
  "rose-pine/neovim",
  "bluz71/vim-nightfly-colors"
}

vim.opt.relativenumber = false
vim.o.background = "dark"
lvim.colorscheme = "vscode"

require("catppuccin").setup({
  flavour = "mocha", -- latte, frappe, macchiato, mocha
  background = { -- :h background
    light = "latte",
    dark = "mocha",
  },
  transparent_background = false, -- disables setting the background color.
  show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  dim_inactive = {
    enabled = false, -- dims the background color of inactive window
    shade = "dark",
    percentage = 0.15, -- percentage of the shade to apply to the inactive window
  },
  no_italic = false, -- Force no italic
  no_bold = false, -- Force no bold
  no_underline = false, -- Force no underline
  styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
    comments = { "italic" }, -- Change the style of comments
    conditionals = { "italic" },
    loops = {},
    functions = {},
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {
    mocha = {
      base = "#000000"
    },
  },
  custom_highlights = {},
  integrations = {
    cmp = true,
    gitsigns = true,
    nvimtree = true,
    treesitter = true,
    notify = false,
    mini = {
      enabled = true,
      indentscope_color = "",
    },
  },
})

require('nightfox').setup({
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    }
  }
})

lvim.keys.normal_mode['<F2>'] = ":bprevious<CR>"
lvim.keys.normal_mode['<F3>'] = ":bnext<CR>"
lvim.keys.normal_mode['<F4>'] = ":BufferKill<CR>"

-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup{{name = "black"},}
lvim.format_on_save.pattern = {"*.tsx", "*.html", "*.css", "*.sh", "*.sql", "*.cpp", "*.c"}

-- 2 indent for python
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.tsx", "*.html", "*.css", "*.sh", "*.sql", "*.cpp", "*.c" },
  command = "setlocal tabstop=2 shiftwidth=2"
})

-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}
