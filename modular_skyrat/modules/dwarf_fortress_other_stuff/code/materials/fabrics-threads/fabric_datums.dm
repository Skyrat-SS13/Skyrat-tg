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

	sheet_type = /obj/item/stack/dwarf_certified/leather_or_cloth/fabric/cotton

	// wood is 0.1, diamond is 0.3, iron is 0, glass is 0.05
	beauty_modifier = 0.1

/datum/material/dwarf_certified/fabric/hemp
	name = "hemp"
	desc = "Woven from hemp, because what else would you do with that plant, right?"

	color = "#d4ebd5"
	greyscale_colors = "#d4ebd5"

	sheet_type = null

	// wood is 0.1, diamond is 0.3, iron is 0, glass is 0.05
	beauty_modifier = 0.05

	integrity_modifier = 0.75
	armor_modifiers = list(MELEE = 0.2, BULLET = 0.2, LASER = 0, ENERGY = 0, BOMB = 0.1, BIO = 0.1, FIRE = 0.3, ACID = 0.1)

/datum/material/dwarf_certified/fabric/reed
	name = "reed fiber"
	desc = "Did you know you can make threads and such out of reeds? No? Well now you do."

	color = "#f5d9c0"
	greyscale_colors = "#f5d9c0"

	sheet_type = null

	// wood is 0.1, diamond is 0.3, iron is 0, glass is 0.05
	beauty_modifier = 0.05

/datum/material/dwarf_certified/fabric/silk
	name = "spider silk"
	desc = "Also known as the most hazardous clothing material to get."

	color = "#ffffff"
	greyscale_colors = "#ffffff"

	sheet_type = null

	// wood is 0.1, diamond is 0.3, iron is 0, glass is 0.05
	beauty_modifier = 0.2

	integrity_modifier = 0.3 // Spider silk is strong specifically against melee attacks (giant spiders walking on it) and not a ton else
	armor_modifiers = list(MELEE = 0.2, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0.1, FIRE = 0.1, ACID = 0.1)
