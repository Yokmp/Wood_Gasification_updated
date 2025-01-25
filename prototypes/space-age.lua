
--- RECIPES ---
if mods["space-age"] then
  data:extend({
    {
        type = "recipe",
        name = "yumako-seed-greenhouse",
        category = "R-greenhouse",
        subgroup = "agriculture-processes",
        order = "a[2-yumako]",
        localised_name = {"", {"entity-name.E-greenhouse"}, " ", {"item-name.yumako-seed"}},
        localised_description = {"", {"entity-description.E-greenhouse"}},
        icon = "__space-age__/graphics/icons/yumako-seed.png",
        enabled = false,
        show_amount_in_title = true,
        energy_required = 20 / settings.startup["greenhouse-output-pr-sec-yumako"].value,
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
        name = "jellynut-seed-greenhouse",
        category = "R-greenhouse",
        subgroup = "agriculture-processes",
        order = "a[3-jellynut]",
        localised_name = {"", {"entity-name.E-greenhouse"}, " ", {"item-name.jellynut-seed"}},
        localised_description = {"", {"entity-description.E-greenhouse"}},
        icon = "__space-age__/graphics/icons/jellynut-seed.png",
        enabled = false,
        show_amount_in_title = true,
        energy_required = 20 / settings.startup["greenhouse-output-pr-sec-jellynut"].value,
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
        subgroup = "agriculture-processes",
        order = "a[1-wood]",
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
        energy_required = 20 / settings.startup["greenhouse-output-pr-sec-wood"].value,
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
if mods["space-age"] then
  table.insert( data.raw.technology["agriculture" ].effects, { type = "unlock-recipe", recipe = "greenhouse"               })
  table.insert( data.raw.technology["tree-seeding"].effects, { type = "unlock-recipe", recipe = "wood-seed-greenhouse"     })
  table.insert( data.raw.technology["yumako"      ].effects, { type = "unlock-recipe", recipe = "yumako-seed-greenhouse"   })
  table.insert( data.raw.technology["jellynut"    ].effects, { type = "unlock-recipe", recipe = "jellynut-seed-greenhouse" })
  if not settings.startup["require-gleba-for-greenhouse-tech"].value then
    table.insert( data.raw.technology["wood-gas-processing"].effects, { type = "unlock-recipe", recipe = "greenhouse"           })
    table.insert( data.raw.technology["wood-gas-processing"].effects, { type = "unlock-recipe", recipe = "wood-seed-greenhouse" })
  end
else
  table.insert( data.raw.technology["wood-gas-processing"].effects, { type = "unlock-recipe", recipe = "greenhouse"      })    
  table.insert( data.raw.technology["wood-gas-processing"].effects, { type = "unlock-recipe", recipe = "wood-greenhouse" })    
end

--- TREE-SEEDS ---
if mods["space-age"] then
  local function addSeedDrops(Table)
    -- Calculates value range and probability for tree seed drops (average amount may go above 1):
    local setting = settings.startup["tree-seed-probability"].value
    local seed_min = 0
    local seed_max = math.ceil(setting * 2) -- factor should not be lower than 2 in this setup!
    local seed_prob = setting / (0.5 * (seed_min + seed_max))    
    -- Identifies trees and adds the tree seed as a potential drop:
    for _, Tree in pairs(Table) do
      if setting == 0 then goto continue end
      if not string.match(Tree.name, "^tree%-") then goto continue end -- *
      if not Tree.minable then goto continue end
      local result_wood = {
        type = "item", name = "wood", amount = Tree.minable.count or 4
      }
      local result_seed = {
        type = "item", name = "tree-seed", amount_min  = seed_min, amount_max  = seed_max, probability = seed_prob
      }
      if Tree.minable.results then    -- loaded first, so checked first
        table.insert(Tree.minable.results, result_seed)
      elseif Tree.minable.result then -- loaded if "results" doesn't exist
        Tree.minable.results = {result_wood, result_seed}
      end
      -- log(serpent.block({Tree.name, Tree.minable.results[2].probability}))
      ::continue::
    end
  end

  for _, v in pairs({"tree", "plant"}) do addSeedDrops(data.raw[v]) end -- *
    
  -- * Best criterium I could find. Seeds will drop from all normal tree variants, including planted
  --   ones. They will not drop from dry or dead trees, nor from sugar canes.

end
