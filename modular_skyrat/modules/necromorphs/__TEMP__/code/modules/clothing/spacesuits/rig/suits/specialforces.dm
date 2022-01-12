/obj/item/weapon/rig/special_forces
	name = "special forces RIG"
	desc = "A heavily armoured rig suit, designed for military use."
	icon_state = "special_forces_rig"
	armor = list(melee = 72.5, bullet = 75, laser = 75, energy = 40, bomb = 75, bio = 100, rad = 75)
	offline_slowdown = 4
	online_slowdown = RIG_HEAVY
	acid_resistance = 1.75	//Contains a fair bit of plastic

	chest_type = /obj/item/clothing/suit/space/rig/special_forces
	helm_type =  /obj/item/clothing/head/helmet/space/rig/special_forces
	boot_type =  /obj/item/clothing/shoes/magboots/rig/special_forces
	glove_type = /obj/item/clothing/gloves/rig/special_forces

	initial_modules = list(
		/obj/item/rig_module/healthbar/advanced,
		/obj/item/rig_module/storage/heavy,
		/obj/item/rig_module/grenade_launcher/military,	//These grenades are lethal weapons
		/obj/item/rig_module/vision/nvgsec,
		/obj/item/rig_module/maneuvering_jets
		)

/obj/item/clothing/suit/space/rig/special_forces
	name = "suit"
	valid_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S, ACCESSORY_SLOT_ARMOR_M)
	restricted_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S)

/obj/item/clothing/gloves/rig/special_forces
	name = "gloves"

/obj/item/clothing/shoes/magboots/rig/special_forces
	name = "boots"

/obj/item/clothing/head/helmet/space/rig/special_forces
	name = "helmet"
	light_overlay = "special_forces_light"


/obj/item/weapon/rig/carver
	name = "Carver's RIG"
	desc = "A heavily armoured rig suit, designed for military use."
	icon_state = "carver_rig"
	armor = list(melee = 72.5, bullet = 75, laser = 75, energy = 40, bomb = 75, bio = 100, rad = 75)
	offline_slowdown = 4
	online_slowdown = RIG_HEAVY
	acid_resistance = 1.75	//Contains a fair bit of plastic

	chest_type = /obj/item/clothing/suit/space/rig/carver
	helm_type =  /obj/item/clothing/head/helmet/space/rig/carver
	boot_type =  /obj/item/clothing/shoes/magboots/rig/carver
	glove_type = /obj/item/clothing/gloves/rig/carver

	initial_modules = list(
		/obj/item/rig_module/healthbar/advanced,
		/obj/item/rig_module/storage/heavy,
		/obj/item/rig_module/grenade_launcher/military,	//These grenades are lethal weapons
		/obj/item/rig_module/vision/nvgsec,
		/obj/item/rig_module/maneuvering_jets
		)

/obj/item/clothing/suit/space/rig/carver
	name = "suit"
	valid_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S, ACCESSORY_SLOT_ARMOR_M)
	restricted_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S)

/obj/item/clothing/gloves/rig/carver
	name = "gloves"

/obj/item/clothing/shoes/magboots/rig/carver
	name = "boots"

/obj/item/clothing/head/helmet/space/rig/carver
	name = "helmet"
	light_overlay = "carver_light"


