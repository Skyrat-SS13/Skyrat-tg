/*
*	BORG POWER TOOLS
*/

/obj/item/crowbar/cyborg/power
	name = "modular crowbar"
	desc = "A cyborg fitted module resembling the jaws of life."
	icon = 'modular_skyrat/modules/cyborg/icons/items_cyborg.dmi'
	icon_state = "jaws_pry_cyborg"
	usesound = 'sound/items/jaws_pry.ogg'
	force = 10
	toolspeed = 0.5

/obj/item/crowbar/cyborg/power/examine()
	. = ..()
	. += " It's fitted with a [tool_behaviour == TOOL_CROWBAR ? "prying" : "cutting"] head."

/obj/item/crowbar/cyborg/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_jaws.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_CROWBAR)
		tool_behaviour = TOOL_WIRECUTTER
		to_chat(user, span_notice("You attach the cutting jaws to [src]."))
		icon_state = "jaws_cutter_cyborg"
		usesound = 'sound/items/jaws_cut.ogg'
	else
		tool_behaviour = TOOL_CROWBAR
		to_chat(user, span_notice("You attach the prying jaws to [src]."))
		icon_state = "jaws_pry_cyborg"
		usesound = 'sound/items/jaws_pry.ogg'

/obj/item/screwdriver/cyborg/power
	name =	"automated drill"
	desc = "A cyborg fitted module resembling the hand drill"
	icon = 'modular_skyrat/modules/cyborg/icons/items_cyborg.dmi'
	icon_state = "drill_screw_cyborg"
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	toolspeed = 0.5
	random_color = FALSE

/obj/item/screwdriver/cyborg/power/examine()
	. = ..()
	. += " It's fitted with a [tool_behaviour == TOOL_SCREWDRIVER ? "screw" : "bolt"] head."

/obj/item/screwdriver/cyborg/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_SCREWDRIVER)
		tool_behaviour = TOOL_WRENCH
		to_chat(user, span_notice("You attach the bolt bit to [src]."))
		icon_state = "drill_bolt_cyborg"
	else
		tool_behaviour = TOOL_SCREWDRIVER
		to_chat(user, span_notice("You attach the screw bit to [src]."))
		icon_state = "drill_screw_cyborg"

/*
*	CYBORG INDUCER
*/

/obj/item/inducer/cyborg
	name = "Cyborg Inducer"
	desc = "A tool for inductively charging internal power cells using the battery of a cyborg"
	powertransfer = 250
	var/power_safety_threshold = 1000

/obj/item/inducer/cyborg/attackby(obj/item/weapon, mob/user)
	return

/obj/item/inducer/cyborg/recharge(atom/movable/target_atom, mob/user)
	if(!iscyborg(user))
		return
	var/mob/living/silicon/robot/borg_user = user
	cell = borg_user.cell
	if(!isturf(target_atom) && user.loc == target_atom)
		return FALSE
	if(recharging)
		return TRUE
	else
		recharging = TRUE
	var/obj/item/stock_parts/cell/target_cell = target_atom.get_cell()
	var/obj/target_object
	var/coefficient = 1
	if(istype(target_atom, /obj/item/gun/energy))
		to_chat(user, span_alert("Error unable to interface with device."))
		return FALSE
	if(istype(target_atom, /obj/item/clothing/suit/space))
		to_chat(user, span_alert("Error unable to interface with device."))
		return FALSE
	if(cell.charge <= power_safety_threshold ) // Cyborg charge safety. Prevents a borg from inducing themself to death.
		to_chat(user, span_alert("Unable to charge device. User battery safety engaged."))
		return
	if(istype(target_atom, /obj))
		target_object = target_atom
	if(target_cell)
		var/done_any = FALSE
		if(target_cell.charge >= target_cell.maxcharge)
			to_chat(user, span_notice("[target_atom] is fully charged!"))
			recharging = FALSE
			return TRUE
		user.visible_message(span_notice("[user] starts recharging [target_atom] with [src]."), span_notice("You start recharging [target_atom] with [src]."))
		while(target_cell.charge < target_cell.maxcharge)
			if(do_after(user, 1 SECONDS, target = user) && cell.charge > (power_safety_threshold + powertransfer))
				done_any = TRUE
				induce(target_cell, coefficient)
				do_sparks(1, FALSE, target_atom)
				if(target_object)
					target_object.update_appearance()
			else
				break
		if(done_any) // Only show a message if we succeeded at least once
			user.visible_message(span_notice("[user] recharged [target_atom]!"), span_notice("You recharged [target_atom]!"))
		recharging = FALSE
		return TRUE
	recharging = FALSE


/obj/item/inducer/attack(mob/target_mob, mob/living/user)
	if(user.combat_mode)
		return ..()

	if(cantbeused(user))
		return

	if(recharge(target_mob, user))
		return
	return ..()

/obj/item/inducer/cyborg/attack_self(mob/user)
	return
