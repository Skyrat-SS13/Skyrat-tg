// MATERIAL DATUM

/datum/material/dwarf_certified/powder
	name = "generic powder"
	desc = "Hey... you shouldn't see this!"

	color = "#ffffff"
	greyscale_colors = "#ffffff"

	sheet_type = /obj/item/stack/dwarf_certified/powder

	strength_modifier = 0.1
	integrity_modifier = 0.1
	armor_modifiers = list(MELEE = 0.2, BULLET = 0.2, LASER = 0, ENERGY = 0, BOMB = 0.5, BIO = 0.8, FIRE = 1, ACID = 1) // Glass is pretty weak to most physical things

	// wood is 0.1, diamond is 0.3, iron is 0
	beauty_modifier = 0

	item_sound_override = null
	turf_sound_override = FOOTSTEP_SAND

/obj/item/stack/dwarf_certified/powder
	name = "generic powder pile"
	singular_name = "generic powder pile"

	desc = "Strange... Maybe you shouldn't be seeing this."

	icon_state = "dust"

	inhand_icon_state = "gemlike"

	merge_type = /obj/item/stack/dwarf_certified/powder

	mats_per_unit = list(/datum/material/dwarf_certified/powder = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/powder

	max_amount = 1
