/datum/design/borg_upgrade_shrink
	name = "Cyborg Upgrade (Shrink)"
	id = "borg_upgrade_shrink"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/shrink
	materials = list(/datum/material/iron=20000, /datum/material/glass=5000)
	construction_time = 120
	category = list(RND_CATEGORY_CYBORG_UPGRADE_MODULES)

/datum/design/borg_upgrade_surgicaltools
	name = "Cyborg Upgrade (Advanced Surgical Tools)"
	id = "borg_upgrade_surgicaltools"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/surgerytools
	materials = list(/datum/material/iron = 14500, /datum/material/glass = 7500, /datum/material/silver = 6000, /datum/material/gold = 1500,  /datum/material/diamond = 200, /datum/material/titanium = 8000, /datum/material/plasma = 2000)
	construction_time = 80
	category = list(RND_CATEGORY_CYBORG_UPGRADE_MODULES)

/datum/design/affection_module
	name = "Cyborg Upgrade (Affection Module)"
	id = "affection_module"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/affectionmodule
	materials = list(/datum/material/iron=1000, /datum/material/glass=500)
	construction_time = 40
	category = list(RND_CATEGORY_CYBORG_UPGRADE_MODULES)

/datum/design/advanced_materials
	name = "Cyborg Upgrade (Advanced Materials)"
	id = "advanced_materials"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/advanced_materials
	materials = list(
		/datum/material/titanium=5000,
		/datum/material/iron=10000,
		/datum/material/uranium=5000,
		/datum/material/glass=10000,
		/datum/material/plasma=7500,
	)
	category = list(RND_CATEGORY_CYBORG_UPGRADE_MODULES)

/datum/design/inducer_upgrade
	name = "Cyborg Upgrade (Inducer)"
	id = "inducer_module"
	construction_time = 60
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/inducer
	materials = list(
		/datum/material/iron=10000,
		/datum/material/gold=4000,
		/datum/material/plasma=2000,
	)
	category = list(RND_CATEGORY_CYBORG_UPGRADE_MODULES)

