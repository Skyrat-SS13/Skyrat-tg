//CONTROL COMPUTER

/obj/machinery/computer/bsa_control
	name = "bluespace artillery control"
	use_power = NO_POWER_USE
	circuit = /obj/item/circuitboard/computer/bsa_control
	icon = 'modular_skyrat/modules/fixing_missing_icons/particle_accelerator.dmi'
	icon_state = "control_boxp"
	var/obj/machinery/bsa_powercore/core //The moveable power core link
	var/obj/machinery/bsa/full/cannon
	var/notice
	var/target
	var/area_aim = FALSE //should also show areas for targeting

	connectable = FALSE //connecting_computer change: since icon_state is not a typical console, it cannot be connectable.

/obj/machinery/computer/bsa_control/multitool_act(mob/living/user, obj/item/I)
	if(!multitool_check_buffer(user, I))
		return
	var/obj/item/multitool/M = I
	if(M.buffer)
		if(istype(M.buffer, /obj/machinery/bsa_powercore))
			if(!cannon)
				to_chat(user, span_warning("There is no cannon linked to this control unit!"))
				return FALSE
			if(core)
				to_chat(user, span_warning("There is already a core linked to this control unit!"))
				return FALSE
			core = M.buffer
			core.control_unit = src
			M.buffer = null
			to_chat(user, span_notice("You link [src] with [core]."))
	else
		to_chat(user, span_warning("[I]'s data buffer is empty!"))
	return TRUE

/obj/machinery/computer/bsa_control/ui_state(mob/user)
	return GLOB.physical_state

/obj/machinery/computer/bsa_control/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BluespaceArtillery", name)
		ui.open()

/obj/machinery/computer/bsa_control/ui_data()
	var/list/data = list()
	data["ready"] = cannon ? cannon.ready : FALSE
	data["connected"] = cannon
	data["notice"] = notice
	data["unlocked"] = GLOB.bsa_unlock
	if(target)
		data["target"] = get_target_name()
	return data

/obj/machinery/computer/bsa_control/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("build")
			cannon = deploy()
			. = TRUE
		if("fire")
			fire(usr)
			. = TRUE
		if("recalibrate")
			calibrate(usr)
			. = TRUE
	update_appearance()

/obj/machinery/computer/bsa_control/proc/calibrate(mob/user)
	if(!GLOB.bsa_unlock)
		return
	var/list/gps_locators = list()
	for(var/datum/component/gps/G in GLOB.GPS_list) //nulls on the list somehow
		if(G.tracking)
			gps_locators[G.gpstag] = G

	var/list/options = gps_locators
	if(area_aim)
		options += GLOB.teleportlocs
	var/victim = tgui_input_list(user, "Select target", "Artillery Targeting", options)
	if(isnull(victim))
		return
	if(isnull(options[victim]))
		return
	target = options[victim]

/obj/machinery/computer/bsa_control/proc/get_target_name()
	if(istype(target, /area))
		return get_area_name(target, TRUE)
	else if(istype(target, /datum/component/gps))
		var/datum/component/gps/G = target
		return G.gpstag

/obj/machinery/computer/bsa_control/proc/get_impact_turf()
	if(istype(target, /area))
		return pick(get_area_turfs(target))
	else if(istype(target, /datum/component/gps))
		var/datum/component/gps/G = target
		return get_turf(G.parent)

/obj/machinery/computer/bsa_control/proc/fire(mob/user)
	if(!core)
		notice = "Core not detected!"
		return
	if((cannon.machine_stat & BROKEN))
		notice = "Cannon integrity failure!"
		return
	if((cannon.machine_stat & NOPOWER))
		notice = "Cannon unpowered!"
		return
	notice = cannon.pre_fire(user, get_impact_turf())

/obj/machinery/computer/bsa_control/proc/deploy(force=FALSE)
	var/obj/machinery/bsa/full/prebuilt = locate() in range(7) //In case of adminspawn
	if(prebuilt)
		prebuilt.control_unit = src
		return prebuilt

	var/obj/machinery/bsa/middle/centerpiece = locate() in range(7)
	if(!centerpiece)
		notice = "No BSA parts detected nearby."
		return null
	notice = centerpiece.check_completion()
	if(notice)
		return null
	//Totally nanite construction system not an immersion breaking spawning
	var/datum/effect_system/fluid_spread/smoke/s = new
	s.set_up(4, location = get_turf(centerpiece))
	s.start()
	var/obj/machinery/bsa/full/cannon = new(get_turf(centerpiece),centerpiece.get_cannon_direction())
	cannon.control_unit = src
	qdel(centerpiece.front)
	qdel(centerpiece.back)
	qdel(centerpiece)
	return cannon

/obj/machinery/computer/bsa_control/Destroy()
	if(cannon)
		cannon.control_unit = null
		cannon = null
	core = null
	. = ..()
