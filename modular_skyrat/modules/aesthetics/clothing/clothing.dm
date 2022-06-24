/*
*	UNIFORMS
*/

/obj/item/clothing/under/rank/civilian/chef/skirt
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'

/obj/item/clothing/under/rank/civilian/bartender/skirt
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'

/obj/item/clothing/under/rank/civilian/chef
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'

/obj/item/clothing/under/rank/civilian/bartender
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/bluesuit
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'


/*
*	SUITS
*/

/obj/item/clothing/suit/bio_suit/general
	worn_icon = 'modular_skyrat/modules/aesthetics/clothing/suit.dmi'

/obj/item/clothing/suit/bio_suit/security
	worn_icon = 'modular_skyrat/modules/aesthetics/clothing/suit.dmi'

/obj/item/clothing/suit/bio_suit/cmo
	worn_icon = 'modular_skyrat/modules/aesthetics/clothing/suit.dmi'

/obj/item/clothing/suit/bio_suit/scientist
	worn_icon = 'modular_skyrat/modules/aesthetics/clothing/suit.dmi'

/obj/item/clothing/suit/bio_suit/janitor
	worn_icon = 'modular_skyrat/modules/aesthetics/clothing/suit.dmi'

/obj/item/clothing/suit/bio_suit/virology
	worn_icon = 'modular_skyrat/modules/aesthetics/clothing/suit.dmi'

/obj/item/clothing/suit/toggle/labcoat
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'

/obj/item/clothing/suit/toggle/labcoat/cmo
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'

/obj/item/clothing/suit/toggle/labcoat/paramedic
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	icon_state = "labcoat_emt"

/obj/item/clothing/suit/toggle/labcoat/mad
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'

/obj/item/clothing/suit/toggle/labcoat/genetics
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'

/obj/item/clothing/suit/toggle/labcoat/chemist
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'

/obj/item/clothing/suit/toggle/labcoat/virologist
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'

/obj/item/clothing/suit/toggle/labcoat/science
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'

/obj/item/clothing/suit/toggle/labcoat/rd
	name = "research directors labcoat"
	desc = "A Nanotrasen standard labcoat for Research Directors. It has extra layers for more protection."
	icon = 'modular_skyrat/modules/aesthetics/clothing/items.dmi'
	worn_icon = 'modular_skyrat/modules/aesthetics/clothing/suit.dmi'
	icon_state = "labcoat_rd"
	body_parts_covered = CHEST|ARMS|LEGS
	armor = list(MELEE = 5, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 80, FIRE = 80, ACID = 70)
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/*
*	HEAD
*/

/obj/item/clothing/head/bio_hood/general
	worn_icon = 'modular_skyrat/modules/aesthetics/clothing/head.dmi'

/obj/item/clothing/head/bio_hood/security
	worn_icon = 'modular_skyrat/modules/aesthetics/clothing/head.dmi'

/obj/item/clothing/head/bio_hood/cmo
	worn_icon = 'modular_skyrat/modules/aesthetics/clothing/head.dmi'

/obj/item/clothing/head/bio_hood/scientist
	worn_icon = 'modular_skyrat/modules/aesthetics/clothing/head.dmi'

/obj/item/clothing/head/bio_hood/janitor
	worn_icon = 'modular_skyrat/modules/aesthetics/clothing/head.dmi'

/obj/item/clothing/head/bio_hood/virology
	worn_icon = 'modular_skyrat/modules/aesthetics/clothing/head.dmi'

/obj/item/clothing/head/weddingveil
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'

/obj/item/clothing/head/pelt
	name = "Bear pelt"
	desc = "A luxurious bear pelt, good to keep warm in winter. Or to sleep through winter."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "bearpelt_brown"
	inhand_icon_state = "bearpelt_brown"

/obj/item/clothing/head/pelt/black
	icon_state = "bearpelt_black"
	inhand_icon_state = "bearpelt_black"

/obj/item/clothing/head/pelt/wolfpelt
	name = "Wolf pelt"
	desc = "A fuzzy wolf pelt, demanding respect as a hunter, well if it isn't synthetic or anything at least. Or bought, for all the glory but none of the credit."
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/pelt_big.dmi'
	icon_state = "wolfpelt_brown"
	inhand_icon_state = "wolfpelt_brown"

/obj/item/clothing/head/pelt/wolfpeltblack
	name = "Wolf pelt"
	desc = "A fuzzy wolf pelt, demanding respect as a hunter, well if it isn't synthetic or anything at least. Or bought, for all the glory but none of the credit."
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/pelt_big.dmi'
	icon_state = "wolfpelt_gray"
	inhand_icon_state = "wolfpelt_gray"

/obj/item/clothing/head/pelt/tigerpelt
	name = "Shiny tiger pelt"
	desc = "A vibrant tiger pelt, particularly fabulous."
	icon_state = "tigerpelt_shiny"
	inhand_icon_state = "tigerpelt_shiny"

/obj/item/clothing/head/pelt/tigerpeltsnow
	name = "Snow tiger pelt"
	desc = "A pelt of a less vibrant tiger, but rather warm."
	icon_state = "tigerpelt_snow"
	inhand_icon_state = "tigerpelt_snow"

/obj/item/clothing/head/pelt/tigerpeltpink
	name = "Pink tiger pelt"
	desc = "A particularly vibrant tiger pelt, for those who want to be the most fabulous at parties."
	icon_state = "tigerpelt_pink"
	inhand_icon_state = "tigerpelt_pink"

/*
*	TURTLENECKS
*/

/obj/item/clothing/under/syndicate
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'

/obj/item/clothing/under/syndicate/sniper
	icon = 'icons/obj/clothing/under/syndicate.dmi'
	worn_icon = 'icons/mob/clothing/under/syndicate.dmi'

/*
*	SHOES
*/

/obj/item/clothing/shoes/workboots/old
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	icon_state = "workbootsold"
