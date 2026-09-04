local util = require("lib.util")
local compatibility = {}

local definitions = {
  syngas = {
    prototype_type = "fluid",
    aliases = {"syngas", "synthesis-gas", "synthetic-gas", "gas-synthesis"},
    exclusions = {}
  },
  carbon = {
    prototype_type = "item",
    aliases = {"carbon", "coke"},
    exclusions = {"wood-charcoal", "carbon-fiber", "carbonic-acid", "carbon-dioxide", "carbon-monoxide", "carbon-composite"}
  },
  carbon_monoxide = {
    prototype_type = "fluid",
    aliases = {"carbon-monoxide", "gas-carbon-monoxide", "co-gas"},
    exclusions = {"carbon-dioxide"}
  },
  carbon_dioxide = {
    prototype_type = "fluid",
    aliases = {"carbon-dioxide", "gas-carbon-dioxide", "co2"},
    exclusions = {"carbon-monoxide"}
  }
}

local function normalize(name)
  return name:lower():gsub("[_ ]+", "-"):gsub("%-+", "-")
end

local function contains_token_sequence(name, alias)
  return ("-" .. normalize(name) .. "-"):find("-" .. normalize(alias) .. "-", 1, true) ~= nil
end

local function excluded(name, exclusions)
  for _, exclusion in ipairs(exclusions or {}) do
    if contains_token_sequence(name, exclusion) then return true end
  end
  return false
end

local function score(name, aliases)
  local normalized_name = normalize(name)
  for index, alias in ipairs(aliases) do
    if normalized_name == normalize(alias) then return 10000 - index end
  end
  for index, alias in ipairs(aliases) do
    if contains_token_sequence(normalized_name, alias) then
      return 1000 - index - #normalized_name / 1000
    end
  end
end

function compatibility.find_prototype(kind)
  local definition = definitions[kind]
  if not definition then return nil end
  local candidates = {}
  for name in pairs(data.raw[definition.prototype_type] or {}) do
    if not excluded(name, definition.exclusions) then
      local candidate_score = score(name, definition.aliases)
      if candidate_score then table.insert(candidates, {name = name, score = candidate_score}) end
    end
  end
  table.sort(candidates, function(a, b)
    if a.score == b.score then return a.name < b.name end
    return a.score > b.score
  end)
  return candidates[1] and candidates[1].name or nil
end

function compatibility.find_unlock_technology(prototype_type, prototype_name)
  local producers = {}
  for recipe_name, recipe in pairs(data.raw.recipe or {}) do
    if util.recipe_produces(recipe, prototype_type, prototype_name) then producers[recipe_name] = true end
  end

  local candidates = {}
  for technology_name, technology in pairs(data.raw.technology or {}) do
    for _, effect in ipairs(technology.effects or {}) do
      if effect.type == "unlock-recipe" and producers[effect.recipe] then
        local count = technology.unit and tonumber(technology.unit.count) or math.huge
        table.insert(candidates, {name = technology_name, count = count})
        break
      end
    end
  end
  table.sort(candidates, function(a, b)
    if a.count == b.count then return a.name < b.name end
    return a.count < b.count
  end)
  return candidates[1] and candidates[1].name or nil
end

return compatibility
