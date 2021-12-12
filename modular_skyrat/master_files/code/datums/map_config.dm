//used for holding information about unique properties of maps
//feed it json files that match the datum layout
//defaults to box
//  -Cyberboss

/datum/map_config
	// Metadata
	var/config_filename = "_maps/metastation.json"
	var/defaulted = TRUE  // set to FALSE by LoadConfig() succeeding
	// Config from maps.txt
	var/config_max_users = 0
	var/config_min_users = 0
	var/voteweight = 1
	var/votable = FALSE

	// Config actually from the JSON - should default to Meta
	var/map_name = "Meta Station"
	var/map_path = "map_files/MetaStation"
	var/map_file = "MetaStation_skyrat.dmm"

	var/traits = null
	var/space_ruin_levels = 3

	var/minetype = "lavaland"

	var/allow_custom_shuttles = TRUE
	var/shuttles = list(
		"cargo" = "cargo_skyrat",
		"ferry" = "ferry_fancy",
		"whiteship" = "whiteship_box",
		"emergency" = "emergency_skyrat")

	/// Dictionary of job sub-typepath to template changes dictionary
	var/job_changes = list()

	/// Type of the global trading hub that will be created
	var/global_trading_hub_type = /datum/trade_hub/worldwide
	/// A lazylist of types of trading hubs to be spawned
	var/localized_trading_hub_types = list(/datum/trade_hub/randomname, /datum/trade_hub/randomname)

	/// The type of the overmap object the station will act as on the overmap
	var/overmap_object_type = /datum/overmap_object/shuttle/station
	/// The weather controller the station levels will have
	var/weather_controller_type = /datum/weather_controller
	/// Type of our day and night controller, can be left blank for none
	var/day_night_controller_type
	/// Type of the atmosphere that will be loaded on station
	var/atmosphere_type
	/// Possible rock colors of the loaded map
	var/list/rock_color
	/// Possible plant colors of the loaded map
	var/list/plant_color
	/// Possible grass colors of the loaded map
	var/list/grass_color
	/// Possible water colors of the loaded map
	var/list/water_color

	var/amount_of_planets_spawned = 1

	var/ore_node_seeder_type

/**
 * Proc that simply loads the default map config, which should always be functional.
 */
/proc/load_default_map_config()
	return new /datum/map_config


/**
 * Proc handling the loading of map configs. Will return the default map config using [/proc/load_default_map_config] if the loading of said file fails for any reason whatsoever, so we always have a working map for the server to run.
 * Arguments:
 * * filename - Name of the config file for the map we want to load. The .json file extension is added during the proc, so do not specify filenames with the extension.
 * * directory - Name of the directory containing our .json - Must be in MAP_DIRECTORY_WHITELIST. We default this to MAP_DIRECTORY_MAPS as it will likely be the most common usecase. If no filename is set, we ignore this.
 * * error_if_missing - Bool that says whether failing to load the config for the map will be logged in log_world or not as it's passed to LoadConfig().
 *
 * Returns the config for the map to load.
 */
/proc/load_map_config(filename = null, directory = null, error_if_missing = TRUE)
	var/datum/map_config/config = load_default_map_config()

	if(filename) // If none is specified, then go to look for next_map.json, for map rotation purposes.

		//Default to MAP_DIRECTORY_MAPS if no directory is passed
		if(directory)
			if(!(directory in MAP_DIRECTORY_WHITELIST))
				log_world("map directory not in whitelist: [directory] for map [filename]")
				return config
		else
			directory = MAP_DIRECTORY_MAPS

		filename = "[directory]/[filename].json"
	else
		filename = PATH_TO_NEXT_MAP_JSON


	if (!config.LoadConfig(filename, error_if_missing))
		qdel(config)
		return load_default_map_config()
	return config


