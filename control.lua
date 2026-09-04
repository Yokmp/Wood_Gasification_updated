local report_name = "wood-gasification-test-report"
local report_path = "Wood_Gasification_updated/test-report.json"

local function write_test_report()
  if not (prototypes and prototypes.mod_data) then return end
  local report = prototypes.mod_data[report_name]
  if not (report and report.data) then return end
  helpers.write_file(report_path, helpers.table_to_json(report.data), false)
end

script.on_init(write_test_report)
script.on_configuration_changed(write_test_report)
