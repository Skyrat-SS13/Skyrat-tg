/obj/item/clothing/under/rank/security
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/security_digi.dmi' // Anything that was in the security.dmi, should be in the security_digi.dmi

/obj/item/clothing/under/rank/security/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'

/obj/item/clothing/under/rank/security/head_of_security/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'

//DEBATE MOVING *ALL* SECURITY STUFF HERE? Even overrides, at least as a like, sub-file?

/*
*	SECURITY OFFICER
*/

/obj/item/clothing/under/rank/security/skyrat/utility
	name = "security utility uniform"
	desc = "A utility uniform worn by Lopland-certified Security officers."
	icon_state = "util_sec"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/skyrat/utility/redsec
	desc = "A utility uniform worn by trained Security officers."
	icon_state = "util_sec_old"
	can_adjust = FALSE

/obj/item/clothing/under/rank/security/skyrat/utility/redsec/syndicate //MOVE ALL /SYNDICATES TO THE SYNDICATE.DM WHEN THE .dmi IS MADE (soon, after centcom.dmi)
	armor_type = /datum/armor/redsec_syndicate
	has_sensor = NO_SENSORS

/*
*	HEAD OF SECURITY
*/

/datum/armor/redsec_syndicate
	melee = 10
	fire = 50
	acid = 40

/obj/item/clothing/under/rank/security/head_of_security/skyrat/imperial //Rank pins of the Grand General
	desc = "A tar black naval suit and a rank badge denoting the Officer of The Internal Security Division. Be careful your underlings don't bump their head on a door."
	name = "head of security's naval jumpsuit"
	icon_state = "imphos"
