/datum/armor/df_armor_default // This gets modified by materials
	melee = 100
	bullet = 100
	bomb = 100
	fire = 100
	acid = 100
	wound = 100

// Plate vest

/obj/item/clothing/suit/armor/df_plate_armor
	name = "plate vest"
	desc = "An armor vest made of large, hand-hammered plates."
	icon = 'modular_skyrat/modules/GAGS/icons/event_clothes_human.dmi'
	worn_icon = 'modular_skyrat/modules/GAGS/icons/event_clothes_human.dmi'
	icon_state = "vest"
	greyscale_config = /datum/greyscale_config/plate_vest
	greyscale_config_worn = /datum/greyscale_config/plate_vest/worn
	greyscale_config_worn_better_vox = /datum/greyscale_config/plate_vest/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/plate_vest/worn/oldvox
	greyscale_config_worn_teshari = /datum/greyscale_config/plate_vest/worn/teshari
	greyscale_colors = "#cec8bf"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/df_armor_default
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

// Gauntlets

/obj/item/clothing/gloves/fingerless/df_gauntlets
	name = "gauntlets"
	desc = "Simple cloth arm wraps with overlying metal protection."
	icon_state = "gauntlets"
	icon = 'modular_skyrat/modules/GAGS/icons/event_clothes_human.dmi'
	worn_icon = 'modular_skyrat/modules/GAGS/icons/event_clothes_human.dmi'
	greyscale_config = /datum/greyscale_config/gauntlets
	greyscale_config_worn = /datum/greyscale_config/gauntlets/worn
	greyscale_config_worn_better_vox = /datum/greyscale_config/gauntlets/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/gauntlets/worn/oldvox
	greyscale_config_worn_teshari = /datum/greyscale_config/gauntlets/worn/teshari
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_colors = "#cec8bf"
	flags_1 = IS_PLAYER_COLORABLE_1
	armor_type = /datum/armor/df_armor_default
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

// Security's sabre

/obj/item/storage/belt/sabre/cargo/security_actually
	name = "leather sheath"
	desc = "A fairly standard looking guard's sabre sheath, its a bit dusty from the trip here."

/obj/item/storage/belt/sabre/cargo/security_actually/PopulateContents()
	new /obj/item/melee/sabre/cargo/security_actually(src)
	update_appearance()

/obj/item/melee/sabre/cargo/security_actually
	name = "guard's sabre"
	desc = "An expertly crafted sabre issued to caravan guards, the fact you're still here means it must've worked!"
