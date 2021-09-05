#define MINIMUM_LIGHT_FOR_LUMINOSITY 0.3
#define VALUES_PER_TRANSITION 5
#define TRANSITION_VALUE (1 / VALUES_PER_TRANSITION)
#define ALL_TRANSITIONS (VALUES_PER_TRANSITION * 6)

/datum/day_night_controller
	/// YOU NEED TO FILL OUT ALL OF THEM
	/// Colors are hexes and lights goes from 0 to 1. Need atleast MINIMUM_LIGHT_FOR_LUMINOSITY to light up the areas
	/// Each of the times represents 4 hours in a 24 hour cycle, the transitions between one and the next are smooth

	var/midnight_color = COLOR_BLACK
	var/midnight_light = 0

	var/morning_color = "#c4faff"
	var/morning_light = 0.5

	var/noon_color = "#fff3c4"
	var/noon_light = 0.9

	var/midday_color = COLOR_WHITE
	var/midday_light = 0.9

	var/evening_color = "#c43f3f"
	var/evening_light = 0.5

	var/night_color = "#0000a6"
	var/night_light = 0.1

	/// Lookup table for the colors
	var/list/color_lookup_table = list()
	/// Lookup table for the light values
	var/list/light_lookup_table = list()

	/// The z levels we are controlling
	var/list/z_levels
	/// Quick lookup for the area checking
	var/list/z_level_lookup = list()
	/// The linked overmap object of our controller
	var/datum/overmap_object/linked_overmap_object
	/// All the areas that are affected by day/night
	var/list/affected_areas = list()
	/// The effect we apply and cut to the area's overlays
	var/obj/effect/fullbright/effect
	/// Whether we have applied luminosity to the areas
	var/has_applied_luminosity = FALSE

/datum/day_night_controller/process()
	update_areas()

/datum/day_night_controller/proc/update_areas()
	if(!length(affected_areas))
		GetAreas() //Need to get it later because otherwise it wont get the areas, quirky stuff
	//Station time goes from 0 to 864000, which makes 600 a 1 minute
	var/time = station_time() / 600 / 60 //600 - minutes //60 - hours. We get from 0 to 24 here
	time = time / 4 * VALUES_PER_TRANSITION //4 hours per transition and 5 transitions
	time = FLOOR(time, 1)
	if(time > ALL_TRANSITIONS || time <= 0)
		CRASH("Tried to set an invalid day/night transition of [time]. Bad time calculation.")
	for(var/i in affected_areas)
		var/area/my_area = i
		my_area.cut_overlay(effect)

	var/target_color = color_lookup_table["[time]"]
	var/target_light = light_lookup_table["[time]"]

	if(linked_overmap_object && linked_overmap_object.weather_controller)
		target_light *= (1-linked_overmap_object.weather_controller.skyblock)
		if(target_light < 0)
			target_light = 0

	effect.color = target_color
	effect.alpha = 255 * target_light
	var/do_luminosity = (target_light > MINIMUM_LIGHT_FOR_LUMINOSITY) ? TRUE : FALSE

	for(var/i in affected_areas)
		var/area/my_area = i
		if(do_luminosity != has_applied_luminosity)
			if(do_luminosity)
				my_area.luminosity++
			else
				my_area.luminosity--
		my_area.add_overlay(effect)
	has_applied_luminosity = do_luminosity

/datum/day_night_controller/proc/GetAreas()
	//Get the areas
	for(var/i in get_areas(/area))
		var/area/my_area = i
		if(!z_level_lookup["[my_area.z]"])
			continue
		if(!my_area.outdoors)
			continue
		if(my_area.underground)
			continue
		affected_areas += my_area

/datum/day_night_controller/New(list/space_level)
	. = ..()
	effect = new
	z_levels = space_level
	for(var/i in z_levels)
		var/datum/space_level/level = i
		z_level_lookup["[level.z_value]"] = TRUE
		level.day_night_controller = src
	SSday_night.day_night_controllers += src

	//Compile the lookup tables
	CompileTransition(midnight_color, midnight_light, morning_color, morning_light, 0)
	CompileTransition(morning_color, morning_light, noon_color, noon_light, VALUES_PER_TRANSITION)
	CompileTransition(noon_color, noon_light, midday_color, midday_light, VALUES_PER_TRANSITION*2)
	CompileTransition(midday_color, midday_light, evening_color, evening_light, VALUES_PER_TRANSITION*3)
	CompileTransition(evening_color, evening_light, night_color, night_light, VALUES_PER_TRANSITION*4)
	CompileTransition(night_color, night_light, midnight_color, midnight_light, VALUES_PER_TRANSITION*5)

/datum/day_night_controller/proc/CompileTransition(color1, light1, color2, light2, start_index)
	var/my_index = start_index + 1
	var/transition_value = 0
	color_lookup_table["[my_index]"] = color1
	light_lookup_table["[my_index]"] = light1
	for(var/i in 1 to VALUES_PER_TRANSITION-1)
		my_index++
		transition_value += TRANSITION_VALUE
		var/next_color = BlendRGB(color1, color2, transition_value)
		var/next_light = (light1*(1-transition_value))+(light2*(0+transition_value))
		color_lookup_table["[my_index]"] = next_color
		light_lookup_table["[my_index]"] = next_light

/datum/day_night_controller/proc/UnlinkOvermapObject()
	linked_overmap_object.day_night_controller = null
	linked_overmap_object = null

/datum/day_night_controller/proc/LinkOvermapObject(datum/overmap_object/passed)
	if(linked_overmap_object)
		UnlinkOvermapObject()
	linked_overmap_object = passed
	linked_overmap_object.day_night_controller = src

/// In theory this should never be destroyed, unless you plan to dynamically change existing z levels
/datum/day_night_controller/Destroy()
	qdel(effect)
	if(linked_overmap_object)
		UnlinkOvermapObject()
	for(var/i in z_levels)
		var/datum/space_level/level = i
		level.day_night_controller = null
	SSday_night.day_night_controllers -= src
	return ..()
