/**
 * This file contains all the control computer related systems.
 */

/obj/machinery/particle_accelerator/control_box
	name = "particle accelerator control console"
	desc = "This controls the density of the particles."
	icon = 'modular_skyrat/modules/singularity_engine/icons/particle_accelerator_controlbox.dmi'
	icon_state = "control_box"
	anchored = FALSE
	density = TRUE
	use_power = NO_POWER_USE
	idle_power_usage = 500
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 10
	dir = NORTH
	mouse_opacity = MOUSE_OPACITY_OPAQUE

	/// The upper limit of our allowed particle strength setting
	var/strength_upper_limit = PARTICLE_STRENGTH_STRONG
	/// The toggle to control if our control wire is cut or not
	var/interface_control = TRUE
	/// A list of our connected parts
	var/list/obj/structure/particle_accelerator/connected_parts
	/// Are we assembled correctly?
	var/assembled = FALSE
	/// Current construction state
	var/construction_state = PA_CONSTRUCTION_UNSECURED
	/// Is the accelerator active?
	var/active = FALSE
	/// Our current strength
	var/strength = PARTICLE_STRENGTH_WEAK
	/// Are we powered?
	var/powered = FALSE

/obj/machinery/particle_accelerator/control_box/Initialize(mapload)
	. = ..()
	wires = new /datum/wires/particle_accelerator/control_box(src)
	connected_parts = list()

/obj/machinery/particle_accelerator/control_box/Destroy()
	if(active)
		toggle_power()
	for(var/obj/structure/particle_accelerator/part as anything in connected_parts)
		part.master = null
	connected_parts.Cut()
	QDEL_NULL(wires)
	return ..()

/obj/machinery/particle_accelerator/control_box/multitool_act(mob/living/user, obj/item/I)
	. = ..()
	if(construction_state == PA_CONSTRUCTION_PANEL_OPEN)
		wires.interact(user)
		return TRUE

/obj/machinery/particle_accelerator/control_box/proc/update_state()
	if(construction_state < PA_CONSTRUCTION_COMPLETE)
		use_power = NO_POWER_USE
		assembled = FALSE
		active = FALSE
		for(var/obj/structure/particle_accelerator/part as anything in connected_parts)
			part.strength = null
			part.powered = FALSE
			part.update_icon()
		connected_parts.Cut()
		return
	if(!part_scan())
		use_power = IDLE_POWER_USE
		active = FALSE
		connected_parts.Cut()

/obj/machinery/particle_accelerator/control_box/update_icon_state()
	. = ..()
	if(active)
		icon_state = "control_boxp[strength]"
	else
		if(use_power)
			if(assembled)
				icon_state = "control_boxp"
			else
				icon_state = "ucontrol_boxp"
		else
			switch(construction_state)
				if(PA_CONSTRUCTION_UNSECURED, PA_CONSTRUCTION_UNWIRED)
					icon_state = "control_box"
				if(PA_CONSTRUCTION_PANEL_OPEN)
					icon_state = "control_boxw"
				else
					icon_state = "control_boxc"

/**
 * Strength Change
 *
 * This is a proc that is called when the strength of the particle accelerator changes.
 * It updates the appearance of the parts.
 */
/obj/machinery/particle_accelerator/control_box/proc/strength_change()
	for(var/obj/structure/particle_accelerator/part as anything in connected_parts)
		part.strength = strength
		part.update_icon()
		update_appearance()

/obj/machinery/particle_accelerator/control_box/proc/increase_strength()
	if(assembled && (strength < strength_upper_limit))
		strength++
		strength_change()

		log_game("PA Control Computer increased to [strength] by [key_name(usr)] in [AREACOORD(src)]")
		investigate_log("increased to <font color='red'>[strength]</font> by [key_name(usr)] at [AREACOORD(src)]", INVESTIGATE_ENGINE)

