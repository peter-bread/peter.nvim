local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local lang = "go"

require("luasnip.session.snippet_collection").clear_snippets(lang)

ls.add_snippets(lang, {

  -- main function
  s("main", {
    t({ "func main() {", "\t" }),
    i(1),
    t({ "", "}" }),
    i(0),
  }),

  -- if err != nil {}
  s("ie", {
    t({ "if err != nil {", "\t" }),
    i(1),
    t({ "", "}" }),
    i(0),
  }),
})
