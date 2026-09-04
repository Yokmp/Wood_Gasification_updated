local config = {}

function config.legacy_mode()
  local setting = settings.startup["wood-gasification-legacy-mode"]
  return setting and setting.value or false
end

return config
