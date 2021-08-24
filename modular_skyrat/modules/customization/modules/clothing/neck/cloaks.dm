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
	mutant_variants = NONE
	heat_protection = CHEST

/obj/item/clothing/neck/cowboylea/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/toggle_clothes, "cowboy_poncho_t")

/obj/item/clothing/neck/ponchoranger
	name = "brown cowboy ponch"
	desc = "Aim for the Heart, Ramon."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "ranger_cloak"
	mutant_variants = NONE
	heat_protection = CHEST

/obj/item/clothing/neck/ponchoranger/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/toggle_clothes, "ranger_cloak_t")
