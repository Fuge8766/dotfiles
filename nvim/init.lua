-- NVIM EVENTS https://gist.github.com/dtr2300/2f867c2b6c051e946ef23f92bd9d1180

-- Constant
local g = vim.g
local o = vim.o
local opt = vim.opt
local cmd = vim.cmd
g.hideall = false

-- Disable built in plugins
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_matchit = 1
g.loaded_2html_plugin = 1
g.loaded_rrhelper = 1
g.loaded_matchparen = 1
g.did_install_default_menus = 1 
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1
g.loaded_nvim_dir_plugin = 1
g.loaded_tutor_mode_plugin = 1
g.loaded_spellfile_plugin = 1

-- Plugin Manager
vim.pack.add({ 'https://github.com/zuqini/zpack.nvim' })

-- Theme
o.background = "dark"
cmd("language en_US.utf8")
o.guifont = "Lucida Console:h14"

-- Variables
g.mapleader = ' '
g.maplocalleader = ' '
o.ignorecase = true
o.smartcase = true
o.mouse	= ''
o.wrap = false
o.backup = false
o.writebackup = false
o.updatetime = 250
o.timeoutlen = 300
o.autoindent = true
o.smartindent = true
opt.whichwrap:append('<,>,h,l')
opt.shortmess:append({ c = true, I = true})
o.confirm = true
o.infercase = true
o.rnu = true
o.autochdir = true
o.showmode = false
o.virtualedit = "onemore"
o.scrolloff = 3
o.sidescrolloff = 5
o.splitright = true
o.cmdheight = 0
o.cot = 'menu,noinsert,fuzzy'
o.cia = 'kind,abbr,menu'
o.wop = 'pum,tagfile,fuzzy'

-- Functions
function map(m, l, r, d)  -- recursive --
	vim.keymap.set(m, l, r, { remap = false, silent = true, desc = d })
end
function rmap(m, l, r, d)  -- no recursive --
	vim.keymap.set(m, l, r, { remap = true, silent = true, desc = d })
end
function emap(m, l, r, d)  -- expression --
	vim.keymap.set(m, l, r, { silent = true, desc = d })
end

-- Local Functions
local function dupline()
	vim.api.nvim_feedkeys("yy" .. vim.v.count1 .. "p", "n", true)
end
local function fold()
	if(o.foldcolumn == "0") then
		o.foldcolumn = "2"
	else
		o.foldcolumn = "0"
	end	
end
local function list()
	o.list = not o.list
end
local function close() --https://github.com/neovim/neovim/issues/19363#issuecomment-4699669668
	if #vim.api.nvim_list_wins() == 1 and vim.bo[vim.api.nvim_win_get_buf(0)].buftype == 'quickfix' then vim.cmd('quit') end
	if vim.bo.filetype == "help" then vim.cmd('bdelete') return end
	if vim.bo.filetype == "man" then vim.cmd('bdelete') return end
	if vim.bo.filetype == "qf" then vim.cmd('cclose') return end
	if vim.bo.filetype == "lf" then vim.cmd('lclose') return end
	-- if vim.bo.filetype == "netrw" then vim.cmd("bdelete") return end
	if vim.bo.filetype == "vim" and vim.bo.buftype == "nofile" then vim.cmd('quit') return end
	if vim.bo.filetype == "pager" and vim.bo.buftype == "nofile" then vim.cmd('close') return end
	if vim.bo.buftype == "terminal" then vim.cmd('bd!') return end
	if not vim.bo.modified and #vim.fn.getbufinfo({ buflisted = 1 }) == 1 then vim.cmd('quit') end

	pcall(vim.cmd.cclose())
	if vim.bo.modified then
	    vim.api.nvim_echo({{ "Buffer has unsaved changes!", "ErrorMsg" }}, false, {})
	    return
	end
	if vim.o.diff == true then vim.cmd('qa') end

	if #vim.fn.getbufinfo({ buflisted = 1 }) == 1 then
	    vim.cmd('quit')
	else
	    vim.cmd('bdelete')
	end
	end
local function presentation()
	if g.hideall == false then
		g.lasthidestatus = {o.foldcolumn, o.relativenumber, o.number, o.showtabline}
		g.hideall = true
		cmd[[
			set noruler
			set laststatus=0
			set noshowcmd
			set foldcolumn=2
			set nornu
			set nonu
			set showtabline=0
		]]
	else
		g.hideall = false
		cmd[[
			set ruler
			set laststatus=2
			set showcmd
		]]
		o.foldcolumn = g.lasthidestatus[1]
		o.relativenumber = g.lasthidestatus[2]
		o.number = g.lasthidestatus[3]
		o.showtabline = g.lasthidestatus[4]
	end
