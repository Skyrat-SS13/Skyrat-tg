/*
 *	Composed of 7 parts:
 *	3 Particle Emitters
 *	1 Power Box
 *	1 Fuel Chamber
 *	1 End Cap
 *	1 Control computer
 *	Setup map
 *	  |EC|
 *	CC|FC|
 *	  |PB|
 *	PE|PE|PE
*/


/obj/structure/particle_accelerator
	name = "particle accelerator"
	desc = "Part of a Particle Accelerator."
	icon = 'modular_skyrat/modules/singularity_engine/icons/particle_accelerator.dmi'
	icon_state = "power_box"
	anchored = FALSE
	density = TRUE
	max_integrity = 500
	armor_type = /datum/armor/structure_particle_accelerator

	/// Our master control computer.
	var/obj/machinery/particle_accelerator/control_box/master = null
	/// Our construction state.
	var/construction_state = PA_CONSTRUCTION_UNSECURED
	/// The default icon state.
	var/icon_state_reference = null
	/// Are we powered or not?
	var/powered = FALSE
	/// Our current strength for the particles.
	var/strength = null

/datum/armor/structure_particle_accelerator
	melee = 30
	melee = 20
	laser = 20
	fire = 90
	acid = 80

/obj/structure/particle_accelerator/examine(mob/user)
	. = ..()

	switch(construction_state)
		if(PA_CONSTRUCTION_UNSECURED)
			. += "Looks like it's not attached to the flooring."
		if(PA_CONSTRUCTION_UNWIRED)
			. += "It is missing some cables."
		if(PA_CONSTRUCTION_PANEL_OPEN)
			. += "The panel is open."

/obj/structure/particle_accelerator/Destroy()
	construction_state = PA_CONSTRUCTION_UNSECURED
	if(master)
		master.connected_parts -= src
		master.assembled = 0
		master = null
	return ..()

/obj/structure/particle_accelerator/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/simple_rotation)


/obj/structure/particle_accelerator/set_anchored(anchorvalue)
	. = ..()
	if(isnull(.))
		return
	construction_state = anchorvalue ? PA_CONSTRUCTION_UNWIRED : PA_CONSTRUCTION_UNSECURED
	update_state()
	update_appearance()

/obj/structure/particle_accelerator/attackby(obj/item/attacking_item, mob/user, params)
	var/did_something = FALSE

	switch(construction_state)
		if(PA_CONSTRUCTION_UNSECURED)
			if(attacking_item.tool_behaviour == TOOL_WRENCH && !isinspace())
				attacking_item.play_tool_sound(src, 75)
				set_anchored(TRUE)
				user.visible_message(span_notice("[user.name] secures the [name] to the floor."), \
					span_notice("You secure the external bolts."))
				user.changeNext_move(CLICK_CD_MELEE)
				return //set_anchored handles the rest of the stuff we need to do.
		if(PA_CONSTRUCTION_UNWIRED)
			if(attacking_item.tool_behaviour == TOOL_WRENCH)
				attacking_item.play_tool_sound(src, 75)
				set_anchored(FALSE)
				user.visible_message(span_notice("[user.name] detaches the [name] from the floor."), \
					span_notice("You remove the external bolts."))
				user.changeNext_move(CLICK_CD_MELEE)
				return //set_anchored handles the rest of the stuff we need to do.
			else if(istype(attacking_item, /obj/item/stack/cable_coil))
				var/obj/item/stack/cable_coil/cable_coil = attacking_item
				if(cable_coil.use(1))
					user.visible_message(span_notice("[user.name] adds wires to the [name]."), \
						span_notice("You add some wires."))
					construction_state = PA_CONSTRUCTION_PANEL_OPEN
					did_something = TRUE
		if(PA_CONSTRUCTION_PANEL_OPEN)
			if(attacking_item.tool_behaviour == TOOL_WIRECUTTER)//TODO:Shock user if its on?
				user.visible_message(span_notice("[user.name] removes some wires from the [name]."), \
					span_notice("You remove some wires."))
				construction_state = PA_CONSTRUCTION_UNWIRED
				did_something = TRUE
			else if(attacking_item.tool_behaviour == TOOL_SCREWDRIVER)
				attacking_item.play_tool_sound(src, 75)
				user.visible_message(span_notice("[user.name] closes the [name]'s access panel."), \
					span_notice("You close the access panel."))
				construction_state = PA_CONSTRUCTION_COMPLETE
				did_something = TRUE
		if(PA_CONSTRUCTION_COMPLETE)
			if(attacking_item.tool_behaviour == TOOL_SCREWDRIVER)
				user.visible_message(span_notice("[user.name] opens the [name]'s access panel."), \
					span_notice("You open the access panel."))
				construction_state = PA_CONSTRUCTION_PANEL_OPEN
				did_something = TRUE

	if(did_something)
		user.changeNext_move(CLICK_CD_MELEE)
		update_state()
		update_appearance()
		return

	return ..()


/obj/structure/particle_accelerator/deconstruct(disassembled = TRUE)
	if(!(obj_flags & NO_DECONSTRUCTION))
		new /obj/item/stack/sheet/iron (loc, 5)
	qdel(src)

/obj/structure/particle_accelerator/Move()
	. = ..()
	if(master && master.active)
		master.toggle_power()
		investigate_log("was moved whilst active; it <font color='red'>powered down</font>.", INVESTIGATE_ENGINE)


/obj/structure/particle_accelerator/update_icon_state()
	. = ..()
	switch(construction_state)
		if(PA_CONSTRUCTION_UNSECURED, PA_CONSTRUCTION_UNWIRED)
			icon_state="[icon_state_reference]"
		if(PA_CONSTRUCTION_PANEL_OPEN)
			icon_state="[icon_state_reference]w"
		if(PA_CONSTRUCTION_COMPLETE)
			if(powered)
				icon_state="[icon_state_reference]p[strength]"
			else
				icon_state="[icon_state_reference]c"

/obj/structure/particle_accelerator/proc/update_state()
	if(master)
		master.update_state()

/obj/structure/particle_accelerator/proc/connect_master(obj/object)
	if(object.dir == dir)
		master = object
		return TRUE
	return FALSE

/*
*	PARTS
*/

/obj/structure/particle_accelerator/end_cap
	name = "alpha particle generation array"
	desc = "This is where alpha particles are generated from \[REDACTED\]."
	icon_state = "end_cap"
	icon_state_reference = "end_cap"

/obj/structure/particle_accelerator/power_box
	name = "particle focusing EM lens"
	desc = "This uses electromagnetic waves to focus the alpha particles."
	icon = 'modular_skyrat/modules/singularity_engine/icons/particle_accelerator.dmi'
	icon_state = "power_box"
	icon_state_reference = "power_box"

/obj/structure/particle_accelerator/fuel_chamber
	name = "EM acceleration chamber"
	desc = "This is where the alpha particles are accelerated to <b><i>radical speeds</i></b>."
	icon = 'modular_skyrat/modules/singularity_engine/icons/particle_accelerator.dmi'
	icon_state = "fuel_chamber"
	icon_state_reference = "fuel_chamber"
