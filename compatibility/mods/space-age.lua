local functions = require("lib.functions")

-- Space Age greenhouse recipes and technology integration.

data:extend({
  {
    type = "recipe",
    name = "yumako-seed-greenhouse",
    categories = {"R-greenhouse"},
    subgroup = "agriculture-processes",
    order = "a[2-yumako]",
    localised_name = {"", {"entity-name.greenhouse"}, " ", {"item-name.yumako-seed"}},
    localised_description = {"entity-description.greenhouse"},
    icon = "__space-age__/graphics/icons/yumako-seed.png",
    icon_size = 64,
    enabled = false,
    energy_required = 20 / settings.startup["greenhouse-output-pr-sec-yumako"].value,
    ingredients = {
      {type = "fluid", name = "water", amount = 120},
      {type = "item", name = "spoilage", amount = 4},
      {type = "item", name = "yumako-seed", amount = 1}
    },
    results = {
      {type = "item", name = "yumako", amount = 20},
      {type = "item", name = "spoilage", amount = 4, independent_probability = 0.25}
    }
  },
  {
    type = "recipe",
    name = "jellynut-seed-greenhouse",
    categories = {"R-greenhouse"},
    subgroup = "agriculture-processes",
    order = "a[3-jellynut]",
    localised_name = {"", {"entity-name.greenhouse"}, " ", {"item-name.jellynut-seed"}},
    localised_description = {"entity-description.greenhouse"},
    icon = "__space-age__/graphics/icons/jellynut-seed.png",
    icon_size = 64,
    enabled = false,
    energy_required = 20 / settings.startup["greenhouse-output-pr-sec-jellynut"].value,
    ingredients = {
      {type = "fluid", name = "water", amount = 120},
      {type = "item", name = "spoilage", amount = 4},
      {type = "item", name = "jellynut-seed", amount = 1}
    },
    results = {
      {type = "item", name = "jellynut", amount = 20},
      {type = "item", name = "spoilage", amount = 4, independent_probability = 0.25}
    }
  },
  {
    type = "recipe",
    name = "wood-seed-greenhouse",
    categories = {"R-greenhouse"},
    subgroup = "agriculture-processes",
    order = "a[1-wood]",
    localised_name = {"", {"entity-name.greenhouse"}, " ", {"item-name.tree-seed"}},
    localised_description = {"entity-description.greenhouse"},
    icon = "__space-age__/graphics/icons/tree-seed.png",
    icon_size = 64,
    enabled = false,
    energy_required = 20 / settings.startup["greenhouse-output-pr-sec-wood"].value,
    surface_conditions = {
      {property = "pressure", min = 0, max = 2000},
      {property = "gravity", min = 2, max = 20}
    },
    ingredients = {
      {type = "fluid", name = "water", amount = 200},
      {type = "item", name = "tree-seed", amount = 5}
    },
    results = {
      {type = "item", name = "wood", amount = 20},
      {type = "item", name = "tree-seed", amount = 6}
    }
  },
  {
    type = "sprite",
    name = "gleba",
    filename = "__space-age__/graphics/icons/gleba.png",
    priority = "extra-high",
    width = 64,
    height = 64
  }
})

if settings.startup["require-gleba-for-greenhouse-tech"].value then
  functions.add_unlock("agriculture", "greenhouse")
  functions.add_unlock("tree-seeding", "wood-seed-greenhouse")
else
  functions.add_unlock("wood-gas-processing", "greenhouse")
  functions.add_unlock("wood-gas-processing", "wood-seed-greenhouse")
end
functions.add_unlock("yumako", "yumako-seed-greenhouse")
functions.add_unlock("jellynut", "jellynut-seed-greenhouse")

local probability = settings.startup["tree-seed-probability"].value
if probability > 0 then
  local seed_min = 0
  local seed_max = math.ceil(probability * 2)
  local seed_probability = probability / (0.5 * (seed_min + seed_max))

  for _, prototype_type in ipairs({"tree", "plant"}) do
    for _, tree in pairs(data.raw[prototype_type] or {}) do
      if tree.name:match("^tree%-") and tree.minable then
        local seed_result = {
          type = "item",
          name = "tree-seed",
          amount_min = seed_min,
          amount_max = seed_max,
          independent_probability = seed_probability
        }
        if tree.minable.results then
          table.insert(tree.minable.results, seed_result)
        elseif tree.minable.result then
          tree.minable.results = {
            {type = "item", name = tree.minable.result, amount = tree.minable.count or 1},
            seed_result
          }
          tree.minable.result = nil
          tree.minable.count = nil
        end
      end
    end
  end
end
