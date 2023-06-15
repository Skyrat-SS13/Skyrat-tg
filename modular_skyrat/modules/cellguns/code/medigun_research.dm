#define RND_SUBCATEGORY_WEAPONS_MEDICALAMMO "/Medical Ammunition"
#define RND_MEDICALAMMO_UTILITY " (Utility)"

//Upgrade Kit//
/datum/design/medigun_speedkit
	name = "VeyMedical CWM-479 upgrade kit"
	desc = "An upgrade kit for the VeyMedical CWM-479 to have a higher-capacity internal cell, with increased recharger throughput."
	id = "medigun_speed"
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
	category = list(RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_EQUIPMENT_MEDICAL)
	materials = list(/datum/material/uranium = SHEET_MATERIAL_AMOUNT * 2, /datum/material/glass = SHEET_MATERIAL_AMOUNT * 2, /datum/material/plasma = SHEET_MATERIAL_AMOUNT, /datum/material/diamond = HALF_SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/device/custom_kit/medigun_fastcharge

/datum/design/medicell
	name = "Base Medicell Design"
	desc = "Hey, you shouldn't see this. Like... at all."
	build_type = PROTOLATHE | AWAY_LATHE
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
	category = list(RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_MEDICALAMMO)

//Tier 2 Medicells//

/datum/design/medicell/brute2
	name = "Brute II Medicell"
	desc = "Allows cell-loaded mediguns to enable improved brute damage healing functionality."
	id = "brute2medicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)
	reagents_list = list(/datum/reagent/medicine/c2/libital = 10)
	build_path = /obj/item/weaponcell/medical/brute/tier_2

/datum/design/medicell/burn2
	name = "Burn II Medicell"
	desc = "Allows cell-loaded mediguns to enable improved burn damage healing functionality."
	id = "burn2medicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)
	reagents_list = list(/datum/reagent/medicine/c2/aiuri = 10)
	build_path = /obj/item/weaponcell/medical/burn/tier_2

/datum/design/medicell/toxin2
	name = "Toxin II Medicell"
	desc = "Allows cell-loaded mediguns to enable improved toxin damage healing functionality."
	id = "toxin2medicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)
	reagents_list = list(/datum/reagent/medicine/c2/multiver = 10)
	build_path = /obj/item/weaponcell/medical/toxin/tier_2

/datum/design/medicell/oxy2
	name = "Oxygen II Medicell"
	desc = "Allows cell-loaded mediguns to enable improved oxygen deprivation healing functionality."
	id = "oxy2medicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT)
	reagents_list = list(/datum/reagent/medicine/c2/convermol = 10)
	build_path = /obj/item/weaponcell/medical/oxygen/tier_2

//Tier 3 Medicells//

/datum/design/medicell/brute3
	name = "Brute III Medicell"
	desc = "Allows cell-loaded mediguns to enable advanced brute damage healing functionality."
	id = "brute3medicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5)
	reagents_list = list(/datum/reagent/medicine/sal_acid = 10)
	build_path = /obj/item/weaponcell/medical/brute/tier_3

/datum/design/medicell/burn3
	name = "Burn III Medicell"
	desc = "Allows cell-loaded mediguns to enable advanced burn damage healing functionality."
	id = "burn3medicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5)
	reagents_list = list(/datum/reagent/medicine/oxandrolone = 10)
	build_path = /obj/item/weaponcell/medical/burn/tier_3

/datum/design/medicell/toxin3
	name = "Toxin III Medicell"
	desc = "Allows cell-loaded mediguns to enable advanced toxin damage healing functionality."
	id = "toxin3medicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5)
	reagents_list = list(/datum/reagent/medicine/pen_acid = 10)
	build_path = /obj/item/weaponcell/medical/toxin/tier_3

/datum/design/medicell/oxy3
	name = "Oxygen III Medicell"
	desc = "Allows cell-loaded mediguns to enable advanced oxygen deprivation healing functionality."
	id = "oxy3medicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/weaponcell/medical/oxygen/tier_3
	reagents_list = list(/datum/reagent/medicine/salbutamol = 10)

//Utility Medicells

/datum/design/medicell/utility
	name = "Utility Medicell"
	category = list(RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_MEDICALAMMO + RND_MEDICALAMMO_UTILITY)

/datum/design/medicell/utility/clot
	name = "Clotting Medicell"
	desc = "A Medicell designed to help deal with bleeding patients"
	id = "clotmedicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/weaponcell/medical/utility/clotting
	reagents_list = list(/datum/reagent/medicine/salglu_solution = 5, /datum/reagent/blood = 5)

/datum/design/medicell/utility/temp
	name = "Temperature Adjustment Medicell"
	desc = "A Medicell that adjusts the hosts temperature to acceptable levels"
	id = "tempmedicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/weaponcell/medical/utility/temperature
	reagents_list = list(/datum/reagent/medicine/leporazine = 10)

/datum/design/medicell/utility/gown
	name = "Hardlight Gown Medicell"
	desc = "A Medicell that deploys a hardlight hospital gown on a patient."
	id = "gownmedicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/weaponcell/medical/utility/hardlight_gown

/datum/design/medicell/utility/bed
	name = "Hardlight Roller Bed Medicell"
	desc = "A Medicell that deploys a hardlight roller bed under a patient lying down."
	id = "bedmedicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/weaponcell/medical/utility/bed

/datum/design/medicell/utility/salve
	name = "Empty Salve Medicell"
	desc = "A Empty Medicell that can be upgraded by aloe into a usable Salve Medicell."
	id = "salvemedicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/device/custom_kit/empty_cell

/datum/design/medicell/utility/body
	name = "Empty Body Teleporter Medicell"
	desc = "An empty medicell that can be upgraded by a bluespace slime extract into an usable body teleporter medicell."
	id = "bodymedicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/device/custom_kit/empty_cell/body_teleporter

/datum/design/medicell/utility/relocation
	name = "Oppressive Force Relocation Medicell"
	desc = "A medicell that can be used to teleport non-medical staff to the lobby."
	id = "relocatemedicell"
	materials = list(/datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)
	reagents_list = list(/datum/reagent/eigenstate = 10)
	build_path = /obj/item/weaponcell/medical/utility/relocation
