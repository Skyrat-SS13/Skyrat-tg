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

/obj/item/clothing/neck/cape
	name = "Cape"
	desc = "A graceful cloak that carefully surrounds your body."
	icon_state = "gags_cape"
	greyscale_config = /datum/greyscale_config/cloak/cape
	greyscale_config_worn = /datum/greyscale_config/cloak/cape/worn
	greyscale_colors = "#8c8c8c#8c8c8c#8c8c8c#8c8c8c"
	body_parts_covered = CHEST|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	heat_protection = CHEST

/obj/item/clothing/neck/cape/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_clothes, "gags_cape_t")

/obj/item/clothing/neck/robes
	name = "Robes"
	desc = "comfortable robes, which lie softly along your back."
	icon_state = "gags_robes"
	greyscale_config = /datum/greyscale_config/cloak/robes
	greyscale_config_worn = /datum/greyscale_config/cloak/robes/worn
	greyscale_colors = "abd0e0"
	body_parts_covered = CHEST|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	heat_protection = CHEST

/obj/item/clothing/neck/wide_cape
	name = "Wide cape"
	desc = "A proud, broad-shouldered cloak with which you can protect the honor of your back."
	icon_state = "gags_wide_cape"
	greyscale_config = /datum/greyscale_config/cloak/wide_cape
	greyscale_config_worn = /datum/greyscale_config/cloak/wide_cape/worn
	greyscale_colors = "#a7bacb#64889f#ffffff"
	body_parts_covered = CHEST|ARMS
	flags_1 = IS_PLAYER_COLORABLE_1
	heat_protection = CHEST
