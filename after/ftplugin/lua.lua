local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

local lang = "lua"

require("luasnip.session.snippet_collection").clear_snippets(lang)

-- normal lua
ls.add_snippets(lang, {
  s("m", {
    t({ "local M = {}", "", "" }),
    i(1),
    t({ "", "", "return M" }),
  }),
})

-- The following snippets should only be available when configuring neovim:
--
-- more specifically, these should only be available when writing
-- plugin specs, but this gets too confusing to check for.

-- current working directory
local cwd = vim.fn.getcwd()

-- expanded path of the ~/.config directory
local config_dir = vim.fn.expand("~/.config")

-- Check if the current working directory matches the pattern
if not cwd:match(config_dir .. "/.*nvim.*") then
  return
end

-- neovim lua
ls.add_snippets(lang, {
  s("plug", {
    t({ "return {", '\t"' }),
    i(1),
    t({ '",', "\t" }),
    i(2),
    t({ "", "}" }),
    i(0),
  }),

  s("enabled", {
    t("enabled = "),
    c(1, {
      t("true"),
      t("false"),
    }),
    t({ ",", "" }),
    i(0),
  }),

  s("lazy", {
    t("lazy = "),
    c(1, {
      t("true"),
      t("false"),
    }),
    t({ ",", "" }),
    i(0),
  }),

  s("version", {
    t('version = "'),
    i(1),
    t({ '",', "" }),
    i(0),
  }),
})

ls.add_snippets(lang, {
  s("addlang", {
    t({ 'local L = require("util.new_lang")', "", "return {", "\t" }),
    i(1),
    t({ "", "}" }),
  }),
})
