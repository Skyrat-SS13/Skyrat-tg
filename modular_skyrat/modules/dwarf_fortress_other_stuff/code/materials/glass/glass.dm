// CRAFTING RECIPES

GLOBAL_LIST_INIT(dwarf_glass_recipes, list(
	new /datum/stack_recipe( \
	"glass window", \
	/obj/structure/window/material, \
	req_amount = 1, \
	res_amount = 1, \
	time = 3 SECONDS, \
	one_per_turf = TRUE, \
	on_solid_ground = TRUE, \
	applies_mats = TRUE \
	), \
))

// MATERIAL DATUM

/datum/material/dwarf_certified/glass
	name = "generic special event glass"
	desc = "Hey... you shouldn't see this!"

	color = "#ffffff"
	greyscale_colors = "#ffffff"
	alpha = 255

	sheet_type = /obj/item/stack/dwarf_certified/glass

	strength_modifier = 1.2 // Glass is super weak but you could make a killer knife out of it
	integrity_modifier = 0.2
	armor_modifiers = list(MELEE = 0.2, BULLET = 0.2, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 1.5, FIRE = 2, ACID = 2) // Glass is pretty weak to most physical things

	// wood is 0.1, diamond is 0.3, iron is 0
	beauty_modifier = 0

	item_sound_override = 'sound/effects/glasshit.ogg'
	turf_sound_override = FOOTSTEP_PLATING

/datum/material/dwarf_certified/glass/on_accidental_mat_consumption(mob/living/carbon/victim, obj/item/source_item)
	victim.apply_damage(10, BRUTE, BODY_ZONE_HEAD, wound_bonus = 5, sharpness = TRUE)
	return TRUE

/obj/item/stack/dwarf_certified/glass
	name = "generic special event glass sheets"
	singular_name = "generic special event glass sheet"

	desc = "Strange... Maybe you shouldn't be seeing this."

	icon_state = null

	inhand_icon_state = null

	merge_type = /obj/item/stack/dwarf_certified/glass

	mats_per_unit = list(/datum/material/dwarf_certified/glass = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/glass

	max_amount = 3 // im evil, a little fuvked up even

/obj/item/stack/dwarf_certified/glass/get_main_recipes()
	. = ..()
	. += GLOB.dwarf_glass_recipes

/datum/material/dwarf_certified/glass/green
	name = "green glass"
	desc = "Lower quality glass produced from nothing but sand."

	color = "#347247"
	greyscale_colors = "#347247c8"
	alpha = 200 // Green glass is a bit difficult to see through

	sheet_type = /obj/item/stack/dwarf_certified/glass/green

	// wood is 0.1, diamond is 0.3, iron is 0, glass is 0.05
	beauty_modifier = 0.02

/obj/item/stack/dwarf_certified/glass/green
	name = "green glass sheets"
	singular_name = "green glass sheet"

	desc = "Thin sheets of some green glass, a bit hard to see through but still glass!."

	merge_type = /obj/item/stack/dwarf_certified/glass/green

	mats_per_unit = list(/datum/material/dwarf_certified/glass/green = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/glass/green

/datum/material/dwarf_certified/glass/clear
	name = "clear glass"
	desc = "Run of the mill clear glass with few imperfections."

	color = "#9bbece"
	greyscale_colors = "#9bbece96"
	alpha = 150

	sheet_type = /obj/item/stack/dwarf_certified/glass/clear

	// wood is 0.1, diamond is 0.3, iron is 0, glass is 0.05
	beauty_modifier = 0.05

/obj/item/stack/dwarf_certified/glass/clear
	name = "clear glass sheets"
	singular_name = "clear glass sheet"

	desc = "Thin sheets of some clear glass."

	merge_type = /obj/item/stack/dwarf_certified/glass/clear

	mats_per_unit = list(/datum/material/dwarf_certified/glass/clear = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/glass/clear

/datum/material/dwarf_certified/glass/crystal
	name = "crystal glass"
	desc = "Glass made of rock crystal, pretty AND strong."

	color = "#ffffff"
	greyscale_colors = "#ffffff64"
	alpha = 100

	sheet_type = /obj/item/stack/dwarf_certified

	strength_modifier = 1.2
	integrity_modifier = 0.4 // Crystal glass is a tad bit stronger
	armor_modifiers = list(MELEE = 0.4, BULLET = 0.4, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 1.5, FIRE = 2, ACID = 2)

	// wood is 0.1, diamond is 0.3, iron is 0, glass is 0.05
	beauty_modifier = 0.2

/obj/item/stack/dwarf_certified/glass/crystal
	name = "crystal glass sheets"
	singular_name = "crystal glass sheet"

	desc = "Thin sheets of some crystal glass, glass made using a rock crystal rather than sand."

	merge_type = /obj/item/stack/dwarf_certified/glass/crystal

	mats_per_unit = list(/datum/material/dwarf_certified/glass/crystal = MINERAL_MATERIAL_AMOUNT)
	material_type = /datum/material/dwarf_certified/glass/crystal

// THE WINDOW STRUCTURE ITSELF

/obj/structure/window/material
	icon = 'modular_skyrat/modules/dwarf_fortress_other_stuff/icons/material_wall.dmi'
	icon_state = "wall"
	glass_type = null

/obj/structure/window/material/set_custom_materials()
	. = ..()

	if(length(custom_materials))
		glass_type = custom_materials[1].sheet_type
