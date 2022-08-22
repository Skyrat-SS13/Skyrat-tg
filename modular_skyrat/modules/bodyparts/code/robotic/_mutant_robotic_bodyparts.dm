// Synth bois!
/obj/item/bodypart/head/robot/mutant
	icon_greyscale = BODYPART_ICON_SYNTHMAMMAL
	limb_id = SPECIES_SYNTHMAMMAL
	is_dimorphic = TRUE
	should_draw_greyscale = TRUE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/chest/robot/mutant
	icon_greyscale = BODYPART_ICON_SYNTHMAMMAL
	should_draw_greyscale = TRUE
	limb_id = SPECIES_SYNTHMAMMAL
	is_dimorphic = TRUE
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/l_arm/robot/mutant
	icon_greyscale = BODYPART_ICON_SYNTHMAMMAL
	limb_id = SPECIES_SYNTHMAMMAL
	should_draw_greyscale = TRUE
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/r_arm/robot/mutant
	icon_greyscale = BODYPART_ICON_SYNTHMAMMAL
	limb_id = SPECIES_SYNTHMAMMAL
	should_draw_greyscale = TRUE
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/l_leg/robot/mutant
	icon_greyscale = BODYPART_ICON_SYNTHMAMMAL
	limb_id = SPECIES_SYNTHMAMMAL
	should_draw_greyscale = TRUE
	digitigrade_type = /obj/item/bodypart/l_leg/robot/digitigrade
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/r_leg/robot/mutant
	icon_greyscale = BODYPART_ICON_SYNTHMAMMAL
	should_draw_greyscale = TRUE
	limb_id = SPECIES_SYNTHMAMMAL
	digitigrade_type = /obj/item/bodypart/r_leg/robot/digitigrade
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/l_leg/robot/digitigrade
	icon = BODYPART_ICON_SYNTHMAMMAL
	icon_static = BODYPART_ICON_SYNTHMAMMAL
	icon_greyscale = BODYPART_ICON_SYNTHMAMMAL
	should_draw_greyscale = TRUE
	limb_id = "digitigrade"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE
	base_limb_id = SPECIES_SYNTHMAMMAL
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/l_leg/robot/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	check_mutant_compatability()

/obj/item/bodypart/r_leg/robot/digitigrade
	icon = BODYPART_ICON_SYNTHMAMMAL
	icon_static = BODYPART_ICON_SYNTHMAMMAL
	icon_greyscale = BODYPART_ICON_SYNTHMAMMAL
	should_draw_greyscale = TRUE
	limb_id = "digitigrade"
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ROBOTIC | BODYTYPE_DIGITIGRADE
	base_limb_id = SPECIES_SYNTHMAMMAL
	brute_reduction = 0
	burn_reduction = 0

/obj/item/bodypart/r_leg/robot/digitigrade/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	. = ..()
	check_mutant_compatability()
