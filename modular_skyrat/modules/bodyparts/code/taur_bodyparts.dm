/obj/item/bodypart/leg/right/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	bodypart_flags = BODYPART_UNREMOVABLE
	can_be_surgically_removed = FALSE
	bodyshape = parent_type::bodyshape | BODYSHAPE_TAUR
	show_icon = FALSE

/obj/item/bodypart/leg/left/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	bodypart_flags = BODYPART_UNREMOVABLE
	can_be_surgically_removed = FALSE
	bodyshape = parent_type::bodyshape | BODYSHAPE_TAUR
	show_icon = FALSE

/obj/item/bodypart/leg/right/synth/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	bodypart_flags = parent_type::bodypart_flags | BODYPART_UNREMOVABLE
	can_be_surgically_removed = FALSE
	bodyshape = parent_type::bodyshape | BODYSHAPE_TAUR
	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT)
	show_icon = FALSE

/obj/item/bodypart/leg/left/synth/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	bodypart_flags = parent_type::bodypart_flags | BODYPART_UNREMOVABLE
	can_be_surgically_removed = FALSE
	bodyshape = parent_type::bodyshape | BODYSHAPE_TAUR
	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT)
	show_icon = FALSE
