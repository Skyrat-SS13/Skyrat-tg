/obj/item/circuitboard/computer/dispatch
	name = "Warden Dispatch Console (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_SECURITY
	build_path = /obj/machinery/computer/dispatch

/datum/design/board/dispatch
	name = "Computer Design (Dispatch Console)"
	desc = "Allows for the construction of circuit boards used to build security dispatch computers."
	id = "dispatch"
	build_path = /obj/item/circuitboard/computer/dispatch
	category = list("Computer Boards")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY

/obj/machinery/computer/dispatch
	name = "dispatch console"
	desc = " Used by the warden to monitor the station and assign orders and squads to Security."
	icon_screen = "cameras"
	icon_keyboard = "security_key"
	use_power = IDLE_POWER_USE
	idle_power_usage = 250
	active_power_usage = 500
	circuit = /obj/item/circuitboard/computer/dispatch
	light_color = COLOR_SOFT_RED
	var/datum/game_map/current_map
	var/mob/living/carbon/human/dummy
	var/list/officer_icons = list() // list(REF(officer_human) = icon_url)
	var/list/officer_icon_md5s = list()
	var/list/officer_names = list() // list(REF(officer_human) = name)
	plays_click_sound = FALSE // wow this is annoying as SHIT.


/obj/machinery/computer/dispatch/ui_data(mob/user)
	. = list()

	var/turf/T = get_turf(src)
	for(var/datum/game_map/potential_map as anything in SSminimap.minimaps)
		if(potential_map.zlevel.z_value == T.z)
			current_map = potential_map
			break

	.["coord_data"] = current_map.coord_data
	.["officer_icons"] = officer_icons
	.["officer_icon_md5s"] = officer_icon_md5s
	.["officer_names"] = officer_names

/obj/machinery/computer/dispatch/ui_static_data(mob/user)
	. = list()
	.["map_size_x"] = current_map.generated_map.Width()
	.["map_size_y"] = current_map.generated_map.Height()
	.["map_name"] = current_map.current_map_url
	.["icon_size"] = current_map.icon_size

/obj/machinery/computer/dispatch/proc/render_officer(mob/living/carbon/human/target)
	dummy = generate_dummy_lookalike(REF(target), target)
	var/datum/job/job_ref = SSjob.GetJob(target.job)
	if(job_ref && job_ref.outfit)
		dummy.equipOutfit(job_ref.outfit, visualsOnly = TRUE)
	COMPILE_OVERLAYS(dummy)
	var/icon/icon = getFlatIcon(dummy)

	// We don't want to qdel the dummy right away, since its items haven't initialized yet.
	SSatoms.prepare_deletion(dummy)
	icon.Scale(115, 115)

	// This is probably better as a Crop, but I cannot figure it out.
	icon.Shift(WEST, 8)
	icon.Shift(SOUTH, 30)

	icon.Crop(1, 1, ANTAGONIST_PREVIEW_ICON_SIZE, ANTAGONIST_PREVIEW_ICON_SIZE)
	icon = icon(icon, frame=1)
	var/icon_path = "data\\security_icons\\[target.real_name]_icon.png"
	fcopy(icon, icon_path)
	var/md5_hash = md5filepath(icon_path)

	var/datum/asset_transport/AS = SSassets.transport
	var/datum/asset_cache_item/ACI = new(md5_hash, icon_path)
	ACI.namespace = "officer_icons"
	if(istype(AS, /datum/asset_transport/webroot))
		var/datum/asset_transport/webroot/WR = AS
		WR.save_asset_to_webroot(ACI)
	else
		AS.register_asset(md5_hash, ACI)
		officer_icon_md5s.Add(md5_hash)
	officer_icons[REF(target)] = AS.get_asset_url(null, ACI)
	officer_names[REF(target)] = target.real_name
	return icon

/obj/machinery/computer/dispatch/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	switch(action)
		if("ping_officer")
			var/mob/living/carbon/human/target = locate(params["ref"])
			if(!target || !istype(target))
				return
			var/message_to_ping = "Check Radio!"
			var/obj/item/clothing/under/uniform = target.w_uniform
			if(!uniform || uniform.has_sensor <= NO_SENSORS || !uniform.sensor_mode || uniform.sensor_mode < SENSOR_COORDS)
				message_to_ping = "Max Sensors then Check Radio!"
			var/obj/item/card/id/ID = target.get_idcard(TRUE)
			if(!ID)
				balloon_alert_to_viewers("target not wearing ID!")
				playsound(src, 'sound/machines/buzz-two.ogg', 30, TRUE)
				return
			target.balloon_alert_to_viewers(message_to_ping)
			playsound(ID, 'sound/items/weeoo1.ogg', 30, TRUE)
			to_chat(target, span_reallybig("WARDEN'S ORDERS: " + message_to_ping))

/obj/machinery/computer/dispatch/ui_interact(mob/user, datum/tgui/ui, map = FALSE)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		if(!current_map)
			var/turf/T = get_turf(src)
			for(var/datum/game_map/potential_map as anything in SSminimap.minimaps)
				if(potential_map.zlevel.z_value == T.z)
					current_map = potential_map
					break

		for(var/mob/living/carbon/human/H as anything in GLOB.human_list) // this is slow, replace this
			if(H.z != current_map.zlevel.z_value)
				continue
			var/datum/job/job_ref = SSjob.GetJob(H.job)
			if(!job_ref)
				continue
			if(job_ref.departments_bitflags & DEPARTMENT_BITFLAG_SECURITY)
				if(!officer_icons[REF(H)])
					render_officer(H)

		if(!istype(SSassets.transport, /datum/asset_transport/webroot)) // SET UP A GODDAMN CDN.
			var/list/md5s_to_send = officer_icon_md5s.Copy()
			md5s_to_send.Add(current_map.current_map_md5)
			SSassets.transport.send_assets(user, md5s_to_send)
		ui = new(user, src, "DispatchConsole", "DispatchConsole")
		ui.open()
