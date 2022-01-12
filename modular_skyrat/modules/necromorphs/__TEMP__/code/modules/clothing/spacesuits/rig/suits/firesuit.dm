/obj/item/weapon/rig/firesuit
	name = "firesuit RIG"
	desc = "A extremely lightweight suit, designed to resist high temperatures whilst reduced armor plating makes it lighter. Soft materials barely impede movement."
	icon_state = "ds_firesuit_rig"
	armor = list(melee = 30, bullet = 35, laser = 50, energy = 40, bomb = 60, bio = 100, rad = 60) //less protective, but a lot faster
	offline_slowdown = 3
	online_slowdown = 1 //lightweight materials.
	acid_resistance = 2.5	//Designed to take burns well.
	max_heat_protection_temperature = FIRESUIT_MAX_HEAT_PROTECTION_TEMPERATURE // equivalent to the firesuits
	seal_delay = 15 //double as fast to deploy thanks to flexible materials
	online_slowdown = RIG_VERY_HEAVY
	chest_type = /obj/item/clothing/suit/space/rig/firesuit
	helm_type =  /obj/item/clothing/head/helmet/space/rig/firesuit
	boot_type =  /obj/item/clothing/shoes/magboots/rig/firesuit
	glove_type = /obj/item/clothing/gloves/rig/firesuit

	initial_modules = list(
		/obj/item/rig_module/healthbar,
		/obj/item/rig_module/storage/light,
		/obj/item/rig_module/grenade_launcher/light,	//These grenades are harmless illumination
		/obj/item/rig_module/device/flash,
		/obj/item/rig_module/vision/nvg
		)

/obj/item/clothing/suit/space/rig/firesuit
	name = "suit"

/obj/item/clothing/gloves/rig/firesuit
	name = "gloves"

/obj/item/clothing/shoes/magboots/rig/firesuit
	name = "boots"

/obj/item/clothing/head/helmet/space/rig/firesuit
	name = "helmet"