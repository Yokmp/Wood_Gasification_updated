local icons = {}

function icons.prototype_layers(prototype_type, prototype_name)
  local prototype = data.raw[prototype_type] and data.raw[prototype_type][prototype_name]
  if not prototype then return {} end
  if prototype.icons then
    local layers = table.deepcopy(prototype.icons)
    for _, layer in ipairs(layers) do layer.icon_size = layer.icon_size or prototype.icon_size end
    return layers
  end
  if prototype.icon then return {{icon = prototype.icon, icon_size = prototype.icon_size or 64}} end
  return {}
end

function icons.scaled_layers(prototype_type, prototype_name, scale, shift)
  local layers = icons.prototype_layers(prototype_type, prototype_name)
  for _, layer in ipairs(layers) do
    local original_shift = layer.shift or {0, 0}
    local x = original_shift[1] or original_shift.x or 0
    local y = original_shift[2] or original_shift.y or 0
    layer.scale = (layer.scale or 1) * scale
    layer.shift = {x * scale + shift[1], y * scale + shift[2]}
  end
  return layers
end

function icons.composite(base_type, base_name, overlays)
  local layers = icons.prototype_layers(base_type, base_name)
  for _, overlay in ipairs(overlays or {}) do
    for _, layer in ipairs(icons.scaled_layers(
      overlay.type, overlay.name, overlay.scale or 0.5, overlay.shift or {0, 8}
    )) do
      table.insert(layers, layer)
    end
  end
  return layers
end

return icons
