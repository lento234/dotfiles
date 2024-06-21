local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("json", {
    s("godebug", fmt(
        [[
{{
    "version": "0.2.0",
    "configurations": [
        {{
            "name": "{}",
            "type": "go",
            "request": "launch",
            "mode": "auto",
            "program": "${{fileDirname}}"
        }}
    ]
}}
    ]], {
            i(1, "name")
        }))
})
