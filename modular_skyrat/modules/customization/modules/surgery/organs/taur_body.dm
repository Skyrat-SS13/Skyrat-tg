/obj/item/organ/external/taur_body
	name = "taur body"
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_TAUR
	external_bodyshapes = BODYSHAPE_TAUR
	use_mob_sprite_as_obj_sprite = TRUE

	preference = "feature_taur"
	mutantpart_key = "taur"
	mutantpart_info = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	bodypart_overlay = /datum/bodypart_overlay/mutant/taur_body

	/// If not null, the left leg limb we add to our mob will have this name.
	var/left_leg_name = "front legs"
	/// If not null, the right leg limb we add to our mob will have this name.
	var/right_leg_name = "back legs"

	/// The mob's old right leg. Used if the person switches to this organ and then back, so they don't just, have no legs anymore. Can be null.
	var/obj/item/bodypart/leg/right/old_right_leg = null
	/// The mob's old left leg. Used if the person switches to this organ and then back, so they don't just, have no legs anymore. Can be null.
	var/obj/item/bodypart/leg/right/old_left_leg = null

	/// If true, our sprite accessory will not render.
	var/hide_self

/obj/item/organ/external/taur_body/horselike

/obj/item/organ/external/taur_body/horselike/synth
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/external/taur_body/serpentine
	left_leg_name = "upper serpentine body"
	right_leg_name = "lower serpentine body"

/obj/item/organ/external/taur_body/serpentine/synth
	organ_flags = ORGAN_ROBOTIC

/obj/item/organ/external/taur_body/spider
	left_leg_name = "left legs"
	right_leg_name = "right legs"

/obj/item/organ/external/taur_body/tentacle
	left_leg_name = "front tentacles"
	right_leg_name = "back tentacles"

/obj/item/organ/external/taur_body/blob
	left_leg_name = "outer blob"
	right_leg_name = "inner blob"

/obj/item/organ/external/taur_body/anthro
	left_leg_name = null
	right_leg_name = null

/obj/item/organ/external/taur_body/anthro/synth
	organ_flags = ORGAN_ROBOTIC

/datum/bodypart_overlay/mutant/taur_body
	feature_key = "taur"
	layers = ALL_EXTERNAL_OVERLAYS | EXTERNAL_FRONT_UNDER_CLOTHES | EXTERNAL_FRONT_OVER
	color_source = ORGAN_COLOR_OVERRIDE


/datum/bodypart_overlay/mutant/taur_body/override_color(rgb_value)
	return draw_color


/datum/bodypart_overlay/mutant/taur_body/get_global_feature_list()
	return SSaccessories.sprite_accessories["taur"]


/obj/item/organ/external/taur_body/Insert(mob/living/carbon/receiver, special, movement_flags)
	if(sprite_accessory_flags & SPRITE_ACCESSORY_HIDE_SHOES)
		external_bodyshapes |= BODYSHAPE_HIDE_SHOES

	old_right_leg = receiver.get_bodypart(BODY_ZONE_R_LEG)
	old_left_leg = receiver.get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/leg/left/taur/new_left_leg
	var/obj/item/bodypart/leg/right/taur/new_right_leg

	if(organ_flags & ORGAN_ORGANIC)
		new_left_leg = new /obj/item/bodypart/leg/left/taur()
		new_right_leg = new /obj/item/bodypart/leg/right/taur()

	if(organ_flags & ORGAN_ROBOTIC)
		new_left_leg = new /obj/item/bodypart/leg/left/robot/synth/taur()
		new_right_leg = new /obj/item/bodypart/leg/right/robot/synth/taur()

	if (left_leg_name)
		new_left_leg.name = left_leg_name + " (Left leg)"
		new_left_leg.plaintext_zone = lowertext(new_left_leg.name) // weird otherwise
	if (right_leg_name)
		new_right_leg.name = right_leg_name + " (Right leg)"
		new_right_leg.plaintext_zone = lowertext(new_right_leg.name)

	new_left_leg.bodyshape |= external_bodyshapes
	new_left_leg.replace_limb(receiver, TRUE)
	if(old_left_leg)
		old_left_leg.forceMove(src)
	new_left_leg.bodytype |= BODYTYPE_TAUR

	new_right_leg.bodyshape |= external_bodyshapes
	new_right_leg.replace_limb(receiver, TRUE)
	if(old_right_leg)
		old_right_leg.forceMove(src)
	new_right_leg.bodytype |= BODYTYPE_TAUR

	return ..()


/obj/item/organ/external/taur_body/Remove(mob/living/carbon/organ_owner, special, moving)
	if(QDELETED(owner))
		return ..()

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

	// We don't call `synchronize_bodytypes()` here, because it's already going to get called in the parent because `external_bodyshapes` has a value.

	return ..()

/obj/item/organ/external/taur_body/Destroy()
	. = ..()
	if(old_left_leg)
		QDEL_NULL(old_left_leg)

	if(old_right_leg)
		QDEL_NULL(old_right_leg)
