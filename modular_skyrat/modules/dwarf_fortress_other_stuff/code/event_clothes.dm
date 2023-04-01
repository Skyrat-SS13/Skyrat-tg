GLOBAL_LIST_INIT(metal_clothing_colors, list("#c74900","#857994","#bec7d3",))
GLOBAL_LIST_INIT(leather_clothing_colors, list("#553f3f","#4e331e","#363441","#645041","#6e423c","#533737",))
GLOBAL_LIST_INIT(fabric_clothing_colors, list("#F1F1F1","#b9b9b9","#d4c7a3","#dac381","#e0d0af","#e9e2d6"))
GLOBAL_LIST_INIT(science_robe_colors, list("#46313f","#382744","#443653",))

/*
* Underclothes
*/

/obj/item/clothing/under/costume/buttondown/event_clothing
	icon = 'modular_skyrat/modules/GAGS/icons/event_clothes_human.dmi'
	worn_icon = 'modular_skyrat/modules/GAGS/icons/event_clothes_human.dmi'
	worn_icon_teshari = 'modular_skyrat/modules/GAGS/icons/event_clothes_teshari.dmi'
	can_adjust = FALSE
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	greyscale_colors = "#F1F1F1#F1F1F1"

// Overalls

/obj/item/clothing/under/costume/buttondown/event_clothing/overalls
	name = "leather overalls"
	desc = "Leather overalls with a pretty normal looking shirt under it, you have no idea what any of this is actually made from."
	icon_state = "overalls_buttondown"
	greyscale_config = /datum/greyscale_config/overalls
	greyscale_config_worn = /datum/greyscale_config/overalls/worn
	greyscale_config_worn_better_vox = /datum/greyscale_config/overalls/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/overalls/worn/oldvox
	greyscale_config_worn_teshari = /datum/greyscale_config/overalls/worn/teshari
	greyscale_config_worn_digi = /datum/greyscale_config/overalls/worn/digi

/obj/item/clothing/under/costume/buttondown/event_clothing/overalls/Initialize(mapload)
	. = ..()
	if(prob(50))
		icon_state = "overalls_longshirt"
	set_greyscale("[pick(GLOB.fabric_clothing_colors)][pick(GLOB.leather_clothing_colors)]")

//Pants with a shirt

/obj/item/clothing/under/costume/buttondown/event_clothing/workpants
	name = "leather pants"
	desc = "Worn looking leather pants with a pretty comfortable shirt on top, where the leather for these pants came from is as of now unknown."
	icon_state = "pants_buttondown"
	greyscale_config = /datum/greyscale_config/workpants
	greyscale_config_worn = /datum/greyscale_config/workpants/worn
	greyscale_config_worn_better_vox = /datum/greyscale_config/workpants/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/workpants/worn/oldvox
	greyscale_config_worn_teshari = /datum/greyscale_config/workpants/worn/teshari
	greyscale_config_worn_digi = /datum/greyscale_config/workpants/worn/digi

/obj/item/clothing/under/costume/buttondown/event_clothing/workpants/Initialize(mapload)
	. = ..()
	if(prob(50))
		icon_state = "pants_longshirt"
	set_greyscale("[pick(GLOB.fabric_clothing_colors)][pick(GLOB.leather_clothing_colors)]")

//High waist pants with a shirt

/obj/item/clothing/under/costume/buttondown/event_clothing/longpants
	name = "high waist leather pants"
	desc = "Leather pants with an exceptionally high waist for working around water, or for geeks, you choose."
	icon_state = "longpants_buttondown"
	greyscale_config = /datum/greyscale_config/longpants
	greyscale_config_worn = /datum/greyscale_config/longpants/worn
	greyscale_config_worn_better_vox = /datum/greyscale_config/longpants/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/longpants/worn/oldvox
	greyscale_config_worn_teshari = /datum/greyscale_config/longpants/worn/teshari
	greyscale_config_worn_digi = /datum/greyscale_config/longpants/worn/digi

/obj/item/clothing/under/costume/buttondown/event_clothing/longpants/Initialize(mapload)
	. = ..()
	if(prob(50))
		icon_state = "longpants_longshirt"
	set_greyscale("[pick(GLOB.fabric_clothing_colors)][pick(GLOB.leather_clothing_colors)]")

/obj/item/clothing/under/costume/buttondown/event_clothing/skirt
	name = "long skirt"
	desc = "A plain skirt (or kilt if you feel like it) with a fairly comfortable shirt on top."
	icon_state = "skirt_buttondown"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	greyscale_config = /datum/greyscale_config/skirt
	greyscale_config_worn = /datum/greyscale_config/skirt/worn
	greyscale_config_worn_better_vox = /datum/greyscale_config/skirt/worn/newvox
	greyscale_config_worn_vox = /datum/greyscale_config/skirt/worn/oldvox
	greyscale_config_worn_teshari = /datum/greyscale_config/skirt/worn/teshari

/obj/item/clothing/under/costume/buttondown/event_clothing/skirt/Initialize(mapload)
	. = ..()
	if(prob(50))
		icon_state = "skirt_longshirt"
	set_greyscale("[pick(GLOB.fabric_clothing_colors)][pick(GLOB.fabric_clothing_colors)]")

//Robes
/obj/item/clothing/under/costume/skyrat/bathrobe/event
	name = "robes"
	desc = "Comfortable, definitely posh looking robes fit for a king, or just a huge nerd who has no other job."

/obj/item/clothing/under/costume/skyrat/bathrobe/event/Initialize(mapload)
	. = ..()
	set_greyscale("[pick(GLOB.science_robe_colors)]")

/*
* Suit Slot Stuff
*/

/obj/item/clothing/suit/toggle/jacket/sweater/cloth_colors
	greyscale_colors = "#F1F1F1"
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/sweater/cloth_colors/Initialize(mapload)
	. = ..()
	set_greyscale("[pick(GLOB.fabric_clothing_colors)]")

/obj/item/clothing/suit/toggle/jacket/sweater/leather_colors
	name = "leather travel jacket"
	desc = "Say that name ten times fast."
	greyscale_colors = "#F1F1F1"
	flags_1 = NONE

/obj/item/clothing/suit/toggle/jacket/sweater/leather_colors/Initialize(mapload)
	. = ..()
	set_greyscale("[pick(GLOB.leather_clothing_colors)]")

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

/obj/item/storage/belt/sabre/cargo/security_actually
	name = "leather sheath"
	desc = "A fairly standard looking guard's sabre sheath, its a bit dusty from the trip here."

/obj/item/storage/belt/sabre/cargo/security_actually/PopulateContents()
	new /obj/item/melee/sabre/cargo/security_actually(src)
	update_appearance()

/obj/item/melee/sabre/cargo/security_actually
	name = "guard's sabre"
	desc = "An expertly crafted sabre issued to caravan guards, the fact you're still here means it must've worked!"
