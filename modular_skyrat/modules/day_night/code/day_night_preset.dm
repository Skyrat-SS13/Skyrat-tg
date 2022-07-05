/datum/day_night_preset
	/// The maps that this preset should be loaded on
	var/load_map_names = list()
	/// The timezones that this preset should have
	var/list/timezones = list()
	/// The timezones that this preset has loaded
	var/list/timezone_cache = list()
	/// A list of areas we control
	var/list/controlled_areas = list()
	/// A list of loaded areas
	var/list/area_cache = list()

/datum/day_night_preset/New()
	. = ..()
	load_areas()
	load_timezones()

/**
 * Finds and saves all areas that this preset will affect
 */
/datum/day_night_preset/proc/load_areas()
	for(var/area/iterating_area_type in controlled_areas)
		for(var/area/iterating_area as anything in get_areas(iterating_area_type, TRUE))
			LAZYADD(area_cache, iterating_area)
			RegisterSignal(iterating_area, COMSIG_PARENT_QDELETING, .proc/remove_area_from_loaded)

/**
 * Creates all of the desired timezone datums and caches them for later.
 */
/datum/day_night_preset/proc/load_timezones()
	for(var/datum/timezone/iterating_timezone in timezones)
		timezone_cache += new iterating_timezone

/**
 * Removes an area from the preset
 */
/datum/day_night_preset/proc/remove_area_from_loaded(area/deleting_area, force)
	SIGNAL_HANDLER

	LAZYREMOVE(area_cache, deleting_area)
	UnregisterSignal(deleting_area, COMSIG_PARENT_QDELETING)

/**
 * Gets the timezone that relates to the given hour
 * Arguments:
 * * hour - The hour at which we will be checking our timezones.
 * Returns the timezone datum.
 */
/datum/day_night_preset/proc/get_timezone(hour)
	for(var/datum/timezone/iterating_timezone as anything in timezone_cache)
		if((hour >= iterating_timezone.start_hour) && (hour <= iterating_timezone.end_hour))
			return iterating_timezone

/**
 * Applys the current timezone to all of the areas
 */
/datum/day_night_preset/proc/update_time(hour)
	var/datum/timezone/timezone_to_apply = get_timezone(hour)
	for(var/area/iterating_area as anything in area_cache)
		iterating_area.set_base_lighting(timezone_to_apply.light_color, timezone_to_apply.light_alpha)

/datum/day_night_preset/icebox
	load_map_names = "IceBoxStation_skyrat.dmm"
	timezones = list(
		/datum/timezone/midnight,
		/datum/timezone/early_morning,
		/datum/timezone/morning,
		/datum/timezone/midday,
		/datum/timezone/early_evening,
		/datum/timezone/evening,
	)
	controlled_areas = list(/area/icemoon/surface/outdoors)
