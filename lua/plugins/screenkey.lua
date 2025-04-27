local yt = false

if yt then
  return {
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*", -- or branch = "dev", to use the latest commit
    config = function()
      vim.cmd("Screenkey")
    end
  }
else
  return {}
end
