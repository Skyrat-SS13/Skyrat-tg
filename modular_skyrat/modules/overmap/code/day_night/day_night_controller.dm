#define MINIMUM_LIGHT_FOR_LUMINOSITY 0.3
#define VALUES_PER_TRANSITION 5
#define TRANSITION_VALUE (1 / VALUES_PER_TRANSITION)
#define ALL_TRANSITIONS (VALUES_PER_TRANSITION * 6)
#define TWEAK_HOUR_SHIFT -1.5 //The amount of hours we tweak forwards to make the cycle more earth-like

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
	/// Whether we have applied luminosity to the areas
	var/has_applied_luminosity = FALSE
	var/last_color = "#FFFFFF"
	var/last_alpha = 1
	var/list/subscribed_blend_areas = list()

/datum/day_night_controller/proc/subscribe_blend_area(area/area_to_sub)
	subscribed_blend_areas[area_to_sub] = TRUE
	area_to_sub.subbed_day_night_controller = src
	area_to_sub.last_day_night_luminosity = FALSE

/datum/day_night_controller/proc/unsubscribe_blend_area(area/area_to_unsub)
	subscribed_blend_areas -= area_to_unsub
	area_to_unsub.subbed_day_night_controller = null
	area_to_unsub.last_day_night_color = null
	area_to_unsub.last_day_night_alpha = null
	area_to_unsub.last_day_night_luminosity = null

/datum/day_night_controller/process()
	update_areas()

/datum/day_night_controller/proc/update_areas()
	if(!length(affected_areas))
		GetAreas() //Need to get it later because otherwise it wont get the areas, quirky stuff
	//Station time goes from 0 to 864000, which makes 600 a 1 minute
	var/time = station_time() / 600 / 60 //600 - minutes //60 - hours. We get from 0 to 24 here

	//We add a "tweak" offset to make the cycle more earth-like
	time += TWEAK_HOUR_SHIFT
	if(time < 0)
		time += 24

	time = time / 4 * VALUES_PER_TRANSITION //4 hours per transition and 5 transitions
	time = CEILING(time, 1)
	time = clamp(time, 1, ALL_TRANSITIONS)

	var/target_color = color_lookup_table["[time]"]
	var/target_light = light_lookup_table["[time]"]

	if(linked_overmap_object && linked_overmap_object.weather_controller)
		target_light *= (1-linked_overmap_object.weather_controller.skyblock)
		if(target_light < 0)
			target_light = 0

	target_light *= 255

	if(target_color == last_color && target_light == last_alpha)
		return

	var/mutable_appearance/appearance_to_add = mutable_appearance('modular_skyrat/modules/overmap/icons/daynight_blend.dmi', "white")
	appearance_to_add.plane = LIGHTING_PLANE
	appearance_to_add.layer = DAY_NIGHT_LIGHTING_LAYER
	appearance_to_add.color = last_color
	appearance_to_add.alpha = last_alpha
	for(var/i in affected_areas)
		var/area/my_area = i
		my_area.underlays -= appearance_to_add

	last_color = target_color
	last_alpha = target_light

	appearance_to_add.color = target_color
	appearance_to_add.alpha = target_light
	var/do_luminosity = (target_light > MINIMUM_LIGHT_FOR_LUMINOSITY) ? TRUE : FALSE

	for(var/i in affected_areas)
		var/area/my_area = i
		if(do_luminosity != has_applied_luminosity)
			if(do_luminosity)
				my_area.luminosity++
			else
				my_area.luminosity--
		my_area.underlays += appearance_to_add
	has_applied_luminosity = do_luminosity

	for(var/i in subscribed_blend_areas)
		var/area/iterated_area = i
		iterated_area.UpdateDayNightTurfsSimple()

/datum/day_night_controller/proc/GetAreas()
	//Get the areas
	var/list/possible_blending_areas = list()
	for(var/i in get_areas(/area))
		var/area/my_area = i
		if(!z_level_lookup["[my_area.z]"])
			continue
		if(!my_area.outdoors)
			possible_blending_areas += my_area
			continue
		if(my_area.underground)
			continue
		affected_areas += my_area
	for(var/i in possible_blending_areas)
		var/area/my_area = i
		my_area.UpdateDayNightTurfs(TRUE, src)

/datum/day_night_controller/New(list/space_level)
	. = ..()
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
	if(linked_overmap_object)
		UnlinkOvermapObject()
	for(var/i in z_levels)
		var/datum/space_level/level = i
		level.day_night_controller = null
	SSday_night.day_night_controllers -= src
	return ..()
