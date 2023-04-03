// BASE TYPE

/datum/material/dwarf_certified/leather
	name = "generic special event leather"
	desc = "Hey... you shouldn't see this!"

	color = "#ffffff"
	greyscale_colors = "#ffffff"

	sheet_type = /obj/item/stack/dwarf_certified/leather_or_cloth/leather

	strength_modifier = 0 // beating you with my objects made of cloth (leather but same idea alright???)
	integrity_modifier = 0.75
	armor_modifiers = list(MELEE = 0.2, BULLET = 0.3, LASER = 0, ENERGY = 0, BOMB = 0.2, BIO = 0.1, FIRE = 0.3, ACID = 0.2)

	// wood is 0.1, diamond is 0.3, iron is 0
	beauty_modifier = 0.1

	turf_sound_override = FOOTSTEP_CARPET

/obj/item/stack/dwarf_certified/leather_or_cloth/leather
	name = "generic leather"
	singular_name = "generic leather"

	desc = "Strange... Maybe you shouldn't be seeing this."

	icon_state = "leather"

	merge_type = /obj/item/stack/dwarf_certified/leather_or_cloth/leather

	mats_per_unit = list(/datum/material/dwarf_certified/leather = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/leather

/obj/item/stack/dwarf_certified/leather_or_cloth/examine(mob/user)
	. = ..()

	. += span_notice("Maybe with a <b>tailoring station</b>, you could turn [src] into clothing and armor?")

// Generic animal leather

/datum/material/dwarf_certified/leather/animal
	name = "animal leather"
	desc = "Its leather, usually from cows but you know any animal will do really."

	color = "#8f4b1f"
	greyscale_colors = "#8f4b1f"

	sheet_type = /obj/item/stack/dwarf_certified/leather_or_cloth/leather/animal

/obj/item/stack/dwarf_certified/leather_or_cloth/leather/animal
	name = "animal leather sheets"
	singular_name = "animal leather sheet"

	desc = "Leather brown... leather, this stuff usually comes from animals, unless you're having a bad year, in which case I'd say be careful because you might be next."

	merge_type = /obj/item/stack/dwarf_certified/leather_or_cloth/leather/animal

	mats_per_unit = list(/datum/material/dwarf_certified/leather/animal = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/leather/animal
