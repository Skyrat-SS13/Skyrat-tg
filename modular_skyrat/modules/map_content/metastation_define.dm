/datum/map_config/metastation
	map_name = "Meta Station"
	map_path = "map_files/MetaStation"
	map_file = "MetaStation.dmm"

	traits = null
	space_ruin_levels = 3

	minetype = "lavaland"

	allow_custom_shuttles = TRUE
	shuttles = list(
		"cargo" = "cargo_box",
		"ferry" = "ferry_fancy",
		"whiteship" = "whiteship_box",
		"emergency" = "emergency_box")

	job_changes = list()

	overmap_object_type = /datum/overmap_object/shuttle/station
