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

// Rapid Light Dispenser 

// Sets the energy cost to use the RLD - Fail Message when out of energy. 
/obj/item/construction/rld/borg
	no_ammo_message = "<span class='warning'>Insufficient charge.</span>"
	desc = "A device used to rapidly build walls and floors."
	var/energyfactor = 72

/obj/item/construction/rld/borg/useResource(amount, mob/user)
	if(!iscyborg(user))
		return FALSE
	var/mob/living/silicon/robot/borgy = user
	if(!borgy.cell)
		to_chat(user, no_ammo_message)
		return FALSE
	. = borgy.cell.use(amount * energyfactor) //borgs get 1.3x the use of their RCDs
	if(!. && user)
		to_chat(user, no_ammo_message)
	return .

/obj/item/construction/rld/borg/checkResource(amount, mob/user)
	if(!iscyborg(user))
		return FALSE
	var/mob/living/silicon/robot/borgy = user
	if(!borgy.cell)
		to_chat(user, no_ammo_message)
		return FALSE
	. = borgy.cell.charge >= (amount * energyfactor)
	if(!.)
		to_chat(user, no_ammo_message)
	return .
