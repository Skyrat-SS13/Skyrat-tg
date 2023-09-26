// Solar panels

/obj/machinery/power/solar/quickdeploy
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	flags_1 = NODECONSTRUCT_1
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/solar

/obj/machinery/power/solar/quickdeploy/examine(mob/user)
	. = ..()
	. += span_notice("You could probably <b>repack</b> this with <b>right click</b>.")

/obj/machinery/power/solar/quickdeploy/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(!can_interact(user) || !user.can_perform_action(src))
		return

	balloon_alert_to_viewers("repacking...")
	if(do_after(user, 1 SECONDS, target = src))
		playsound(src, 'sound/items/ratchet.ogg', 50, TRUE)
		new repacked_type(get_turf(src))
		deconstruct(disassembled = TRUE)

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/power/solar/quickdeploy/crowbar_act(mob/user, obj/item/I)
	return

/obj/machinery/power/solar/quickdeploy/deconstruct(disassembled = TRUE)
	var/obj/item/solar_assembly/assembly = locate() in src
	if(assembly)
		qdel(assembly)
	return ..()

// Solar panel deployable item

/obj/item/flatpacked_machine/solar
	name = "\improper flatpacked solar panel"
	desc = "The whole of a solar panel, panel included. This one's frame is built different \
		to standard panels in order to allow a relatively compact stowage form factor."
	icon_state = "solar_panel_packed"
	type_to_deploy = /obj/machinery/power/solar/quickdeploy
	deploy_time = 2 SECONDS

// Solar trackers

/obj/machinery/power/tracker/quickdeploy
	icon = 'modular_skyrat/modules/colony_fabricator/icons/machines.dmi'
	flags_1 = NODECONSTRUCT_1
	/// The item we turn into when repacked
	var/repacked_type = /obj/item/flatpacked_machine/solar_tracker

/obj/machinery/power/tracker/quickdeploy/examine(mob/user)
	. = ..()
	. += span_notice("You could probably <b>repack</b> this with <b>right click</b>.")

/obj/machinery/power/tracker/quickdeploy/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(!can_interact(user) || !user.can_perform_action(src))
		return

	balloon_alert_to_viewers("repacking...")
	if(do_after(user, 1 SECONDS, target = src))
		playsound(src, 'sound/items/ratchet.ogg', 50, TRUE)
		new repacked_type(get_turf(src))
		deconstruct(disassembled = TRUE)

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/machinery/power/tracker/quickdeploy/crowbar_act(mob/user, obj/item/I)
	return

/obj/machinery/power/tracker/quickdeploy/deconstruct(disassembled = TRUE)
	var/obj/item/solar_assembly/assembly = locate() in src
	if(assembly)
		qdel(assembly)
	return ..()

// Solar tracker deployable item

/obj/item/flatpacked_machine/solar_tracker
	name = "\improper flatpacked solar tracker"
	desc = "The whole of a solar tracker, panel included. This one's frame is built different \
		to standard panels in order to allow a relatively compact stowage form factor."
	icon_state = "solar_tracker_packed"
	type_to_deploy = /obj/machinery/power/tracker/quickdeploy
