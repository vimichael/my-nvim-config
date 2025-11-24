local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  s("fn", {
    i(1, "void"),
    t({ " " }),
    i(2, "fn"),
    t({ "(" }),
    i(3, "void"),
    t({ ") {", "" }),
    i(4, ""),
    t({ "}" }),
  }),


  s("main", {
    t({ "int main(int argc, char** argv) {", "" }),
    i(1, { "" }),
    t({ "", "\treturn 0;", "}" }),
  }),

  s("hw", {
    t({ "#include <iostream>", "#include <vector>", "", "using namespace std;", "", "int main(int argc, char** argv) {",
      "" }),
    i(1, { "" }),
    t({ "", "\treturn 0;", "}" }),
  }),

}
