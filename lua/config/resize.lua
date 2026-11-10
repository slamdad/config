local M = {}

local SMALL = 2   -- lowercase hjkl step
local BIG = 10    -- uppercase HJKL step

-- Is there another window on that side of the current one?
-- (winnr(dir) returns the current window's number when there isn't.)
local function has_neighbor(dir)
  return vim.fn.winnr(dir) ~= vim.fn.winnr()
end

-- Move a border in the direction of the key.
-- The "active" border is the right/bottom one if a neighbor exists there,
-- otherwise the left/top one. Moving the active border right/down grows
-- the window if it is the window's right/bottom edge, and shrinks it
-- if it is the left/top edge.
function M.move_border(dir, amount)
  if dir == "h" or dir == "l" then
    local right, left = has_neighbor("l"), has_neighbor("h")
    if not (right or left) then return end
    local grow = (right and dir == "l") or (not right and dir == "h")
    vim.cmd(("vertical resize %s%d"):format(grow and "+" or "-", amount))
  else
    local below, above = has_neighbor("j"), has_neighbor("k")
    if not (below or above) then return end
    local grow = (below and dir == "j") or (not below and dir == "k")
    vim.cmd(("resize %s%d"):format(grow and "+" or "-", amount))
  end
end

local arrow_to_dir = {}
for name, dir in pairs({ ["<Left>"] = "h", ["<Right>"] = "l", ["<Up>"] = "k", ["<Down>"] = "j" }) do
  arrow_to_dir[vim.keycode(name)] = dir
end

function M.start()
  local msg = "-- RESIZE -- hjkl small | HJKL big | arrows: window | = equal | Esc exit"
  while true do
    vim.cmd("redraw")
    vim.api.nvim_echo({ { msg, "ModeMsg" } }, false, {})
    local ok, key = pcall(vim.fn.getcharstr)
    if not ok or key == "\27" or key == "\3" or key == "q" then break end

    if key:match("^[hjkl]$") then
      M.move_border(key, SMALL)
    elseif key:match("^[HJKL]$") then
      M.move_border(key:lower(), BIG)
    elseif arrow_to_dir[key] then
      vim.cmd("wincmd " .. arrow_to_dir[key])
    elseif key == "=" then
      vim.cmd("wincmd =")
    end
  end
  vim.cmd("redraw")
  vim.api.nvim_echo({ { "" } }, false, {})
end

return M
