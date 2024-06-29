/obj/item/bodypart/leg/right/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	bodypart_flags = BODYPART_UNREMOVABLE
	can_be_surgically_removed = FALSE
	bodyshape = parent_type::bodyshape | BODYSHAPE_TAUR

/obj/item/bodypart/leg/right/taur/generate_icon_key()
	RETURN_TYPE(/list)
	// We don't want more than one icon for all of the taur legs, because they're going to be invisible.
	return list("taur")

/obj/item/bodypart/leg/left/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	bodypart_flags = BODYPART_UNREMOVABLE
	can_be_surgically_removed = FALSE
	bodyshape = parent_type::bodyshape | BODYSHAPE_TAUR

/obj/item/bodypart/leg/left/taur/generate_icon_key()
	RETURN_TYPE(/list)
	// We don't want more than one icon for all of the taur legs, because they're going to be invisible.
	return list("taur")

/obj/item/bodypart/leg/right/robot/synth/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	bodypart_flags = parent_type::bodypart_flags | BODYPART_UNREMOVABLE
	can_be_surgically_removed = FALSE
	bodyshape = parent_type::bodyshape | BODYSHAPE_TAUR
	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT)

/obj/item/bodypart/leg/right/robot/synth/taur/generate_icon_key()
	RETURN_TYPE(/list)
	// We don't want more than one icon for all of the taur legs, because they're going to be invisible.
	return list("taur")

/obj/item/bodypart/leg/left/robot/synth/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	bodypart_flags = parent_type::bodypart_flags | BODYPART_UNREMOVABLE
	can_be_surgically_removed = FALSE
	bodyshape = parent_type::bodyshape | BODYSHAPE_TAUR
	damage_examines = list(BRUTE = ROBOTIC_BRUTE_EXAMINE_TEXT, BURN = ROBOTIC_BURN_EXAMINE_TEXT)

/obj/item/bodypart/leg/left/robot/synth/taur/generate_icon_key()
	RETURN_TYPE(/list)
	// We don't want more than one icon for all of the taur legs, because they're going to be invisible.
	return list("taur")
