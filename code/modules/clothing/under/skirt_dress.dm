/obj/item/clothing/under/dress
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	can_adjust = FALSE
	body_parts_covered = CHEST|GROIN
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	icon = 'icons/obj/clothing/under/dress.dmi'
	worn_icon = 'icons/mob/clothing/under/dress.dmi'

/obj/item/clothing/under/dress/striped/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/gags_recolorable)
	update_icon(UPDATE_OVERLAYS)

/obj/item/clothing/under/dress/striped
	name = "striped dress"
	desc = "Fashion in space."
	icon_state = "stripeddress"
	inhand_icon_state = null
	female_sprite_flags = FEMALE_UNIFORM_FULL
	greyscale_config = /datum/greyscale_config/striped_dress
	greyscale_config_worn = /datum/greyscale_config/striped_dress/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#003284#000000#ffffff"

/obj/item/clothing/under/dress/sailor
	name = "sailor dress"
	desc = "Formal wear for a leading lady."
	icon_state = "sailor_dress"
	greyscale_config = /datum/greyscale_config/sailor_dress
	greyscale_config_worn = /datum/greyscale_config/sailor_dress/worn
	greyscale_colors = "#0000ff#cc0000#eaeaea"
	inhand_icon_state = "blackskirt"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/wedding_dress
	name = "wedding dress"
	desc = "A luxurious gown for once-in-a-lifetime occasions."
	icon_state = "wedding_dress"
	inhand_icon_state = null
	body_parts_covered = CHEST|GROIN|LEGS
	flags_inv = HIDESHOES

/obj/item/clothing/under/dress/eveninggown
	name = "evening gown"
	desc = "Fancy dress for space bar singers."
	icon_state = "evening_gown"
	inhand_icon_state = null
	greyscale_config = /datum/greyscale_config/evening_dress
	greyscale_config_worn = /datum/greyscale_config/evening_dress/worn
	flags_1 = IS_PLAYER_COLORABLE_1
	greyscale_colors = "#e11f1f"

/obj/item/clothing/under/dress/skirt
	name = "cardigan skirt"
	desc = "A nice skirt with a cute cardigan, very fancy!"
	icon_state = "cardiganskirt"
	greyscale_config = /datum/greyscale_config/cardiganskirt
	greyscale_config_worn = /datum/greyscale_config/cardiganskirt/worn
	greyscale_colors = "#bf504d#545454"
	inhand_icon_state = "blackskirt"
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/skirt/plaid
	name = "plaid skirt"
	desc = "A preppy plaid skirt with a white blouse."
	icon_state = "plaidskirt"
	can_adjust = TRUE
	alt_covers_chest = TRUE
	custom_price = PAYCHECK_CREW
	greyscale_colors = "#CC2102"
	greyscale_config = /datum/greyscale_config/plaidskirt
	greyscale_config_worn = /datum/greyscale_config/plaidskirt/worn
	greyscale_config_worn_digi = /datum/greyscale_config/plaidskirt/worn/digi //SKYRAT EDIT ADDITION - DigiGreyscale
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/skirt/turtleskirt
	name = "turtleneck skirt"
	desc = "A casual turtleneck skirt."
	icon_state = "turtleskirt"
	custom_price = PAYCHECK_CREW
	greyscale_colors = "#cc0000#5f5f5f"
	greyscale_config = /datum/greyscale_config/turtleskirt
	greyscale_config_worn = /datum/greyscale_config/turtleskirt/worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/tango
	name = "tango dress"
	desc = "Filled with Latin fire."
	icon_state = "tango"
	custom_price = PAYCHECK_CREW
	greyscale_colors = "#ff0000#1c1c1c"
	greyscale_config = /datum/greyscale_config/tango
	greyscale_config_worn = /datum/greyscale_config/tango/worn
	flags_1 = IS_PLAYER_COLORABLE_1

/obj/item/clothing/under/dress/sundress
	name = "sundress"
	desc = "Makes you want to frolic in a field of daisies."
	icon_state = "sundress"
	custom_price = PAYCHECK_CREW
	greyscale_colors = "#FFE60F#9194A5#1F243C"
	greyscale_config = /datum/greyscale_config/sundress
	greyscale_config_worn = /datum/greyscale_config/sundress/worn
	flags_1 = IS_PLAYER_COLORABLE_1
