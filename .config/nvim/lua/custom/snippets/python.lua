local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt


ls.add_snippets("json", {
    s({ trig = "pydebug", dscr = "snippet for python debug launch.json" }, fmt(
        [[
{{
    "version": "0.2.0",
    "configurations": [
        {{
            "name": "{}",
            "type": "python",
            "request": "launch",
            "program": "${{file}}",
            "console": "integratedTerminal",
            "python": "python",
            "justMyCode": true,
            "args": ["{}"]
        }}
    ]
}}
    ]], {
            i(1, "Python debugging"),
            i(2, "arg")
        }))
})
