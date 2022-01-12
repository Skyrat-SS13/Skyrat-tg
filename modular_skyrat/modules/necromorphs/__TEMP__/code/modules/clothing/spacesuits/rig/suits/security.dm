//Ishimura Sec RIGs
//PCSI RIG
/obj/item/weapon/rig/security/pcsi
	name = "PCSI RIG"
	desc = "A lightweight and flexible armoured rig suit used by CEC shipboard security during crackdowns and for use in hazardous environments."
	icon_state = "pcsi_rig"
	armor = list(melee = 57.5, bullet = 65, laser = 60, energy = 0, bomb = 60, bio = 100, rad = 60)
	online_slowdown = RIG_MEDIUM
	acid_resistance = 1.75	//Contains a fair bit of plastic

	chest_type = /obj/item/clothing/suit/space/rig/security/pcsi
	helm_type =  /obj/item/clothing/head/helmet/space/rig/security/pcsi
	boot_type =  /obj/item/clothing/shoes/magboots/rig/security/pcsi
	glove_type = /obj/item/clothing/gloves/rig/security/pcsi

	initial_modules = list(
		/obj/item/rig_module/healthbar,
		/obj/item/rig_module/storage,
		/obj/item/rig_module/grenade_launcher/light,	//These grenades are harmless illumination
		/obj/item/rig_module/device/paperdispenser,	//For warrants and paperwork
		/obj/item/rig_module/device/pen,
		/obj/item/rig_module/vision/nvgsec
		)

/obj/item/clothing/head/helmet/space/rig/security/pcsi

/obj/item/clothing/suit/space/rig/security/pcsi
	valid_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S, ACCESSORY_SLOT_ARMOR_M)
	restricted_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S)

/obj/item/clothing/shoes/magboots/rig/security/pcsi

/obj/item/clothing/gloves/rig/security/pcsi

//PCSI Riot RIG
/obj/item/weapon/rig/security/pcsi/advanced
	name = "PCSI riot RIG"
	desc = "A lightweight and flexible armoured rig suit used by CEC shipboard security during crackdowns and for use in hazardous environments."
	icon_state = "pcsi_riot_rig"
	armor = list(melee = 62, bullet = 56, laser = 60, energy = 0, bomb = 60, bio = 100, rad = 60)
	online_slowdown = RIG_MEDIUM
	acid_resistance = 1.75	//Contains a fair bit of plastic

	chest_type = /obj/item/clothing/suit/space/rig/security/pcsi/advanced
	helm_type =  /obj/item/clothing/head/helmet/space/rig/security/pcsi/advanced
	boot_type =  /obj/item/clothing/shoes/magboots/rig/security/pcsi/advanced
	glove_type = /obj/item/clothing/gloves/rig/security/pcsi/advanced

	initial_modules = list(
		/obj/item/rig_module/healthbar,
		/obj/item/rig_module/storage,
		/obj/item/rig_module/grenade_launcher/light,	//These grenades are harmless illumination
		/obj/item/rig_module/device/paperdispenser,	//For warrants and paperwork
		/obj/item/rig_module/device/pen,
		/obj/item/rig_module/vision/nvgsec
		)

/obj/item/clothing/head/helmet/space/rig/security/pcsi/advanced

/obj/item/clothing/suit/space/rig/security/pcsi/advanced
	valid_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S, ACCESSORY_SLOT_ARMOR_M)
	restricted_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S)

/obj/item/clothing/shoes/magboots/rig/security/pcsi/advanced

/obj/item/clothing/gloves/rig/security/pcsi/advanced


//Sprawl Sec RIGs
//Titan Security RIG
/obj/item/weapon/rig/security
	name = "security RIG"
	desc = "A lightweight and flexible armoured rig suit, designed for riot control and shipboard disciplinary enforcement."
	icon_state = "ds_security_rig"
	armor = list(melee = 57.5, bullet = 60, laser = 60, energy = 25, bomb = 60, bio = 100, rad = 60)
	online_slowdown = RIG_MEDIUM
	acid_resistance = 1.75	//Contains a fair bit of plastic

	chest_type = /obj/item/clothing/suit/space/rig/security
	helm_type =  /obj/item/clothing/head/helmet/space/rig/security
	boot_type =  /obj/item/clothing/shoes/magboots/rig/security
	glove_type = /obj/item/clothing/gloves/rig/security

	initial_modules = list(
		/obj/item/rig_module/healthbar,
		/obj/item/rig_module/storage,
		/obj/item/rig_module/grenade_launcher/light,	//These grenades are harmless illumination
		/obj/item/rig_module/device/paperdispenser,	//For warrants and paperwork
		/obj/item/rig_module/device/pen,
		/obj/item/rig_module/vision/nvgsec
		)

/obj/item/clothing/head/helmet/space/rig/security

/obj/item/clothing/suit/space/rig/security
	valid_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S, ACCESSORY_SLOT_ARMOR_M)
	restricted_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S)

/obj/item/clothing/gloves/rig/security

/obj/item/clothing/shoes/magboots/rig/security
