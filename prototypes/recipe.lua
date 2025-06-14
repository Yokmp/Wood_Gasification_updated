
data:extend({
  {
    type = "recipe",
    name = "wood-gasification",
    category = "chemistry",
    enabled = false,
    energy_required = 5,
    ingredients = {
      {type="item", name="wood", amount=10},
    },
    results = {
      {type="fluid", name="petroleum-gas", amount=20},
      {type="fluid", name="tar", amount=8},
    },
    icon = "__Wood_Gasification_updated__/graphics/icon/wood-gasification.png",
    icon_size = 64,
    subgroup = "fluid-recipes",
    order = "a[fluid-chemistry]-w[wood-gas-processing]",
-- order = "a-w",
    crafting_machine_tint =
    {
      primary = {r = 0.698, g = 0.698, b = 0.698, a = 0.000}, -- #7f7f7f00
      secondary = {r = 0.400, g = 0.400, b = 0.400, a = 0.000}, -- #66666600
      tertiary = {r = 0.305, g = 0.305, b = 0.305, a = 0.000}, -- #4d4d4d00
    },
    always_show_products = true,
    always_show_made_in = true,
    allow_decomposition = false,
  },
  {
    type = "recipe",
    name = "solid-fuel-from-tar",
    category = "chemistry",
    enabled = false,
    energy_required = 5,
    ingredients = {
      {type="fluid", name="tar", amount=32},
    },
    results = {
      {type="item", name="solid-fuel", amount=1},
    },
    icon = "__Wood_Gasification_updated__/graphics/icon/solid-fuel-from-tar.png",
    icon_size = 64,
    subgroup = "fluid-recipes",
    order = "a[fluid-chemistry]-w[solid-fuel-from-tar]",
  -- order = "a-w",
    crafting_machine_tint =
    {
      primary = {r = 0.000, g = 0.000, b = 0.000, a = 0.000}, -- #00000000
      secondary = {r = 0.000, g = 0.000, b = 0.000, a = 0.000}, -- #00000000
      tertiary = {r = 0.000, g = 0.000, b = 0.000, a = 0.000}, -- #00000000
    },
    always_show_products = true,
    always_show_made_in = true,
    allow_decomposition = false,
  },
  {
    type = "recipe",
    name = "crude-oil-from-tar",
    category = "chemistry",
    enabled = false,
    energy_required = 5,
    ingredients = {
      {type="fluid", name="tar", amount=32},
      {type="fluid", name="water", amount=200},
    },
    results = {
      {type="fluid", name="crude-oil", amount=40},
    },
    icon = "__Wood_Gasification_updated__/graphics/icon/crude-oil-from-tar.png",
    icon_size = 64,
    subgroup = "fluid-recipes",
    order = "a[fluid-chemistry]-w[crude-oil-from-tar]",
-- order = "a-w",
    crafting_machine_tint =
    {
      primary = {r = 0.290, g = 0.027, b = 0.000, a = 0.000}, -- #49060000
      secondary = {r = 0.722, g = 0.465, b = 0.190, a = 0.000}, -- #b8763000
      tertiary = {r = 0.870, g = 0.365, b = 0.000, a = 0.000}, -- #dd5d0000
    },
    always_show_products = true,
    always_show_made_in = true,
    allow_decomposition = false,
  },
  {
    type = "recipe",
    name = "advanced-wood-gasification",
    category = "oil-processing",
    enabled = false,
    energy_required = 10,
    ingredients =
    {
      {type="item", name="wood", amount=20},
      {type="fluid", name="water", amount=200}
    },
    results=
    {
      {type="fluid", name="heavy-oil", amount=15},
      {type="fluid", name="light-oil", amount=15},
      {type="fluid", name="petroleum-gas", amount=30}
    },
    icon = "__Wood_Gasification_updated__/graphics/icon/advanced-wood-gasification.png",
    icon_size = 64,
    subgroup = "fluid-recipes",
    order = "a[oil-processing]-w[advanced-wood-gasification]",
-- order = "a-w",
    always_show_products = true,
    always_show_made_in = true,
    allow_decomposition = false,
  },

------------------
--- GREENHOUSE ---
------------------

  {
    type = "recipe",
    name = "greenhouse",
    enabled = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "stone-brick", amount = 8},
      {type = "item", name = "pipe", amount = 5},
      {type = "item", name = "iron-plate", amount = 10}
    },
    results = {{type = "item", name = "greenhouse", amount = 1}}
  },
  {
    type = "recipe",
    name = "wood-greenhouse",
    category = "R-greenhouse",
    enabled = false,
    show_amount_in_title = true,
    energy_required = 20 / settings.startup["greenhouse-output-pr-sec-wood"].value,
    ingredients = {
      {type = "fluid", name = "water", amount = 200},
      {type = "item", name = "wood", amount = 20}
    },
    results = {{type = "item", name = "wood", amount = 40}}
  },
  {
    type = "recipe-category",
    name = "R-greenhouse"
  }
})
