local util = require("lib.util")
local functions = {}

function functions.add_crafting_category(machine_name, category)
  local machine = data.raw["assembling-machine"] and data.raw["assembling-machine"][machine_name]
  if not machine then return false end
  machine.crafting_categories = machine.crafting_categories or {}
  util.insert_unique(machine.crafting_categories, category)
  return true
end

function functions.remove_crafting_category(machine_name, category)
  local machine = data.raw["assembling-machine"] and data.raw["assembling-machine"][machine_name]
  if not machine or not machine.crafting_categories then return false end
  for index = #machine.crafting_categories, 1, -1 do
    if machine.crafting_categories[index] == category then
      table.remove(machine.crafting_categories, index)
    end
  end
  return true
end

function functions.crafting_machine_is_available(machine_name)
  local machine = data.raw["assembling-machine"] and data.raw["assembling-machine"][machine_name]
  if not machine or machine.hidden then return false end

  for _, item_type in ipairs({"item", "item-with-entity-data"}) do
    for _, item in pairs(data.raw[item_type] or {}) do
      if item.place_result == machine_name and not item.hidden then return true end
    end
  end
  return false
end

function functions.set_effective_recipe_time(recipe_name, machine_name, duration)
  local recipe = data.raw.recipe and data.raw.recipe[recipe_name]
  local machine = data.raw["assembling-machine"] and data.raw["assembling-machine"][machine_name]
  if not recipe or not machine or not machine.crafting_speed then return false end
  recipe.energy_required = duration * machine.crafting_speed
  return true
end

function functions.add_unlock(technology_name, recipe_name)
  local technology = data.raw.technology and data.raw.technology[technology_name]
  if not technology then return false end
  technology.effects = technology.effects or {}
  for _, effect in ipairs(technology.effects) do
    if effect.type == "unlock-recipe" and effect.recipe == recipe_name then return true end
  end
  table.insert(technology.effects, {type = "unlock-recipe", recipe = recipe_name})
  return true
end

function functions.find_recipe_unlock(recipe_name)
  for technology_name, technology in pairs(data.raw.technology or {}) do
    for _, effect in ipairs(technology.effects or {}) do
      if effect.type == "unlock-recipe" and effect.recipe == recipe_name then return technology_name end
    end
  end
  return nil
end

return functions
