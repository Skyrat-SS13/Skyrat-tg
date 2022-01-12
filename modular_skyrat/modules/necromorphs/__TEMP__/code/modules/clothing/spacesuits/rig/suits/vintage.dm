/obj/item/weapon/rig/vintage
	name = "antique CEC RIG"
	desc = "An extremely bulky, durable vintage suit that has mostly been replaced by sleeker modern designs. Some collectors still value the good old days though."
	icon_state = "vintage_rig"
	armor = list(melee = 65, bullet = 70, laser = 70, energy = 25, bomb = 90, bio = 100, rad = 70)
	offline_slowdown = 5
	online_slowdown = RIG_SUPER_HEAVY

	max_health = 4000

	chest_type = /obj/item/clothing/suit/space/rig/vintage
	helm_type =  /obj/item/clothing/head/helmet/space/rig/vintage
	boot_type =  /obj/item/clothing/shoes/magboots/rig/vintage
	glove_type = /obj/item/clothing/gloves/rig/vintage

	initial_modules = list(
		/obj/item/rig_module/healthbar,
		/obj/item/rig_module/storage/heavy,
		/obj/item/rig_module/device/orescanner,
		/obj/item/rig_module/maneuvering_jets,
		/obj/item/rig_module/vision/meson
		)

/obj/item/clothing/head/helmet/space/rig/vintage

/obj/item/clothing/suit/space/rig/vintage

/obj/item/clothing/gloves/rig/vintage

/obj/item/clothing/shoes/magboots/rig/vintage


/obj/item/weapon/rig/vintage/heavy
	name = "antique heavy-duty CEC RIG"
	desc = "The heavy-duty vintage CEC RIG is used in the most hazardous engineering operations aboard CEC vessels. Its heavier armor plating can withstand more blunt damage than most CEC suits, and can withstand radiation just as well. As working conditions on CEC ships have improved, this RIG has been discontinued, but some heavy variants can still be found on old planet crackers."
	icon_state = "vintage_suit"
	armor = list(melee = 72, bullet = 77, laser = 77, energy = 28, bomb = 99, bio = 110, rad = 77)

	chest_type = /obj/item/clothing/suit/space/rig/vintage/heavy
	helm_type =  /obj/item/clothing/head/helmet/space/rig/vintage/heavy
	boot_type =  /obj/item/clothing/shoes/magboots/rig/vintage/heavy
	glove_type = /obj/item/clothing/gloves/rig/vintage/heavy

/obj/item/clothing/head/helmet/space/rig/vintage/heavy

/obj/item/clothing/suit/space/rig/vintage/heavy

/obj/item/clothing/gloves/rig/vintage/heavy

/obj/item/clothing/shoes/magboots/rig/vintage/heavy