
/obj/item/debug_item_overlays
	name = "debug item"
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/tails.dmi'
	icon_state = "m_waggingtail_catbig_BEHIND"

/obj/item/debug_item_overlays/attack_self(mob/user, modifiers)
	var/static/icon/mask = icon('modular_skyrat/master_files/icons/mob/sprite_accessory/test.dmi', "fill")
	add_filter("fill", 1, alpha_mask_filter(icon = mask, flags = MASK_SWAP))
