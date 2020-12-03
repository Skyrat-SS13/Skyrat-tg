/datum/sprite_accessory/horns
	key = "horns"
	generic = "Horns"
	relevent_layers = list(BODY_FRONT_LAYER)
	icon = 'modular_skyrat/modules/customization/icons/mob/sprite_accessory/horns.dmi'
	default_color = "555"

/datum/sprite_accessory/horns/is_hidden(mob/living/carbon/human/H, obj/item/bodypart/HD)
	if(H.head && (H.head.flags_inv & HIDEHAIR) || (H.wear_mask && (H.wear_mask.flags_inv & HIDEHAIR)) || !HD || HD.status == BODYPART_ROBOTIC)
		return TRUE
	return FALSE

/datum/sprite_accessory/horns/angler
	default_color = DEFAULT_SECONDARY

/datum/sprite_accessory/horns/ram
	name = "Ram"
	icon_state = "ram"

/datum/sprite_accessory/horns/guilmon
	name = "Guilmon"
	icon_state = "guilmon"

/datum/sprite_accessory/horns/drake
	name = "Drake"
	icon_state = "drake"

/datum/sprite_accessory/horns/knight
	name = "Knight"
	icon_state = "knight"

/datum/sprite_accessory/horns/unicorn/straight
	name = "unicorn Straight"
	icon_state = "unicorn_straight"
/datum/sprite_accessory/horns/unicorn/curved
	name = "Unicorn Curved"
	icon_state = "unicorn_curved"

/datum/sprite_accessory/horns/unicorn/thick
	name = "Unicorn Thick"
	icon_state = "unicorn_thick"

/datum/sprite_accessory/horns/unicorn/holes
	name = "Holes"
	icon_state = "unicorn_holes"
