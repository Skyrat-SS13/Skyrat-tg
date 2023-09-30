// Short wooden fences, oh me oh my

/obj/structure/railing/wooden_fencing
	name = "wooden fence"
	desc = "A basic wooden fence meant to prevent people like you either in or out of somewhere."
	icon = 'modular_skyrat/modules/primitive_structures/icons/wooden_fence.dmi'
	icon_state = "fence"
	layer = BELOW_OBJ_LAYER // I think this is the default but lets be safe?
	resistance_flags = FLAMMABLE
	flags_1 = NODECONSTRUCT_1 | ON_BORDER_1

/obj/structure/railing/wooden_fencing/Initialize(mapload)
	. = ..()
	icon_state = pick(
		"fence",
		"fence_2",
		"fence_3",
	)
	update_appearance(UPDATE_ICON)

/obj/structure/railing/wooden_fencing/update_icon()
	. = ..()
	switch(dir)
		if(SOUTH)
			layer = ABOVE_MOB_LAYER
		if(NORTH)
			layer = initial(layer) - 0.01
		else
			layer = initial(layer)

// Fence gates for the above mentioned fences

/obj/structure/railing/wooden_fencing/gate
	name = "wooden fence gate"
	desc = "A basic wooden gate meant to prevent animals like you escaping."
	icon_state = "gate"
	/// Has the gate been opened or not?
	var/opened

/obj/structure/railing/wooden_fencing/gate/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	return open_or_close(user)

/// Proc that checks if the gate is open or not, then closes/opens the gate repsectively
/obj/structure/railing/wooden_fencing/gate/proc/open_or_close(mob/user)
	if(!user.can_interact_with(src))
		balloon_alert(user, "can't interact")
		return
	opened = !opened
	set_density(!opened)
	icon_state = "[opened ? "gate_open" : "gate"]"
	update_appearance(UPDATE_ICON)

/obj/structure/railing/wooden_fencing/gate/update_icon()
	. = ..()
	if(!opened)
		return
	if(dir == EAST)
		layer = ABOVE_MOB_LAYER

// Large wooden gate, used for big doors or entrances to camps

/obj/structure/mineral_door/wood/large_gate
	name = "large wooden gate"
	icon = 'modular_skyrat/modules/primitive_structures/icons/wooden_gate.dmi'
	icon_state = "gate"

/obj/structure/mineral_door/wood/large_gate/Open()
	playsound(src, openSound, 100, TRUE)
	set_opacity(FALSE)
	set_density(FALSE)
	door_opened = TRUE
	layer = OPEN_DOOR_LAYER
	air_update_turf(TRUE, FALSE)
	update_appearance()

/obj/structure/mineral_door/wood/large_gate/Close()
	if(!door_opened)
		return
	for(var/mob/living/blocking_mob in get_turf(src))
		return
	playsound(src, closeSound, 100, TRUE)
	set_density(TRUE)
	set_opacity(TRUE)
	door_opened = FALSE
	layer = initial(layer)
	air_update_turf(TRUE, TRUE)
	update_appearance()

/obj/structure/mineral_door/wood/large_gate/update_icon()
	. = ..()
	if(!door_opened)
		return
	if(dir == EAST)
		layer = ABOVE_MOB_LAYER
