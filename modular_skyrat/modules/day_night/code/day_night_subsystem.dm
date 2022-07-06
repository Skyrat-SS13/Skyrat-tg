

/**
 * STATION TIMES ARE 24 HR FORMAT
 */

SUBSYSTEM_DEF(day_night)
	name = "Day/Night Cycle"
	wait = 1 MINUTES // Every minute, the clock moves forward 10 minutes
	/// The current hour
	var/current_hour = 0
	/// The current minute
	var/current_minute = 0
	/// A list of all currently loaded presets to be handled
	var/list/cached_presets = list()

/datum/controller/subsystem/day_night/Initialize(start_timeofday)
	for(var/datum/day_night_preset/iterating_preset as anything in subtypesof(/datum/day_night_preset))
		if(SSmapping.config.map_file == initial(iterating_preset.load_map_name))
			LAZYADD(cached_presets, new iterating_preset)
	current_hour = rand(0, 23)
	update_presets(current_hour)
	return ..()

/datum/controller/subsystem/day_night/fire(resumed)
	current_minute += SUBSYTEM_FIRE_INCREMENT

	if(current_minute >= HOUR_INCREMENT)
		var/time_delta = (current_minute - HOUR_INCREMENT) > 0 ? current_minute - HOUR_INCREMENT : 0
		current_minute = time_delta
		current_hour += 1
		update_presets(current_hour)

	if(current_hour >= MIDNIGHT_RESET)
		current_hour = 0

/**
 * Gets the current 24hr time in text format to be displayed on the statpanel.
 *
 * Returns HH:MM
 */
/datum/controller/subsystem/day_night/proc/get_twentyfourhour_timestamp()
	var/hour_entry = "[current_hour]"
	if(current_hour < 10)
		hour_entry = "0[hour_entry]"
	var/minute_entry = "[current_minute]"
	if(current_minute < 10)
		minute_entry = "0[minute_entry]"
	return "[hour_entry][minute_entry]"

/**
 * Gets the current 12hr time in text format to be displayed on the statpanel.
 *
 * Returns HH:MM
 */
/datum/controller/subsystem/day_night/proc/get_twelvehour_timestamp()
	return


/**
 * Updates the current preset timezones
 * Arguments:
 * * hour - The updating hour which we will sent to the preset controllers
 */
/datum/controller/subsystem/day_night/proc/update_presets(hour)
	for(var/datum/day_night_preset/iterating_preset as anything in cached_presets)
		iterating_preset.update_time(hour)
