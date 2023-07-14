//DO NOT ADD TO THIS FILE UNLESS THE SITUATION IS DIRE
//MISC FILES = UNSORTED FILES. EVEN TG HATES THIS ONE.

/obj/item/clothing/under/misc
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/under/misc_digi.dmi'

/obj/item/clothing/under/misc/skyrat
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/misc.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/misc.dmi'
	can_adjust = FALSE

/*
	Do we even bother sorting these? We don't want to use the file, it's for emergencies and in-betweens.
	Just... don't lose your stuff.
*/

/obj/item/clothing/under/misc/skyrat/gear_harness
	name = "gear harness"
	desc = "A simple, inconspicuous harness replacement for a jumpsuit."
	icon_state = "gear_harness"
	body_parts_covered = NONE
	attachment_slot_override = CHEST
	can_adjust = FALSE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/under/misc/skyrat/gear_harness/eve
	name = "collection of leaves"
	desc = "Three leaves, designed to cover the nipples and genetalia of the wearer. A foe so proud will first the weaker seek."
	icon_state = "eve"
	body_parts_covered = CHEST|GROIN

/obj/item/clothing/under/misc/skyrat/gear_harness/adam
	name = "leaf"
	desc = "A single leaf, designed to cover the genitalia of the wearer. Seek not temptation."
	icon_state = "adam"
	body_parts_covered = GROIN
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY

/obj/item/clothing/under/misc/skyrat/taccas
	name = "tacticasual uniform"
	desc = "A white wifebeater on top of some cargo pants. For when you need to carry various beers."
	icon_state = "tac_s"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/misc/skyrat/mechanic
	name = "mechanic's overalls"
	desc = "An old-fashioned pair of brown overalls, along with assorted pockets and belt-loops."
	icon_state = "mechanic"

/obj/item/clothing/under/misc/skyrat/utility
	name = "general utility uniform"
	desc = "A utility uniform worn by civilian-ranked crew."
	icon_state = "utility"
	body_parts_covered = CHEST|ARMS|GROIN|LEGS
	can_adjust = FALSE

/obj/item/clothing/under/misc/skyrat/utility/syndicate
	armor_type = /datum/armor/clothing_under/utility_syndicate
	has_sensor = NO_SENSORS

/datum/armor/clothing_under/utility_syndicate
	melee = 10
	fire = 50
	acid = 40
