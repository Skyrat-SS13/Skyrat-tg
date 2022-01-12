/obj/item/weapon/rig/combat
	name = "combat hardsuit control module"
	desc = "A sleek and dangerous hardsuit for active combat."
	icon_state = "security_rig"
	suit_type = "combat hardsuit"
	armor = list(melee = 70, bullet = 65, laser = 55, energy = 15, bomb = 80, bio = 100, rad = 60)
	online_slowdown = RIG_HEAVY
	offline_slowdown = 3
	offline_vision_restriction = TINT_HEAVY
	allowed = list(/obj/item/device/flashlight, /obj/item/weapon/tank,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/handcuffs,/obj/item/device/t_scanner, /obj/item/weapon/rcd, /obj/item/weapon/tool/crowbar, \
	/obj/item/weapon/tool/screwdriver, /obj/item/weapon/tool/weldingtool, /obj/item/weapon/tool/wirecutters, /obj/item/weapon/tool/wrench, /obj/item/weapon/tool/multitool, \
	/obj/item/device/radio, /obj/item/device/analyzer,/obj/item/weapon/storage/briefcase/inflatable, /obj/item/weapon/melee/baton, /obj/item/weapon/gun, \
	/obj/item/weapon/storage/firstaid, /obj/item/weapon/reagent_containers/hypospray, /obj/item/roller, /obj/item/device/suit_cooling_unit)

	chest_type = /obj/item/clothing/suit/space/rig/combat
	helm_type = /obj/item/clothing/head/helmet/space/rig/combat
	boot_type = /obj/item/clothing/shoes/magboots/rig/combat
	glove_type = /obj/item/clothing/gloves/rig/combat

/obj/item/clothing/head/helmet/space/rig/combat
	light_overlay = "helmet_light_dual_green"
	species_restricted = list(SPECIES_HUMAN, SPECIES_UNATHI)

/obj/item/clothing/suit/space/rig/combat
	species_restricted = list(SPECIES_HUMAN,SPECIES_SKRELL, SPECIES_UNATHI)

/obj/item/clothing/shoes/magboots/rig/combat
	species_restricted = list(SPECIES_HUMAN,SPECIES_SKRELL, SPECIES_UNATHI)

/obj/item/clothing/gloves/rig/combat
	species_restricted = list(SPECIES_HUMAN,SPECIES_SKRELL, SPECIES_UNATHI)

/obj/item/weapon/rig/combat/equipped
	initial_modules = list(
		/obj/item/rig_module/vision/thermal,
		/obj/item/rig_module/grenade_launcher,
		/obj/item/rig_module/ai_container,
		/obj/item/rig_module/power_sink,
		/obj/item/rig_module/electrowarfare_suite,
		/obj/item/rig_module/chem_dispenser/combat,
		/obj/item/rig_module/cooling_unit,
		/obj/item/rig_module/healthbar
		)

//Extremely OP, hardly standard issue equipment
//Now a little less OP
/obj/item/weapon/rig/military
	name = "military hardsuit control module"
	desc = "An austere hardsuit used by paramilitary groups and real soldiers alike."
	icon_state = "military_rig"
	suit_type = "military hardsuit"
	armor = list(melee = 70, bullet = 75, laser = 60, energy = 15, bomb = 80, bio = 100, rad = 30)
	online_slowdown = RIG_HEAVY
	offline_slowdown = 3
	offline_vision_restriction = TINT_HEAVY
	allowed = list(/obj/item/device/flashlight, /obj/item/weapon/tank,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/handcuffs,/obj/item/device/t_scanner, /obj/item/weapon/rcd, /obj/item/weapon/tool/crowbar, \
	/obj/item/weapon/tool/screwdriver, /obj/item/weapon/tool/weldingtool, /obj/item/weapon/tool/wirecutters, /obj/item/weapon/tool/wrench, /obj/item/weapon/tool/multitool, \
	/obj/item/device/radio, /obj/item/device/analyzer,/obj/item/weapon/storage/briefcase/inflatable, /obj/item/weapon/melee/baton, /obj/item/weapon/gun, \
	/obj/item/weapon/storage/firstaid, /obj/item/weapon/reagent_containers/hypospray, /obj/item/roller, /obj/item/device/suit_cooling_unit)

	chest_type = /obj/item/clothing/suit/space/rig/military
	helm_type = /obj/item/clothing/head/helmet/space/rig/military
	boot_type = /obj/item/clothing/shoes/magboots/rig/military
	glove_type = /obj/item/clothing/gloves/rig/military

/obj/item/clothing/head/helmet/space/rig/military
	light_overlay = "helmet_light_dual_green"
	species_restricted = list(SPECIES_HUMAN)

