// Synth bois!
/obj/item/bodypart/head/robot/mutant
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'
	limb_id = SPECIES_SYNTHMAMMAL
	should_draw_greyscale = TRUE
	uses_mutcolor = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_SNOUTED //This is temporary. Ideally the "snout" external organ adds to this.

/obj/item/bodypart/chest/robot/mutant
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	limb_id = SPECIES_SYNTHMAMMAL
	is_dimorphic = TRUE

/obj/item/bodypart/l_arm/robot/mutant
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'
	limb_id = SPECIES_SYNTHMAMMAL
	should_draw_greyscale = TRUE

/obj/item/bodypart/r_arm/robot/mutant
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'
	limb_id = SPECIES_SYNTHMAMMAL
	should_draw_greyscale = TRUE

/obj/item/bodypart/l_leg/robot/mutant
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'
	limb_id = SPECIES_SYNTHMAMMAL
	should_draw_greyscale = TRUE
	digitigrade_type = /obj/item/bodypart/l_leg/robot/digitigrade

/obj/item/bodypart/r_leg/robot/mutant
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	limb_id = SPECIES_SYNTHMAMMAL
	digitigrade_type = /obj/item/bodypart/r_leg/robot/digitigrade

/obj/item/bodypart/l_leg/robot/digitigrade
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	limb_id = "digitigrade"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE
	/// What is our normal limb ID? used for squashing legs.
	var/base_limb_id = SPECIES_SYNTHMAMMAL

/obj/item/bodypart/l_leg/robot/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
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

/obj/item/bodypart/r_leg/robot/digitigrade
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/synthliz_parts_greyscale.dmi'
	uses_mutcolor = TRUE
	limb_id = "digitigrade"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE
	/// What is our normal limb ID? used for squashing legs.
	var/base_limb_id = SPECIES_SYNTHMAMMAL

/obj/item/bodypart/r_leg/robot/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
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
