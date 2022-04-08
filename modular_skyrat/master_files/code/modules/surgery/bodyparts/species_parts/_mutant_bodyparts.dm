/obj/item/bodypart
	/// A list of all of our bodypart markings. NOT IN USE YET.
	var/list/bodypart_markings

/obj/item/bodypart/r_leg
	/// This is used in digitigrade legs, when this leg is swapped out with the digitigrade version.
	var/digitigrade_type = /obj/item/bodypart/r_leg/digitigrade

/obj/item/bodypart/l_leg
	/// This is used in digitigrade legs, when this leg is swapped out with the digitigrade version.
	var/digitigrade_type = /obj/item/bodypart/l_leg/digitigrade


/// General mutant bodyparts. Used in most mutant species.
/obj/item/bodypart/head/mutant
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/mammal_parts_greyscale.dmi'
	limb_id = SPECIES_MAMMAL
	uses_mutcolor = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_SNOUTED //This is temporary. Ideally the "snout" external organ adds to this.

/obj/item/bodypart/chest/mutant
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/mammal_parts_greyscale.dmi'
	uses_mutcolor = TRUE
	limb_id = SPECIES_MAMMAL
	is_dimorphic = TRUE

/obj/item/bodypart/l_arm/mutant
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/mammal_parts_greyscale.dmi'
	uses_mutcolor = TRUE
	limb_id = SPECIES_MAMMAL

/obj/item/bodypart/r_arm/mutant
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/mammal_parts_greyscale.dmi'
	uses_mutcolor = TRUE
	limb_id = SPECIES_MAMMAL

/obj/item/bodypart/l_leg/mutant
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/mammal_parts_greyscale.dmi'
	uses_mutcolor = TRUE
	limb_id = SPECIES_MAMMAL

/obj/item/bodypart/r_leg/mutant
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/mammal_parts_greyscale.dmi'
	uses_mutcolor = TRUE
	limb_id = SPECIES_MAMMAL

/obj/item/bodypart/l_leg/digitigrade
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/mammal_parts_greyscale.dmi'
	uses_mutcolor = TRUE
	limb_id = "digitigrade"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_DIGITIGRADE
	/// What is our normal limb ID? used for squashing legs.
	var/base_limb_id = SPECIES_MAMMAL

/obj/item/bodypart/l_leg/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	if(ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		var/uniform_compatible = FALSE
		var/suit_compatible = FALSE
		if(!(human_owner.w_uniform) || (human_owner.w_uniform.supports_variations_flags & (CLOTHING_DIGITIGRADE_VARIATION|CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON))) //Checks uniform compatibility
			uniform_compatible = TRUE
		if((!human_owner.wear_suit) || (human_owner.wear_suit.supports_variations_flags & (CLOTHING_DIGITIGRADE_VARIATION|CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON)) || !(human_owner.wear_suit.body_parts_covered & LEGS)) //Checks suit compatability
			suit_compatible = TRUE

		if((uniform_compatible && suit_compatible) || (suit_compatible && human_owner.wear_suit?.flags_inv & HIDEJUMPSUIT)) //If the uniform is hidden, it doesnt matter if its compatible
			limb_id = "digitigrade"
		else
			limb_id = base_limb_id

/obj/item/bodypart/r_leg/digitigrade
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/mammal_parts_greyscale.dmi'
	uses_mutcolor = TRUE
	limb_id = "digitigrade"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_DIGITIGRADE
	/// What is our normal limb ID? used for squashing legs.
	var/base_limb_id = SPECIES_MAMMAL

/obj/item/bodypart/r_leg/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	if(ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		var/uniform_compatible = FALSE
		var/suit_compatible = FALSE
		if(!(human_owner.w_uniform) || (human_owner.w_uniform.supports_variations_flags & (CLOTHING_DIGITIGRADE_VARIATION|CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON))) //Checks uniform compatibility
			uniform_compatible = TRUE
		if((!human_owner.wear_suit) || (human_owner.wear_suit.supports_variations_flags & (CLOTHING_DIGITIGRADE_VARIATION|CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON)) || !(human_owner.wear_suit.body_parts_covered & LEGS)) //Checks suit compatability
			suit_compatible = TRUE

		if((uniform_compatible && suit_compatible) || (suit_compatible && human_owner.wear_suit?.flags_inv & HIDEJUMPSUIT)) //If the uniform is hidden, it doesnt matter if its compatible
			limb_id = "digitigrade"
		else
			limb_id = base_limb_id
