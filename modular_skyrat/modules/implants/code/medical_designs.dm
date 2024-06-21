/datum/design/cyberimp_mantis
	name = "Mantis Blade Implant"
	desc = "A long, sharp, mantis-like blade installed within the forearm, acting as a deadly self defense weapon."
	id = "ci-mantis"
	build_type = MECHFAB
	materials = list (
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 200
	build_path = /obj/item/organ/internal/cyberimp/arm/armblade
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_COMBAT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/cyberimp_claws
	name = "Razor Claws Implant"
	desc = "Long, sharp, double-edged razors installed within the fingers, functional for cutting. All kinds of cutting."
	id = "ci-razor"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list (
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 20 SECONDS
	build_path = /obj/item/organ/internal/cyberimp/arm/razor_claws
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_TOOLS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SECURITY

/datum/design/cyberimp_hacker
	name = "Hacking Hand Implant"
	desc = "An advanced hacking and machine modification toolkit fitted into an arm implant, designed to be installed on a subject's arm."
	id = "ci-hacker"
	build_type = MECHFAB
	materials = list (
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 200
	build_path = /obj/item/organ/internal/cyberimp/arm/hacker
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING

/datum/design/cyberimp_flash
	name = "Photon Projector Implant"
	desc = "An integrated projector mounted onto a user's arm that is able to be used as a powerful flash."
	id = "ci-flash"
	build_type = PROTOLATHE | AWAY_LATHE | MECHFAB
	materials = list (
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 200
	build_path = /obj/item/organ/internal/cyberimp/arm/flash
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_COMBAT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_botany
	name = "Botany Arm Implant"
	desc = "Everything a botanist needs in an arm implant, designed to be installed on a subject's arm."
	id = "ci-botany"
	build_type = MECHFAB | PROTOLATHE
	materials = list (
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/plastic = SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 200
	build_path = /obj/item/organ/internal/cyberimp/arm/botany
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_TOOLS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SERVICE

/datum/design/cyberimp_nv
	name = "Night Vision Eyes"
	desc = "These cybernetic eyes will give you Night Vision. Big, mean, and green."
	id = "ci-nv"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 60
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/silver = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/gold = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/uranium = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/internal/eyes/night_vision/cyber
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_UTILITY,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_antisleep
	name = "CNS Jumpstarter Implant"
	desc = "This implant will automatically attempt to jolt you awake from unconsciousness, with a short cooldown between jolts. Conflicts with the CNS Rebooter."
	id = "ci-antisleep"
	build_type = PROTOLATHE | MECHFAB
	construction_time = 60
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 6,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
		)
	build_path = /obj/item/organ/internal/cyberimp/brain/anti_sleep
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_COMBAT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_scanner
	name = "Internal Medical Analyzer"
	desc = "This implant interfaces with a host's body, sending detailed readouts of the vessel's condition on command via the mind."
	id = "ci-scanner"
	build_type = MECHFAB | PROTOLATHE
	construction_time = 40
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 3,
		/datum/material/silver = SHEET_MATERIAL_AMOUNT,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
	)
	build_path = /obj/item/organ/internal/cyberimp/chest/scanner
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_HEALTH,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL

/datum/design/cyberimp_janitor
	name = "Janitor Arm Implant"
	desc = "A set of janitor tools fitted into an arm implant, designed to be installed on subject's arm."
	id = "ci-janitor"
	build_type = PROTOLATHE | MECHFAB
	materials = list (
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 200
	build_path = /obj/item/organ/internal/cyberimp/arm/janitor
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_TOOLS,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SERVICE

/datum/design/cyberimp_lighter
	name = "Lighter Arm Implant"
	desc = "A lighter, installed into the subject's arm. Incredibly useless."
	id = "ci-lighter"
	build_type = PROTOLATHE | MECHFAB
	materials = list (
		/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/silver = HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 100
	build_path = /obj/item/organ/internal/cyberimp/arm/lighter
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_MISC,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL | DEPARTMENT_BITFLAG_SERVICE

/datum/design/cyberimp_thermals
	name = "Thermal Eyes"
	id = "ci-thermals"
	build_type = AWAY_LATHE | MECHFAB
	departmental_flags = DEPARTMENT_BITFLAG_SECURITY

/datum/design/cyberimp_reviver
	name = "Reviver Implant"
	id = "ci-reviver"
	category = list(
		RND_CATEGORY_CYBERNETICS + RND_SUBCATEGORY_CYBERNETICS_IMPLANTS_COMBAT,
	)
	departmental_flags = DEPARTMENT_BITFLAG_MEDICAL
