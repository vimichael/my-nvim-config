return {
}

-- cant figure out how to disable list rendering :(

-- return {
--   "OXY2DEV/markview.nvim",
--   opts = {
--     markdown = {
--       list_items = {
--         enable = false,
--         shift_width = function(buffer, item)
--           --- Reduces the `indent` by 1 level.
--           local parent_indnet = math.max(1, item.indent - vim.bo[buffer].shiftwidth)
--
--           return item.indent * (1 / (parent_indnet * 2))
--         end,
--         marker_minus = {
--           add_padding = function(_, item)
--             return item.indent > 1
--           end,
--         },
--       },
--     },
--   },
-- }
