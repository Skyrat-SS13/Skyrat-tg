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
	desc = "Gives cell-loaded mediguns improved brute damage healing functionality."
	id = "brute2medicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/weaponcell/medical/brute/tier_2

/datum/design/medicell/burn2
	name = "Burn II Medicell"
	desc = "Gives cell-loaded mediguns improved burn damage healing functionality."
	id = "burn2medicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/weaponcell/medical/burn/tier_2

/datum/design/medicell/toxin2
	name = "Toxin II Medicell"
	desc = "Gives cell-loaded mediguns improved toxin damage healing functionality."
	id = "toxin2medicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/weaponcell/medical/toxin/tier_2

/datum/design/medicell/oxy2
	name = "Oxygen II Medicell"
	desc = "Gives cell-loaded mediguns improved oxygen deprivation healing functionality."
	id = "oxy2medicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/weaponcell/medical/oxygen/tier_2

//Tier 3 Medicells//

/datum/design/medicell/brute3
	name = "Brute III Medicell"
	desc = "Gives cell-loaded mediguns advanced brute damage healing functionality."
	id = "brute3medicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 3, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/weaponcell/medical/brute/tier_3

/datum/design/medicell/burn3
	name = "Burn III Medicell"
	desc = "Gives cell-loaded mediguns advanced burn damage healing functionality."
	id = "burn3medicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 3, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/weaponcell/medical/burn/tier_3

/datum/design/medicell/toxin3
	name = "Toxin III Medicell"
	desc = "Gives cell-loaded mediguns advanced toxin damage healing functionality."
	id = "toxin3medicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 3, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/weaponcell/medical/toxin/tier_3

/datum/design/medicell/oxy3
	name = "Oxygen III Medicell"
	desc = "Gives cell-loaded mediguns advanced oxygen deprivation healing functionality."
	id = "oxy3medicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/glass = SMALL_MATERIAL_AMOUNT * 3, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 3, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/weaponcell/medical/oxygen/tier_3

//Utility Medicells

/datum/design/medicell/utility
	name = "Utility Medicell"
	category = list(RND_CATEGORY_WEAPONS + RND_SUBCATEGORY_WEAPONS_MEDICALAMMO + RND_MEDICALAMMO_UTILITY)

/datum/design/medicell/utility/clot
	name = "Clotting Medicell"
	desc = "Gives cell-loaded mediguns projectile-based coagulation functionality."
	id = "clotmedicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 3, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/weaponcell/medical/utility/clotting

/datum/design/medicell/utility/temp
	name = "Temperature Adjustment Medicell"
	desc = "Gives cell loaded-mediguns projectile-based body temperature regulation functionality."
	id = "tempmedicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/gold = SMALL_MATERIAL_AMOUNT * 3, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 3, /datum/material/uranium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5)
	build_path = /obj/item/weaponcell/medical/utility/temperature

/datum/design/medicell/utility/gown
	name = "Hardlight Gown Medicell"
	desc = "Gives cell-loaded mediguns projectile-based hardlight gown deployment functionality."
	id = "gownmedicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/weaponcell/medical/utility/hardlight_gown

/datum/design/medicell/utility/bed
	name = "Hardlight Roller Bed Medicell"
	desc = "Gives cell-loaded mediguns projectile-based hardlight roller bed deployment functionality. Best used on already-horizontal patients."
	id = "bedmedicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 3, /datum/material/bluespace = SMALL_MATERIAL_AMOUNT * 3)
	build_path = /obj/item/weaponcell/medical/utility/bed

/datum/design/medicell/utility/salve
	name = "Empty Salve Medicell"
	desc = "An incomplete medicell that requires a leaf of aloe to fully realize its potential to provide projectile-embedding-based healing-over-time functionality."
	id = "salvemedicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/device/custom_kit/empty_cell

/datum/design/medicell/utility/body
	name = "Empty Body Teleporter Medicell"
	desc = "An incomplete medicell that requires a bluespace slime extract in order to provide projectile-based corpse retrieval functionality."
	id = "bodymedicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/device/custom_kit/empty_cell/body_teleporter

/datum/design/medicell/utility/relocation
	name = "Oppressive Force Relocation Medicell"
	desc = "Gives cell-loaded mediguns projectile-based rubbernecker relocation functionality, by dumping them into the Medbay lobby via eigenstate manipulation. Only works in Medbay when fired by authorized users."
	id = "relocatemedicell"
	materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/plastic = SHEET_MATERIAL_AMOUNT, /datum/material/glass = SHEET_MATERIAL_AMOUNT, /datum/material/plasma = HALF_SHEET_MATERIAL_AMOUNT, /datum/material/diamond = SMALL_MATERIAL_AMOUNT * 5, /datum/material/bluespace = SHEET_MATERIAL_AMOUNT)
	build_path = /obj/item/device/custom_kit/empty_cell/relocator
