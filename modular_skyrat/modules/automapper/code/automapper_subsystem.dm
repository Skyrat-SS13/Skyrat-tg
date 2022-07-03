/**
 * The AUTOMAPPER
 *
 * This is a subsystem designed to make modular mapping far easier.
 *
 * It does two things: Loads maps from an automapper config and loads area spawn datums for simpler items.
 *
 * The benefits? We no longer need to have _skyrat maps and can have a more unique feeling map experience as each time, it can be different.
 *
 * Please note, this uses some black magic to interject the templates mid world load to prevent mass runtimes down the line.
 */

SUBSYSTEM_DEF(automapper)
	name = "Automapper"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_AUTOMAPPER
	/// The path to our TOML file
	var/config_file = "_maps/skyrat/automapper/automapper_config.toml"
	/// Our loaded TOML file
	var/loaded_config
	/// Our preloaded map templates
	var/list/preloaded_map_templates = list()
	/// Have we been preloaded?
	var/preloaded = FALSE

/datum/controller/subsystem/automapper/Initialize(start_timeofday)
	loaded_config = rustg_read_toml_file(config_file)
	return ..()

/**
 * This will preload our templates into a cache ready to be loaded later.
 *
 * IMPORTANT: This requires Z levels to exist in order to function, so make sure it is preloaded AFTER that.
 */
/datum/controller/subsystem/automapper/proc/preload_templates_from_toml()
	if(preloaded)
		return
	loaded_config = rustg_read_toml_file(config_file)
	for(var/template in loaded_config["templates"])
		if(SSmapping.config.map_name != loaded_config["templates"][template]["required_map"])
			continue

		var/selected_template = loaded_config["templates"][template]

		var/list/coordinates = selected_template["coordinates"]
		if(LAZYLEN(coordinates) != 3)
			CRASH("Invalid coordinates for automap template [template]!")

		var/desired_z = SSmapping.levels_by_trait(ZTRAIT_STATION)[coordinates[3]]

		var/turf/load_turf = locate(coordinates[1], coordinates[2], desired_z)

		if(!LAZYLEN(selected_template["map_files"]))
			CRASH("Could not find any valid map files for automap template [template]!")

		var/map_file = loaded_config["directory"] + pick(selected_template["map_files"])

		var/datum/map_template/automap_template/map = new()

		map.preload(map_file, load_turf, selected_template["clear_everything"], template)

		preloaded_map_templates += map
	preloaded = TRUE

/**
 * Assuming we have preloaded our templates, this will load them from the cache.
 */
/datum/controller/subsystem/automapper/proc/load_templates_from_cache()
	for(var/datum/map_template/automap_template/iterating_template as anything in preloaded_map_templates)
		if(iterating_template.load(iterating_template.load_turf, FALSE))
			add_startup_message("AUTOMAPPER: Successfully loaded map template [iterating_template.name] at [iterating_template.load_turf.x], [iterating_template.load_turf.y], [iterating_template.load_turf.z]!")
/**
 * This returns a list of turfs that have been preloaded and preselected using our templates.
 *
 * Not really useful outside of load groups.
 */
/datum/controller/subsystem/automapper/proc/get_turf_blacklists(load_type)
	if(load_type != "Station")
		return
	var/list/blacklisted_turfs = list()
	for(var/datum/map_template/automap_template/iterating_template as anything in preloaded_map_templates)
		for(var/turf/iterating_turf as anything in iterating_template.get_affected_turfs(iterating_template.load_turf, FALSE))
			blacklisted_turfs += iterating_turf
	return blacklisted_turfs

