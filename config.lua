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
  "bluz71/vim-nightfly-colors",
  "altercation/vim-colors-solarized",
  "olivercederborg/poimandres.nvim"
}

-- hopefully fixes the explorer problem
local function open_nvim_tree()
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
vim.api.nvim_set_keymap('n', '<Leader>e', ":lua require'nvim-tree'.focus()<CR>", { noremap = true, silent = true })

vim.opt.relativenumber = false
vim.o.background = "dark"
lvim.colorscheme = "poimandres"

require('nightfox').setup({
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    }
  }
})

-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup{{name = "black"},}
lvim.format_on_save.pattern = { "*.tsx", "*.html", "*.css", "*.sh", "*.sql", "*.cpp", "*.c"}

-- 2 indent for frontend 
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.py", "*.tsx", "*.html", "*.css", "*.sh", "*.sql", "*.cpp", "*.c" },
  command = "setlocal tabstop=2 shiftwidth=2"
})

-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

-- Define the key mappings for <F2>, <F3>, and <F4>
lvim.keys.normal_mode["<F2>"] =  ":bprevious<CR>"
lvim.keys.normal_mode["<F3>"] =  ":bnext<CR>"
lvim.keys.normal_mode["<F4>"] =  ":bd<CR>"

-- Indentation using leader[ and leader]
lvim.keys.normal_mode["<leader>["] = "<<"
lvim.keys.normal_mode["<leader>]"] = ">>"
lvim.keys.visual_mode["<leader>["] = "<gv"
lvim.keys.visual_mode["<leader>]"] = ">gv"

-- Define custom key mappings for splitting horizontally and vertically
lvim.keys.normal_mode["<Leader>-"] = ":split<CR>"
lvim.keys.normal_mode["<Leader>|"] = ":vsplit<CR>"

-- Move between split windows using leader key + arrow keys
lvim.keys.normal_mode["<Leader><Up>"] = "<C-w>k"
lvim.keys.normal_mode["<Leader><Down>"] = "<C-w>j"
lvim.keys.normal_mode["<Leader><Left>"] = "<C-w>h"
lvim.keys.normal_mode["<Leader><Right>"] = "<C-w>l"