end
-- vim.fn.jobstart({ "firefox", vim.fn.expand("%") }, { detach = true })

-- Keymaps
map({'n','v'}, '<Space>', '<Nop>')

map({'n','v','x'}, '<leader>y', '"+y', "Copy to clipboard")
map({'n','v','x'}, '<leader>u', '"+p', "Paste to clipboard")
map('n', '<leader>R', '<cmd>:e $MYVIMRC<cr>', "Edit init.lua")
map('n', '<leader>S', function() MiniExtra.pickers.explorer({cwd= string.gsub(vim.fn.expand('$Snippet'),'\\','/') }) end, "Edit snippets")
map('n', '<leader>P', function() MiniExtra.pickers.explorer({cwd= string.gsub(vim.fn.expand('$Plugin'),'\\','/') }) end, "Edit plugins spec")
map('n', '<leader>z', '`^', "Jump to insert mode last position")
map('n', '<leader>v', '<C-w>v', "Split vertically")
map('n', '<leader>s', '<C-w>s', "Split horizontally")
map('n', '<leader>l', '<cmd>:set wrap!<cr>', "Toggle wrap lines")
emap('n', '<leader>d', dupline, "Duplicate current line (Count)")
map('n', "<leader><leader>x", "<cmd>:.lua<cr>", "Run the current line as lua script") 
map('v', "<leader><leader>x", "<cmd>:'<,'>lua<cr>", "Run the selected line as lua script (Visual)")
map({'n', 'v'}, "<leader>c", "<cmd>:term<cr>", "Create terminal")
map({'n', 'v'}, "<leader>w", "<cmd>:wincmd T<cr>", "Move current window to new tab")
map({'n', 'v'}, "<leader>q", close, "Close buffer or quit nvim")

map({'n'}, 'o', '<S-a><cr>')
map({'n'}, 'O', '<S-i><S-cr><C-o>k')
rmap({'n','i'}, '<C-s>', '<cmd>:w<cr>')
map('t', '<Esc>', '<C-\\><C-n>')
map('n', '<Esc>', '<cmd>:noh<cr>')
map('n', 'x', '"_x')
map('n', '<C-f>', '<S-k>')
map('n', '<Tab>', '<cmd>:b#<cr>') --need to solve buffer dont exist after delete it
-- :ls t
map('n', '<S-Tab>', '<cmd>:bnext<cr>')
map('n', '<C-Tab>', '<cmd>:tabnext<cr>')
map({'n','v'}, '<S-k>', '<C-U>')
map({'n','v'}, '<S-j>', '<C-D>')
map({'n','v'}, '<C-k>', '<C-B>')
map({'n','v'}, '<C-j>', '<C-F>')
map('i', 'jk', '<Esc>')
map('i', 'kj', '<Esc>')
map({'n','v'}, '<F2>', '<cmd>:set nu!<CR><cmd>:set nornu<CR>')
map({'n','v'}, '<S-F2>', '<cmd>:set rnu!<CR><cmd>:set nonu<CR>')
map({'n','v'}, '<F3>', fold)
map({'n','v'}, '<F4>', list)
map({'n','v'}, '<F8>', presentation)

-- Autocommands
vim.api.nvim_create_autocmd({"BufWinLeave"}, {
  pattern = {"*.*"},
  desc = "Save view (folds), when closing file",
  command = "mkview",
})
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  pattern = {"*.*"},
  desc = "Load view (folds), when opening file",
  command = "silent! loadview"
})

-- Plugin Setup
require('zpack').setup({
  defaults = {
    confirm = true,
  },
  performance = {
    vim_loader = true,
  },
  cmd_name = 'Zp',
})

-- Neovide
if g.neovide == true then
	g.neovide_scale_factor = 1.5
	vim.keymap.set("n", "<C-=>", ":lua vim.g.neovide_scale_factor = math.min(vim.g.neovide_scale_factor + 0.1,  3.0)<CR>", { silent = true })
	vim.keymap.set("n", "<C-->", ":lua vim.g.neovide_scale_factor = math.max(vim.g.neovide_scale_factor - 0.1,  0.1)<CR>", { silent = true })
	vim.keymap.set("n", "<C-+>", ":lua vim.g.neovide_opacity = math.min(vim.g.neovide_opacity + 0.1, 1.0)<CR>", { silent = true })
	vim.keymap.set("n", "<C-_>", ":lua vim.g.neovide_opacity = math.max(vim.g.neovide_opacity - 0.1, 0.0)<CR>", { silent = true })
	vim.api.nvim_set_keymap("n", "<F11>", ":lua vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen<CR>", { silent = true })
end
