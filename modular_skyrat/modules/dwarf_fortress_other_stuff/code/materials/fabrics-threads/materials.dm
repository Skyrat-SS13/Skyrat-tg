// BASE TYPE

/datum/material/dwarf_certified/fabric
	name = "generic special event fabric"
	desc = "Hey... you shouldn't see this!"

	color = "#ffffff"
	greyscale_colors = "#ffffff"
	alpha = 255

	sheet_type = /obj/item/stack/dwarf_certified/glass

	strength_modifier = 0 // beating you with my objects made of cloth
	integrity_modifier = 0.5
	armor_modifiers = list(MELEE = 0.1, BULLET = 0.1, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0.1, FIRE = 0.2, ACID = 0.1)

	// wood is 0.1, diamond is 0.3, iron is 0
	beauty_modifier = 0

	item_sound_override = 'sound/effects/rustle2.ogg'
	turf_sound_override = FOOTSTEP_CARPET

// COTTON

/datum/material/dwarf_certified/fabric/cotton
	name = "cotton"
	desc = "Woven from a plant of the same name."

	color = "#f0dfdf"
	greyscale_colors = "#f0dfdf"

	sheet_type = null

	// wood is 0.1, diamond is 0.3, iron is 0, glass is 0.05
	beauty_modifier = 0.1
