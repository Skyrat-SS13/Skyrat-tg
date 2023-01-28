/obj/item/bodypart/leg/right/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	dismemberable = FALSE
	can_be_surgically_removed = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_TAUR


/obj/item/bodypart/leg/right/taur/generate_icon_key()
	RETURN_TYPE(/list)
	// We don't want more than one icon for all of the taur legs, because they're going to be invisible.
	return list("taur")


/obj/item/bodypart/leg/left/taur
	icon_greyscale = BODYPART_ICON_TAUR
	limb_id = LIMBS_TAUR
	dismemberable = FALSE
	can_be_surgically_removed = FALSE
	bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC | BODYTYPE_TAUR


/obj/item/bodypart/leg/left/taur/generate_icon_key()
	RETURN_TYPE(/list)
	// We don't want more than one icon for all of the taur legs, because they're going to be invisible.
	return list("taur")
