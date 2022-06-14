/**
 * # Ninja Mask
 *
 * Space ninja's mask.  Other than looking cool, doesn't do anything.
 *
 * A mask which only spawns as a part of space ninja's starting kit.  Functions as a gas mask.
 *
 */
/obj/item/clothing/mask/gas/ninja
	name = "ninja mask"
	desc = "A close-fitting nano-enhanced mask that acts both as an air filter and a post-modern fashion statement."
	icon_state = "ninja"
	strip_delay = 12 SECONDS
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH | PEPPERPROOF
	has_fov = FALSE

/obj/item/clothing/under/syndicate/ninja
	name = "ninja suit"
	desc = "A nano-enhanced jumpsuit designed for maximum comfort and tacticality."
	icon_state = "ninja_suit"
	strip_delay = 12 SECONDS
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	can_adjust = FALSE

// SKYRAT EDIT ADDITION - Use TG sprites for missing assets
/obj/item/clothing/under/syndicate/ninja/Initialize(mapload)
	. = ..()
	icon = 'icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'icons/mob/clothing/under/syndicate.dmi'
