/datum/design/borg_upgrade_shrink
	name = "Shrink Module"
	id = "borg_upgrade_shrink"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/shrink
	materials = list(/datum/material/iron=SHEET_MATERIAL_AMOUNT * 10, /datum/material/glass=SHEET_MATERIAL_AMOUNT * 4)
	construction_time = 120
	category = list(RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL)

/datum/design/borg_upgrade_surgicaltools
	name = "Advanced Surgical Tools Module"
	id = "borg_upgrade_surgicaltools"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/surgerytools
	materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 7, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 3, /datum/material/silver = SHEET_MATERIAL_AMOUNT * 3, /datum/material/gold = SHEET_MATERIAL_AMOUNT,  /datum/material/diamond = SMALL_MATERIAL_AMOUNT, /datum/material/titanium = SHEET_MATERIAL_AMOUNT * 4, /datum/material/plasma = SHEET_MATERIAL_AMOUNT)
	construction_time = 80
	category = list(RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_MEDICAL)

/datum/design/affection_module
	name = "Affection Module"
	id = "affection_module"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/affectionmodule
	materials = list(/datum/material/iron=HALF_SHEET_MATERIAL_AMOUNT, /datum/material/glass=HALF_SHEET_MATERIAL_AMOUNT)
	construction_time = 40
	category = list(RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL)

/datum/design/advanced_materials
	name = "Advanced Materials Module"
	id = "advanced_materials"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/advanced_materials
	materials = list(
		/datum/material/titanium=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/iron=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/uranium=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/glass=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT * 3,
	)
	category = list(RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING)

/datum/design/inducer_upgrade
	name = "Inducer Module"
	id = "inducer_module"
	construction_time = 60
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/inducer
	materials = list(
		/datum/material/iron=SHEET_MATERIAL_AMOUNT * 5,
		/datum/material/gold=SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/plasma=SHEET_MATERIAL_AMOUNT,
	)
	category = list(RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ENGINEERING)

/datum/design/borg_shapeshifter_module
	name = "Shapeshifting Module"
	id = "borg_shapeshifter_module"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/borg_shapeshifter
	materials = list(/datum/material/silver = SHEET_MATERIAL_AMOUNT * 5, /datum/material/plasma = SHEET_MATERIAL_AMOUNT * 5, /datum/material/diamond = SHEET_MATERIAL_AMOUNT * 2)
	construction_time = 120
	category = list(RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_ALL)

