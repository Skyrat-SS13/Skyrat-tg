/obj/item/organ/external/taur_body
	name = "taur body"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_TAUR
	external_bodytypes = BODYTYPE_TAUR
	use_mob_sprite_as_obj_sprite = TRUE

	preference = "feature_taur"
	mutantpart_key = "taur"
	mutantpart_info = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	bodypart_overlay = /datum/bodypart_overlay/mutant/taur_body
	/// The mob's old right leg. Used if the person switches to this organ and then back, so they don't just, have no legs anymore. Can be null.
	var/obj/item/bodypart/leg/right/old_right_leg = null
	/// The mob's old left leg. Used if the person switches to this organ and then back, so they don't just, have no legs anymore. Can be null.
	var/obj/item/bodypart/leg/right/old_left_leg = null

/obj/item/organ/external/taur_body/synth
	organ_flags = ORGAN_ROBOTIC

/datum/bodypart_overlay/mutant/taur_body
	feature_key = "taur"
	layers = ALL_EXTERNAL_OVERLAYS | EXTERNAL_FRONT_UNDER_CLOTHES | EXTERNAL_FRONT_OVER
	color_source = ORGAN_COLOR_OVERRIDE


/datum/bodypart_overlay/mutant/taur_body/override_color(rgb_value)
	return draw_color


/datum/bodypart_overlay/mutant/taur_body/get_global_feature_list()
	return GLOB.sprite_accessories["taur"]


/obj/item/organ/external/taur_body/Insert(mob/living/carbon/reciever, special, drop_if_replaced)
	if(sprite_accessory_flags & SPRITE_ACCESSORY_HIDE_SHOES)
		external_bodytypes |= BODYTYPE_HIDE_SHOES

	old_right_leg = reciever.get_bodypart(BODY_ZONE_R_LEG)
	old_left_leg = reciever.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/leg/left/taur/new_left_leg
	var/obj/item/bodypart/leg/right/taur/new_right_leg

	if(organ_flags & ORGAN_ORGANIC)
		new_left_leg = new /obj/item/bodypart/leg/left/taur()
		new_right_leg = new /obj/item/bodypart/leg/right/taur()

	if(organ_flags & ORGAN_ROBOTIC)
		new_left_leg = new /obj/item/bodypart/leg/left/robot/synth/taur()
		new_right_leg = new /obj/item/bodypart/leg/right/robot/synth/taur()


	new_left_leg.bodytype |= external_bodytypes
	new_left_leg.replace_limb(reciever, TRUE)
	if(old_left_leg)
		old_left_leg.forceMove(src)

	new_right_leg.bodytype |= external_bodytypes
	new_right_leg.replace_limb(reciever, TRUE)
	if(old_right_leg)
		old_right_leg.forceMove(src)

	return ..()


/obj/item/organ/external/taur_body/Remove(mob/living/carbon/organ_owner, special, moving)
	var/obj/item/bodypart/leg/left/left_leg = organ_owner.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/leg/right/right_leg = organ_owner.get_bodypart(BODY_ZONE_R_LEG)

	if(left_leg)
		left_leg.drop_limb()

		if(left_leg)
			qdel(left_leg)

	if(right_leg)
		right_leg.drop_limb()

		if(right_leg)
			qdel(right_leg)

	if(old_left_leg)
		old_left_leg.replace_limb(organ_owner, TRUE)
		old_left_leg = null

	if(old_right_leg)
		old_right_leg.replace_limb(organ_owner, TRUE)
		old_right_leg = null

	// We don't call `synchronize_bodytypes()` here, because it's already going to get called in the parent because `external_bodytypes` has a value.

	return ..()

/obj/item/organ/external/taur_body/Destroy()
	. = ..()
	if(old_left_leg)
		QDEL_NULL(old_left_leg)

	if(old_right_leg)
		QDEL_NULL(old_right_leg)
