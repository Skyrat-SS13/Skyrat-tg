/obj/item/weapon/rig/hacker
	name = "hacker RIG"
	desc = "A lightweight suit cobbled together from civilian parts, with some high end tech hidden within"
	icon_state = "ds_hacker_rig"

	//Similar resistances as firesuit
	armor = list(melee = 35, bullet = 35, laser = 40, energy = 40, bomb = 40, bio = 80, rad = 60) //less protective, but a lot faster

	offline_slowdown = 2
	online_slowdown = RIG_LIGHT


	max_health = 1500

	chest_type = /obj/item/clothing/suit/space/rig/hacker
	helm_type =  /obj/item/clothing/head/helmet/space/rig/hacker
	boot_type =  /obj/item/clothing/shoes/magboots/rig/hacker
	glove_type = /obj/item/clothing/gloves/rig/hacker

	initial_modules = list(
		/obj/item/rig_module/healthbar,
		/obj/item/rig_module/storage/light,
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/hotswap,
		/obj/item/rig_module/power_sink,
		/obj/item/rig_module/electrowarfare_suite,
		/obj/item/rig_module/vision/sechud
		)


/obj/item/clothing/suit/space/rig/hacker
	name = "suit"

/obj/item/clothing/gloves/rig/hacker
	name = "insulated gloves"
	desc = "These gloves will protect the wearer from electric shocks."
	siemens_coefficient = 0

/obj/item/clothing/shoes/magboots/rig/hacker
	name = "shoes"

/obj/item/clothing/head/helmet/space/rig/hacker
	name = "helmet"
