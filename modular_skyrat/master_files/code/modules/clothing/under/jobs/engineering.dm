/obj/item/clothing/under/rank/engineering
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/engineering_digi.dmi' // Anything that was in the engineering.dmi, should be in the engineering_digi.dmi

/obj/item/clothing/under/rank/engineering/engineer/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/engineering.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/engineering.dmi'

// Add a /obj/item/clothing/under/rank/engineering/chief_engineer/skyrat or /obj/item/clothing/under/rank/engineering/atmospheric_technician/skyrat if you add uniforms for either

/*
*	ENGINEER
*/

/obj/item/clothing/under/rank/engineering/engineer/skyrat/utility
	name = "engineering utility uniform"
	desc = "A utility uniform worn by Engineering personnel."
	icon_state = "util_eng"
	can_adjust = FALSE
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 60, ACID = 20) // Same stats as default engineering jumpsuit

/obj/item/clothing/under/rank/engineering/engineer/skyrat/utility/syndicate
	armor = list(MELEE = 10, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 50, ACID = 40) // Same stats as the tactical turtleneck.
	has_sensor = NO_SENSORS

/obj/item/clothing/under/rank/engineering/engineer/skyrat/hazard_chem
	name = "chemical hazard jumpsuit"
	desc = "A high visibility jumpsuit with additional protection from gas and chemical hazards, at the cost of less fire-proofing."
	icon_state = "hazard_green"
	inhand_icon_state = "suit-green"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, FIRE = 20, ACID = 60)
	resistance_flags = ACID_PROOF
	alt_covers_chest = TRUE

/obj/item/clothing/under/rank/engineering/engineer/skyrat/hazard_chem/emt
	name = "chemical hazard EMT jumpsuit"
	desc = "An EMT jumpsuit used for first responders in situations involving gas and/or chemical hazards. The label reads, \"Not designed for prolonged exposure\"."
	icon_state = "hazard_white"
	inhand_icon_state = "suit-white"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 10, FIRE = 10, ACID = 50) // Worse stats than the proper chem-hazard uniform
