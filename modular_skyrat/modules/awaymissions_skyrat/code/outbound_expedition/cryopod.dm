GLOBAL_LIST_EMPTY(outbound_cryopods)

/obj/machinery/outbound_expedition
	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	max_integrity = INFINITY
	density = TRUE
	anchored = TRUE
	/// If the system has failed
	var/failed = FALSE

/obj/machinery/outbound_expedition/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_AWAY_SYSTEM_FAIL, .proc/on_system_fail)

/obj/machinery/outbound_expedition/proc/on_system_fail(datum/outbound_ship_system/failed_system)
	SHOULD_CALL_PARENT(TRUE)
	failed = TRUE

/obj/machinery/outbound_expedition/cryopod
	name = "cryogenic freezer"
	desc = "A cryogenic pod that slows down body functions, enabling long-term journeys with minimal impact to the user.."
	icon = 'modular_skyrat/modules/cryosleep/icons/cryogenics.dmi'
	icon_state = "cryopod-open"
	density = TRUE
	anchored = TRUE
	state_open = TRUE
	interaction_flags_machine = INTERACT_MACHINE_OFFLINE|INTERACT_MACHINE_WIRES_IF_OPEN|INTERACT_MACHINE_ALLOW_SILICON|INTERACT_MACHINE_OPEN_SILICON|INTERACT_MACHINE_SET_MACHINE
	/// Is the machine locked closed, unable to open?
	var/locked = FALSE

/obj/machinery/outbound_expedition/cryopod/Initialize(mapload)
	. = ..()
	GLOB.outbound_cryopods += src

/obj/machinery/outbound_expedition/cryopod/Destroy()
	GLOB.outbound_cryopods -= src
	return ..()

/obj/machinery/outbound_expedition/cryopod/close_machine(atom/movable/target, density_to_set = TRUE)
	OUTBOUND_CONTROLLER
	if((isnull(target) || isliving(target)) && state_open && !panel_open)
		..()
		var/mob/living/mob_occupant = occupant
		if(mob_occupant && mob_occupant.stat != DEAD)
			to_chat(occupant, span_notice("<b>You feel cool air surround you. You go numb as your senses turn inward.</b>"))

	SEND_SIGNAL(outbound_controller, COMSIG_AWAY_CRYOPOD_ENTERED, target)

	icon_state = "cryopod"

/obj/machinery/outbound_expedition/cryopod/open_machine(drop = TRUE, density_to_set = FALSE)
	OUTBOUND_CONTROLLER
	if(locked)
		for(var/mob/living/locked_in in contents)
			to_chat(locked_in, span_warning("[src] seems to be locked, it won't budge!"))
		return
	for(var/mob/living/internal_mob in contents)
		SEND_SIGNAL(outbound_controller, COMSIG_AWAY_CRYOPOD_EXITED, internal_mob)
	..()
	icon_state = "cryopod-open"
	set_density(density_to_set)
	name = initial(name)

/obj/machinery/outbound_expedition/cryopod/container_resist_act(mob/living/user)
	if(locked)
		to_chat(user, span_warning("[src] seems to be locked, it won't budge!"))
		return
	visible_message(span_notice("[occupant] emerges from [src]!"),
		span_notice("You climb out of [src]!"))
	open_machine()

/obj/machinery/outbound_expedition/cryopod/relaymove(mob/user)
	container_resist_act(user)

/obj/machinery/outbound_expedition/cryopod/MouseDrop_T(mob/living/target, mob/user)
	if(!istype(target) || !can_interact(user) || !target.Adjacent(user) || !ismob(target) || isanimal(target) || !istype(user.loc, /turf) || target.buckled)
		return
	OUTBOUND_CONTROLLER

	if(outbound_controller.current_event)
		to_chat(user, span_notice("You can't cryo at the moment!"))
		return

	if(occupant)
		to_chat(user, span_notice("[src] is already occupied!"))
		return

	if(target.stat == DEAD)
		to_chat(user, span_notice("Dead people can not be put into cryo."))
		return

	if(tgui_alert(user, "Would you like to place [target] into [src]?", "Place into Cryopod?", list("Yes", "No")) == "No")
		return

	if(!target.Adjacent(src))
		return

	to_chat(user, span_danger("You put [target] into [src]. [target.p_theyre(capitalized = TRUE)] in the cryopod."))

	add_fingerprint(target)

	close_machine(target)
	name = "[name] ([target.name])"

	if(LAZYLEN(target.buckled_mobs) > 0)
		if(target == user)
			to_chat(user, span_danger("You can't fit into the cryopod while someone is buckled to you."))
		else
			to_chat(user, span_danger("You can't fit [target] into the cryopod while someone is buckled to them."))
		return

	if(!istype(target) || !can_interact(user) || !target.Adjacent(user) || !ismob(target) || isanimal(target) || !istype(user.loc, /turf) || target.buckled)
		return
		// rerun the checks in case of shenanigans

	if(occupant)
		to_chat(user, span_notice("[src] is already occupied!"))
		return

	if(target == user)
		visible_message(span_infoplain("[user] starts climbing into the cryo pod."))
	else
		visible_message(span_infoplain("[user] starts putting [target] into the cryo pod."))

	add_fingerprint(target)

	close_machine(target)
	name = "[name] ([target.name])"
