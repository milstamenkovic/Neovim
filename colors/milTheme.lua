-- milTheme -- Mil Neovim Theme
-- Created: 05.05.2026. - Ćuprija, Serbia - Mil Stamenković
-- Revised: 05.05.2026. - Ćuprija, Serbia - Mil Stamenković



-- MIL THEME NAME
vim.cmd("highlight clear")
vim.opt.background = "dark"
vim.g.colors_name = "milTheme"



-- 24-bit COLORS
-- (This goes before themes and colors)
vim.opt.termguicolors = true

-- SYNTAX COLORING
vim.cmd("syntax on")
vim.cmd('filetype on')

-- TRANSPARENT BACKGROUND NEOVIM 
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })






-- TAB TITLES
function _G.TabLine()
  local s = ''
  for i = 1, vim.fn.tabpagenr('$') do
    local winnr = vim.fn.tabpagewinnr(i)
    local buflist = vim.fn.tabpagebuflist(i)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.bufname(bufnr)
    local filename = bufname ~= '' and vim.fn.fnamemodify(bufname, ':t') or '[No Name]'
    if i == vim.fn.tabpagenr() then
      s = s .. '%#TabLineSel# ' .. filename .. ' '
    else
      s = s .. '%#TabLine# ' .. filename .. ' '
    end
  end
  return s .. '%#TabLineFill#'
end
-- Tabs customization
vim.opt.tabline = '%!v:lua.TabLine()'
vim.opt.showtabline = 2
vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#BABABA", bg = "none", bold = true })
vim.api.nvim_set_hl(0, "TabLine",    { fg = "#616161", bg = "none" })
vim.api.nvim_set_hl(0, "TabLineFill",{ bg = "none" })
