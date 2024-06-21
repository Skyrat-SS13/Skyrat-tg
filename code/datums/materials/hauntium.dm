/datum/material/hauntium
	name = "hauntium"
	desc = "very scary!"
	color = list(460/255, 464/255, 460/255, 0, 0,0,0,0, 0,0,0,0, 0,0,0,1, 0,0,0,0)
	greyscale_colors = "#FFFFFF64"
	alpha = 100
	starlight_color = COLOR_ALMOST_BLACK
	categories = list(MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = TRUE, MAT_CATEGORY_ITEM_MATERIAL=TRUE)
	sheet_type = /obj/item/stack/sheet/hauntium
	value_per_unit = 0.05
	beauty_modifier = 0.25
	//pretty good but only the undead can actually make use of these modifiers
	strength_modifier = 1.2
	armor_modifiers = list(MELEE = 1.1, BULLET = 1.1, LASER = 1.15, ENERGY = 1.15, BOMB = 1, BIO = 1, FIRE = 1, ACID = 0.7)

/datum/material/hauntium/on_applied_obj(obj/o, amount, material_flags)
	. = ..()
	o.make_haunted(INNATE_TRAIT, "#f8f8ff")

/datum/material/hauntium/on_removed_obj(obj/o, amount, material_flags)
	. = ..()
	o.remove_haunted(INNATE_TRAIT)
