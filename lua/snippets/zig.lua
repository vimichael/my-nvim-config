local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
	s("stru", {
		t({ "const " }),
		i(1, ""),
		t({ " = struct {", "\t" }),
		i(2, ""),
		t({ "", "};" }),
	}),
}
