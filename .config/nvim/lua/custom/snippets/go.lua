local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("go", {
    s({ trig = "iferr", dscr = "snippet for err" }, fmt(
        [[
if err != nil {{
    return {}
}}
]], { i(1, "err") }))
})
