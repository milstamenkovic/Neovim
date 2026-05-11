-- Mil Stamenković Neovim init.lua
-- Repo: https://github.com/milstamenkovic/neovim
-- Created: 03h01'00'' - 03.05.2026. - Ćuprija, Serbia - Mil Stamenković
-- Revised: 01h41'03'' - 11.05.2026. - Ćuprija, Serbia - Mil Stamenković






-- FORCE SYNTAC COLOR - FORCE READ WHOLE FILE - FIX SYNTAX BREAKING
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.html", "*.css", "*.js", "*.lua" },
  command = "syntax sync fromstart",
})





-- 24-bit COLORS
-- (This goes before themes and colors)
vim.opt.termguicolors = true

-- SYNTAX COLORING
vim.cmd("syntax on")
vim.cmd('filetype on')




-- CURSOR - BLOCK CURSOR
vim.opt.guicursor = "n-c-i:block-blinkon0,v-ve:ver20-blinkon0"



-- VSPLIT TO RIGHT
vim.opt.splitright = true
-- SPLIT TO RIGHT AND BELOW
vim.opt.splitbelow = true



-- TAB SPACES
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- LINE NUMBERING
vim.opt.number = true

-- TIME AND DATE
function _G.get_datetime()
  return os.date('%Hh%M\' - %d.%m.%Y.')
end

-- NOTE LEFT PADDING
vim.opt.foldcolumn = '4'
vim.opt.signcolumn = 'yes:4'

-- WORDWRAP
vim.opt.wrap = true
vim.opt.linebreak = true




-- DISABLE NETRW
-- Required by nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1



-- STATUS LINE
-- vim.opt.statusline = " %t %m %= line %l / %L (%p%%) [%{v:lua.get_datetime()}] "
-- vim.opt.laststatus = 3







-- POWERSHELL 7+
vim.opt.shell = [["C:/Program Files/WindowsApps/Microsoft.PowerShell_7.6.1.0_x64__8wekyb3d8bbwe/pwsh.exe"]]
vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command"
vim.opt.shellquote = ""
vim.opt.shellxquote = ""
vim.opt.shellpipe = "| Out-File -Encoding UTF8 %s"
vim.opt.shellredir = "| Out-File -Encoding UTF8 %s"













-- LAZY.NVIM
-- LAZY.NVIM
-- LAZY.NVIM
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- PLUGINS
-- PLUGINS
-- PLUGINS
require("lazy").setup({
  -- TELESCOPE
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
			require('telescope').setup()
    end,
  },
	-- NEOVIM-PROJECT
	{
		"coffebar/neovim-project",
		opts = {
		projects = (function()
  		local data = vim.fn.stdpath("data")
  		local ok, paths = pcall(dofile, data .. "/neovim-project/projects-paths.lua")
  		return ok and paths or {}
		end)(),
		picker = {
			type = "telescope", -- one of "telescope", "fzf-lua", or "snacks"
			},
		},
		init = function()
			-- enable saving the state of plugins in the session
			vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
		end,
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			-- optional picker
			{ "nvim-telescope/telescope.nvim" },
			-- optional picker
			{ "ibhagwan/fzf-lua" },
			-- optional picker
			{ "folke/snacks.nvim" },
			{ "Shatur/neovim-session-manager" },
		},
		lazy = false,
		priority = 100,
	},
  -- NVIM-TREE
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        on_attach = my_on_attach,
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        tab = {
          sync = {
            open = true,
            close = true,
          },
        },
				view = {
					width = "20%",
					side = left,
				},
      })
    end,
  },
	-- GITSIGNS
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
    end
  },
  -- NEOGIT
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true
  },
  -- AUTO-PAIRS
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
  },
  -- AUTO-TAGS
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
	-- LUALINE
	{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                    refresh_time = 16,
                    events = {
                        'WinEnter', 'BufEnter', 'BufWritePost', 'SessionLoadPost',
                        'FileChangedShellPost', 'VimResized', 'Filetype', 
                        'CursorMoved', 'CursorMovedI', 'ModeChanged',
                    },
                },
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location', get_datetime}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        })
    end
	},
	-- THEMES
	-- TOKYONIGHT THEMES
	{
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  {
	  "nyoom-engineering/oxocarbon.nvim"
  -- Add in any other configuration; 
  --   event = foo, 
  --   config = bar
  --   end,
	},
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
		lazy = false,
		priority = 1000
	}
})















-- NVIM-TREE 
-- Toggle NVIM.TREE  Keybind Tt
vim.keymap.set('n', 'Tt', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Nvim.tree
local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
	-- Apply defauly mappings
  api.config.mappings.default_on_attach(bufnr)
	-- Custom Keybindings
	vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts("Close Directory"))
  vim.keymap.set('n', '<leader>s', api.node.open.vertical,         opts("Open Vertical Split"))
  vim.keymap.set('n', 'C', api.tree.change_root_to_node,   opts("Change Root To Node"))
  vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts("Change Root To Parent"))
end
-- Keep blank buffer when last file is closed
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    local wins = vim.api.nvim_list_wins()
    local non_tree_wins = vim.tbl_filter(function(w)
      return vim.bo[vim.api.nvim_win_get_buf(w)].filetype ~= "NvimTree"
    end, wins)
    if #non_tree_wins == 0 then
      vim.cmd("enew")
    end
  end,
})
-- Auto-open with Neovim - But don't open if file is opening Neovim
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    -- Buffer is a directory?
    local is_directory = vim.fn.isdirectory(data.file) == 1
    if is_directory then
      -- Change to the directory
      vim.cmd.cd(data.file)
      -- Open the tree
      require("nvim-tree.api").tree.open()
    else
      -- If it's just a file (like index.html), open the tree and jump back to the file
      require("nvim-tree.api").tree.open()
      vim.cmd("wincmd p")
    end
  end
})

-- NEOVIMPROJECT WON'T CLOSE NVIMTREE
vim.api.nvim_create_autocmd("User", {
  pattern = "SessionLoadPost",
  callback = function()
    require("nvim-tree.api").tree.open()
  end,
})


















-- THEMES

-- MIL NEOVIM THEME
-- vim.cmd("colorscheme milTheme")

vim.opt.background = "dark" -- set this to dark or light
vim.cmd("colorscheme tokyonight-night")







-- KEYBIDINGS
-- KEYBIDINGS
-- KEYBIDINGS
-- C = CTRL
-- capital letter = SHIFT
-- M = ALT
-- <CR> = Carriage Return = Enter

-- CTRL+n = New buffer
vim.keymap.set('n', '<C-n>', ':enew<CR>', { silent = true })

-- ALT+n = New tab
vim.keymap.set('n', '<M-n>', ':tabnew<CR>', { silent = true })
-- ALT+c = Close tab
vim.keymap.set('n', '<M-c>', ':tabclose<CR>', { silent = true })

-- cob = CLEAR OTHER BUFFERS (EXCEPT CURRENT FILE)
vim.keymap.set('n', 'cob', '<cmd>%bd|e#|bd#<cr>', { desc = 'Close all buffers except current' })

-- ALT+CTRL+x = :qa! = Quit Neovim without saving
vim.keymap.set('n', '<M-C-x>', ':qa<CR>', { silent = true })

-- ALT+d = :NeovimProjectDiscover = Projects
vim.keymap.set('n', '<M-d>', ':NeovimProjectDiscover<CR>', { silent = true })
