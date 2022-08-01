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
 *
 * LIMITED SUPPORT FOR NON-STATION LEVELS(until someone adds a better Z level handling system for this)
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

/datum/controller/subsystem/automapper/Initialize(start_timeofday)
	loaded_config = rustg_read_toml_file(config_file)
	return ..()

/**
 * This will preload our templates into a cache ready to be loaded later.
 *
 * IMPORTANT: This requires Z levels to exist in order to function, so make sure it is preloaded AFTER that.
 */
/datum/controller/subsystem/automapper/proc/preload_templates_from_toml(map_names)
	if(!islist(map_names))
		map_names = list(map_names)
	for(var/template in loaded_config["templates"])
		var/selected_template = loaded_config["templates"][template]
		var/required_map = selected_template["required_map"]

		// !builtin is a magic code for built in maps, ie CentCom levels.
		// We'll pretend it's loaded with the station z-level, because they by definition they are loaded before the station z-levels.
		var/requires_builtin = (required_map == AUTOMAPPER_MAP_BUILTIN) && ((SSmapping.config.map_file in map_names) || SSmapping.config.map_file == map_names)

		if(!requires_builtin && !(required_map in map_names))
			continue

		var/list/coordinates = selected_template["coordinates"]
		if(LAZYLEN(coordinates) != 3)
			CRASH("Invalid coordinates for automap template [template]!")

		var/desired_z = SSmapping.levels_by_trait(selected_template["trait_name"])[coordinates[3]]

		var/turf/load_turf = locate(coordinates[1], coordinates[2], desired_z)

		if(!LAZYLEN(selected_template["map_files"]))
			CRASH("Could not find any valid map files for automap template [template]!")

		var/map_file = selected_template["directory"] + pick(selected_template["map_files"])

		if(!fexists(map_file))
			CRASH("[template] could not find map file [map_file]!")

		var/datum/map_template/automap_template/map = new(map_file, template, required_map, load_turf)
		preloaded_map_templates += map

/**
 * Assuming we have preloaded our templates, this will load them from the cache.
 */
/datum/controller/subsystem/automapper/proc/load_templates_from_cache(map_names)
	if(!islist(map_names))
		map_names = list(map_names)
	for(var/datum/map_template/automap_template/iterating_template as anything in preloaded_map_templates)
		if(iterating_template.affects_builtin_map && ((SSmapping.config.map_file in map_names) || SSmapping.config.map_file == map_names))
			// CentComm already started loading objects, place them in the netherzone
			for(var/turf/old_turf as anything in iterating_template.get_affected_turfs(iterating_template.load_turf, FALSE))
				init_contents(old_turf)
		else if(!(iterating_template.required_map in map_names))
			continue
		if(iterating_template.load(iterating_template.load_turf, FALSE))
			add_startup_message("Loaded [iterating_template.name] at [iterating_template.load_turf.x], [iterating_template.load_turf.y], [iterating_template.load_turf.z]!")
			log_world("AUTOMAPPER: Successfully loaded map template [iterating_template.name] at [iterating_template.load_turf.x], [iterating_template.load_turf.y], [iterating_template.load_turf.z]!")

/**
 * CentCom atoms aren't initialized but already exist, so must be properly initialized and then qdel'd.
 * Arguments:
 * * parent - parent turf
 */
/datum/controller/subsystem/automapper/proc/init_contents(atom/parent)
	var/static/list/mapload_args = list(TRUE)
	// Don't even initialize things in this list. Very specific edge cases.
	var/static/list/type_blacklist = typecacheof(list(
		/obj/docking_port/stationary,
		/obj/structure/bookcase,
		/obj/structure/closet,
		/obj/item/storage,
		/obj/item/reagent_containers,
	))

	var/previous_initialized_value = SSatoms.initialized
	SSatoms.initialized = INITIALIZATION_INNEW_MAPLOAD

	// Force everything to init as if INITIALIZE_IMMEDIATE was called on them.
	for(var/atom/atom_to_init as anything in parent.get_all_contents_ignoring(type_blacklist) - parent)
		if(atom_to_init.flags_1 & INITIALIZED_1)
			continue
		SSatoms.InitAtom(atom_to_init, FALSE, mapload_args)

	SSatoms.initialized = previous_initialized_value

	// NOW we can finally delete everything.
	for(var/atom/atom_to_del as anything in parent.get_all_contents() - parent)
		qdel(atom_to_del, TRUE)

/**
 * This returns a list of turfs that have been preloaded and preselected using our templates.
 *
 * Not really useful outside of load groups.
 */
/datum/controller/subsystem/automapper/proc/get_turf_blacklists(map_names)
	if(!islist(map_names))
		map_names = list(map_names)
	var/list/blacklisted_turfs = list()
	for(var/datum/map_template/automap_template/iterating_template as anything in preloaded_map_templates)
		if(!(iterating_template.required_map in map_names))
			continue
		for(var/turf/iterating_turf as anything in iterating_template.get_affected_turfs(iterating_template.load_turf, FALSE))
			blacklisted_turfs += iterating_turf
	return blacklisted_turfs
