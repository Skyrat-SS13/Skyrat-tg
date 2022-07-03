/// Checks that all automapper TOML entries actually link to a map and that the config exists.
/datum/unit_test/automapper
	var/config_path = "_maps/skyrat/automapper/automapper_config.toml"

/datum/unit_test/automapper/Run()
	var/test_config = rustg_read_toml_file(config_path)

	if(!test_config)
		TEST_FAIL("Automapper could not read/find TOML config [config_path]!")
		return

	for(var/template in test_config["templates"])
		var/selected_template = test_config["templates"][template]

		for(var/map in selected_template["map_files"])
			var/map_file = selected_template["directory"] + selected_template["map_files"][map]
			TEST_ASSERT(fexists(map_file), "[template] could not find map file [map_file]!")
