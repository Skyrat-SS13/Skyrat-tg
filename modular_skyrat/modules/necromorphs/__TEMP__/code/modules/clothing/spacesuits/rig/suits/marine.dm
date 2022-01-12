/obj/item/weapon/rig/marine
	name = "advanced soldier RIG"
	desc = "A heavily armoured rig suit, designed for military use."
	icon_state = "adv_soldier"
	armor = list(melee = 72.5, bullet = 75, laser = 75, energy = 40, bomb = 75, bio = 100, rad = 75)
	offline_slowdown = 4
	online_slowdown = RIG_HEAVY
	acid_resistance = 1.75	//Contains a fair bit of plastic

	chest_type = /obj/item/clothing/suit/space/rig/marine
	helm_type =  /obj/item/clothing/head/helmet/space/rig/marine
	boot_type =  /obj/item/clothing/shoes/magboots/rig/marine
	glove_type = /obj/item/clothing/gloves/rig/marine

	initial_modules = list(
		/obj/item/rig_module/healthbar/advanced,
		/obj/item/rig_module/storage/heavy,
		/obj/item/rig_module/grenade_launcher/military,	//These grenades are lethal weapons
		/obj/item/rig_module/vision/nvgsec,
		/obj/item/rig_module/maneuvering_jets
		)

/obj/item/clothing/suit/space/rig/marine
	name = "suit"
	valid_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S, ACCESSORY_SLOT_ARMOR_M)
	restricted_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S)

/obj/item/clothing/gloves/rig/marine
	name = "gloves"

/obj/item/clothing/shoes/magboots/rig/marine
	name = "boots"

/obj/item/clothing/head/helmet/space/rig/marine
	name = "helmet"



/obj/item/weapon/rig/marine/specialist
	name = "advanced specialist RIG"
	desc = "A powerful yet flexible suit, designed for use by military and naval specialists or command staff."
	icon_state = "adv_soldier_dark"
	armor = list(melee = 67.5, bullet = 70, laser = 70, energy = 40, bomb = 70, bio = 100, rad = 75)
	offline_slowdown = 3
	online_slowdown = RIG_MEDIUM
	acid_resistance = 1	//Contains a fair bit of plastic

	chest_type = /obj/item/clothing/suit/space/rig/marine
	helm_type =  /obj/item/clothing/head/helmet/space/rig/marine
	boot_type =  /obj/item/clothing/shoes/magboots/rig/marine
	glove_type = /obj/item/clothing/gloves/rig/marine

	initial_modules = list(
		/obj/item/rig_module/healthbar/advanced,
		/obj/item/rig_module/storage,
		/obj/item/rig_module/grenade_launcher/military,	//These grenades are lethal weapons
		/obj/item/rig_module/device/flash,
		/obj/item/rig_module/kinesis/advanced,
		/obj/item/rig_module/hotswap,
		/obj/item/rig_module/vision/nvgsec,
		/obj/item/rig_module/maneuvering_jets
		)

/obj/item/weapon/rig/marine/earthgov //PLACEHOLDER RIG for earthgovs. Will be replaced by a special earthgov rig later.
	name = "advanced specialist RIG"
	desc = "A powerful yet flexible suit, designed for use by military and naval specialists or command staff."
	icon_state = "adv_soldier_dark"
	armor = list(melee = 50, bullet = 65, laser = 30, energy = 20, bomb = 30, bio = 100, rad = 75)
	offline_slowdown = 3
	online_slowdown = RIG_MEDIUM
	acid_resistance = 1	//Contains a fair bit of plastic

	chest_type = /obj/item/clothing/suit/space/rig/marine
	helm_type =  /obj/item/clothing/head/helmet/space/rig/marine
	boot_type =  /obj/item/clothing/shoes/magboots/rig/marine
	glove_type = /obj/item/clothing/gloves/rig/marine

	initial_modules = list(
		/obj/item/rig_module/healthbar,
		/obj/item/rig_module/storage,
		/obj/item/rig_module/grenade_launcher/light,	//These grenades are harmless illumination
		/obj/item/rig_module/vision/nvgsec
		)