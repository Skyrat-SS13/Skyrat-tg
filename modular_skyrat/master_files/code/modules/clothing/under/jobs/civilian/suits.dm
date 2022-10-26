
/obj/item/clothing/under/suit
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/suits_digi.dmi' //Anything that was in TG's suits.dmi, should be in our suits_digi.dmi

/obj/item/clothing/under/suit/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/suits.dmi'

//DO NOT ADD A /obj/item/clothing/under/rank/civilian/lawyer/skyrat. USE /obj/item/clothing/under/suit/skyrat FOR MODULAR SUITS

/*
*	SUITS
*/

/obj/item/clothing/under/suit/skyrat/pencil
	name = "black pencilskirt"
	desc = "A clean white shirt with a tight-fitting black pencilskirt."
	icon_state = "black_pencil"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/suit/skyrat/pencil/black_really
	name = "executive pencilskirt"
	desc = "A sleek suit with a tight-fitting black pencilskirt."
	icon_state = "really_black_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/charcoal
	name = "charcoal pencilskirt"
	desc = "A clean white shirt with a tight-fitting charcoal pencilskirt."
	icon_state = "charcoal_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/navy
	name = "navy pencilskirt"
	desc = "A clean white shirt with a tight-fitting navy-blue pencilskirt."
	icon_state = "navy_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/burgandy
	name = "burgandy pencilskirt"
	desc = "A clean white shirt with a tight-fitting burgandy-red pencilskirt."
	icon_state = "burgandy_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/checkered
	name = "checkered pencilskirt"
	desc = "A clean white shirt with a tight-fitting grey checkered pencilskirt."
	icon_state = "checkered_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/tan
	name = "tan pencilskirt"
	desc = "A clean white shirt with a tight-fitting tan pencilskirt."
	icon_state = "tan_pencil"

/obj/item/clothing/under/suit/skyrat/pencil/green
	name = "green pencilskirt"
	desc = "A clean white shirt with a tight-fitting green pencilskirt."
	icon_state = "green_pencil"

/obj/item/clothing/under/suit/skyrat/scarface
	name = "cuban suit"
	desc = "A yayo coloured silk suit with a crimson shirt. You just know how to hide, how to lie. Me, I don't have that problem. Me, I always tell the truth. Even when I lie."
	icon_state = "scarface"

/obj/item/clothing/under/suit/skyrat/black_really_collared
	name = "wide-collared executive suit"
	desc = "A formal black suit with the collar worn wide, intended for the station's finest."
	icon_state = "really_black_suit_collar"

/obj/item/clothing/under/suit/skyrat/black_really_collared/skirt
	name = "wide-collared executive suitskirt"
	desc = "A formal black suit with the collar worn wide, intended for the station's finest."
	icon_state = "really_black_suit_skirt_collar"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY|FEMALE_UNIFORM_NO_BREASTS
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	gets_cropped_on_taurs = FALSE

/obj/item/clothing/under/suit/skyrat/inferno
	name = "inferno suit"
	desc = "Stylish enough to impress the devil."
	icon_state = "lucifer"
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	obj_flags = UNIQUE_RENAME
	unique_reskin = list(
		"Pride" = "lucifer",
		"Wrath" = "justice",
		"Gluttony" = "malina",
		"Envy" = "zdara",
		"Vanity" = "cereberus",
	)

/obj/item/clothing/under/suit/skyrat/inferno/skirt
	name = "inferno suitskirt"
	icon_state = "modeus"
	obj_flags = UNIQUE_RENAME
	unique_reskin = list(
		"Lust" = "modeus",
		"Sloth" = "pande",
	)

/obj/item/clothing/under/suit/skyrat/inferno/beeze
	name = "designer inferno suit"
	desc = "A fancy tail-coated suit with a fluffy bow emblazoned on the chest, complete with an NT pin."
	icon_state = "beeze"
	obj_flags = null
	unique_reskin = null

/obj/item/clothing/under/suit/skyrat/helltaker
	name = "red shirt with white pants"
	desc = "No time. Busy gathering girls."
	icon_state = "helltaker"

/obj/item/clothing/under/suit/skyrat/helltaker/skirt
	name = "red shirt with white skirt"
	desc = "No time. Busy gathering boys."
	icon_state = "helltakerskirt"
