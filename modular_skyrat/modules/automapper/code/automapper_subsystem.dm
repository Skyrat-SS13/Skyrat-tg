/**
 * The AUTOMAPPER
 *
 * This is a subsystem designed to make modular mapping far easier.
 *
 * It does two things: Loads maps from an automapper config and loads area spawn datums for simpler items.
 *
 * The benefits? We no longer need to have _skyrat maps and can have a more unique feeling map experience as each time, it can be different.
 */

SUBSYSTEM_DEF(automapper)
	name = "Automapper"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_MINOR_MAPPING
	/// The path to our TOML file
	var/config_file = "_maps/skyrat/automapper/automapper_config.toml"
	/// Our loaded TOML file
	var/loaded_config

/datum/controller/subsystem/automapper/Initialize(start_timeofday)
	loaded_config = rustg_read_toml_file(config_file)
	load_templates_from_toml()
	load_area_spawn_datums()
	return ..()

/datum/controller/subsystem/automapper/proc/load_templates_from_toml()
	for(var/template in loaded_config["templates"])
		if(SSmapping.config.map_name != loaded_config["templates"][template]["required_map"])
			continue

		var/selected_template = loaded_config["templates"][template]

		var/list/coordinates = selected_template["coordinates"]
		if(LAZYLEN(coordinates) != 3)
			CRASH("Invalid coordinates for automap template [template]!")

		var/desired_z = SSmapping.levels_by_trait(ZTRAIT_STATION)[coordinates[3]]

		var/turf/load_turf = locate(coordinates[1], coordinates[2], desired_z)

		if(!load_turf)
			CRASH("Could not find a valid turf for automap template [template]!")

		if(!LAZYLEN(selected_template["map_files"]))
			CRASH("Could not find any valid map files for automap template [template]!")

		var/map_file = loaded_config["directory"] + pick(selected_template["map_files"])

		var/datum/map_template/automap_template/map = new()

		if(map.load(load_turf, FALSE, map_file, selected_template["clear_everything"]))
			add_startup_message("AUTOMAPPER: Successfully loaded map template [template] at [load_turf.x], [load_turf.y], [load_turf.z]!")
			log_mapping("AUTOMAPPER: Successfully loaded map template [template] at [load_turf.x], [load_turf.y], [load_turf.z]!")

/datum/controller/subsystem/automapper/proc/load_area_spawn_datums()
	for(var/iterating_type in subtypesof(/datum/area_spawn))
		var/datum/area_spawn/iterating_area_spawn = new iterating_type
		iterating_area_spawn.try_spawn()
