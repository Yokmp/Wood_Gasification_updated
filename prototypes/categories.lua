data:extend({
  {type = "recipe-category", name = "wood-syngas-reforming"},
  {type = "recipe-category", name = "wood-syngas-charcoal-synthesis"},
  {type = "recipe-category", name = "wood-syngas-solid-fuel-synthesis"},
  {type = "recipe-category", name = "wood-syngas-liquefaction"}
})

if settings.startup["enable-greenhouse"].value then
  data:extend({{type = "recipe-category", name = "R-greenhouse"}})
end

local functions = require("lib.functions")
functions.add_crafting_category("chemical-plant", "wood-syngas-reforming")
functions.add_crafting_category("chemical-plant", "wood-syngas-charcoal-synthesis")
functions.add_crafting_category("chemical-plant", "wood-syngas-solid-fuel-synthesis")
functions.add_crafting_category("chemical-plant", "wood-syngas-liquefaction")
