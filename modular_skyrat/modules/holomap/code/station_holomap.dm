// Wall mounted holomap of the station
// Credit to polaris for the code which this map was based off of, and credit to VG for making it in the first place.

/obj/machinery/station_map
	name = "\improper station holomap"
	desc = "A virtual map of the surrounding station."
	icon = 'icons/stationmap.dmi'
	icon_state = "station_map"
	layer = ABOVE_WINDOW_LAYER
	use_power = IDLE_POWER_USE
	idle_power_usage = 10
	active_power_usage = 500
	circuit = /obj/item/circuitboard/machine/station_map
	light_color = HOLOMAP_HOLOFIER

	/// The mob beholding this marvel.
	var/mob/watching_mob
	/// The image that can be seen in-world.
	var/image/small_station_map
	/// The little "map" floor painting.
	var/image/floor_markings

	// zLevel which the map is a map for.
	var/current_z_level
	/// This set to FALSE when the station map is initialized on a zLevel that has its own icon formatted for use by station holomaps.
	var/bogus = TRUE
	/// The various images and icons for the map are stored in here, as well as the actual big map itself.
	var/datum/station_holomap/holomap_datum

/obj/machinery/station_map/Initialize()
	. = ..()
	current_z_level = loc.z
	SSholomaps.station_holomaps += src

/obj/machinery/station_map/LateInitialize()
	. = ..()
	if(SSholomaps.initialized)
		setup_holomap()

/obj/machinery/station_map/Destroy()
	SSholomaps.station_holomaps -= src
	close_map()
	QDEL_NULL(holomap_datum)
	. = ..()

/obj/machinery/station_map/proc/setup_holomap()
	holomap_datum = new()
	bogus = FALSE
	var/turf/current_turf = get_turf(src)
	current_z_level = current_turf.z
	if(!("[HOLOMAP_EXTRA_STATIONMAP]_[current_z_level]" in SSholomaps.extra_holomaps))
		bogus = TRUE
		holomap_datum.initialize_holomap_bogus()
		update_icon()
		return

	holomap_datum.initialize_holomap(current_turf.x, current_turf.y, current_turf.z, reinit_base_map = TRUE, extra_overlays = handle_extra_overlays())

	small_station_map = image(SSholomaps.extra_holomaps["[HOLOMAP_EXTRA_STATIONMAPSMALL]_[current_z_level]"], dir = dir)

	floor_markings = image('icons/stationmap.dmi', "decal_station_map")
	floor_markings.dir = src.dir

	update_icon()

/obj/machinery/station_map/attack_hand(var/mob/user)
	if(user == watching_mob)
		close_map(user)
		return

	open_map(user)

/// Tries to open the map for the given mob. Returns FALSE if it doesn't meet the criteria, TRUE if the map successfully opened with no runtimes.
/obj/machinery/station_map/proc/open_map(var/mob/user)
	if(!anchored || (machine_stat & (NOPOWER | BROKEN)) || !user?.client || panel_open)
		return FALSE

	if(!holomap_datum)
		// Something is very wrong if we have to un-fuck ourselves here.
		message_admins("\[HOLOMAP] WARNING: Holomap at [x], [y], [z] [ADMIN_FLW(src)] had to set itself up on interact! Something during Initialize went very wrong!")
		setup_holomap()

	holomap_datum.update_map(handle_extra_overlays())

	var/datum/hud/human/user_hud = user.hud_used
	holomap_datum.base_map.loc = user_hud.holomap  // Put the image on the holomap hud
	holomap_datum.base_map.alpha = 0 // Set to transparent so we can fade in

	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(check_position))

	playsound(src, 'modular_skyrat/modules/holomap/sound/holomap_open.ogg', 125)
	animate(holomap_datum.base_map, alpha = 255, time = 5, easing = LINEAR_EASING)
	icon_state = "station_map_active"
	set_light(2, 3)

	user.hud_used.holomap.used_station_map = src
	user.hud_used.holomap.mouse_opacity = MOUSE_OPACITY_ICON
	user.client.screen |= user.hud_used.holomap
	user.client.images |= holomap_datum.base_map

	watching_mob = user
	update_use_power(ACTIVE_POWER_USE)

	if(bogus)
		to_chat(user, span_warning("The holomap failed to initialize. This area of space cannot be mapped."))
	else
		to_chat(user, span_notice("A hologram of the station appears before your eyes."))

	return TRUE