/obj/machinery/particle_accelerator/control_box/proc/decrease_strength()
	if(assembled && (strength > 0))
		strength--
		strength_change()

		log_game("PA Control Computer decreased to [strength] by [key_name(usr)] in [AREACOORD(src)]")
		investigate_log("decreased to <font color='green'>[strength]</font> by [key_name(usr)] at [AREACOORD(src)]", INVESTIGATE_ENGINE)

/obj/machinery/particle_accelerator/control_box/power_change()
	. = ..()
	if(machine_stat & NOPOWER)
		active = FALSE
		use_power = NO_POWER_USE
	else if(!machine_stat && construction_state == PA_CONSTRUCTION_COMPLETE)
		use_power = IDLE_POWER_USE

/obj/machinery/particle_accelerator/control_box/process()
	if(active)
		//a part is missing!
		if(LAZYLEN(connected_parts) < 6)
			investigate_log("lost a connected part; It <font color='red'>powered down</font>.", INVESTIGATE_ENGINE)
			toggle_power()
			update_appearance()
			return
		//emit some particles
		for(var/obj/structure/particle_accelerator/particle_emitter/PE in connected_parts)
			PE.emit_particle(strength)

/**
 * Part Scan
 *
 * Scans the nearby area for all related parts.
 *
 * It will also turn them to be facing the correct way.
 */
/obj/machinery/particle_accelerator/control_box/proc/part_scan()
	var/left_dir = turn(dir, -90)
	var/right_dir = turn(dir, 90)
	var/around_dir = turn(dir, 180)
	var/turf/our_turf = get_turf(src)

	assembled = FALSE
	critical_machine = FALSE

	var/obj/structure/particle_accelerator/fuel_chamber/found_fuel_chamber = locate() in orange(1, src)
	if(!found_fuel_chamber)
		return FALSE

	setDir(found_fuel_chamber.dir)
	connected_parts.Cut()

	our_turf = get_step(our_turf, right_dir)
	if(!check_part(our_turf, /obj/structure/particle_accelerator/fuel_chamber))
		return FALSE
	our_turf = get_step(our_turf, around_dir)
	if(!check_part(our_turf, /obj/structure/particle_accelerator/end_cap))
		return FALSE
	our_turf = get_step(our_turf, dir)
	our_turf = get_step(our_turf, dir)
	if(!check_part(our_turf, /obj/structure/particle_accelerator/power_box))
		return FALSE
	our_turf = get_step(our_turf, dir)
	if(!check_part(our_turf, /obj/structure/particle_accelerator/particle_emitter/center))
		return FALSE
	our_turf = get_step(our_turf, left_dir)
	if(!check_part(our_turf, /obj/structure/particle_accelerator/particle_emitter/left))
		return FALSE
	our_turf = get_step(our_turf, right_dir)
	our_turf = get_step(our_turf, right_dir)
	if(!check_part(our_turf, /obj/structure/particle_accelerator/particle_emitter/right))
		return FALSE

	assembled = TRUE
	critical_machine = TRUE	//Only counts if the PA is actually assembled.
	return TRUE

/obj/machinery/particle_accelerator/control_box/proc/check_part(turf/turf_to_check, type)
	var/obj/structure/particle_accelerator/found_accelerator = locate(/obj/structure/particle_accelerator) in turf_to_check
	if(istype(found_accelerator, type) && (found_accelerator.construction_state == PA_CONSTRUCTION_COMPLETE))
		if(found_accelerator.connect_master(src))
			connected_parts.Add(found_accelerator)
			return TRUE
	return FALSE

