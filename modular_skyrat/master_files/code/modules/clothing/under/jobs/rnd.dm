/obj/item/clothing/under/rank/rnd
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd_digi.dmi'	// Anything that was in the rnd.dmi, should be in the rnd_digi.dmi

/obj/item/clothing/under/rank/rnd/scientist/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/rnd.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd.dmi'

/obj/item/clothing/under/rank/rnd/roboticist/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/rnd.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd.dmi'

/obj/item/clothing/under/rank/rnd/research_director/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/rnd.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd.dmi'

// Add a 'rnd/geneticist/skyrat' if you make Geneticist uniforms

/*
*	SCIENTIST
*/

/obj/item/clothing/under/rank/rnd/scientist/skyrat/utility
	name = "science utility uniform"
	desc = "A utility uniform worn by NT-certified Science staff."
	icon_state = "util_sci"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION
	can_adjust = FALSE

/obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate
	desc = "A utility uniform worn by Science staff."
	armor_type = /datum/armor/clothing_under/utility_syndicate
	has_sensor = NO_SENSORS

/obj/item/clothing/under/rank/rnd/scientist/skyrat/hlscience
	name = "science team uniform"
	desc = "A simple semi-formal uniform consisting of a grayish-blue shirt and off-white slacks, paired with a ridiculous, but mandatory, tie."
	icon_state = "hl_scientist"
	can_adjust = FALSE

/*
*	ROBOTICIST
*/

/obj/item/clothing/under/rank/rnd/roboticist/skyrat/sleek
	name = "sleek roboticst jumpsuit"
	desc = "A sleek version of the roboticist uniform, complete with amber sci-fi stripes."
	icon_state = "robosleek"
	can_adjust = FALSE

/*
*	RESEARCH DIRECTOR
*/

/obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit
	name = "research director's jumpsuit"
	desc = "A shiny nano-weave uniform for those holding the title of \"Research Director\". Its fabric provides minor protection from biological contaminants."
	icon_state = "director_jumpsuit"
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit/skirt // I know this seems wrong, but its for consistency sake; its the skirt version OF the jumpsuit
	name = "research director's jumpskirt"
	icon_state = "director_jumpskirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/rank/rnd/research_director/skyrat/imperial //Rank pins of the Major General
	desc = "An off-white naval suit over black pants, with a rank badge denoting the Officer of the Internal Science Division. It's a peaceful life."
	name = "research director's naval jumpsuit"
	icon_state = "imprd"

/*
*	OVERRIDES
*	ORION TODO: look over these when TG finishes their science resprites (any day now...)
*/

/obj/item/clothing/under/rank/rnd/scientist
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/rnd.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd.dmi'
	icon_state = "science_new"

/obj/item/clothing/under/rank/rnd/scientist/skirt
	icon_state = "sciwhite_skirt_new"

/obj/item/clothing/under/rank/rnd/roboticist
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/rnd.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd.dmi'
	icon_state = "robotics_new"

/obj/item/clothing/under/rank/rnd/roboticist/skirt
	icon_state = "robotics_skirt_new"

/obj/item/clothing/under/rank/rnd/geneticist
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/rnd.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/rnd.dmi'
	icon_state = "genetics_new"

/obj/item/clothing/under/rank/rnd/geneticist/skirt
	icon_state = "geneticswhite_skirt_new"