#define CHECK_EXISTS(X) if(!istext(json[X])) { log_world("[##X] missing from json!"); return; }
/datum/map_config/proc/LoadConfig(filename, error_if_missing)
	if(!fexists(filename))
		if(error_if_missing)
			log_world("map_config not found: [filename]")
		return

	var/json = file(filename)
	if(!json)
		log_world("Could not open map_config: [filename]")
		return

	json = file2text(json)
	if(!json)
		log_world("map_config is not text: [filename]")
		return

	json = json_decode(json)
	if(!json)
		log_world("map_config is not json: [filename]")
		return

	config_filename = filename

	if(!json["version"])
		log_world("map_config missing version!")
		return

	if(json["version"] != MAP_CURRENT_VERSION)
		log_world("map_config has invalid version [json["version"]]!")
		return

	CHECK_EXISTS("map_name")
	map_name = json["map_name"]
	CHECK_EXISTS("map_path")
	map_path = json["map_path"]

	map_file = json["map_file"]
	// "map_file": "MetaStation.dmm"
	if (istext(map_file))
		if (!fexists("_maps/[map_path]/[map_file]"))
			log_world("Map file ([map_path]/[map_file]) does not exist!")
			return
	// "map_file": ["Lower.dmm", "Upper.dmm"]
	else if (islist(map_file))
		for (var/file in map_file)
			if (!fexists("_maps/[map_path]/[file]"))
				log_world("Map file ([map_path]/[file]) does not exist!")
				return
	else
		log_world("map_file missing from json!")
		return

	if (islist(json["shuttles"]))
		var/list/L = json["shuttles"]
		for(var/key in L)
			var/value = L[key]
			shuttles[key] = value
	else if ("shuttles" in json)
		log_world("map_config shuttles is not a list!")
		return

	shuttles["emergency"] = "emergency_skyrat"

	traits = json["traits"]
	// "traits": [{"Linkage": "Cross"}, {"Space Ruins": true}]
	if (islist(traits))
		// "Station" is set by default, but it's assumed if you're setting
		// traits you want to customize which level is cross-linked
		for (var/level in traits)
			var/list/level_traits = level
			var/base_traits_station = ZTRAITS_STATION
			for(var/trait_to_validate in base_traits_station)
				if(!level_traits[trait_to_validate])
					level_traits[trait_to_validate] = base_traits_station[trait_to_validate]
	// "traits": null or absent -> default
	else if (!isnull(traits))
		log_world("map_config traits is not a list!")
		return

	var/temp = json["space_ruin_levels"]
	if (isnum(temp))
		space_ruin_levels = temp
	else if (!isnull(temp))
		log_world("map_config space_ruin_levels is not a number!")
		return

	if ("minetype" in json)
		minetype = json["minetype"]

	allow_custom_shuttles = json["allow_custom_shuttles"] != FALSE

	if ("job_changes" in json)
		if(!islist(json["job_changes"]))
			log_world("map_config \"job_changes\" field is missing or invalid!")
			return
		job_changes = json["job_changes"]

	if(json["overmap_object_type"])
		overmap_object_type = text2path(json["overmap_object_type"])

	if(json["weather_controller_type"])
		weather_controller_type = text2path(json["weather_controller_type"])

	if(json["day_night_controller_type"])
		day_night_controller_type = text2path(json["day_night_controller_type"])

	if(json["atmosphere_type"])
		atmosphere_type = text2path(json["atmosphere_type"])

	if ("rock_color" in json)
		if(islist(json["rock_color"]))
			rock_color = json["rock_color"]

	if ("plant_color" in json)
		if(islist(json["plant_color"]))
			plant_color = json["plant_color"]

	if ("grass_color" in json)
		if(islist(json["grass_color"]))
			grass_color = json["grass_color"]

	if ("water_color" in json)
		if(islist(json["water_color"]))
			water_color = json["water_color"]

	if(json["amount_of_planets_spawned"])
		atmosphere_type = text2path(json["amount_of_planets_spawned"])

	temp = json["amount_of_planets_spawned"]
	if(isnum(temp))
		amount_of_planets_spawned = temp

	if(json["ore_node_seeder_type"])
		ore_node_seeder_type = text2path(json["ore_node_seeder_type"])

	if(json["global_trading_hub_type"])
		global_trading_hub_type = text2path(json["global_trading_hub_type"])

	if(json["ore_node_seeder_type"])
		atmosphere_type = text2path(json["ore_node_seeder_type"])

	if(json["localized_trading_hub_types"])
		var/list/hub_types = json["localized_trading_hub_types"]
		for(var/hub_type in hub_types)
			localized_trading_hub_types += text2path(hub_type)

	defaulted = FALSE
	return TRUE
#undef CHECK_EXISTS

/datum/map_config/proc/GetFullMapPaths()
	if (istext(map_file))
		return list("_maps/[map_path]/[map_file]")
	. = list()
	for (var/file in map_file)
		. += "_maps/[map_path]/[file]"

/datum/map_config/proc/MakeNextMap()
	return config_filename == PATH_TO_NEXT_MAP_JSON || fcopy(config_filename, PATH_TO_NEXT_MAP_JSON)
