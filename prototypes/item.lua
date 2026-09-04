data:extend({
  {
    type = "item",
    name = "wood-charcoal",
    icon = "__Wood_Gasification_updated__/graphics/icon/wood-charcoal.png",
    icon_size = 64,
    subgroup = "raw-material",
    order = "a[wood-products]-a[wood-charcoal]",
    stack_size = 100,
    fuel_category = "chemical",
    fuel_value = "4MJ"
  }
})

if settings.startup["enable-greenhouse"].value then
  data:extend({
    {
      type = "item",
      name = "greenhouse",
      icon = "__Wood_Gasification_updated__/graphics/greenhouse/greenhouse_icon.png",
      icon_size = 64,
      subgroup = mods["space-age"] and "agriculture" or "production-machine",
      order = "0",
      stack_size = 10,
      place_result = "greenhouse",
      weight = 100 * kg
    }
  })
end
