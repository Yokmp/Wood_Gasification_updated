local icons = require("lib.icons")
local legacy_mode = require("lib.config").legacy_mode()

local common = {
  enabled = false,
  energy_required = 5,
  always_show_made_in = true,
  allow_decomposition = false
}

local function recipe(definition)
  for key, value in pairs(common) do
    if definition[key] == nil then definition[key] = value end
  end
  definition.type = "recipe"
  return definition
end

data:extend({
  -- Kept unchanged for existing saves and exposed again when legacy mode is enabled.
  recipe({
    name = "wood-gasification",
    categories = {"chemistry"},
    hidden = not legacy_mode,
    ingredients = {{type = "item", name = "wood", amount = 10}},
    results = {
      {type = "fluid", name = "petroleum-gas", amount = 20},
      {type = "fluid", name = "tar", amount = 8}
    },
    icon = "__Wood_Gasification_updated__/graphics/icon/wood-gasification.png",
    icon_size = 64,
    subgroup = "fluid-recipes",
    order = "a[fluid-chemistry]-w[wood-gas-processing]",
    crafting_machine_tint = {
      primary = {r = 0.698, g = 0.698, b = 0.698, a = 0},
      secondary = {r = 0.4, g = 0.4, b = 0.4, a = 0},
      tertiary = {r = 0.305, g = 0.305, b = 0.305, a = 0}
    }
  }),
  recipe({
    name = "crude-oil-from-tar",
    categories = {"chemistry"},
    hidden = not legacy_mode,
    ingredients = {
      {type = "fluid", name = "tar", amount = 32},
      {type = "fluid", name = "water", amount = 200}
    },
    results = {{type = "fluid", name = "crude-oil", amount = 40}},
    icon = "__Wood_Gasification_updated__/graphics/icon/crude-oil-from-tar.png",
    icon_size = 64,
    subgroup = "fluid-recipes",
    order = "a[fluid-chemistry]-w[crude-oil-from-tar]",
    crafting_machine_tint = {
      primary = {r = 0.29, g = 0.027, b = 0, a = 0},
      secondary = {r = 0.722, g = 0.465, b = 0.19, a = 0},
      tertiary = {r = 0.87, g = 0.365, b = 0, a = 0}
    }
  }),
  recipe({
    name = "advanced-wood-gasification",
    categories = {"oil-processing"},
    hidden = not legacy_mode,
    energy_required = 10,
    ingredients = {
      {type = "item", name = "wood", amount = 20},
      {type = "fluid", name = "water", amount = 200}
    },
    results = {
      {type = "fluid", name = "heavy-oil", amount = 15},
      {type = "fluid", name = "light-oil", amount = 15},
      {type = "fluid", name = "petroleum-gas", amount = 30}
    },
    icon = "__Wood_Gasification_updated__/graphics/icon/advanced-wood-gasification.png",
    icon_size = 64,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-w[advanced-wood-gasification]"
  }),

  recipe({
    name = "wood-pyrolysis",
    categories = {"chemistry"},
    hidden = legacy_mode,
    ingredients = {{type = "item", name = "wood", amount = 10}},
    results = {
      {type = "item", name = "wood-charcoal", amount = 5},
      {type = "fluid", name = "petroleum-gas", amount = 10},
      {type = "fluid", name = "tar", amount = 8}
    },
    icon = "__Wood_Gasification_updated__/graphics/icon/wood-gasification.png",
    icon_size = 64,
    main_product = "tar",
    subgroup = "fluid-recipes",
    order = "a[fluid-chemistry]-w[wood-pyrolysis]"
  }),
  recipe({
    name = "solid-fuel-from-tar",
    categories = {"chemistry"},
    ingredients = {{type = "fluid", name = "tar", amount = 32}},
    results = {{type = "item", name = "solid-fuel", amount = 1}},
    icon = "__Wood_Gasification_updated__/graphics/icon/solid-fuel-from-tar.png",
    icon_size = 64,
    subgroup = "fluid-recipes",
    order = "a[fluid-chemistry]-w[solid-fuel-from-tar]",
    crafting_machine_tint = {
      primary = {r = 0, g = 0, b = 0, a = 0},
      secondary = {r = 0, g = 0, b = 0, a = 0},
      tertiary = {r = 0, g = 0, b = 0, a = 0}
    }
  }),
  recipe({
    name = "wood-tar-steam-cracking",
    categories = {"chemistry"},
    hidden = legacy_mode,
    ingredients = {
      {type = "fluid", name = "tar", amount = 24},
      {type = "fluid", name = "steam", amount = 40, minimum_temperature = 100}
    },
    results = {
      {type = "fluid", name = "heavy-oil", amount = 10},
      {type = "fluid", name = "petroleum-gas", amount = 20}
    },
    icons = icons.composite("fluid", "tar", {
      {type = "fluid", name = "heavy-oil", shift = {-8, 8}},
      {type = "fluid", name = "petroleum-gas", shift = {8, 8}}
    }),
    main_product = "heavy-oil",
    subgroup = "fluid-recipes",
    order = "a[fluid-chemistry]-w[wood-tar-steam-cracking]"
  }),
  recipe({
    name = "hydrothermal-wood-pyrolysis",
    categories = {"chemistry"},
    hidden = legacy_mode,
    ingredients = {
      {type = "item", name = "wood", amount = 20},
      {type = "fluid", name = "water", amount = 200}
    },
    results = {
      {type = "fluid", name = "heavy-oil", amount = 30},
      {type = "fluid", name = "petroleum-gas", amount = 30}
    },
    icons = icons.composite("item", "wood", {
      {type = "fluid", name = "heavy-oil", shift = {-8, 8}},
      {type = "fluid", name = "petroleum-gas", shift = {8, 8}}
    }),
    main_product = "heavy-oil",
    subgroup = "fluid-recipes",
    order = "a[fluid-chemistry]-x[hydrothermal-wood-pyrolysis]"
  }),
  recipe({
    name = "wood-tar-steam-gasification",
    categories = {"oil-processing"},
    hidden = legacy_mode,
    ingredients = {
      {type = "fluid", name = "tar", amount = 24},
      {type = "fluid", name = "steam", amount = 60, minimum_temperature = 100}
    },
    results = {{type = "fluid", name = "petroleum-gas", amount = 30}},
    icons = icons.composite("fluid", "tar", {
      {type = "fluid", name = "petroleum-gas", shift = {0, 8}}
    }),
    main_product = "petroleum-gas",
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-x[wood-tar-steam-gasification]"
  }),
  recipe({
    name = "wood-carbonization",
    categories = {"smelting"},
    hidden = legacy_mode,
    ingredients = {{type = "item", name = "wood", amount = 10}},
    results = {{type = "item", name = "wood-charcoal", amount = 6}},
    icons = icons.composite("item", "wood-charcoal", {
      {type = "item", name = "wood", shift = {-8, 8}}
    }),
    main_product = "wood-charcoal",
    subgroup = "raw-material",
    order = "a[wood-products]-b[wood-carbonization]"
  })
})

if settings.startup["enable-greenhouse"].value then
  data:extend({
    recipe({
      name = "greenhouse",
      energy_required = 2,
      ingredients = {
        {type = "item", name = "stone-brick", amount = 8},
        {type = "item", name = "pipe", amount = 5},
        {type = "item", name = "iron-plate", amount = 10}
      },
      results = {{type = "item", name = "greenhouse", amount = 1}}
    }),
    recipe({
      name = "wood-greenhouse",
      categories = {"R-greenhouse"},
      energy_required = 20 / settings.startup["greenhouse-output-pr-sec-wood"].value,
      ingredients = {
        {type = "fluid", name = "water", amount = 200},
        {type = "item", name = "wood", amount = 20}
      },
      results = {{type = "item", name = "wood", amount = 40}}
    })
  })
end
