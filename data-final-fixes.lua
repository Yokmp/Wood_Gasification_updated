require("compatibility.optional-recipes")

if mods["angelspetrochem"] then require("compatibility.mods.angels") end

if settings.startup["wood-gasification-test-mode"].value then
  local profile = require("tools.test.profile")
  local report = require("tools.test.runner").run(profile)
  data:extend({{type = "mod-data", name = "wood-gasification-test-report", data = report}})
end
