// This file is going to be just all bitflag additions

/datum/design/bounced_radio/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/radio_navigation_beacon/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/engine_goggles/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/magboots/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/pneumatic_seal/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/welding_goggles/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/welding_helmet/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/gas_filter/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/plasmaman_gas_filter/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/plasmarefiller/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/emergency_oxygen_engi/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/plasmaman_tank_belt/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/generic_gas_tank/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/plasma_tank/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/diagnostic_hud/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/sticky_tape/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/portaseeder/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/oven_tray/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/survival_knife
	name = "Survival Knife"
	id = "survival_knife"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 6
	)
	build_path = /obj/item/knife/combat/survival
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

/datum/design/soup_pot
	name = "Soup Pot"
	id = "soup_pot"
	build_type = COLONY_FABRICATOR
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2.5
	)
	build_path = /obj/item/reagent_containers/cup/soup_pot
	category = list(
		RND_CATEGORY_INITIAL,
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_KITCHEN,
	)
	departmental_flags = DEPARTMENT_BITFLAG_SERVICE

// Stock parts are going here too because there's not many of them

/datum/design/water_recycler/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/super_cell/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/adv_capacitor/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/adv_scanning/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/nano_servo/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/high_micro_laser/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/adv_matter_bin/New()
	. = ..()
	build_type |= COLONY_FABRICATOR

/datum/design/rped/New()
	. = ..()
	build_type |= COLONY_FABRICATOR
