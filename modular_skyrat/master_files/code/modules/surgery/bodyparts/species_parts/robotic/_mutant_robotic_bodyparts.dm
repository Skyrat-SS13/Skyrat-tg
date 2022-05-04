// Synth bois!
/obj/item/bodypart/head/robot/mutant
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'
	limb_id = SPECIES_SYNTHMAMMAL
	is_dimorphic = TRUE
	should_draw_greyscale = TRUE
	uses_mutcolor = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC

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
	icon = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'
	icon_static = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	limb_id = "digitigrade"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE
	base_limb_id = SPECIES_SYNTHMAMMAL

/obj/item/bodypart/l_leg/robot/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	check_mutant_compatability()

/obj/item/bodypart/r_leg/robot/digitigrade
	icon = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'
	icon_static = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'
	icon_greyscale = 'modular_skyrat/master_files/icons/mob/species/synthmammal_parts_greyscale.dmi'
	uses_mutcolor = TRUE
	should_draw_greyscale = TRUE
	limb_id = "digitigrade"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE
	base_limb_id = SPECIES_SYNTHMAMMAL

/obj/item/bodypart/r_leg/robot/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	check_mutant_compatability()
