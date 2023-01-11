// Wall mounted holomap of the station
// Credit to polaris for the code which this map was based off of.

/obj/machinery/station_map
	name = "station holomap"
	desc = "A virtual map of the surrounding station."
	icon = 'icons/stationmap.dmi'
	icon_state = "station_map"
	layer = ABOVE_WINDOW_LAYER
	use_power = IDLE_POWER_USE
	idle_power_usage = 10
	active_power_usage = 500
	circuit = /obj/item/circuitboard/machine/station_map
	light_color = HOLOMAP_HOLOFIER

	var/mob/watching_mob
	var/image/small_station_map
	var/image/floor_markings
	var/image/panel

	var/current_z_level // zLevel on which the station map was initialized.
	var/bogus = TRUE // set to FALSE when you initialize the station map on a zLevel that has its own icon formatted for use by station holomaps.
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

	var/list/extra_overlays = list()
	for(var/z_transition in SSholomaps.holomap_z_transitions["[current_z_level]"])
		world.log << "Loading map transition at [z_transition]"
		var/list/position = splittext(z_transition, ":")
		var/image/transition_image = image('icons/holomap_markers.dmi', "z_marker")
		transition_image.pixel_x = text2num(position[1]) - 1
		transition_image.pixel_y = text2num(position[2])
		extra_overlays += transition_image

	holomap_datum.initialize_holomap(current_turf, reinit_base_map = TRUE, extra_overlays = extra_overlays)

	small_station_map = image(SSholomaps.extra_holomaps["[HOLOMAP_EXTRA_STATIONMAPSMALL]_[current_z_level]"], dir = dir)

	floor_markings = image('icons/stationmap.dmi', "decal_station_map")
	floor_markings.dir = src.dir

	update_icon()

/obj/machinery/station_map/attack_hand(var/mob/user)
	if(user == watching_mob)
		close_map(user)
		return

	open_map(user)

/obj/machinery/station_map/proc/open_map(var/mob/user)
	if(!isliving(user) || !anchored || (machine_stat & (NOPOWER | BROKEN)) || !user.client)
		return

	if(!holomap_datum)
		// Something is very wrong if we have to un-fuck ourselves here.
		message_admins("\[HOLOMAP] WARNING: Holomap at [x], [y], [z] [ADMIN_FLW(src)] had to set itself up on interact! Something in Initialize is very wrong!")
		setup_holomap()

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

/obj/machinery/station_map/attack_ai(var/mob/living/silicon/robot/user)
	attack_hand(user)

/obj/machinery/station_map/process()
	if((machine_stat & (NOPOWER | BROKEN)) || !anchored)
		close_map()

/obj/machinery/station_map/proc/check_position()
	SIGNAL_HANDLER
	if(!watching_mob || !isliving(watching_mob))
		return

	if(!Adjacent(watching_mob))
		close_map(watching_mob)

/obj/machinery/station_map/proc/close_map()
	if(!watching_mob || !isliving(watching_mob))
		return

	UnregisterSignal(watching_mob, COMSIG_MOVABLE_MOVED)
	playsound(src, 'modular_skyrat/modules/holomap/sound/holomap_close.ogg', 125)
	icon_state = "station_map"
	if(watching_mob.client)
		animate(holomap_datum.base_map, alpha = 0, time = 5, easing = LINEAR_EASING)
		spawn(5) //we give it time to fade out
			watching_mob.client.screen -= watching_mob.hud_used.holomap
			watching_mob.client.images -= holomap_datum.base_map
			watching_mob.hud_used.holomap.used_station_map = null
			watching_mob = null

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
	else if((machine_stat & NOPOWER) || !anchored)
		icon_state = "station_map_off"
	else
		icon_state = "station_map"

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

	if(panel_open)
		add_overlay("station_map_panel")
	else
		cut_overlay("station_map_panel")

/obj/machinery/station_map/screwdriver_act(mob/living/user, obj/item/tool)
	. = default_deconstruction_screwdriver(user, "station_map_opened", "station_map_off", tool)

	if(!.) // Prevent re-running setup holomap for no reason.
		return FALSE

	if(!panel_open)
		setup_holomap()

	return .

/obj/machinery/station_map/screwdriver_act_secondary(mob/living/user, obj/item/tool)
	if(!panel_open)
		to_chat(user, span_warning("You need to open the panel to change the [src]'[p_s()] settings!"))
		return FALSE

	if(SSholomaps.valid_map_indexes.len > current_z_level)
		current_z_level = 1
	else
		current_z_level += 1

	to_chat(span_info("You set the [src]'[p_s()] database index to [current_z_level]."))
	return TRUE

/obj/machinery/station_map/crowbar_act(mob/living/user, obj/item/tool)
	return default_deconstruction_crowbar(tool)

/obj/machinery/station_map/wrench_act(mob/living/user, obj/item/tool)
	rotate_map(-90)
	return TRUE

/obj/machinery/station_map/wrench_act_secondary(mob/living/user, obj/item/tool)
	rotate_map(90)
	return TRUE

/// Rotates the map machine by the given amount of degrees. See byond's builtin `turn` for more info.
/obj/machinery/station_map/proc/rotate_map(direction)
	dir = turn(dir, direction)

// These are fragile!
/obj/machinery/station_map/ex_act(severity)
	. = ..()

	switch(severity)
		if(EXPLODE_DEVASTATE)
			qdel(src)

		if(EXPLODE_HEAVY)
			if(prob(50))
				qdel(src)
			else
				set_broken()

		if(EXPLODE_LIGHT)
			if(prob(25))
				set_broken()

/obj/machinery/station_map/emp_act(severity)
	set_broken()

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/station_map, 32)
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/station_map/engineering, 32)

/obj/item/circuitboard/machine/station_map
	name = "Station Map"
	specific_parts = TRUE // Fuck you, triphasic scanner and an ultra laser to rebuild these.
	build_path = /obj/machinery/station_map
	req_components = list(/obj/item/stock_parts/scanning_module/triphasic = 3, /obj/item/stock_parts/micro_laser/ultra = 4)
