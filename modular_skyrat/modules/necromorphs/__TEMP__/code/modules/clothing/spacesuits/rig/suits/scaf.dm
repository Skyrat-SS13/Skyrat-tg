//"Refurbished" SCAF RIGs
// - These are not intended to go anywhere but the store. Do not add them to random lists. - Snype

//SCAF Elite RIG
/obj/item/weapon/rig/scaf
	name = "refurbished SCAF RIG"
	desc = "A lightweight and flexible armoured rig suit, designed for riot control and shipboard disciplinary enforcement."
	icon_state = "scaf_elite_rig"

	//Security RIG stats
	armor = list(melee = 57.5, bullet = 65, laser = 60, energy = 0, bomb = 60, bio = 100, rad = 60)

	online_slowdown = RIG_MEDIUM
	acid_resistance = 1.75	//Contains a fair bit of plastic

	chest_type = /obj/item/clothing/suit/space/rig/scaf
	helm_type =  /obj/item/clothing/head/helmet/space/rig/scaf
	boot_type =  /obj/item/clothing/shoes/magboots/rig/scaf
	glove_type = /obj/item/clothing/gloves/rig/scaf

	initial_modules = list(
		/obj/item/rig_module/healthbar,
		/obj/item/rig_module/storage,
		/obj/item/rig_module/grenade_launcher/light	//These grenades are harmless illumination
		)

//These pieces don't need redefined for every sub-rig, their values are set procedurally from the frame
/obj/item/clothing/head/helmet/space/rig/scaf

/obj/item/clothing/suit/space/rig/scaf
	valid_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S, ACCESSORY_SLOT_ARMOR_M)
	restricted_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S)

/obj/item/clothing/gloves/rig/scaf

/obj/item/clothing/shoes/magboots/rig/scaf

/obj/item/weapon/rig/scaf/elite
	name = "elite SCAF RIG"
	icon_state = "scaf_elite_rig"


//SCAF Legionnaire RIG
/obj/item/weapon/rig/scaf/legionnaire
	name = "refurbished SCAF expeditionary RIG"
	desc = "A lightweight and flexible armoured rig suit, designed for riot control and shipboard disciplinary enforcement."
	icon_state = "scaf_legionnaire_rig"
	online_slowdown = RIG_MEDIUM
	acid_resistance = 1.75	//Contains a fair bit of plastic


//SCAF Sharpshooter RIG
/obj/item/weapon/rig/scaf/sharpshooter
	name = "refurbished SCAF sharpshooter RIG"
	desc = "A lightweight and flexible armoured rig suit, designed for riot control and shipboard disciplinary enforcement."
	icon_state = "scaf_sharpshooter_rig"
	online_slowdown = RIG_MEDIUM
	acid_resistance = 1.75	//Contains a fair bit of plastic

	initial_modules = list(
		/obj/item/rig_module/healthbar,
		/obj/item/rig_module/storage,
		/obj/item/rig_module/grenade_launcher/light,	//These grenades are harmless illumination
		/obj/item/rig_module/vision/nvgsec				//Unique advantage of the Sharpshooter rig vs its counterparts.
		)