/obj/machinery/particle_accelerator/control_box/proc/toggle_power()
	active = !active
	investigate_log("turned [active?"<font color='green'>ON</font>":"<font color='red'>OFF</font>"] by [usr ? key_name(usr) : "outside forces"] at [AREACOORD(src)]", INVESTIGATE_ENGINE)
	message_admins("PA Control Computer turned [active ?"ON":"OFF"] by [usr ? ADMIN_LOOKUPFLW(usr) : "outside forces"] in [ADMIN_VERBOSEJMP(src)]")
	log_game("PA Control Computer turned [active ?"ON":"OFF"] by [usr ? "[key_name(usr)]" : "outside forces"] at [AREACOORD(src)]")
	if(active)
		use_power = ACTIVE_POWER_USE
		for(var/obj/structure/particle_accelerator/part as anything in connected_parts)
			part.strength = strength
			part.powered = TRUE
			part.update_icon()
	else
		use_power = IDLE_POWER_USE
		for(var/obj/structure/particle_accelerator/part as anything in connected_parts)
			part.strength = null
			part.powered = FALSE
			part.update_icon()
	return TRUE

/obj/machinery/particle_accelerator/control_box/examine(mob/user)
	. = ..()
	switch(construction_state)
		if(PA_CONSTRUCTION_UNSECURED)
			. += "Looks like it's not attached to the flooring."
		if(PA_CONSTRUCTION_UNWIRED)
			. += "It is missing some cables."
		if(PA_CONSTRUCTION_PANEL_OPEN)
			. += "The panel is open."

/obj/machinery/particle_accelerator/control_box/set_anchored(anchorvalue)
	. = ..()
	if(isnull(.))
		return
	construction_state = anchorvalue ? PA_CONSTRUCTION_UNWIRED : PA_CONSTRUCTION_UNSECURED
	update_state()
	update_icon()

/obj/machinery/particle_accelerator/control_box/attackby(obj/item/weapon, mob/user, params)
	var/did_something = FALSE

	switch(construction_state)
		if(PA_CONSTRUCTION_UNSECURED)
			if(weapon.tool_behaviour == TOOL_WRENCH && !isinspace())
				weapon.play_tool_sound(src, 75)
				set_anchored(TRUE)
				user.visible_message(span_notice("[user.name] secures the [name] to the floor."), \
					span_notice("You secure the external bolts."))
				user.changeNext_move(CLICK_CD_MELEE)
				return //set_anchored handles the rest of the stuff we need to do.
		if(PA_CONSTRUCTION_UNWIRED)
			if(weapon.tool_behaviour == TOOL_WRENCH)
				weapon.play_tool_sound(src, 75)
				set_anchored(FALSE)
				user.visible_message(span_notice("[user.name] detaches the [name] from the floor."), \
					span_notice("You remove the external bolts."))
				user.changeNext_move(CLICK_CD_MELEE)
				return //set_anchored handles the rest of the stuff we need to do.
			else if(istype(weapon, /obj/item/stack/cable_coil))
				var/obj/item/stack/cable_coil/CC = weapon
				if(CC.use(1))
					user.visible_message(span_notice("[user.name] adds wires to the [name]."), \
						span_notice("You add some wires."))
					construction_state = PA_CONSTRUCTION_PANEL_OPEN
					did_something = TRUE
		if(PA_CONSTRUCTION_PANEL_OPEN)
			if(weapon.tool_behaviour == TOOL_WIRECUTTER)
				user.visible_message(span_notice("[user.name] removes some wires from the [name]."), \
					span_notice("You remove some wires."))
				construction_state = PA_CONSTRUCTION_UNWIRED
				did_something = TRUE
			else if(weapon.tool_behaviour == TOOL_SCREWDRIVER)
				user.visible_message(span_notice("[user.name] closes the [name]'s access panel."), \
					span_notice("You close the access panel."))
				construction_state = PA_CONSTRUCTION_COMPLETE
				did_something = TRUE
		if(PA_CONSTRUCTION_COMPLETE)
			if(weapon.tool_behaviour == TOOL_SCREWDRIVER)
				user.visible_message(span_notice("[user.name] opens the [name]'s access panel."), \
					span_notice("You open the access panel."))
				construction_state = PA_CONSTRUCTION_PANEL_OPEN
				did_something = TRUE

	if(did_something)
		user.changeNext_move(CLICK_CD_MELEE)
		update_state()
		update_icon()
		return

	return ..()

