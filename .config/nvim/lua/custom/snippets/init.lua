-- include all languages
local languages = {
    "json",
    "go",
    "python",
}
for _, l in pairs(languages) do
    require("custom.snippets." .. l)
end
