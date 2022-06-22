/obj/item/clothing/under/rank/civilian
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian_digi.dmi' //Anything that was in TG's civilian.dmi, should be in our civilian_digi.dmi

//TG's files separate this into Civilian, Clown/Mime, and Curator. We wont have as many, so all Service goes into this file.
//No, it will not be called Service.dm, its meant to be almost identical to TG, minus the cases with single-item files.

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'
	can_adjust = FALSE //Just gonna set it to default for ease

/obj/item/clothing/under/rank/civilian/lawyer/skyrat	//Why do we have so many of these
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/civilian.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/civilian.dmi'

/*
*	HEAD OF PERSONNEL
*/

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/imperial //Rank pins of the Grand Moff
	name = "head of personnel's naval jumpsuit"
	desc = "A pale green naval suit and a rank badge denoting the Personnel Officer. Target, maximum firepower."
	icon_state = "imphop"
	inhand_icon_state = "g_suit"

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
	desc = "A dark teal turtleneck and black khakis, for a second with a superior sense of style."
	icon_state = "hopturtle"
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/civilian/head_of_personnel/skyrat/turtleneck/skirt
	name = "head of personnel's turtleneck skirt"
	desc = "A dark teal turtleneck and tanblack khaki skirt, for a second with a superior sense of style."
	icon_state = "hopturtle_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/*
*	NO MODULAR LAWYER ADDITIONS!
*	ALL "LAWYER" SUITS WILL SIMPLY BE SUITS. PUT THEM INTO (uniform)SUITS.DM.
*/

/obj/item/clothing/under/rank/civilian/lawyer/grey/skirtybaby
	desc = "A white shirt with a grey pancilskirt."
	name = "grey suit skirt"
	icon_state = "detective_skirty"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/black/skirtybaby
	desc = "A white shirt with a dark pancilskirt."
	name = "black suit skirt"
	icon_state = "internalaffairs_skirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/gentle/skirtybaby
	desc = "A black shirt with a grey pancilskirt."
	name = "gentle suit skirt"
	icon_state = "gentlesuit_skirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/red/skirtybaby
	desc = "A satin white shirt with a dark red pancilskirt."
	name = "burgundy suit skirt"
	icon_state = "burgundy_suit_skirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/tan/skirtybaby
	desc = "A satin white shirt with a tan pancilskirt."
	name = "tan suit skirt"
	icon_state = "tan_suit_skirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/blue/skirtybaby
	desc = "A satin white shirt with a light blue pancilskirt."
	name = "blue suit skirt"
	icon_state = "bluesuit_suit_skirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/green/skirtybaby
	desc = "A satin white shirt with a light green pancilskirt."
	name = "green suit skirt"
	icon_state = "greensuit_skirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'

/obj/item/clothing/under/rank/civilian/lawyer/inferno
	name = "inferno suit"
	desc = "Stylish enough to impress the devil."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
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

/obj/item/clothing/under/rank/civilian/lawyer/inferno/skirt
	name = "inferno suitskirt"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "modeus"
	obj_flags = UNIQUE_RENAME
	unique_reskin = list(
		"Lust" = "modeus",
		"Sloth" = "pande",
	)

/obj/item/clothing/under/rank/civilian/lawyer/inferno/beeze
	name = "designer inferno suit"
	desc = "A fancy tail-coated suit with a fluffy bow emblazoned on the chest, complete with an NT pin."
	icon_state = "beeze"
	obj_flags = null
	unique_reskin = null

/obj/item/clothing/under/suit/black/female/trousers //i swear this already existed, but whatever
	name = "feminine suit"
	desc = "Perfect for a secretary that does no work. This time with pants!"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "black_suit_fem"

/obj/item/clothing/under/suit/black/female/skirt
	name = "feminine skirt"
	desc = "Perfect for a secretary that does no work."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "black_suit_fem_skirt"


/obj/item/clothing/under/suit/helltaker
	name = "red shirt with white pants"
	desc = "No time. Busy gathering girls."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "helltaker"

/obj/item/clothing/under/suit/helltaker/skirt
	name = "red shirt with white skirt"
	desc = "No time. Busy gathering boys."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "helltakerskirt"

/obj/item/clothing/under/suit/white/scarface
	name = "cuban suit"
	desc = "A yayo coloured silk suit with a crimson shirt. You just know how to hide, how to lie. Me, I don't have that problem. Me, I always tell the truth. Even when I lie."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "scarface"
