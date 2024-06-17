/obj/item/bodypart
	/// A list of all of our bodypart markings.
	var/list/markings
	/// A list of all our aux zone markings(hands)
	var/list/aux_zone_markings
	/// The alpha override of our markings.
	var/markings_alpha
	/// What is our normal limb ID? used for squashing legs.
	var/base_limb_id = SPECIES_MAMMAL

/obj/item/bodypart/proc/check_mutant_compatability()
	return

/obj/item/bodypart/leg/right
	/// This is used in digitigrade legs, when this leg is swapped out with the digitigrade version.
	var/digitigrade_type = /obj/item/bodypart/leg/right/digitigrade

/obj/item/bodypart/leg/left
	/// This is used in digitigrade legs, when this leg is swapped out with the digitigrade version.
	var/digitigrade_type = /obj/item/bodypart/leg/left/digitigrade


/// General mutant bodyparts. Used in most mutant species.
/obj/item/bodypart/head/mutant
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = SPECIES_MAMMAL
	head_flags = HEAD_ALL_FEATURES

/obj/item/bodypart/chest/mutant
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = SPECIES_MAMMAL
	is_dimorphic = TRUE

/obj/item/bodypart/chest/mutant/get_butt_sprite()
	return icon('modular_skyrat/master_files/icons/mob/butts.dmi', BUTT_SPRITE_VULP)

/obj/item/bodypart/arm/left/mutant
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = SPECIES_MAMMAL
	unarmed_attack_verbs = list("slash")
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/weapons/slashmiss.ogg'


/obj/item/bodypart/arm/right/mutant
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = SPECIES_MAMMAL
	unarmed_attack_verbs = list("slash")
	unarmed_attack_effect = ATTACK_EFFECT_CLAW
	unarmed_attack_sound = 'sound/weapons/slash.ogg'
	unarmed_miss_sound = 'sound/weapons/slashmiss.ogg'


/obj/item/bodypart/leg/left/mutant
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = SPECIES_MAMMAL

/obj/item/bodypart/leg/right/mutant
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = SPECIES_MAMMAL

/obj/item/bodypart/leg/left/digitigrade
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = "digitigrade"
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	base_limb_id = "digitigrade"

/obj/item/bodypart/leg/left/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	check_mutant_compatability()

/obj/item/bodypart/leg/right/digitigrade
	icon_greyscale = BODYPART_ICON_MAMMAL
	limb_id = "digitigrade"
	bodyshape = parent_type::bodyshape | BODYSHAPE_DIGITIGRADE
	base_limb_id = "digitigrade"

/obj/item/bodypart/leg/right/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	check_mutant_compatability()
