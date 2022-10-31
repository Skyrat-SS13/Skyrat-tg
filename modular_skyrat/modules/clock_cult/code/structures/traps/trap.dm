//Thing that you stick on the floor
/obj/item/clockwork/trap_placer
	name = "trap"
	desc = "don't trust it"
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_objects.dmi'
	w_class = WEIGHT_CLASS_HUGE
	var/result_path = /obj/structure/destructible/clockwork/trap

/obj/item/clockwork/trap_placer/attack_self(mob/user)
	. = ..()
	if(!(IS_CLOCK(user)))
		return
	for(var/obj/structure/destructible/clockwork/trap/trap in get_turf(src)) // No 50-spear instakills please
		if(!istype(trap, result_path))
			continue
		user.balloon_alert(user, "space occupied!")
		return
	to_chat(user, span_brass("You place [src], use a <b>clockwork slab</b> to link it to other traps."))
	var/obj/new_obj = new result_path(get_turf(src))
	new_obj.setDir(user.dir)
	qdel(src)

//Thing you stick on the wall
/obj/item/wallframe/clocktrap
	name = "Clockwork trap item"
	desc = "It's a... wait what?"
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_objects.dmi'
	pixel_shift = -24
	w_class = WEIGHT_CLASS_HUGE
	result_path = /obj/structure/destructible/clockwork/trap

/obj/item/wallframe/clocktrap/examine(mob/user)
	. = ..()
	if(IS_CLOCK(user))
		. += span_brass("It looks like it can be placed on a wall.")

//Wall item (either spawned by a wallframe or directly)
/obj/structure/destructible/clockwork/trap
	name = "Clockwork trap item"
	desc = "monkey noises"
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_objects.dmi'
	density = FALSE
	layer = LOW_OBJ_LAYER
	break_message = span_warning("The intricate looking device falls apart.")
	/// What item's produced when this structure is unwrenched
	var/unwrench_path = /obj/item/wallframe/clocktrap
	/// The component used for the trap's back-end
	var/component_datum = /datum/component/clockwork_trap

/obj/structure/destructible/clockwork/trap/Initialize(mapload)
	. = ..()
	AddComponent(component_datum)

/obj/structure/destructible/clockwork/trap/wrench_act(mob/living/user, obj/item/I)
	. = ..()
	balloon_alert(user, "unwrenching...")
	if(!do_after(user, 50, target=src))
		return
	balloon_alert(user, "detached [src]")
	new unwrench_path(get_turf(src))
	qdel(src)

//Component
/datum/component/clockwork_trap
	/// A list of traps this sends a signal to when this is triggered
	var/list/outputs
	/// If this sends input (e.g. pressure plate)
	var/sends_input = FALSE
	/// If this takes input (e.g. skewer)
	var/takes_input = FALSE

/datum/component/clockwork_trap/Initialize()
	. = ..()
	outputs = list()

	RegisterSignal(parent, COMSIG_CLOCKWORK_SIGNAL_RECEIVED, .proc/trigger)
	RegisterSignal(parent, COMSIG_ATOM_ATTACK_HAND, .proc/clicked)
	RegisterSignal(parent, COMSIG_PARENT_ATTACKBY, .proc/on_attackby)

/datum/component/clockwork_trap/proc/add_input(datum/component/clockwork_trap/input)
	outputs |= input.parent

/datum/component/clockwork_trap/proc/add_output(datum/component/clockwork_trap/output)
	output.outputs |= parent

/datum/component/clockwork_trap/proc/trigger()
	SIGNAL_HANDLER

	return TRUE

/datum/component/clockwork_trap/proc/clicked(mob/user)
	SIGNAL_HANDLER

	return

/datum/component/clockwork_trap/proc/on_attackby(datum/source, obj/item/attack_item, mob/user)
	SIGNAL_HANDLER

	if(!(IS_CLOCK(user)))
		return
	if(!istype(attack_item, /obj/item/clockwork/clockwork_slab))
		return
	var/obj/item/clockwork/clockwork_slab/slab = attack_item
	if(slab.buffer)
		if(takes_input)
			to_chat(user, span_brass("You connect [slab.buffer.parent] to [parent]."))
			add_output(slab.buffer)
			slab.buffer = null
		else
			to_chat(user, span_brass("That device does not accept input."))
	else
		if(sends_input)
			to_chat(user, span_brass("You prepare to connect [parent] with other devices."))
			slab.buffer = src
		else
			to_chat(user, span_brass("That device does not output anything."))

/datum/component/clockwork_trap/proc/trigger_connected()
	for(var/obj/output as anything in outputs) //must be typecasted because of how SEND_SIGNAL works
		SEND_SIGNAL(output, COMSIG_CLOCKWORK_SIGNAL_RECEIVED)
