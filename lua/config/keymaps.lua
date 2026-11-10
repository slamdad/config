-- Resize mode: <leader>r, then hjkl / HJKL / arrows / = / Esc (see resize.lua)
vim.keymap.set("n", "<leader>r", function()
  require("config.resize").start()
end, { desc = "Window resize mode" })
