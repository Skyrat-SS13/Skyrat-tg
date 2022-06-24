/obj/item/clothing/under/rank/civilian
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian_digi.dmi' //Anything that was in TG's civilian.dmi, should be in our civilian_digi.dmi

/obj/item/clothing/under/suit
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/suits_digi.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/beige	//Some FOOL upstream has this item's worn and object icons seperate. This sucks.
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/suits_digi.dmi'

//TG's files separate this into Civilian, Clown/Mime, and Curator. We wont have as many, so all Service goes into this file.
//No, it will not be called Service.dm, because its merged with Suit.dm too. Its for Civilians, period.

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE //Just gonna set it to default for ease

/obj/item/clothing/under/suit/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/suits.dmi'

//DO NOT ADD A /obj/item/clothing/under/rank/civilian/lawyer/skyrat. USE /obj/item/clothing/under/suit/skyrat FOR MODULAR SUITS.

/*
*	HEAD OF PERSONNEL
*/

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/imperial //Rank pins of the Grand Moff
	name = "head of personnel's naval jumpsuit"
	desc = "A pale green naval suit and a rank badge denoting the Personnel Officer. Target, maximum firepower."
	icon_state = "imphop"
	inhand_icon_state = "g_suit"
	supports_variations_flags = NONE

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/parade
	name = "head of personnel's male formal uniform"
	desc = "A luxurious uniform for the head of personnel, woven in a deep blue. On the lapel is a small pin in the shape of a corgi's head."
	icon_state = "hop_parade_male"
	inhand_icon_state = "hop_parade_male"

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/parade/female
	name = "head of personnel's female formal uniform"
	icon_state = "hop_parade_female"

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck
	name = "head of personnel's turtleneck"
	desc = "A soft blue turtleneck and black khakis worn by Executives who prefer a bit more comfort over style."
	icon_state = "hopturtle"
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck/skirt
	name = "head of personnel's turtleneck skirt"
	desc = "A soft blue turtleneck and black skirt worn by Executives who prefer a bit more comfort over style."
	icon_state = "hopturtle_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/*
*	SUITS
*/

/obj/item/clothing/under/suit/skyrat/pencil
	name = "black pencilskirt"
	desc = "A clean white shirt with a tight-fitting black pencilskirt."
	icon_state = "black_pencil"

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
