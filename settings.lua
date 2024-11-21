local hidden, default = true, false
if mods["space-age"] then
  default = true
  hidden = false
  l_name = "__base__/graphics/empty.png"
end
data:extend({
  {
    type = "bool-setting",
    name = "use-gleba",
    localised_name = {"", "[planet=gleba]", " ?"} or "",
    setting_type = "startup",
    default_value = default,
    order = "a",
    hidden = hidden
  },
  {
    type = "string-setting",
    name = "seed-probability",
    localised_name = {"", "[img=sigma-symbol]", {"item-name.tree-seed"}, " ?"},
    setting_type = "startup",
    default_value = "0.1",
    order = "b",
    hidden = hidden
  },
})