/obj/machinery/station_map/attack_ai(var/mob/living/silicon/robot/user)
	attack_hand(user)

/obj/machinery/station_map/process()
	if((machine_stat & (NOPOWER | BROKEN)) || !anchored)
		close_map()

/obj/machinery/station_map/proc/check_position()
	SIGNAL_HANDLER
	if(!watching_mob)
		return

	if(!Adjacent(watching_mob))
		close_map(watching_mob)

/obj/machinery/station_map/proc/close_map()
	if(!watching_mob)
		return

	UnregisterSignal(watching_mob, COMSIG_MOVABLE_MOVED)
	playsound(src, 'modular_skyrat/modules/holomap/sound/holomap_close.ogg', 125)
	icon_state = initial(icon_state)
	if(watching_mob.client)
		animate(holomap_datum.base_map, alpha = 0, time = 5, easing = LINEAR_EASING)
		spawn(5) //we give it time to fade out
			watching_mob.client.screen -= watching_mob.hud_used.holomap
			watching_mob.client.images -= holomap_datum.base_map
			watching_mob.hud_used.holomap.used_station_map = null
			watching_mob = null
			set_light(1, 2)

	update_use_power(IDLE_POWER_USE)

/obj/machinery/station_map/power_change()
	. = ..()
	update_icon()

	if(machine_stat & NOPOWER)
		set_light(0)
	else
		set_light(1, 2)

/obj/machinery/station_map/proc/set_broken()
	machine_stat |= BROKEN
	update_icon()

/obj/machinery/station_map/update_icon()
	. = ..()
	if(!holomap_datum)
		return //Not yet.

	cut_overlays()
	if(machine_stat & BROKEN)
		icon_state = "station_map_broken"
	else if(panel_open)
		icon_state = "station_map_opened"
	else if((machine_stat & NOPOWER) || !anchored)
		icon_state = "station_map_off"
	else
		icon_state = initial(icon_state)

		if(bogus)
			holomap_datum.initialize_holomap_bogus()
		else
			small_station_map = image(SSholomaps.extra_holomaps["[HOLOMAP_EXTRA_STATIONMAPSMALL]_[current_z_level]"], dir = src.dir)
			add_overlay(small_station_map)

	// Put the little "map" overlay down where it looks nice
	if(floor_markings)
		floor_markings.dir = src.dir
		floor_markings.pixel_x = -src.pixel_x
		floor_markings.pixel_y = -src.pixel_y
		add_overlay(floor_markings)

/obj/machinery/station_map/screwdriver_act(mob/living/user, obj/item/tool)
	. = default_deconstruction_screwdriver(user, "station_map_opened", "station_map_off", tool)
	close_map()
	update_icon()

	if(!.) // Prevent re-running setup holomap for no reason.
		return FALSE

	if(!panel_open)
		setup_holomap()

	return .

/obj/machinery/station_map/multitool_act(mob/living/user, obj/item/tool)
	if(!panel_open)
		to_chat(user, span_warning("You need to open the panel to change the [src]'[p_s()] settings!"))
		return TRUE
	if(!SSholomaps.valid_map_indexes.len > 1)
		to_chat(user, span_warning("There are no other maps available for [src]!"))
		return TRUE

	tool.play_tool_sound(user, 50)
	var/current_index = SSholomaps.valid_map_indexes.Find(current_z_level)
	if(current_index >= SSholomaps.valid_map_indexes.len)
		current_z_level = SSholomaps.valid_map_indexes[1]
	else
		current_z_level = SSholomaps.valid_map_indexes[current_index + 1]

	to_chat(user, span_info("You set the [src]'[p_s()] database index to [current_z_level]."))
	return TRUE

