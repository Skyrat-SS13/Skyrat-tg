#define RND_CATEGORY_MECHFAB_SYNTH_PARTS "/Synthetic Parts"
#define RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_ALL "/All Synthetics"
#define RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_HUMANOID "/Synthetic Humanoid"
#define RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_LIZARD "/Synthetic Lizard"
#define RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_MAMMAL "/Synthetic Mammal"
#define RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_IPC "/IPC"

/*
	IPC/SYNTHLIZ/SYNTH CONSTRUCTION
	HELL YEAH LETS GET THIS BREAD
*/

/datum/design/power_cord
	name = "Arm Power Cord"
	desc = "Required for synthetics to recharge. Do not forget."
	id = "arm_cord"
	build_type = MECHFAB
	build_path = /obj/item/organ/internal/cyberimp/arm/power_cord
	materials = list(/datum/material/iron = 1200, /datum/material/gold = 200, /datum/material/glass = 500)
	construction_time = 100
	category = list(RND_CATEGORY_MECHFAB_SYNTH_PARTS + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_ALL)

/datum/design/ipc_chassis
	name = "IPC chassis"
	desc = "A self actualization device is recommended for converting cybernetic limbs to the correct type."
	id = "ipc_chassis"
	build_type = MECHFAB
	research_icon = BODYPART_ICON_IPC
	research_icon_state = "synth_chest"
	build_path = /mob/living/carbon/human/species/ipc/chassis
	materials = list(/datum/material/iron = 5000, /datum/material/titanium = 10000, /datum/material/gold = 5000, /datum/material/glass = 1000)
	construction_time = 500
	category = list(RND_CATEGORY_MECHFAB_SYNTH_PARTS + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_IPC)

/datum/design/synth_chassis
	name = "Synth humanoid chassis"
	desc = "A self actualization device is recommended for converting cybernetic limbs to the correct type."
	id = "synth_chassis"
	build_type = MECHFAB
	research_icon = BODYPART_ICON_HUMAN
	research_icon_state = "human_chest_m"
	build_path = /mob/living/carbon/human/species/synthetic_human/chassis
	materials = list(/datum/material/iron = 7000, /datum/material/titanium = 10000, /datum/material/plasma = 5000, /datum/material/gold = 5000, /datum/material/glass = 1000)
	construction_time = 600
	category = list(RND_CATEGORY_MECHFAB_SYNTH_PARTS + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_HUMANOID)

/datum/design/synthlizard_chassis
	name = "Synth lizard chassis"
	desc = "A self actualization device is recommended for converting cybernetic limbs to the correct type."
	id = "synthliz_chassis"
	build_type = MECHFAB
	research_icon = BODYPART_ICON_SYNTHLIZARD
	research_icon_state = "synthliz_chest_m"
	build_path = /mob/living/carbon/human/species/synthliz/chassis
	materials = list(/datum/material/iron = 7000, /datum/material/titanium = 10000, /datum/material/plasma = 5000, /datum/material/gold = 5000, /datum/material/glass = 1000)
	construction_time = 600
	category = list(RND_CATEGORY_MECHFAB_SYNTH_PARTS + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_LIZARD)

/datum/design/synthmammal_chassis
	name = "Synth mammal chassis"
	desc = "A self actualization device is recommended for converting cybernetic limbs to the correct type."
	id = "synthmammal_chassis"
	build_type = MECHFAB
	research_icon = BODYPART_ICON_SYNTHMAMMAL
	research_icon_state = "synthmammal_chest_m"
	build_path = /mob/living/carbon/human/species/synthetic_mammal/chassis
	materials = list(/datum/material/iron = 7000, /datum/material/titanium = 10000, /datum/material/plasma = 5000, /datum/material/gold = 5000, /datum/material/glass = 1000)
	construction_time = 600
	category = list(RND_CATEGORY_MECHFAB_SYNTH_PARTS + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_MAMMAL)

//ipc organs
/datum/design/ipc_heart
	name = "Hydraulic pump engine"
	desc = "Synthetic equivalent to a heart."
	id = "ipc_heart"
	build_type = MECHFAB
	build_path = /obj/item/organ/internal/heart/robot_ipc
	materials = list(/datum/material/iron = 3000, /datum/material/gold = 1000, /datum/material/titanium = 500)
	construction_time = 150
	category = list(RND_CATEGORY_MECHFAB_SYNTH_PARTS + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_ALL)

/datum/design/ipc_lungs
	name = "Heat sink"
	desc = "Prevents overheating. Do not forget this."
	id = "ipc_lungs"
	build_type = MECHFAB
	build_path = /obj/item/organ/internal/lungs/robot_ipc
	materials = list(/datum/material/iron = 1500, /datum/material/gold = 500)
	construction_time = 150
	category = list(RND_CATEGORY_MECHFAB_SYNTH_PARTS + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_ALL)

/datum/design/ipc_tongue
	name = "Synthetic voicebox"
	desc = "Synthetic equivalent to a tongue."
	id = "ipc_tongue"
	build_type = MECHFAB
	build_path = /obj/item/organ/internal/tongue/robot_ipc
	materials = list(/datum/material/iron = 1000, /datum/material/gold = 1000)
	construction_time = 100
	category = list(RND_CATEGORY_MECHFAB_SYNTH_PARTS + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_ALL)

/datum/design/ipc_stomach
	name = "Synthetic micro cell"
	desc = "Stores synth charge. Do not forget, otherwise the synth will be permanently stuck on low-power mode, and will feel large amounts of resent."
	id = "ipc_stomach"
	build_type = MECHFAB
	build_path = /obj/item/organ/internal/stomach/robot_ipc
	materials = list(/datum/material/iron = 1000, /datum/material/gold = 1000, /datum/material/uranium = 2500)
	construction_time = 100
	category = list(RND_CATEGORY_MECHFAB_SYNTH_PARTS + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_ALL)

/datum/design/ipc_liver
	name = "Reagent processing unit"
	desc = "Allows the synth to process reagents. Optional, but recommended."
	id = "ipc_liver"
	build_type = MECHFAB
	build_path = /obj/item/organ/internal/liver/robot_ipc
	materials = list(/datum/material/iron = 1000, /datum/material/gold = 1000, /datum/material/uranium = 2500)
	construction_time = 100
	category = list(RND_CATEGORY_MECHFAB_SYNTH_PARTS + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_ALL)

/datum/design/ipc_eyes
	name = "Optical sensors"
	desc = "Synthetic equivalent to eyes."
	id = "ipc_eyes"
	build_type = MECHFAB
	build_path = /obj/item/organ/internal/eyes/robot_ipc
	materials = list(/datum/material/iron = 1000, /datum/material/gold = 1000, /datum/material/uranium = 2500, /datum/material/glass = 1000)
	construction_time = 100
	category = list(RND_CATEGORY_MECHFAB_SYNTH_PARTS + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_ALL)

/datum/design/ipc_ears
	name = "Auditory sensors"
	desc = "Synthetic equivalent to ears."
	id = "ipc_ears"
	build_type = MECHFAB
	build_path = /obj/item/organ/internal/ears/robot_ipc
	materials = list(/datum/material/iron = 3000, /datum/material/silver = 1000, /datum/material/titanium = 2000)
	construction_time = 100
	category = list(RND_CATEGORY_MECHFAB_SYNTH_PARTS + RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_ALL)

#undef RND_CATEGORY_MECHFAB_SYNTH_PARTS
#undef RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_ALL
#undef RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_HUMANOID
#undef RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_LIZARD
#undef RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_MAMMAL
#undef RND_SUBCATEGORY_MECHFAB_SYNTH_PARTS_IPC