/obj/machinery/particle_accelerator/control_box/blob_act(obj/structure/blob/B)
	if(prob(50))
		qdel(src)

/obj/machinery/particle_accelerator/control_box/interact(mob/user)
	if(construction_state == PA_CONSTRUCTION_PANEL_OPEN)
		wires.interact(user)
	else
		..()

/obj/machinery/particle_accelerator/control_box/proc/is_interactive(mob/user)
	if(!interface_control)
		to_chat(user, span_alert("ERROR: Request timed out. Check wire contacts."))
		return FALSE
	if(construction_state != PA_CONSTRUCTION_COMPLETE)
		return FALSE
	return TRUE

/obj/machinery/particle_accelerator/control_box/ui_status(mob/user)
	if(is_interactive(user))
		return ..()
	return UI_CLOSE

/obj/machinery/particle_accelerator/control_box/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ParticleAccelerator", name)
		ui.open()

/obj/machinery/particle_accelerator/control_box/ui_data(mob/user)
	var/list/data = list()
	data["assembled"] = assembled
	data["power"] = active
	data["strength"] = strength
	return data

/obj/machinery/particle_accelerator/control_box/ui_act(action, params)
	if(..())
		return

	switch(action)
		if("power")
			if(wires.is_cut(WIRE_POWER))
				return
			toggle_power()
			. = TRUE
		if("scan")
			part_scan()
			. = TRUE
		if("increase_strength")
			if(wires.is_cut(WIRE_STRENGTH))
				return
			increase_strength()
			. = TRUE
		if("decrease_strength")
			if(wires.is_cut(WIRE_STRENGTH))
				return
			decrease_strength()
			. = TRUE

	update_icon()

/**
 * Wires
 */

/datum/wires/particle_accelerator/control_box
	holder_type = /obj/machinery/particle_accelerator/control_box
	proper_name = "Particle Accelerator"

/datum/wires/particle_accelerator/control_box/New(atom/holder)
	wires = list(
		WIRE_POWER, WIRE_STRENGTH, WIRE_LIMIT,
		WIRE_INTERFACE
	)
	add_duds(2)
	..()

/datum/wires/particle_accelerator/control_box/interactable(mob/user)
	if(!..())
		return FALSE
	var/obj/machinery/particle_accelerator/control_box/control_box = holder
	if(control_box.construction_state == 2)
		return TRUE

/datum/wires/particle_accelerator/control_box/on_pulse(wire, user)
	var/obj/machinery/particle_accelerator/control_box/control_box = holder
	switch(wire)
		if(WIRE_POWER)
			control_box.toggle_power()
		if(WIRE_STRENGTH)
			control_box.increase_strength()
		if(WIRE_INTERFACE)
			control_box.interface_control = !control_box.interface_control
		if(WIRE_LIMIT)
			control_box.visible_message(span_notice("[icon2html(control_box, viewers(holder))]<b>[control_box]</b> makes a loud whirring noise."))

/datum/wires/particle_accelerator/control_box/on_cut(wire, mend = FALSE, source = null)
	var/obj/machinery/particle_accelerator/control_box/control_box = holder
	switch(wire)
		if(WIRE_POWER)
			if(control_box.active == !mend)
				control_box.toggle_power()
		if(WIRE_STRENGTH)
			for(var/i = 1; i < 3; i++)
				control_box.decrease_strength()
		if(WIRE_INTERFACE)
			if(!mend)
				control_box.interface_control = FALSE
		if(WIRE_LIMIT)
			control_box.strength_upper_limit = (mend ? 2 : 3)
			if(control_box.strength_upper_limit < control_box.strength)
				control_box.increase_strength()

/datum/wires/particle_accelerator/control_box/emp_pulse() // to prevent singulo from pulsing wires
	return

