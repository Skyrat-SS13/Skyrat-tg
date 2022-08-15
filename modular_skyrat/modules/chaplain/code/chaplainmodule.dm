// FILE FOR CHAPLAIN RELATED SKYRAT CODE

// Nun outfit
/obj/item/clothing/head/nun
	name = "nun headdress"
	desc = "A cloth headpiece that covers the hair and ears. The iconic uniform of nuns across the galaxy."
	icon = 'modular_skyrat/modules/chaplain/icons/nun.dmi'
	worn_icon = 'modular_skyrat/modules/chaplain/icons/nunmob.dmi'
	icon_state = "nun_head"
	inhand_icon_state = "cowboy_hat_black"
	flags_inv = HIDEHAIR | HIDEEARS

/obj/item/clothing/under/nunrobes
	name = "nun robes"
	desc = "Plain black robes in a feminine style, meant to display piety and turn thoughts away from sin."
	icon = 'modular_skyrat/modules/chaplain/icons/nun.dmi'
	worn_icon = 'modular_skyrat/modules/chaplain/icons/nunmob.dmi'
	icon_state = "nun"
	inhand_icon_state = "judge"
	body_parts_covered = CHEST|GROIN|ARMS
	alternate_worn_layer = GLOVES_LAYER // since the sleeves cover a part of the hands, this way gloves still covers it up.
	can_adjust = FALSE
	female_sprite_flags = NO_FEMALE_UNIFORM
