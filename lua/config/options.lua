local opt = vim.opt

-- Line display
opt.number = true            -- absolute line numbers
opt.relativenumber = false   -- you navigate with arrows, so absolute is enough
opt.numberwidth = 4
opt.cursorline = false        -- highlight the line the cursor is on
opt.colorcolumn = "0"       -- vertical guide at column 80 (C style limit)
opt.wrap = false             -- long lines scroll sideways instead of wrapping
opt.scrolloff = 8            -- keep 8 lines visible above/below the cursor
opt.sidescrolloff = 8
opt.signcolumn = "yes"       -- reserve the gutter so text doesn't jump

-- Indentation: 4 spaces by default, 2 for web/Lua files
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "javascript", "lua" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

-- Don't auto-insert a comment marker when pressing Enter/o/O in a comment
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Search
opt.ignorecase = true
opt.smartcase = true         -- case-sensitive only if you type a capital
opt.hlsearch = true
opt.incsearch = true

-- Windows
opt.splitright = true
opt.splitbelow = true

-- Files
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true          -- undo history survives closing the file

-- UI / behavior
opt.termguicolors = true
opt.mouse = "a"
opt.showmode = false         -- the statusline shows the mode instead
opt.timeoutlen = 400         -- how long Neovim waits for the next key of a combo
opt.updatetime = 300

-- System clipboard (set after startup; doing it earlier slows launch).
-- On Linux this needs xclip or wl-clipboard installed.
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

-- Terminal buffers don't need line numbers
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.signcolumn = "no"
    vim.opt_local.colorcolumn = ""
  end,
})
