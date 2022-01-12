
/obj/item/weapon/rig/patrol
	name = "patrol RIG"
	desc = "A very lightweight yet reasonably armoured suit, designed for long journeys on foot."
	icon_state = "patrol"
	armor = list(melee = 57.5, bullet = 60, laser = 60, energy = 25, bomb = 60, bio = 100, rad = 60)
	online_slowdown = RIG_FLEXIBLE

	chest_type = /obj/item/clothing/suit/space/rig/patrol
	helm_type =  /obj/item/clothing/head/helmet/space/rig/patrol
	boot_type =  /obj/item/clothing/shoes/magboots/rig/patrol
	glove_type = /obj/item/clothing/gloves/rig/patrol

	initial_modules = list(
		/obj/item/rig_module/healthbar,
		/obj/item/rig_module/storage/heavy,
		/obj/item/rig_module/extension/speedboost
		)

	/*
		Far Future TODO
		Give patrol rig better cold resistance, making it good for wilderness survival on tau volantis

	*/

/obj/item/clothing/suit/space/rig/patrol
	name = "suit"
	valid_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S, ACCESSORY_SLOT_ARMOR_M)
	restricted_accessory_slots = list(ACCESSORY_SLOT_INSIGNIA, ACCESSORY_SLOT_ARMOR_S)

/obj/item/clothing/gloves/rig/patrol
	name = "gloves"

/obj/item/clothing/shoes/magboots/rig/patrol
	name = "boots"

/obj/item/clothing/head/helmet/space/rig/patrol
	name = "helmet"



