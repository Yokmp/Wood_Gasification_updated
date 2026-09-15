local compatibility = require("compatibility.prototypes")
local functions = require("lib.functions")
local icons = require("lib.icons")
local legacy_mode = require("lib.config").legacy_mode()

local function create_syngas_fluid()
  data:extend({
    {
      type = "fluid",
      name = "wood-syngas",
      icon = "__Wood_Gasification_updated__/graphics/icon/syngas.png",
      icon_size = 64,
      subgroup = "fluid",
      order = "a[fluid]-u[wood-syngas]",
      default_temperature = 25,
      gas_temperature = 25,
      max_temperature = 100,
      heat_capacity = "0.1kJ",
      base_color = {r = 0.69, g = 0.39, b = 0.69},
      flow_color = {r = 0.92, g = 0.55, b = 0.92}
    }
  })
end

local function create_syngas_technology(hidden)
  data:extend({
    {
      type = "technology",
      name = "wood-syngas-processing",
      icon = "__Wood_Gasification_updated__/graphics/technology/wood-syngas.png",
      icon_size = 256,
      hidden = hidden,
      prerequisites = {"advanced-wood-gas-processing"},
      effects = {},
      unit = {
        count = 150,
        ingredients = {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1}
        },
        time = 30
      },
      order = "d-b-c"
    }
  })
  return "wood-syngas-processing"
end

local syngas = compatibility.find_prototype("syngas")
local syngas_technology
if syngas then
  if not legacy_mode then syngas_technology = compatibility.find_unlock_technology("fluid", syngas) end
  log("Wood Gasification: using synthesis gas fluid '" .. syngas .. "'.")
else
  syngas = "wood-syngas"
  create_syngas_fluid()
  log("Wood Gasification: no compatible synthesis gas found; using 'wood-syngas'.")
end
if not syngas_technology then syngas_technology = create_syngas_technology(legacy_mode) end

local carbon_monoxide = compatibility.find_prototype("carbon_monoxide")
local carbon_dioxide = compatibility.find_prototype("carbon_dioxide")

local charcoal_results = {{type = "fluid", name = syngas, amount = 30}}
if carbon_monoxide then
  table.insert(charcoal_results, {type = "fluid", name = carbon_monoxide, amount = 10})
end

local solid_fuel_results = {
  {type = "fluid", name = "tar", amount = 12},
  {type = "fluid", name = syngas, amount = 15}
}

local liquefaction_results = {{type = "fluid", name = "crude-oil", amount = 50}}
if carbon_dioxide then
  table.insert(liquefaction_results, {type = "fluid", name = carbon_dioxide, amount = 10})
end

data:extend({
  {
    type = "recipe",
    name = "wood-tar-steam-reforming",
    categories = {"wood-syngas-reforming"},
    enabled = false,
    hidden = legacy_mode,
    energy_required = 5,
    ingredients = {
      {type = "fluid", name = "tar", amount = 12},
      {type = "fluid", name = "steam", amount = 20, minimum_temperature = 100}
    },
    results = {{type = "fluid", name = syngas, amount = 15}},
    icons = icons.composite("fluid", "tar", {
      {type = "fluid", name = syngas, shift = {0, 8}}
    }),
    main_product = syngas,
    subgroup = "fluid-recipes",
    order = "a[fluid-chemistry]-y[wood-tar-steam-reforming]",
    always_show_made_in = true,
    allow_decomposition = false
  },
  {
    type = "recipe",
    -- Kept for compatibility; the prototype now performs charcoal steam gasification.
    name = "wood-tar-synthesis-from-charcoal",
    categories = {"wood-syngas-charcoal-synthesis"},
    enabled = false,
    hidden = legacy_mode,
    energy_required = 5,
    ingredients = {
      {type = "item", name = "wood-charcoal", amount = 10},
      {type = "fluid", name = "steam", amount = 40, minimum_temperature = 100}
    },
    results = charcoal_results,
    icons = icons.composite("fluid", syngas, {
      {type = "item", name = "wood-charcoal", shift = {0, 8}}
    }),
    main_product = syngas,
    subgroup = "fluid-recipes",
    order = "a[fluid-chemistry]-y[wood-tar-synthesis-from-charcoal]",
    always_show_made_in = true,
    allow_decomposition = false
  },
  {
    type = "recipe",
    -- Kept for compatibility; the prototype now performs solid-fuel steam reforming.
    name = "wood-tar-synthesis-from-solid-fuel",
    categories = {"wood-syngas-solid-fuel-synthesis"},
    enabled = false,
    hidden = legacy_mode,
    energy_required = 5,
    ingredients = {
      {type = "item", name = "solid-fuel", amount = 8},
      {type = "fluid", name = "steam", amount = 20, minimum_temperature = 100}
    },
    results = solid_fuel_results,
    icons = icons.composite("fluid", "tar", {
      {type = "item", name = "solid-fuel", shift = {-8, 8}},
      {type = "fluid", name = syngas, shift = {8, 8}}
    }),
    main_product = "tar",
    subgroup = "fluid-recipes",
    order = "a[fluid-chemistry]-y[wood-tar-synthesis-from-solid-fuel]",
    always_show_made_in = true,
    allow_decomposition = false
  },
  {
    type = "recipe",
    name = "wood-tar-syngas-liquefaction",
    categories = {"wood-syngas-liquefaction"},
    enabled = false,
    hidden = legacy_mode,
    energy_required = 5,
    ingredients = {
      {type = "fluid", name = "tar", amount = 24},
      {type = "fluid", name = syngas, amount = 30}
    },
    results = liquefaction_results,
    icons = icons.composite("fluid", "tar", {
      {type = "fluid", name = syngas, shift = {-8, 8}},
      {type = "fluid", name = "crude-oil", shift = {8, 8}}
    }),
    main_product = "crude-oil",
    subgroup = "fluid-recipes",
    order = "a[fluid-chemistry]-y[wood-tar-syngas-liquefaction]",
    always_show_made_in = true,
    allow_decomposition = false
  }
})

for _, recipe_name in ipairs({
  "wood-carbonization",
  "wood-tar-steam-reforming",
  "wood-tar-synthesis-from-charcoal",
  "wood-tar-synthesis-from-solid-fuel",
  "wood-tar-syngas-liquefaction"
}) do
  functions.add_unlock(syngas_technology, recipe_name)
end

local carbon = compatibility.find_prototype("carbon")
if carbon then
  data:extend({
    {
      type = "recipe",
      name = "wood-charcoal-purification",
      categories = {"advanced-crafting"},
      enabled = false,
      hidden = legacy_mode,
      energy_required = 5,
      ingredients = {{type = "item", name = "wood-charcoal", amount = 10}},
      results = {{type = "item", name = carbon, amount = 6}},
      icons = icons.composite("item", "wood-charcoal", {
        {type = "item", name = carbon, shift = {0, 8}}
      }),
      main_product = carbon,
      subgroup = "raw-material",
      order = "a[wood-products]-c[carbon]",
      always_show_made_in = true,
      allow_decomposition = false
    }
  })
  local carbon_technology = not legacy_mode and compatibility.find_unlock_technology("item", carbon)
  if not carbon_technology then carbon_technology = "advanced-wood-gas-processing" end
  functions.add_unlock(carbon_technology, "wood-charcoal-purification")
  log("Wood Gasification: using carbon item '" .. carbon .. "'.")
end
