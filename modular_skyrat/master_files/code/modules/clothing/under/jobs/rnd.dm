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
	can_adjust = FALSE

/obj/item/clothing/under/rank/rnd/scientist/skyrat/utility/syndicate
	desc = "A utility uniform worn by Science staff."
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 40) // Same stats as the tactical turtleneck.
	has_sensor = NO_SENSORS

/obj/item/clothing/under/rank/rnd/scientist/skyrat/hlscience
	name = "ridiculous scientist outfit"
	desc = "The tie is mandatory."
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
	inhand_icon_state = "purple_suit"
	can_adjust = TRUE
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/rnd/research_director/skyrat/jumpsuit/skirt // I know this seems wrong, but its for consistency sake; its the skirt version OF the jumpsuit
	name = "research director's jumpskirt"
	icon_state = "director_jumpskirt"
	body_parts_covered = CHEST|GROIN|ARMS
	dying_key = DYE_REGISTRY_JUMPSKIRT
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/*
*	OVERRIDES
*	Remind Orion to look over these when TG finishes their science resprites
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
