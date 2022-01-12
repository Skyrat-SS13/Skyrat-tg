/obj/item/weapon/rig/engineering
	name = "engineering RIG"
	desc = "A lightweight and flexible armoured rig suit, designed for mining and shipboard engineering."
	icon_state = "ds_engineering_rig"
	armor = list(melee = 40, bullet = 50, laser = 50, energy = 25, bomb = 60, bio = 100, rad = 75)
	offline_slowdown = 4
	online_slowdown = RIG_HEAVY
	acid_resistance = 2	//Contains a fair bit of plastic

	chest_type = /obj/item/clothing/suit/space/rig/engineering
	helm_type =  /obj/item/clothing/head/helmet/space/rig/engineering
	boot_type =  /obj/item/clothing/shoes/magboots/rig/engineering
	glove_type = /obj/item/clothing/gloves/rig/engineering

	initial_modules = list(
		/obj/item/rig_module/healthbar,
		/obj/item/rig_module/storage,
		/obj/item/rig_module/grenade_launcher/light,	//These grenades are harmless illumination
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/vision/meson,
		/obj/item/rig_module/kinesis,
		/obj/item/rig_module/hotswap,
		/obj/item/rig_module/power_sink
		)

/obj/item/clothing/suit/space/rig/engineering
	name = "suit"

/obj/item/clothing/gloves/rig/engineering
	name = "insulated gloves"
	desc = "These gloves will protect the wearer from electric shocks."
	siemens_coefficient = 0

/obj/item/clothing/shoes/magboots/rig/engineering
	name = "boots"

/obj/item/clothing/head/helmet/space/rig/engineering
	name = "helmet"
