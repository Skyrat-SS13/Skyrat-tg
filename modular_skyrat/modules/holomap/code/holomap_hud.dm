/datum/hud
	var/atom/movable/screen/holomap/holomap

/datum/hud/New(mob/owner)
	. = ..()

	holomap = new /atom/movable/screen/holomap()
	holomap.name = "holomap"
	holomap.icon = null
	holomap.screen_loc = ui_holomap
	holomap.mouse_opacity = MOUSE_OPACITY_ICON


/atom/movable/screen/holomap
	/// The owner. Used to get z-level data.
	var/obj/machinery/station_map/used_station_map

/atom/movable/screen/holomap/Click(location, control, params)
	. = ..()
	if(!used_station_map)
		return

	if(LAZYACCESS(params2list(params), RIGHT_CLICK))
		used_station_map.close_map()
		return

	var/list/modifiers = params2list(params)
	var/icon_x = text2num(LAZYACCESS(modifiers, ICON_X))
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))

	if(icon_x < HOLOMAP_LEGEND_X || icon_x > HOLOMAP_LEGEND_X + HOLOMAP_LEGEND_WIDTH || icon_y < HOLOMAP_LEGEND_Y || icon_y > used_station_map.holomap_datum.total_legend_y)
		return

	var/selected_entry = round(icon_y / 10, 1) - 1 // Always round for a whole number, and subtract one cause I have no fucking idea what I'm doing
	var/list/overlay_data = used_station_map.holomap_datum.overlay_data

	if(!("[selected_entry]" in overlay_data))
		return

	var/list/disabled_overlays = used_station_map.holomap_datum.disabled_overlays

	if(overlay_data["[selected_entry]"] in disabled_overlays)
		disabled_overlays -= overlay_data["[selected_entry]"]
	else
		disabled_overlays += overlay_data["[selected_entry]"]

	used_station_map.holomap_datum.update_map(used_station_map.handle_overlays())

/atom/movable/screen/holomap/MouseEntered(location, control, params)
	. = ..()
	MouseMove(location, control, params)

// I overrode this to do nothing cause that'd be bad to have two things competing to do the same thing.
/atom/movable/screen/holomap/on_mouse_enter(client/client)
	return

/atom/movable/screen/holomap/MouseMove(location, control, params)
	if(!used_station_map)
		return

	var/list/modifiers = params2list(params)
	var/icon_x = text2num(LAZYACCESS(modifiers, ICON_X))
	var/icon_y = text2num(LAZYACCESS(modifiers, ICON_Y))
	var/list/position_to_name = SSholomaps.holomap_position_to_name["[used_station_map.current_z_level]"]

	if(!position_to_name || !usr.hud_used)
		return

	var/datum/hud/active_hud = usr.hud_used
	var/text_for_screentip = position_to_name["[icon_x]:[icon_y]"]

	active_hud.screentip_text.maptext = "<span class='maptext' style='text-align: center; font-size: 32px; color: [active_hud.screentip_color]'>[text_for_screentip]</span>"
