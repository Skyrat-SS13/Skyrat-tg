/**
 * The control computer
 *
 * Responsible for cannon firing protocols.
 */

/obj/machinery/computer/bsa_control
	name = "bluespace artillery control"
	use_power = NO_POWER_USE
	circuit = /obj/item/circuitboard/computer/bsa_control
	icon = 'icons/obj/machines/particle_accelerator.dmi'
	icon_state = "control_boxp"
	icon_keyboard = null
	icon_screen = null
	/// A weakref to our cannon
	var/datum/weakref/connected_cannon
	/// The current system status of the gun
	var/notice
	/// Our target... WHY NOT WEEKREFF
	var/atom/target
	/// Are we allowing the gun to target areas?
	var/area_aim = FALSE //should also show areas for targeting

	connectable = FALSE //connecting_computer change: since icon_state is not a typical console, it cannot be connectable.


/obj/machinery/computer/bsa_control/ui_state(mob/user)
	return GLOB.physical_state

/obj/machinery/computer/bsa_control/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BluespaceArtillerySkyrat", name)
		ui.open()

/obj/machinery/computer/bsa_control/ui_data()
	var/list/data = list()
	var/obj/machinery/bsa/full/cannon = connected_cannon?.resolve()

	data["connected"] = cannon
	data["notice"] = notice
	data["unlocked"] = GLOB.bsa_unlock
	data["powernet_power"] = cannon?.get_available_powercap()
	data["power_suck_cap"] = cannon?.power_suck_cap
	data["status"] = cannon?.system_state
	data["capacitor_charge"] = cannon?.capacitor_power
	data["target_capacitor_charge"] = cannon?.target_power
	data["max_capacitor_charge"] = cannon?.max_charge
	if(target)
		data["target"] = get_target_name()
	return data

/obj/machinery/computer/bsa_control/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("build")
			deploy()
			. = TRUE
		if("fire")
			fire(usr)
			. = TRUE
		if("recalibrate")
			calibrate(usr)
			. = TRUE
		if("charge")
			charge()
		if("capacitor_target_change")
			change_capacitor_target(params["capacitor_target"])
	update_appearance()

/obj/machinery/computer/bsa_control/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	obj_flags |= EMAGGED
	balloon_alert(user, "rigged to explode")
	to_chat(user, span_warning("You emag [src] and hear the focusing crystal short out. You get the feeling it wouldn't be wise to stand near [src] when the BSA fires..."))
	return TRUE

/**
 * Changes the target charge for the internal capacitors
 */
/obj/machinery/computer/bsa_control/proc/change_capacitor_target(new_target)
	var/obj/machinery/bsa/full/cannon = connected_cannon?.resolve()
	if(!cannon)
		return
	cannon.target_power = new_target

/**
 * Takes power from the powernet and inserts it into the gun.
 */
/obj/machinery/computer/bsa_control/proc/charge()
	var/obj/machinery/bsa/full/cannon = connected_cannon?.resolve()
	if(!cannon)
		return
	if(cannon.system_state != BSA_SYSTEM_READY && cannon.system_state != BSA_SYSTEM_LOW_POWER)
		return
	cannon.system_state = BSA_SYSTEM_CHARGE_CAPACITORS

/**
 * Sets a target for the gun to use.
 */
/obj/machinery/computer/bsa_control/proc/calibrate(mob/user)
	if(!GLOB.bsa_unlock)
		return
	var/list/gps_locators = list()
	for(var/datum/component/gps/iterating_gps in GLOB.GPS_list) //nulls on the list somehow
		if(iterating_gps.tracking)
			gps_locators[iterating_gps.gpstag] = iterating_gps

	var/list/options = gps_locators
	if(area_aim)
		options += GLOB.teleportlocs
	var/victim = tgui_input_list(user, "Select target", "Artillery Targeting", options)
	if(isnull(victim))
		return
	if(isnull(options[victim]))
		return
	target = options[victim]

/**
 * Returns the targets name, simple.
 */
/obj/machinery/computer/bsa_control/proc/get_target_name()
	if(istype(target, /area))
		return get_area_name(target, TRUE)
	else if(istype(target, /datum/component/gps))
		var/datum/component/gps/gps = target
		return gps.gpstag

/**
 * Locates the impact turf based off of if it's an area or a GPS.
 */
/obj/machinery/computer/bsa_control/proc/get_impact_turf()
	if(obj_flags & EMAGGED)
		return get_turf(src)
	else if(istype(target, /area))
		return pick(get_area_turfs(target))
	else if(istype(target, /datum/component/gps))
		var/datum/component/gps/gps = target
		return get_turf(gps.parent)

/**
 * Initiates the cannon fire protocol
 */
/obj/machinery/computer/bsa_control/proc/fire(mob/user)
	var/obj/machinery/bsa/full/cannon = connected_cannon?.resolve()
	if(!cannon)
		notice = "System error"
		return
	if((cannon.machine_stat & BROKEN))
		notice = "Cannon integrity failure!"
		return
	if((cannon.machine_stat & NOPOWER))
		notice = "Cannon unpowered!"
		return
	var/turf/target_turf = get_impact_turf()
	notice = cannon.pre_fire(user, target_turf)

/**
 * Deploy
 *
 * Deploys the cannon and deletes the old parts.
 */
/obj/machinery/computer/bsa_control/proc/deploy(force=FALSE)
	var/obj/machinery/bsa/full/prebuilt = locate() in range(7) //In case of adminspawn
	if(prebuilt)
		prebuilt.control_computer = src
		connected_cannon = WEAKREF(prebuilt)
		return

	var/obj/machinery/bsa/middle/centerpiece = locate() in range(7)
	if(!centerpiece)
		notice = "No BSA parts detected nearby."
		return null
	notice = centerpiece.check_completion()
	if(notice)
		return null
	//Totally nanite construction system not an immersion breaking spawning
	var/datum/effect_system/fluid_spread/smoke/smoke = new
	smoke.set_up(4, location = get_turf(centerpiece))
	smoke.start()
	var/obj/machinery/bsa/full/cannon = new(get_turf(centerpiece), centerpiece.get_cannon_direction())
	cannon.control_computer = src
	if(centerpiece.front_piece)
		qdel(centerpiece.front_piece.resolve())
	if(centerpiece.back_piece)
		qdel(centerpiece.back_piece.resolve())
	qdel(centerpiece)
	connected_cannon = WEAKREF(cannon)

