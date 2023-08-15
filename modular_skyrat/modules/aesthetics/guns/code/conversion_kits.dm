/obj/item/crafting_conversion_kit
	name = "base conversion kit"
	desc = "It's a set of parts, for something. This shouldn't be here, and you should probably throw this away, since it's not going to be very useful."
	icon = 'icons/obj/storage/box.dmi'
	icon_state = "secbox"
	// the inhands are just what the box uses
	inhand_icon_state = "syringe_kit"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	drop_sound = 'sound/items/handling/component_drop.ogg'
	pickup_sound = 'sound/items/handling/component_pickup.ogg'

/obj/item/crafting_conversion_kit/mosin_pro
	name = "\improper FTU 'Archangel' precision rifle stock (desert tan)"
	desc = "It's a plastic rifle stock, an extended .310 Strilka magazine, and some off-brand sight. Unfortunately, it lacks the actual bits that make it go bang. \
	It's probably a safe assumption that fixing that is an exercise left to the buyer."
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'
	icon_state = "bubba_wit_no_bubba"

/datum/crafting_recipe/mosin_pro
	name = "Sakhno to FTU 'Archangel' Conversion"
	desc = "It's actually really easy to change the stock on your Sakhno. Anyone can do it. It takes roughly thirty seconds and a screwdriver."
	result = /obj/item/gun/ballistic/rifle/boltaction/sporterized/empty
	reqs = list(
		/obj/item/gun/ballistic/rifle/boltaction = 1,
		/obj/item/crafting_conversion_kit/mosin_pro = 1
	)
	steps = list(
		"Empty the rifle",
		"Leave the bolt open"
	)
	tool_behaviors = list(TOOL_SCREWDRIVER)
	time = 30 SECONDS
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/mosin_pro/New()
	..()
	blacklist |= subtypesof(/obj/item/gun/ballistic/rifle/boltaction) - list(/obj/item/gun/ballistic/rifle/boltaction/surplus)

/datum/crafting_recipe/mosin_pro/check_requirements(mob/user, list/collected_requirements)
	var/obj/item/gun/ballistic/rifle/boltaction/the_piece = collected_requirements[/obj/item/gun/ballistic/rifle/boltaction][1]
	if(!the_piece.bolt_locked)
		return FALSE
	if(LAZYLEN(the_piece.magazine.stored_ammo))
		return FALSE
	return ..()
