/obj/item/bodypart/r_leg/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	dismemberable = FALSE
	can_be_surgically_removed = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_TAUR


/obj/item/bodypart/r_leg/taur/generate_icon_key()
	RETURN_TYPE(/list)
	// We don't want more than one icon for all of the taur legs, because they're going to be invisible.
	return list("taur")


/obj/item/bodypart/l_leg/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	dismemberable = FALSE
	can_be_surgically_removed = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_TAUR


/obj/item/bodypart/l_leg/taur/generate_icon_key()
	RETURN_TYPE(/list)
	// We don't want more than one icon for all of the taur legs, because they're going to be invisible.
	return list("taur")
