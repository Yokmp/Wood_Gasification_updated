local hidden = true
if mods["space-age"] then
  hidden = false
end
data:extend({
  {
    type = "bool-setting",
    name = "wood-gasification-legacy-mode",
    setting_type = "startup",
    default_value = false,
    order = "a"
  },
  {
    type = "bool-setting",
    name = "enable-greenhouse",
    localised_name = {"", "[item=greenhouse]", " ?"} or "",
    setting_type = "startup",
    default_value = true,
    order = "aa",
    hidden = false
  },
  {
    type = "bool-setting",
    name = "require-gleba-for-greenhouse-tech",
    localised_name = {"", "[planet=gleba]", " ?"} or "",
    setting_type = "startup",
    default_value = false,
    order = "ab",
    hidden = hidden
  },
  {
    type = "double-setting",
    name = "tree-seed-probability",
    localised_name = {"", "[img=sigma-symbol]", {"item-name.tree-seed"}, " ?"},
    setting_type = "startup",
    default_value = 0.1,
    minimum_value = 0,
    maximum_value = 1,
    order = "b",
    hidden = hidden
  },
  {
    type = "double-setting",
    name = "greenhouse-output-pr-sec-wood",
    setting_type = "startup",
    default_value = 0.3333,
    minimum_value = 0.001,
    order = "c",
  },
  {
    type = "double-setting",
    name = "greenhouse-output-pr-sec-yumako",
    setting_type = "startup",
    default_value = 0.3333,
    minimum_value = 0.001,
    order = "d",
    hidden = hidden
  },
  {
    type = "double-setting",
    name = "greenhouse-output-pr-sec-jellynut",
    setting_type = "startup",
    default_value = 0.3333,
    minimum_value = 0.001,
    order = "e",
    hidden = hidden
  },
  {
    type = "bool-setting",
    name = "wood-gasification-auto-unlock-byproduct-handling",
    setting_type = "startup",
    default_value = true,
    hidden = true,
    order = "zy"
  },
  {
    type = "bool-setting",
    name = "wood-gasification-test-mode",
    setting_type = "startup",
    default_value = false,
    hidden = true,
    order = "zz"
  }
})
