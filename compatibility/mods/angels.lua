local functions = require("lib.functions")

local chemical_plants = {
  "chemical-plant",
  "angels-chemical-plant-2",
  "angels-chemical-plant-3",
  "angels-chemical-plant-4"
}

local function highest_available(names)
  local reference_machine
  for _, name in ipairs(names) do
    if functions.crafting_machine_is_available(name) then reference_machine = name end
  end
  return reference_machine
end

local function normalize_recipes(recipe_names, reference_machine)
  if not reference_machine then return end
  for _, recipe_name in ipairs(recipe_names) do
    functions.set_effective_recipe_time(recipe_name, reference_machine, 5)
  end
end

local function assign_to_machines(names, category, recipe_names)
  local reference_machine = highest_available(names)
  for _, name in ipairs(names) do
    if functions.crafting_machine_is_available(name) then
      functions.add_crafting_category(name, category)
    end
  end

  if reference_machine then
    for _, name in ipairs(chemical_plants) do
      functions.remove_crafting_category(name, category)
    end
  else
    for _, name in ipairs(chemical_plants) do
      if functions.crafting_machine_is_available(name) then
        functions.add_crafting_category(name, category)
      end
    end
    reference_machine = highest_available(chemical_plants)
  end

  normalize_recipes(recipe_names, reference_machine)
  return reference_machine
end

normalize_recipes({
  "wood-pyrolysis",
  "solid-fuel-from-tar",
  "wood-tar-steam-cracking",
  "hydrothermal-wood-pyrolysis"
}, highest_available(chemical_plants))

normalize_recipes({"wood-tar-steam-gasification"}, highest_available({
  "oil-refinery",
  "angels-oil-refinery-2",
  "angels-oil-refinery-3",
  "angels-oil-refinery-4"
}))

assign_to_machines({
  "angels-steam-cracker",
  "angels-steam-cracker-2",
  "angels-steam-cracker-3",
  "angels-steam-cracker-4"
}, "wood-syngas-reforming", {"wood-tar-steam-reforming"})

assign_to_machines({
  "angels-gas-refinery-small",
  "angels-gas-refinery-small-2",
  "angels-gas-refinery-small-3",
  "angels-gas-refinery-small-4"
}, "wood-syngas-charcoal-synthesis", {"wood-tar-synthesis-from-charcoal"})

assign_to_machines({
  "angels-separator",
  "angels-separator-2",
  "angels-separator-3",
  "angels-separator-4"
}, "wood-syngas-solid-fuel-synthesis", {"wood-tar-synthesis-from-solid-fuel"})

-- Only the advanced gas refinery has the two fluid inputs required for tar and synthesis gas.
assign_to_machines({
  "angels-gas-refinery",
  "angels-gas-refinery-2",
  "angels-gas-refinery-3",
  "angels-gas-refinery-4"
}, "wood-syngas-liquefaction", {"wood-tar-syngas-liquefaction"})

if not require("lib.config").legacy_mode()
  and settings.startup["wood-gasification-auto-unlock-byproduct-handling"].value
  and data.raw.recipe["angels-flare-stack"]
then
  for _, recipe_name in ipairs({
    "wood-tar-synthesis-from-charcoal",
    "wood-tar-syngas-liquefaction"
  }) do
    local synthesis_technology = functions.find_recipe_unlock(recipe_name)
    if synthesis_technology then
      functions.add_unlock(synthesis_technology, "angels-flare-stack")
    end
  end
end
