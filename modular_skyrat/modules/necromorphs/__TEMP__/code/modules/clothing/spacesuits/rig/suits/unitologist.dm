/obj/item/weapon/rig/zealot
	name = "zealot RIG"
	desc = "An old combat RIG used by SCAF over two hundred years ago. The armour has seen some wear but still functions as it should, it has been repainted in black and crimson colours. There are unitologist markings across the suit."
	icon_state = "zealot_rig"
	armor = list(melee = 60, bullet = 60, laser = 30, energy = 20, bomb = 30, bio = 100, rad = 40)
	online_slowdown = RIG_MEDIUM
	acid_resistance = 1.75	//Contains a fair bit of plastic

	chest_type = /obj/item/clothing/suit/space/rig/zealot
	helm_type =  /obj/item/clothing/head/helmet/space/rig/zealot
	boot_type =  /obj/item/clothing/shoes/magboots/rig/zealot
	glove_type = /obj/item/clothing/gloves/rig/zealot

	initial_modules = list(
		/obj/item/rig_module/healthbar,
		/obj/item/rig_module/storage,
		/obj/item/rig_module/grenade_launcher/light,	//These grenades are harmless illumination
		/obj/item/rig_module/vision/nvgsec
		)

/obj/item/clothing/head/helmet/space/rig/zealot
	light_overlay = "zealothelm_light"

/obj/item/clothing/suit/space/rig/zealot
	valid_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S, ACCESSORY_SLOT_ARMOR_M)
	restricted_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S)

/obj/item/clothing/gloves/rig/zealot

/obj/item/clothing/shoes/magboots/rig/zealot
