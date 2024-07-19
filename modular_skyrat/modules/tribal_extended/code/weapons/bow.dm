/obj/item/gun/ballistic/bow/tribalbow
	icon = 'modular_skyrat/modules/tribal_extended/icons/projectile.dmi'
	lefthand_file = 'modular_skyrat/modules/tribal_extended/icons/bows_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/tribal_extended/icons/bows_righthand.dmi'
	worn_icon = 'modular_skyrat/modules/tribal_extended/icons/back.dmi'
	inhand_icon_state = "bow"
	icon_state = "bow_unloaded"
	base_icon_state = "bow"
	worn_icon_state = "bow"
	slot_flags = ITEM_SLOT_BACK
	projectile_damage_multiplier = 0.5
	force = 20

/obj/item/gun/ballistic/bow/tribalbow/update_icon()
	. = ..()
	icon_state = "[base_icon_state][drawn ? "_drawn" : ""]"

/obj/item/gun/ballistic/bow/tribalbow/update_overlays()
	. = ..()
	if(chambered)
		. += "[chambered.base_icon_state][drawn ? "_drawn" : ""]"


/obj/item/gun/ballistic/bow/tribalbow/ashen
	name = "bone bow"
	desc = "Some sort of primitive projectile weapon made of bone and wrapped sinew, oddly robust."
	icon = 'modular_skyrat/modules/tribal_extended/icons/projectile.dmi'
	icon_state = "ashenbow_unloaded"
	base_icon_state = "ashenbow"
	inhand_icon_state = "ashenbow"
	worn_icon_state = "ashenbow"

/obj/item/gun/ballistic/bow/tribalbow/pipe
	name = "pipe bow"
	desc = "Portable and sleek, but you'd be better off hitting someone with a pool noodle."
	icon = 'modular_skyrat/modules/tribal_extended/icons/projectile.dmi'
	icon_state = "pipebow_unloaded"
	base_icon_state = "pipebow"
	inhand_icon_state = "pipebow"
	worn_icon_state = "pipebow"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_SUITSTORE
