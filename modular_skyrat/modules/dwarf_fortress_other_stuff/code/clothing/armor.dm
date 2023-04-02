GLOBAL_LIST_INIT(metal_clothing_colors, list("#c74900","#857994","#bec7d3",))
GLOBAL_LIST_INIT(leather_clothing_colors, list("#553f3f","#4e331e","#363441","#645041","#6e423c","#533737",))
GLOBAL_LIST_INIT(fabric_clothing_colors, list("#F1F1F1","#b9b9b9","#d4c7a3","#dac381","#e0d0af","#e9e2d6"))
GLOBAL_LIST_INIT(science_robe_colors, list("#46313f","#382744","#443653",))

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
	greyscale_colors = "#cec8bf#cec8bf"
	flags_1 = IS_PLAYER_COLORABLE_1

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
