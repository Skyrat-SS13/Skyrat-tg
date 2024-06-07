#define RND_SUBCATEGORY_MECHFAB_CYBORG_DIGI "/Digitigrade"
#define RND_SUBCATEGORY_CYBERNETICS_ADVANCED_DIGI "/Advanced Digitigrade"

/datum/design/digitigrade_cyber_r_leg
	name = "Digitigrade Cybernetic Right Leg"
	id = "digitigrade_cyber_r_leg"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/leg/right/robot/digi
	materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT * 2)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_DIGI,
	)

/datum/design/digitigrade_cyber_l_leg
	name = "Digitigrade Cybernetic Left Leg"
	id = "digitigrade_cyber_l_leg"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/leg/left/robot/digi
	materials = list(/datum/material/iron= SHEET_MATERIAL_AMOUNT * 2)
	construction_time = 8 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG + RND_SUBCATEGORY_MECHFAB_CYBORG_DIGI,
	)

/datum/design/digitigrade_adv_r_leg
	name = "Digitigrade Advanced Right Leg"
	id = "digitigrade_advanced_r_leg"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/leg/right/robot/advanced/digi
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 3,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ADVANCED_DIGI
	)

/datum/design/digitigrade_adv_l_leg
	name = "Digitigrade Advanced Left Leg"
	id = "digitigrade_advanced_l_leg"
	build_type = MECHFAB
	build_path = /obj/item/bodypart/leg/left/robot/advanced/digi
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 10,
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/gold = SHEET_MATERIAL_AMOUNT * 3,
	)
	construction_time = 20 SECONDS
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_ADVANCED_DIGI
	)
