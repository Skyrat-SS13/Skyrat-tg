/datum/material/dwarf_certified/rock
	name = "generic rock"
	desc = "Hey... you shouldn't see this!"

	color = "#ffffff"
	greyscale_colors = "#ffffff"

	sheet_type = /obj/item/stack/dwarf_certified/rock

	strength_modifier = 1
	integrity_modifier = 1
	armor_modifiers = list(MELEE = 0.7, BULLET = 0.7, LASER = 1, ENERGY = 1, BOMB = 0.5, BIO = 1, FIRE = 1, ACID = 1)

	// wood is 0.1, diamond is 0.3, iron is 0
	beauty_modifier = 0.1

	item_sound_override = null
	turf_sound_override = FOOTSTEP_FLOOR

/obj/item/stack/dwarf_certified/rock
	name = "generic boulder"
	singular_name = "generic boulder"

	desc = "Strange... Maybe you shouldn't be seeing this."

	icon_state = "chunk"

	inhand_icon_state = "stonelike"

	merge_type = /obj/item/stack/dwarf_certified/rock

	mats_per_unit = list(/datum/material/dwarf_certified/rock = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/rock

	max_amount = 1
