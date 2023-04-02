/*
* Underclothes
*/

/obj/item/clothing/under/costume/buttondown/event_clothing
	icon = 'modular_skyrat/modules/GAGS/icons/event_clothes_human.dmi'
	worn_icon = 'modular_skyrat/modules/GAGS/icons/event_clothes_human.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/GAGS/icons/event_clothes_teshari.dmi'
	can_adjust = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#cec8bf"
	armor_type = /datum/armor/df_armor_default // let me cook
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

//Pants with a shirt

/obj/item/clothing/under/costume/buttondown/event_clothing/workpants
	name = "pants with shirt"
	desc = "Worn looking leather pants with a pretty comfortable shirt on top, where the leather for these pants came from is as of now unknown."
	icon_state = "pants_buttondown"
	greyscale_config = /datum/greyscale_config/workpants
	greyscale_config_worn = /datum/greyscale_config/workpants/worn
	greyscale_config_worn_better_vox = /datum/greyscale_config/workpants/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/workpants/worn/oldvox
	greyscale_config_worn_teshari = /datum/greyscale_config/workpants/worn/teshari
	greyscale_config_worn_digi = /datum/greyscale_config/workpants/worn/digi

//High waist pants with a shirt

/obj/item/clothing/under/costume/buttondown/event_clothing/longpants
	name = "high waist pants with shirt"
	desc = "Leather pants with an exceptionally high waist for working around water, or for geeks, you choose."
	icon_state = "longpants_buttondown"
	greyscale_config = /datum/greyscale_config/longpants
	greyscale_config_worn = /datum/greyscale_config/longpants/worn
	greyscale_config_worn_better_vox = /datum/greyscale_config/longpants/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/longpants/worn/oldvox
	greyscale_config_worn_teshari = /datum/greyscale_config/longpants/worn/teshari
	greyscale_config_worn_digi = /datum/greyscale_config/longpants/worn/digi

/obj/item/clothing/under/costume/buttondown/event_clothing/skirt
	name = "skirt with shirt"
	desc = "A plain skirt (or kilt if you feel like it) with a fairly comfortable shirt on top."
	icon_state = "skirt_buttondown"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/skirt
	greyscale_config_worn = /datum/greyscale_config/skirt/worn
	greyscale_config_worn_better_vox = /datum/greyscale_config/skirt/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/skirt/worn/oldvox
	greyscale_config_worn_teshari = /datum/greyscale_config/skirt/worn/teshari

//Robes
/obj/item/clothing/under/costume/skyrat/bathrobe/event
	name = "robes"
	desc = "Comfortable, definitely posh looking robes fit for a king, or just a huge nerd who has no other job."
	armor_type = /datum/armor/df_armor_default
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

/*
* Suit Slot Stuff
*/

/obj/item/clothing/suit/toggle/jacket/sweater/cloth_colors
	greyscale_colors = "#cec8bf"
	flags_1 = NONE
	armor_type = /datum/armor/df_armor_default
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

/obj/item/clothing/suit/toggle/jacket/sweater/leather_colors
	name = "leather travel jacket"
	desc = "Say that name ten times fast."
	greyscale_colors = "#cec8bf"
	flags_1 = NONE
	armor_type = /datum/armor/df_armor_default
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS

/obj/item/storage/backpack/explorer/event
	icon = 'modular_skyrat/modules/GAGS/icons/event_clothes_human.dmi'
	worn_icon = 'modular_skyrat/modules/GAGS/icons/event_clothes_human.dmi'
	icon_state = "backpack"
	worn_icon_state = "backpack_worn"
	worn_icon_better_vox =	'modular_skyrat/modules/GAGS/icons/event_clothes_new_vox.dmi'
	worn_icon_vox = 'modular_skyrat/modules/GAGS/icons/event_clothes_old_vox.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/GAGS/icons/event_clothes_teshari.dmi'

/obj/item/storage/backpack/satchel/explorer/event
	icon = 'modular_skyrat/modules/GAGS/icons/event_clothes_human.dmi'
	worn_icon = 'modular_skyrat/modules/GAGS/icons/event_clothes_human.dmi'
	icon_state = "satchel"
	worn_icon_state = "satchel_worn"
	worn_icon_better_vox =	'modular_skyrat/modules/GAGS/icons/event_clothes_new_vox.dmi'
	worn_icon_vox = 'modular_skyrat/modules/GAGS/icons/event_clothes_old_vox.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/GAGS/icons/event_clothes_teshari.dmi'

// Armwraps

/obj/item/clothing/gloves/fingerless/df_armwraps
	name = "arm wraps"
	desc = "Simple cloth to wrap around one's arms."
	icon_state = "armwraps"
	icon = 'modular_skyrat/modules/GAGS/icons/event_clothes_human.dmi'
	worn_icon = 'modular_skyrat/modules/GAGS/icons/event_clothes_human.dmi'
	greyscale_config = /datum/greyscale_config/armwraps
	greyscale_config_worn = /datum/greyscale_config/armwraps/worn
	greyscale_config_worn_better_vox = /datum/greyscale_config/armwraps/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/armwraps/worn/oldvox
	greyscale_config_worn_teshari = /datum/greyscale_config/armwraps/worn/teshari
	greyscale_colors = "#cec8bf"
	flags_1 = IS_PLAYER_COLORABLE_1
	armor_type = /datum/armor/df_armor_default
	material_flags = MATERIAL_EFFECTS | MATERIAL_ADD_PREFIX | MATERIAL_GREYSCALE | MATERIAL_COLOR | MATERIAL_AFFECT_STATISTICS
