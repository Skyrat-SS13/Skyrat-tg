/obj/item/clothing/neck/chaplain
	name = "bishop's cloak"
	desc = "Become the space pope."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "bishopcloak"

/obj/item/clothing/neck/chaplain/black
	name = "black bishop's cloak"
	icon_state = "blackbishopcloak"

/obj/item/clothing/neck/cloak/qm/syndie
	name = "deck officer's cloak"
	desc = "A cloak that represents the eternal Cargoslavia. There's little Mosin Nagant emblems woven into the fabric."

/obj/item/clothing/neck/cowboylea
	name = "green cowboy poncho"
	desc = "A sand covered cloak, there seems to be a small deer head with antlers embroidered inside."
	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "cowboy_poncho"
	heat_protection = CHEST

/obj/item/clothing/neck/cowboylea/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_clothes, "cowboy_poncho_t")

//This one is greyscale :)
/obj/item/clothing/neck/ranger_poncho
	name = "ranger poncho"
	desc = "Aim for the Heart, Ramon."
	icon_state = "ranger_poncho"
	greyscale_config = /datum/greyscale_config/ranger_poncho
	greyscale_config_worn = /datum/greyscale_config/ranger_poncho/worn
	greyscale_colors = "#917A57#858585"	//Roughly the same color as the original non-greyscale item was
	flags_1 = IS_PLAYER_COLORABLE_1
	heat_protection = CHEST

/obj/item/clothing/neck/ranger_poncho/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_clothes, "ranger_poncho_t")

/obj/item/clothing/neck/robe_cape
	name = "robe cape"
	desc = "A comfortable northern-style cape, draped down your back and held around your neck with a brooch. Reminds you of a sort of robe."
	icon_state = "robe_cape"
	greyscale_config = /datum/greyscale_config/robe_cape
	greyscale_config_worn = /datum/greyscale_config/robe_cape/worn
	greyscale_colors = "#867361"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/neck/long_cape
	name = "long cape"
	desc = "A graceful cloak that carefully surrounds your body."
	icon_state = "long_cape"
	greyscale_config = /datum/greyscale_config/long_cape
	greyscale_config_worn = /datum/greyscale_config/long_cape/worn
	greyscale_colors = "#867361#4d433d#b2a69c#b2a69c"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/neck/long_cape/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_clothes, "long_cape_t")

/obj/item/clothing/neck/wide_cape
	name = "wide cape"
	desc = "A proud, broad-shouldered cloak with which you can protect the honor of your back."
	icon_state = "wide_cape"
	greyscale_config = /datum/greyscale_config/wide_cape
	greyscale_config_worn = /datum/greyscale_config/wide_cape/worn
	greyscale_colors = "#867361#4d433d#b2a69c"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|ARMS
