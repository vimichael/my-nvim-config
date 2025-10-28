local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  s("leetcode", {
    t({ "#include <iostream>", "" }),
    t({ "#include <vector>", "" }),
    t({ "#include <algorithm>", "", "" }),
    t({ "using namespace std;", "", "" }),
    t({ "int main() {", "" }),
    t({ "  return 0;", "" }),
    t({ "}" }),
  }),
}
