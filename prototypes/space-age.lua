
--- RECIPES ---
if mods["space-age"] then
  data:extend({
    {
        type = "recipe",
        name = "yumako-seed-greenhouse",
        category = "R-greenhouse",
        localised_name = {"", {"entity-name.E-greenhouse"}, " ", {"item-name.yumako-seed"}},
        localised_description = {"", {"entity-description.E-greenhouse"}},
        icon = "__space-age__/graphics/icons/yumako-seed.png",
        enabled = false,
        show_amount_in_title = true,
        energy_required = 60,
        ingredients = {
            {type = "fluid", name = "water", amount = 120},
            {type = "item", name = "spoilage", amount = 4,},
            {type = "item", name = "yumako-seed", amount = 1}
        },
        results = {
            {type = "item", name = "yumako", amount = 20},
            {type = "item", name = "spoilage", amount = 4, probability = 0.25}
        }
    },
    {
        type = "recipe",
        category = "R-greenhouse",
        name = "jellynut-seed-greenhouse",
        localised_name = {"", {"entity-name.E-greenhouse"}, " ", {"item-name.jellynut-seed"}},
        localised_description = {"", {"entity-description.E-greenhouse"}},
        icon = "__space-age__/graphics/icons/jellynut-seed.png",
        enabled = false,
        show_amount_in_title = true,
        energy_required = 60,
        ingredients = {
            {type = "fluid", name = "water", amount = 120},
            {type = "item", name = "spoilage", amount = 4,},
            {type = "item", name = "jellynut-seed", amount = 1}
        },
        results = {
            {type = "item", name = "jellynut", amount = 20},
            {type = "item", name = "spoilage", amount = 4, probability = 0.25}
        }
    },
    {
        type = "recipe",
        name = "wood-seed-greenhouse",
        category = "R-greenhouse",
        localised_name = {"", {"entity-name.E-greenhouse"}, " ", {"item-name.tree-seed"}},
        localised_description = {"", {"entity-description.E-greenhouse"}},
        icons = {
            -- {
            --     icon = "__base__/graphics/icons/wood.png"
            -- },
            {
                icon = "__space-age__/graphics/icons/tree-seed.png",
                -- scale = 0.3,
                -- shift = {0,0}
            },
        },
        enabled = false,
        show_amount_in_title = true,
        energy_required = 30,
        surface_conditions =
        {
            {
                property = "pressure",
                min = 0,
                max = 2000
            },
            {
                property = "gravity",
                min = 2,
                max = 20
            }
        },
        ingredients = {
            {type = "fluid", name = "water", amount = 200},
            {type = "item",  name = "tree-seed", amount = 5}
        },
        results = {
            {type = "item", name = "wood", amount = 20},
            {type = "item", name = "tree-seed", amount = 6}
        }
    },

--- SPRITES ---
    {
      type = "sprite",
      name = "gleba",
      filename = "__space-age__/graphics/icons/gleba.png",
      priority = "extra-high",
      width = 64,
      height = 64,
    },
  })
end

--- TECHNOLOGY ---
if mods["space-age"] and settings.startup["use-gleba"].value then
  table.insert( data.raw.technology["agriculture"].effects, { type = "unlock-recipe", recipe = "greenhouse" })
  table.insert(data.raw.technology["tree-seeding"].effects, { type = "unlock-recipe", recipe = "wood-seed-greenhouse" })
  table.insert(data.raw.technology["yumako"].effects, { type = "unlock-recipe", recipe = "yumako-seed-greenhouse" })
  table.insert(data.raw.technology["jellynut"].effects, { type = "unlock-recipe", recipe = "jellynut-seed-greenhouse" })
else
  table.insert( data.raw.technology["wood-gas-processing"].effects, { type = "unlock-recipe", recipe = "greenhouse" })
  if mods["space-age"] then
    table.insert(data.raw.technology["tree-seeding"].effects, { type = "unlock-recipe", recipe = "wood-seed-greenhouse" })
  end
end

--- TREE-SEEDS ---
if mods["space-age"] then
  local seed_probability = tonumber(settings.startup["seed-probability"].value)
  if type(seed_probability) ~= "number" then seed_probability = 0.12 end
  if seed_probability > 1 then seed_probability = seed_probability/100 end

  local t = data.raw.tree
  -- data.raw.tree["dead-tree-desert"].minable = nil
  for _, value in pairs(t) do
    if address_exists(value, "minable", "result") and value.minable.result == "wood" then
      value.minable.results = {
        {type = "item", name = "wood", amount = value.minable.count or 4},
        {type = "item", name = "tree-seed", amount = 1, probability = seed_probability},
      }
      -- log(serpent.block({value.name, value.minable.results[2].probability}))
    end
  end
end