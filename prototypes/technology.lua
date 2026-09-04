local legacy_mode = require("lib.config").legacy_mode()

local early_effects = {
  {type = "unlock-recipe", recipe = "wood-pyrolysis"},
  {type = "unlock-recipe", recipe = "solid-fuel-from-tar"},
  {type = "unlock-recipe", recipe = "wood-tar-steam-cracking"},
  {type = "unlock-recipe", recipe = "wood-gasification"}
}

if settings.startup["enable-greenhouse"].value and not mods["space-age"] then
  table.insert(early_effects, {type = "unlock-recipe", recipe = "greenhouse"})
  table.insert(early_effects, {type = "unlock-recipe", recipe = "wood-greenhouse"})
end

data:extend({
  {
    type = "technology",
    name = "wood-gas-processing",
    icon = "__Wood_Gasification_updated__/graphics/technology/wood-gas-processing.png",
    icon_size = 256,
    localised_name = legacy_mode and {"recipe-name.wood-gasification"} or nil,
    localised_description = legacy_mode and {"technology-description.wood-gas-processing-legacy"} or nil,
    prerequisites = {"oil-processing"},
    effects = early_effects,
    unit = {
      count = legacy_mode and 100 or 50,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    order = "d-b-a"
  },
  {
    type = "technology",
    name = "advanced-wood-gas-processing",
    icon = "__Wood_Gasification_updated__/graphics/technology/advanced-wood-gas-processing.png",
    icon_size = 256,
    localised_name = legacy_mode and {"recipe-name.advanced-wood-gasification"} or nil,
    localised_description = legacy_mode and {"technology-description.advanced-wood-gas-processing-legacy"} or nil,
    prerequisites = {"wood-gas-processing"},
    effects = {
      {type = "unlock-recipe", recipe = "hydrothermal-wood-pyrolysis"},
      {type = "unlock-recipe", recipe = "wood-tar-steam-gasification"},
      {type = "unlock-recipe", recipe = "advanced-wood-gasification"}
    },
    unit = {
      count = legacy_mode and 150 or 100,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    order = "d-b-b"
  },
  {
    type = "technology",
    name = "wood-gas-processing-to-crude-oil",
    icon = "__Wood_Gasification_updated__/graphics/technology/wood-gas-processing-to-crude-oil.png",
    icon_size = 256,
    prerequisites = {"wood-gas-processing"},
    hidden = not legacy_mode,
    effects = {{type = "unlock-recipe", recipe = "crude-oil-from-tar"}},
    unit = {
      count = 400,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1}
      },
      time = 30
    },
    order = "d-b-z"
  },
})