/obj/machinery/station_map/crowbar_act(mob/living/user, obj/item/tool)
	return default_deconstruction_crowbar(tool)

/obj/machinery/station_map/wrench_act(mob/living/user, obj/item/tool)
	if(!panel_open)
		return FALSE
	rotate_map(-90)
	tool.play_tool_sound(user, 50)
	return TRUE

/obj/machinery/station_map/wrench_act_secondary(mob/living/user, obj/item/tool)
	if(!panel_open)
		return FALSE
	rotate_map(90)
	tool.play_tool_sound(user, 50)
	return TRUE

/// Rotates the map machine by the given amount of degrees. See byond's builtin `turn` for more info.
/obj/machinery/station_map/proc/rotate_map(direction)
	dir = turn(dir, direction)
	switch(dir)
		if(NORTH)
			pixel_x = 0
			pixel_y = 32
		if(SOUTH)
			pixel_x = 0
			pixel_y = -32
		if(EAST)
			pixel_x = 32
			pixel_y = 0
		if(WEST)
			pixel_x = -32
			pixel_y = 0

	setup_holomap() // Required to refresh the small map icon.

/obj/machinery/station_map/emp_act(severity)
	set_broken()

/obj/machinery/station_map/proc/handle_extra_overlays()
	var/list/extra_overlays = list()
	for(var/z_transition in SSholomaps.holomap_z_transitions["[current_z_level]"])
		var/list/position = splittext(z_transition, ":")
		var/image/transition_image = image('icons/holomap_markers.dmi', "z_marker")
		transition_image.pixel_x = text2num(position[1]) - 1
		transition_image.pixel_y = text2num(position[2])
		extra_overlays += transition_image

	return extra_overlays

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/station_map, 32)

/obj/machinery/station_map/engineering
	name = "\improper engineering station map"
	icon_state = "station_map_engi"
	circuit = /obj/item/circuitboard/machine/station_map/engineering

/obj/machinery/station_map/engineering/handle_extra_overlays()
	var/list/extra_overlays = ..()
	if(!bogus)
		for(var/obj/machinery/firealarm/alarm as anything in GLOB.station_fire_alarms["[current_z_level]"])
			if(alarm?.z == current_z_level && alarm?.my_area?.active_alarms[ALARM_FIRE])
				var/image/alarm_icon = image('icons/holomap_markers.dmi', "fire_marker")
				alarm_icon.pixel_x = alarm.x + HOLOMAP_CENTER_X - 1
				alarm_icon.pixel_y = alarm.y + HOLOMAP_CENTER_Y
				extra_overlays += alarm_icon

		for(var/obj/machinery/airalarm/air_alarm as anything in GLOB.air_alarms)
			if(air_alarm?.z == current_z_level && air_alarm?.my_area?.active_alarms[ALARM_ATMOS])
				var/image/alarm_icon = image('icons/holomap_markers.dmi', "atmos_marker")
				alarm_icon.pixel_x = air_alarm.x + HOLOMAP_CENTER_X - 1
				alarm_icon.pixel_y = air_alarm.y + HOLOMAP_CENTER_Y
				extra_overlays += alarm_icon

	return extra_overlays

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/station_map/engineering, 32)

/obj/item/circuitboard/machine/station_map
	name = "Station Map"
	specific_parts = TRUE // Fuck you, triphasic scanner and an ultra laser to rebuild these.
	build_path = /obj/machinery/station_map/directional/north
	req_components = list(/obj/item/stock_parts/scanning_module/triphasic = 3, /obj/item/stock_parts/micro_laser/ultra = 4)

/obj/item/circuitboard/machine/station_map/engineering
	name = "Engineering Station Map"
	specific_parts = TRUE // Fuck you, triphasic scanner and an ultra laser to rebuild these, oh, and cause they make engineering's life that much easier, enjoy making a subspace analyser too.
	build_path = /obj/machinery/station_map/engineering/directional/north
	req_components = list(/obj/item/stock_parts/scanning_module/triphasic = 3, /obj/item/stock_parts/micro_laser/ultra = 4, /obj/item/stock_parts/subspace/analyzer = 1)
