local util = {}

function util.contains(values, expected)
  for _, value in ipairs(values or {}) do
    if value == expected then return true end
  end
  return false
end

function util.insert_unique(values, value)
  if not util.contains(values, value) then table.insert(values, value) end
end

function util.recipe_produces(recipe, prototype_type, prototype_name)
  for _, result in pairs((recipe and recipe.results) or {}) do
    if result.name == prototype_name and (result.type or "item") == prototype_type then return true end
  end
  return false
end

return util
