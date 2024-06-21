///Blocks the implantee from being teleported
/obj/item/implant/teleport_blocker
	name = "bluespace grounding implant"
	desc = "Grounds your bluespace signature in baseline reality, whatever the hell that means."
	actions_types = null
	implant_flags = IMPLANT_TYPE_SECURITY
	hud_icon_state = "hud_imp_noteleport"

/obj/item/implant/teleport_blocker/get_data()
	return "<b>Implant Specifications:</b><BR> \
		<b>Name:</b> Robust Corp EXP-001 'Bluespace Grounder'<BR> \
		<b>Implant Details:</b> Upon implantation, grounds the user's bluespace signature to their currently occupied plane of existence. \
		Most, if not all forms of teleportation on the implantee will be rendered ineffective. Useful for keeping especially slippery prisoners in place.<BR>"

/obj/item/implant/teleport_blocker/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	. = ..()
	if(!. || !isliving(target))
		return FALSE
	RegisterSignal(target, COMSIG_MOVABLE_TELEPORTING, PROC_REF(on_teleport))
	return TRUE

/obj/item/implant/teleport_blocker/removed(mob/target, silent = FALSE, special = FALSE)
	. = ..()
	if(!. || !isliving(target))
		return FALSE
	UnregisterSignal(target, COMSIG_MOVABLE_TELEPORTING)
	return TRUE

/// Signal for COMSIG_MOVABLE_TELEPORTED that blocks teleports and stuns the would-be-teleportee.
/obj/item/implant/teleport_blocker/proc/on_teleport(mob/living/teleportee, atom/destination, channel)
	SIGNAL_HANDLER

	to_chat(teleportee, span_holoparasite("You feel yourself teleporting, but are suddenly flung back to where you just were!"))

	teleportee.apply_status_effect(/datum/status_effect/incapacitating/paralyzed, 5 SECONDS)
	var/datum/effect_system/spark_spread/quantum/spark_system = new()
	spark_system.set_up(5, TRUE, teleportee)
	spark_system.start()
	return COMPONENT_BLOCK_TELEPORT

/obj/item/implantcase/teleport_blocker
	name = "implant case - 'Bluespace Grounding'"
	desc = "A glass case containing a bluespace grounding implant."
	imp_type = /obj/item/implant/teleport_blocker
