
-- vim.cmd("set expandtab")       -- Use spaces instead of tabs
vim.cmd("set textwidth=80")
vim.cmd("set tabstop=4")       -- Tabs count as 4 columns visually
vim.cmd("set shiftwidth=4")    -- Indent by 4 spaces
vim.cmd("set autoindent")

vim.g.mapleader = " "
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.opt.clipboard = "unnamedplus"


-- Setup lazy.nvim
require("lazy").setup("plugins")


vim.keymap.set('n', '<C-n>', ':Neotree<CR>')

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "javascript", "html", "c"},
  highlight = { enable = true },
  indent = { enable = true },  
})
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"
require('lualine').setup {
	options = {
		    theme = 'dracula'
		},
}


local function format_c_file()
  -- Run clang-format with your config file
  local file = vim.fn.expand("%:p") -- full path of current file
  local cmd = string.format("clang-format -i --style=file %s", file)
  vim.fn.system(cmd)

  -- Reload buffer after formatting
  vim.cmd("edit!")
end

-- Create a command you can run manually
vim.api.nvim_create_user_command("ClangFormat", format_c_file, {})
