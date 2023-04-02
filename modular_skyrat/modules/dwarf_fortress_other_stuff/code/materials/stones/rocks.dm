// Siltstone

/datum/material/dwarf_certified/rock/siltstone
	name = "siltstone"
	desc = "Its like standstone but smaller!"

	color = "#b89e7c"
	greyscale_colors = "#b89e7c"

	sheet_type = /obj/item/stack/dwarf_certified/rock/siltstone

	strength_modifier = 1
	integrity_modifier = 0.8
	armor_modifiers = list(MELEE = 0.6, BULLET = 0.6, LASER = 1, ENERGY = 1, BOMB = 0.4, BIO = 1, FIRE = 1, ACID = 1)

	// wood is 0.1, diamond is 0.3, iron is 0
	beauty_modifier = 0.05

/obj/item/stack/dwarf_certified/rock/siltstone
	name = "siltstone boulder"
	singular_name = "siltstone boulder"

	desc = "Siltstone is sandstone's little brother, usually with a finer grain."

	merge_type = /obj/item/stack/dwarf_certified/rock/siltstone

	mats_per_unit = list(/datum/material/dwarf_certified/rock/siltstone = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/rock/siltstone

	cut_type = /obj/item/stack/dwarf_certified/brick/siltstone

/obj/item/stack/dwarf_certified/brick/siltstone
	name = "siltstone brick"
	singular_name = "siltstone brick"

	desc = "Sandstone but cooler, now in a portable brick format!"

	merge_type = /obj/item/stack/dwarf_certified/brick/siltstone

	mats_per_unit = list(/datum/material/dwarf_certified/rock/siltstone = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/rock/siltstone

// Marble

/datum/material/dwarf_certified/rock/marble
	name = "marble"
	desc = "A beautiful white stone that makes a good building material."

	color = "#dee4e6"
	greyscale_colors = "#dee4e6"

	sheet_type = /obj/item/stack/dwarf_certified/rock/marble

	// wood is 0.1, diamond is 0.3, iron is 0
	beauty_modifier = 0.2

/obj/item/stack/dwarf_certified/rock/marble
	name = "marble boulder"
	singular_name = "marble boulder"

	desc = "Marble is a white stone commonly used in construction for its decorative attributes."

	merge_type = /obj/item/stack/dwarf_certified/rock/marble

	mats_per_unit = list(/datum/material/dwarf_certified/rock/marble = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/rock/marble

	cut_type = /obj/item/stack/dwarf_certified/brick/marble

/obj/item/stack/dwarf_certified/brick/marble
	name = "marble brick"
	singular_name = "marble brick"

	desc = "White decorative stone, now in a portable brick format!"

	merge_type = /obj/item/stack/dwarf_certified/brick/marble

	mats_per_unit = list(/datum/material/dwarf_certified/rock/marble = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/rock/marble

// Andesite

/datum/material/dwarf_certified/rock/andesite
	name = "andesite"
	desc = "A dull grey, but relatively sturdy stone."

	color = "#656666"
	greyscale_colors = "#656666"

	sheet_type = /obj/item/stack/dwarf_certified/rock/andesite

/obj/item/stack/dwarf_certified/rock/andesite
	name = "andesite boulder"
	singular_name = "andesite boulder"

	desc = "Andesite is a relatively unremarkable grey stone, though its still strong enough to make a pretty good castle out of."

	merge_type = /obj/item/stack/dwarf_certified/rock/andesite

	mats_per_unit = list(/datum/material/dwarf_certified/rock/andesite = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/rock/andesite

	cut_type = /obj/item/stack/dwarf_certified/brick/andesite

/obj/item/stack/dwarf_certified/brick/andesite
	name = "andesite brick"
	singular_name = "andesite brick"

	desc = "Dull grey stone, now in a portable brick format!"

	merge_type = /obj/item/stack/dwarf_certified/brick/andesite

	mats_per_unit = list(/datum/material/dwarf_certified/rock/andesite = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/rock/andesite

// Basalt

/datum/material/dwarf_certified/rock/basalt
	name = "basalt"
	desc = "A dull black, but relatively sturdy stone."

	color = "#292727"
	greyscale_colors = "#292727"

	sheet_type = /obj/item/stack/dwarf_certified/rock/basalt

/obj/item/stack/dwarf_certified/rock/basalt
	name = "basalt boulder"
	singular_name = "basalt boulder"

	desc = "Basalt is a relatively unremarkable black stone, though its still strong enough to make a pretty good castle out of."

	merge_type = /obj/item/stack/dwarf_certified/rock/basalt

	mats_per_unit = list(/datum/material/dwarf_certified/rock/basalt = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/rock/basalt

	cut_type = /obj/item/stack/dwarf_certified/brick/basalt

/obj/item/stack/dwarf_certified/brick/basalt
	name = "basalt brick"
	singular_name = "basalt brick"

	desc = "Dull black stone, now in a portable brick format!"

	merge_type = /obj/item/stack/dwarf_certified/brick/basalt

	mats_per_unit = list(/datum/material/dwarf_certified/rock/basalt = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/rock/basalt
