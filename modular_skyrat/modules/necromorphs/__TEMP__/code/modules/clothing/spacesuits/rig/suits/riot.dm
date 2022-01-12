/obj/item/weapon/rig/riot
	name = "riot RIG"
	desc = "A heavy duty and armoured rig suit, designed for riot control and shipboard disciplinary enforcement. This suit is commonly found among security officers on the Sprawl, and in lesser capacity on private ships and stations."
	icon_state = "ds_riot_rig"
	armor = list(melee = 70, bullet = 60, laser = 60, energy = 30, bomb = 65, bio = 100, rad = 60)
	online_slowdown = RIG_VERY_HEAVY
	acid_resistance = 2	//Contains a fair bit of plastic
	allowed = list(/obj/item/weapon/shield/riot)

	chest_type = /obj/item/clothing/suit/space/rig/riot
	helm_type =  /obj/item/clothing/head/helmet/space/rig/riot
	boot_type =  /obj/item/clothing/shoes/magboots/rig/riot
	glove_type = /obj/item/clothing/gloves/rig/riot

	initial_modules = list(
		/obj/item/rig_module/healthbar,
		/obj/item/rig_module/storage/heavy,
		/obj/item/rig_module/grenade_launcher/light,	//These grenades are harmless illumination
		/obj/item/rig_module/device/paperdispenser,	//For warrants and paperwork
		/obj/item/rig_module/device/pen,
		/obj/item/rig_module/vision/nvgsec
		)

/obj/item/clothing/suit/space/rig/riot
	name = "armor"
	valid_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S, ACCESSORY_SLOT_ARMOR_M)
	restricted_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S)

/obj/item/clothing/gloves/rig/riot
	name = "gauntlets"

/obj/item/clothing/shoes/magboots/rig/riot
	name = "boots"

/obj/item/clothing/head/helmet/space/rig/riot
	name = "helmet"
