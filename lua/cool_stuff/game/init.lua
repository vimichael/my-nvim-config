local M = {}

local opts = {
  fps = 60.0,
  width = 80,
  height = 30,
}

local player = {
  ch = '@',
  hl = "Normal",
  x = 1,
  y = 1,
}

local enemies = {}
local enemy_opts = {
  ticks_per_move = 120,
}
local prize = {
  ch = '*',
  hl = 'SpecialChar',
  x = 11,
  y = 11,
}
local game_won = false

local function setup_enemies()
  enemies = {}

  local positions = {
    { 4,  2 },
    { 20, 3 },
    { 30, 10 },
    { 40, 12 },
  }

  for _, pos in ipairs(positions) do
    table.insert(enemies, {
      ch = '$',
      hl = "Error",
      x = pos[1],
      y = pos[2],
      move_counter = pos[1] + pos[2]
    })
  end
end

local win = nil
local screen = {}
local hl_namespace = nil

local game_map = {
  "            x x     ",
  "    xxxxxxxxx x     ",
  "    x         x     ",
  "    x    x    x     ",
  "    xxxxxx    xxxx  ",
  "    x            x  ",
  "  xxxxx  xxxx xxxx  ",
  "  x         x x     ",
  "  x         x x     ",
  "  xxxxxxxxxxx x     ",
}

local function valid_coord(x, y)
  return x < opts.width + 1 and y < opts.height + 1 and x > 0 and y > 0
end

local function clamp(low, high, target)
  return math.max(low, math.min(high, target))
end

local function put_char(sprite, x, y)
  if not valid_coord(x, y) then return end

  screen[y][x].ch = sprite.ch
  screen[y][x].hl = sprite.hl or "Normal"
end

local function put_line(line, x, y)
  local i = 1
  for ch in line:gmatch(".") do
    local x_index = i + x
    put_char({ ch = ch }, x_index, y)
    i = i + 1
  end
end

local function put_lines(lines, x, y)
  for i, line in ipairs(lines) do
    put_line(line, x, y + i)
  end
end

local function screen_clear()
  for y, row in ipairs(screen) do
    for x, _ in ipairs(row) do
      screen[y][x].ch = " "
      screen[y][x].hl = ""
    end
  end
end

local function sprite_move_by(sprite, x, y)
  sprite.x = clamp(1, opts.width, sprite.x + x)
  sprite.y = clamp(1, opts.height, sprite.y + y)
end

local function obstacle_exists(x, y)
  if not valid_coord(x, y) then return end

  return screen[y][x].ch == 'x'
end

local function sprite_move_collisions(sprite, x, y)
  local _x = sprite.x + x
  local _y = sprite.y + y
  if obstacle_exists(_x, _y) == false then
    sprite_move_by(sprite, x, y)
  end
end

local function player_move(x, y)
  sprite_move_collisions(player, x, y)
end

-- create empty screen
local function setup_screen()
  for y = 1, opts.height do
    screen[y] = {}
    for x = 1, opts.width do
      screen[y][x] = { ch = " ", hl = "Normal" }
    end
  end
end

local buf = nil

local function frame()
  if win == nil then
    return
  end

  local delay = (opts.fps / 60.0)

  -- update enemies
  for _, enemy in ipairs(enemies) do
    enemy.move_counter = enemy.move_counter - 1
    if enemy.move_counter == 0 then
      enemy.move_counter = enemy_opts.ticks_per_move
      if player.x < enemy.x then
        sprite_move_collisions(enemy, -1, 0)
      else
        if player.x > enemy.x then
          sprite_move_collisions(enemy, 1, 0)
        end
      end

      if player.y < enemy.y then
        sprite_move_collisions(enemy, 0, -1)
      else
        if player.y > enemy.y then
          sprite_move_collisions(enemy, 0, 1)
        end
      end

      if screen[enemy.y][enemy.x].ch == player.ch then
        player.x = 1
        player.y = 1
      end
    end
  end

  if prize.x == player.x and prize.y == player.y then
    enemies = {}
    -- just dont render it
    game_won = true
  end

  if game_won == true then
    screen_clear()
    local win_msg = "you win!"
    put_line(win_msg, (opts.width - win_msg:len()) / 2, opts.height / 2)
    -- put_line(win_msg, 1, 1)
    local restart_msg = "press r to restart"
    put_line(restart_msg, (opts.width - restart_msg:len()) / 2, opts.height / 2 + 1)
    -- put_line(restart_msg, 1, 2)
  else
    -- draw stuff
    screen_clear()
    put_lines(game_map, 5, 5)
    put_char(player, player.x, player.y)
    for _, enemy in ipairs(enemies) do
      put_char(enemy, enemy.x, enemy.y)
    end
    put_char(prize, prize.x, prize.y)
  end


  -- list of strings, one for each line
  local lines = {}
  for _, row in ipairs(screen) do
    local line = {}
    for _, col in ipairs(row) do
      table.insert(line, col.ch)
    end

    table.insert(lines, table.concat(line, ""))
  end

  vim.api.nvim_buf_set_lines(buf, 0, opts.height, false, lines)

  -- hl groups
  vim.api.nvim_buf_clear_namespace(buf, hl_namespace, 0, -1)
  for y, row in ipairs(screen) do
    for x, col in ipairs(row) do
      vim.api.nvim_buf_add_highlight(buf, hl_namespace, col.hl, y - 1, x - 1, x)
    end
  end

  vim.api.nvim_win_set_buf(win, buf)

  if win ~= nil then
    vim.defer_fn(frame, delay)
  end
end

local function win_cfg()
  local x = (vim.o.columns - opts.width - 5) / 2
  local y = (vim.o.lines - opts.height) / 2

  return {
    relative = "editor",
    width = opts.width + 5,
    height = opts.height,
    col = x,
    row = y,
    border = "single",
  }
end

local function open_window()
  buf = vim.api.nvim_create_buf(false, true)
  win = vim.api.nvim_open_win(buf, true, win_cfg())
  vim.api.nvim_win_set_option(win, "list", false)

  if win == nil then
    vim.notify("failed to open window")
    return
  end
end

local function setup_hl()
  hl_namespace = vim.api.nvim_create_namespace("game")
end

local function setup_keymaps()
  vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
    noremap = false,
    silent = true,
    callback = function()
      vim.api.nvim_win_close(0, true)
      win = nil
    end
  })
  vim.api.nvim_buf_set_keymap(buf, "n", "h", "", {
    noremap = false,
    silent = true,
    callback = function()
      player_move(-1, 0)
    end
  })
  vim.api.nvim_buf_set_keymap(buf, "n", "j", "", {
    noremap = false,
    silent = true,
    callback = function()
      player_move(0, 1)
    end
  })
  vim.api.nvim_buf_set_keymap(buf, "n", "k", "", {
    noremap = false,
    silent = true,
    callback = function()
      player_move(0, -1)
    end
  })
  vim.api.nvim_buf_set_keymap(buf, "n", "l", "", {
    noremap = false,
    silent = true,
    callback = function()
      player_move(1, 0)
    end
  })
end


local function game()
  open_window()
  setup_screen()
  setup_keymaps()
  setup_hl()
  setup_enemies()

  vim.api.nvim_buf_set_keymap(buf, "n", "r", "", {
    noremap = false,
    silent = true,
    callback = function()
      if game_won then
        game_won = false
        game()
        prize.x = 11
        player.x = 1
        player.y = 1
      end
    end
  })

  vim.cmd("setlocal nonumber")

  frame()
end



M.setup = function()
  vim.api.nvim_create_user_command("Game", game, {})
end

return M