/obj/item/clothing/suit/space/rig/military
	species_restricted = list(SPECIES_HUMAN,SPECIES_SKRELL, SPECIES_UNATHI)

/obj/item/clothing/shoes/magboots/rig/military
	species_restricted = list(SPECIES_HUMAN,SPECIES_SKRELL, SPECIES_UNATHI)

/obj/item/clothing/gloves/rig/military
	species_restricted = list(SPECIES_HUMAN,SPECIES_SKRELL, SPECIES_UNATHI)

/obj/item/weapon/rig/military/equipped
	initial_modules = list(
		/obj/item/rig_module/vision/multi,
		/obj/item/rig_module/grenade_launcher,
		/obj/item/rig_module/ai_container,
		/obj/item/rig_module/power_sink,
		/obj/item/rig_module/electrowarfare_suite,
		/obj/item/rig_module/chem_dispenser/combat,
		/obj/item/rig_module/cooling_unit,
		/obj/item/rig_module/healthbar
		)






//////////////////////////////////////////////////////////////////////
///////////////Dead Space Unitologists Rig Suits Proper///////////////
//////////////////////////////////////////////////////////////////////
/*

/obj/item/weapon/rig/deadspace/unisoldier
	name = "unitologist combat rig control module"
	suit_type = "unitologist combat rig"

	icon_state = "unifaith_rig"
	desc = "An old combat RIG used by SCAF over two hundred years ago. The armour has seen some wear but still functions as it should, it has been repainted in black and crimson colours. There are unitologist markings across the suit."
	armor = list(melee = 60, bullet = 60, laser = 30, energy = 20, bomb = 30, bio = 40, rad = 40)
	online_slowdown = 0.8
	offline_slowdown = 5
	emp_protection = 10
	allowed = list(/obj/item/device/flashlight, /obj/item/weapon/tank,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/handcuffs,/obj/item/device/t_scanner, /obj/item/weapon/rcd, /obj/item/weapon/tool/crowbar, \
	/obj/item/weapon/tool/screwdriver, /obj/item/weapon/tool/weldingtool, /obj/item/weapon/tool/wirecutters, /obj/item/weapon/tool/wrench, /obj/item/weapon/tool/multitool, \
	/obj/item/device/radio, /obj/item/device/analyzer,/obj/item/weapon/storage/briefcase/inflatable, /obj/item/weapon/melee/baton, /obj/item/weapon/gun, \
	/obj/item/weapon/storage/firstaid, /obj/item/weapon/reagent_containers/hypospray, /obj/item/roller, /obj/item/device/suit_cooling_unit)

	chest_type = /obj/item/clothing/suit/space/rig/unisoldier
	helm_type = /obj/item/clothing/head/helmet/space/rig/unisoldier
	boot_type = /obj/item/clothing/shoes/magboots/rig/unisoldier
	glove_type = /obj/item/clothing/gloves/rig/unisoldier


/obj/item/clothing/suit/space/rig/unisoldier
	name = "combat armor"
	breach_threshold = 60

/obj/item/clothing/head/helmet/space/rig/unisoldier
	name = "combat helmet"
	light_overlay = "helmet_light_dual"

/obj/item/clothing/shoes/magboots/rig/unisoldier
	name = "combat magboots"

/obj/item/clothing/gloves/rig/unisoldier
	name = "combat gloves"
	siemens_coefficient = 0


/obj/item/weapon/rig/deadspace/unisoldier/equipped
	initial_modules = list(
		/obj/item/rig_module/vision/multi,
		/obj/item/rig_module/chem_dispenser/combat,
		/obj/item/rig_module/cooling_unit,
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/voice
		)

/obj/item/weapon/rig/deadspace/uniengie
	name = "unitologist engineer rig control module"
	suit_type = "unitologist engineer rig"

	icon_state = "uniengie_rig"
	desc = "An old combat RIG used by SCAF over two hundred years ago. The armour has seen some wear but still functions as it should, it has been repainted in black and crimson colours. There are unitologist markings across the suit. This one includes an RCD module, the equipment of an engineer on the go."
	armor = list(melee = 60, bullet = 60, laser = 30, energy = 20, bomb = 70, bio = 40, rad = 90)
	online_slowdown = 0.8
	offline_slowdown = 5
	emp_protection = 10
	allowed = list(/obj/item/device/flashlight, /obj/item/weapon/tank,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/handcuffs,/obj/item/device/t_scanner, /obj/item/weapon/rcd, /obj/item/weapon/tool/crowbar, \
	/obj/item/weapon/tool/screwdriver, /obj/item/weapon/tool/weldingtool, /obj/item/weapon/tool/wirecutters, /obj/item/weapon/tool/wrench, /obj/item/weapon/tool/multitool, \
	/obj/item/device/radio, /obj/item/device/analyzer,/obj/item/weapon/storage/briefcase/inflatable, /obj/item/weapon/melee/baton, /obj/item/weapon/gun, \
	/obj/item/weapon/storage/firstaid, /obj/item/weapon/reagent_containers/hypospray, /obj/item/roller, /obj/item/device/suit_cooling_unit)

	chest_type = /obj/item/clothing/suit/space/rig/uniengie
	helm_type = /obj/item/clothing/head/helmet/space/rig/uniengie
	boot_type = /obj/item/clothing/shoes/magboots/rig/uniengie
	glove_type = /obj/item/clothing/gloves/rig/uniengie


/obj/item/clothing/suit/space/rig/uniengie
	name = "combat armor"
	breach_threshold = 60

/obj/item/clothing/head/helmet/space/rig/uniengie
	name = "combat helmet"
	light_overlay = "helmet_light_dual"

/obj/item/clothing/shoes/magboots/rig/uniengie
	name = "combat magboots"

/obj/item/clothing/gloves/rig/uniengie
	name = "combat gloves"
	siemens_coefficient = 0


/obj/item/weapon/rig/deadspace/uniengie/equipped
	initial_modules = list(
		/obj/item/rig_module/vision/multi,
		/obj/item/rig_module/chem_dispenser/combat,
		/obj/item/rig_module/cooling_unit,
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/voice,
		/obj/item/rig_module/device/rcd
		)


/obj/item/weapon/rig/deadspace/unifaithful
	name = "unitologist zealot combat rig control module"
	suit_type = "unitologist zealot combat rig"

	icon_state = "unideac_rig"
	desc = "An old combat RIG used by SCAF over two hundred years ago. The armour has seen some wear but still functions as it should, it has been repainted in black and crimson colours. There are unitologist markings across the suit, this one in particular features marker script engraved across the suit, the armour of a zealot."
	armor = list(melee = 60, bullet = 60, laser = 30, energy = 20, bomb = 30, bio = 40, rad = 40)
	online_slowdown = 0.8
	offline_slowdown = 5
	emp_protection = 10
	allowed = list(/obj/item/device/flashlight, /obj/item/weapon/tank,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/handcuffs,/obj/item/device/t_scanner, /obj/item/weapon/rcd, /obj/item/weapon/tool/crowbar, \
	/obj/item/weapon/tool/screwdriver, /obj/item/weapon/tool/weldingtool, /obj/item/weapon/tool/wirecutters, /obj/item/weapon/tool/wrench, /obj/item/weapon/tool/multitool, \
	/obj/item/device/radio, /obj/item/device/analyzer,/obj/item/weapon/storage/briefcase/inflatable, /obj/item/weapon/melee/baton, /obj/item/weapon/gun, \
	/obj/item/weapon/storage/firstaid, /obj/item/weapon/reagent_containers/hypospray, /obj/item/roller, /obj/item/device/suit_cooling_unit)

	chest_type = /obj/item/clothing/suit/space/rig/unifaithful
	helm_type = /obj/item/clothing/head/helmet/space/rig/unifaithful
	boot_type = /obj/item/clothing/shoes/magboots/rig/unifaithful
	glove_type = /obj/item/clothing/gloves/rig/unifaithful


/obj/item/clothing/suit/space/rig/unifaithful
	name = "combat armor"
	breach_threshold = 60

/obj/item/clothing/head/helmet/space/rig/unifaithful
	name = "combat helmet"
	light_overlay = "helmet_light_dual"

/obj/item/clothing/shoes/magboots/rig/unifaithful
	name = "zealot combat magboots"

/obj/item/clothing/gloves/rig/unifaithful
	name = "zealot combat gloves"
	siemens_coefficient = 0


/obj/item/weapon/rig/deadspace/unifaithful/equipped
	initial_modules = list(
		/obj/item/rig_module/vision/multi,
		/obj/item/rig_module/chem_dispenser/combat,
		/obj/item/rig_module/cooling_unit,
		/obj/item/rig_module/voice
		)

/obj/item/weapon/rig/deadspace/unimedic
	name = "unitologist medic combat rig control module"
	suit_type = "unitologist medic combat rig"

	icon_state = "unimedic_rig"
	desc = "An old combat RIG used by SCAF over two hundred years ago. The armour has seen some wear but still functions as it should, it has been repainted in black and crimson colours. There are unitologist markings across the suit, this one in particular also features a red cross, indicating a medic."
	armor = list(melee = 60, bullet = 60, laser = 30, energy = 20, bomb = 30, bio = 90, rad = 40)
	online_slowdown = 0.8
	offline_slowdown = 5
	emp_protection = 10
	allowed = list(/obj/item/device/flashlight, /obj/item/weapon/tank,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/handcuffs,/obj/item/device/t_scanner, /obj/item/weapon/rcd, /obj/item/weapon/tool/crowbar, \
	/obj/item/weapon/tool/screwdriver, /obj/item/weapon/tool/weldingtool, /obj/item/weapon/tool/wirecutters, /obj/item/weapon/tool/wrench, /obj/item/weapon/tool/multitool, \
	/obj/item/device/radio, /obj/item/device/analyzer,/obj/item/weapon/storage/briefcase/inflatable, /obj/item/weapon/melee/baton, /obj/item/weapon/gun, \
	/obj/item/weapon/storage/firstaid, /obj/item/weapon/reagent_containers/hypospray, /obj/item/roller, /obj/item/device/suit_cooling_unit)

	chest_type = /obj/item/clothing/suit/space/rig/unimedic
	helm_type = /obj/item/clothing/head/helmet/space/rig/unifaithful
	boot_type = /obj/item/clothing/shoes/magboots/rig/unimedic
	glove_type = /obj/item/clothing/gloves/rig/unimedic


/obj/item/clothing/suit/space/rig/unimedic
	name = "combat armor"
	breach_threshold = 60

/obj/item/clothing/head/helmet/space/rig/unimedic
	name = "combat helmet"
	light_overlay = "helmet_light_dual"

/obj/item/clothing/shoes/magboots/rig/unimedic
	name = "combat magboots"

/obj/item/clothing/gloves/rig/unimedic
	name = "combat gloves"
	siemens_coefficient = 0


/obj/item/weapon/rig/deadspace/unimedic/equipped
	initial_modules = list(
		/obj/item/rig_module/vision/multi,
		/obj/item/rig_module/chem_dispenser/combat,
		/obj/item/rig_module/cooling_unit,
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/device/healthscanner,
		/obj/item/rig_module/voice
		)


/obj/item/weapon/rig/deadspace/unizerker
	name = "unitologist berserker combat rig control module"
	suit_type = "unitologist berserker combat rig"

	icon_state = "unizerk_rig"
	desc = "An extremely heavy reinforced urban combat rig painted in Unitologist iconography and... blood. Definitely something that only a madman would wear."
	armor = list(melee = 90, bullet = 90, laser = 30, energy = 20, bomb = 70, bio = 40, rad = 40)
	online_slowdown = 3 //higher slowdown since this suit is supposedly more protective.
	offline_slowdown = 5
	emp_protection = 10
	allowed = list(/obj/item/device/flashlight, /obj/item/weapon/tank,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/handcuffs,/obj/item/device/t_scanner, /obj/item/weapon/rcd, /obj/item/weapon/tool/crowbar, \
	/obj/item/weapon/tool/screwdriver, /obj/item/weapon/tool/weldingtool, /obj/item/weapon/tool/wirecutters, /obj/item/weapon/tool/wrench, /obj/item/weapon/tool/multitool, \
	/obj/item/device/radio, /obj/item/device/analyzer,/obj/item/weapon/storage/briefcase/inflatable, /obj/item/weapon/melee/baton, /obj/item/weapon/gun, \
	/obj/item/weapon/storage/firstaid, /obj/item/weapon/reagent_containers/hypospray, /obj/item/roller, /obj/item/device/suit_cooling_unit)

	chest_type = /obj/item/clothing/suit/space/rig/unizerk
	helm_type = /obj/item/clothing/head/helmet/space/rig/unizerk
	boot_type = /obj/item/clothing/shoes/magboots/rig/unizerk
	glove_type = /obj/item/clothing/gloves/rig/unizerk


/obj/item/clothing/suit/space/rig/unizerk
	name = "combat armor"
	breach_threshold = 60

/obj/item/clothing/head/helmet/space/rig/unizerk
	name = "combat helmet"
	light_overlay = "helmet_light_dual"

/obj/item/clothing/shoes/magboots/rig/unizerk
	name = "combat magboots"

/obj/item/clothing/gloves/rig/unizerk
	name = "combat gloves"
	siemens_coefficient = 0


/obj/item/weapon/rig/deadspace/unizerker/equipped
	initial_modules = list(
		/obj/item/rig_module/vision/multi,
		/obj/item/rig_module/chem_dispenser/combat,
		/obj/item/rig_module/cooling_unit,
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/voice
		)*/
