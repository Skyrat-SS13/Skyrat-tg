/datum/material/ceramic
	name = "ceramic"
	desc = "Ceramic."

	color = "#fff7c9"
	greyscale_colors = "#fff7c9"
	alpha = 255

	sheet_type = null

	integrity_modifier = 0.7
	armor_modifiers = list(MELEE = 0.3, BULLET = 0.3, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 1, FIRE = 1.5, ACID = 1) // Ceramics are kinda weak to getting hit by stuff you know?

	beauty_modifier = 0.2

	item_sound_override = 'sound/effects/glasshit.ogg'
	turf_sound_override = FOOTSTEP_PLATING

/datum/material/ceramic/on_accidental_mat_consumption(mob/living/carbon/victim, obj/item/source_item)
	victim.apply_damage(10, BRUTE, BODY_ZONE_HEAD, wound_bonus = 5, sharpness = TRUE) // Mmmm crunchy
	return TRUE

/obj/item/reagent_containers/cup/bowl/generic_material/ceramic

/obj/item/reagent_containers/cup/bowl/generic_material/ceramic/Initialize(mapload)
	..()
	set_custom_materials(list(/datum/material/ceramic = MINERAL_MATERIAL_AMOUNT * 0.5))

/obj/item/reagent_containers/cup/beaker/generic_material/ceramic

/obj/item/reagent_containers/cup/beaker/generic_material/ceramic/Initialize(mapload)
	..()
	set_custom_materials(list(/datum/material/ceramic = MINERAL_MATERIAL_AMOUNT * 0.5))

/obj/item/plate/generic_material/ceramic
	custom_materials = list(/datum/material/ceramic = MINERAL_MATERIAL_AMOUNT * 0.5)

/obj/item/plate/large/generic_material/ceramic
	custom_materials = list(/datum/material/ceramic = MINERAL_MATERIAL_AMOUNT * 0.5)

/obj/item/plate/small/generic_material/ceramic
	custom_materials = list(/datum/material/ceramic = MINERAL_MATERIAL_AMOUNT * 0.5)

/obj/item/plate/oven_tray/generic_material/ceramic
	custom_materials = list(/datum/material/ceramic = MINERAL_MATERIAL_AMOUNT * 0.5)

