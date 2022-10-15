/mob/living/carbon/human
	var/arousal = 0
	var/pleasure = 0
	var/pain = 0

	var/pain_limit = 0
	var/arousal_status = AROUSAL_NONE

	// Add variables for slots to the human class
	var/obj/item/vagina = null
	var/obj/item/anus = null
	var/obj/item/nipples = null
	var/obj/item/penis = null

	var/has_penis = FALSE
	var/has_vagina = FALSE
	var/has_breasts = FALSE
	var/has_anus = FALSE


// For tracking arousal and fluid regen.
/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	if(!istype(src, /mob/living/carbon/human/species/monkey))
		apply_status_effect(/datum/status_effect/aroused)
		apply_status_effect(/datum/status_effect/body_fluid_regen)

/*
*	This code needed to determine if the human is naked in that part of body or not
*	You can use this for your own stuff if you want, haha.
*/

/// Are we wearing something that covers our chest?
/mob/living/carbon/human/proc/is_topless()
	return (!(wear_suit) || !(wear_suit.body_parts_covered & CHEST)) && (!(w_uniform) || !(w_uniform.body_parts_covered & CHEST))

/// Are we wearing something that covers our groin?
/mob/living/carbon/human/proc/is_bottomless()
	return (!(wear_suit) || !(wear_suit.body_parts_covered & GROIN)) && (!(w_uniform) || !(w_uniform.body_parts_covered & GROIN))

/// Are we wearing something that covers our shoes?
/mob/living/carbon/human/proc/is_barefoot()
	return (!(wear_suit) || !(wear_suit.body_parts_covered & GROIN)) && (!(shoes) || !(shoes.body_parts_covered & FEET))

/mob/living/carbon/human/proc/is_hands_uncovered()
    return (gloves?.body_parts_covered & ARMS)

/mob/living/carbon/human/proc/is_head_uncovered()
    return (head?.body_parts_covered & HEAD)

/// Returns true if the human has an accessible penis for the parameter. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_penis(required_state = REQUIRE_GENITAL_ANY)
	var/obj/item/organ/external/genital/genital = getorganslot(ORGAN_SLOT_PENIS)
	if(!genital)
		return FALSE

	switch(required_state)
		if(REQUIRE_GENITAL_ANY)
			return TRUE
		if(REQUIRE_GENITAL_EXPOSED)
			return genital.visibility_preference == GENITAL_ALWAYS_SHOW || is_bottomless()
		if(REQUIRE_GENITAL_UNEXPOSED)
			return genital.visibility_preference != GENITAL_ALWAYS_SHOW && !is_bottomless()
		else
			return TRUE

/// Returns true if the human has a accessible balls for the parameter. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_balls(required_state = REQUIRE_GENITAL_ANY)
	var/obj/item/organ/external/genital/genital = getorganslot(ORGAN_SLOT_TESTICLES)
	if(!genital)
		return FALSE

	switch(required_state)
		if(REQUIRE_GENITAL_ANY)
			return TRUE
		if(REQUIRE_GENITAL_EXPOSED)
			return genital.visibility_preference == GENITAL_ALWAYS_SHOW || is_bottomless()
		if(REQUIRE_GENITAL_UNEXPOSED)
			return genital.visibility_preference != GENITAL_ALWAYS_SHOW && !is_bottomless()
		else
			return TRUE

/// Returns true if the human has an accessible vagina for the parameter. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_vagina(required_state = REQUIRE_GENITAL_ANY)
	var/obj/item/organ/external/genital/genital = getorganslot(ORGAN_SLOT_VAGINA)
	if(!genital)
		return FALSE

	switch(required_state)
		if(REQUIRE_GENITAL_ANY)
			return TRUE
		if(REQUIRE_GENITAL_EXPOSED)
			return genital.visibility_preference == GENITAL_ALWAYS_SHOW || is_bottomless()
		if(REQUIRE_GENITAL_UNEXPOSED)
			return genital.visibility_preference != GENITAL_ALWAYS_SHOW && !is_bottomless()
		else
			return TRUE

/// Returns true if the human has a accessible breasts for the parameter. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_breasts(required_state = REQUIRE_GENITAL_ANY)
	var/obj/item/organ/external/genital/genital = getorganslot(ORGAN_SLOT_BREASTS)
	if(!genital)
		return FALSE

	switch(required_state)
		if(REQUIRE_GENITAL_ANY)
			return TRUE
		if(REQUIRE_GENITAL_EXPOSED)
			return genital.visibility_preference == GENITAL_ALWAYS_SHOW || is_topless()
		if(REQUIRE_GENITAL_UNEXPOSED)
			return genital.visibility_preference != GENITAL_ALWAYS_SHOW && !is_topless()
		else
			return TRUE

/// Returns true if the human has an accessible anus for the parameter. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_anus(required_state = REQUIRE_GENITAL_ANY)
	if(issilicon(src))
		return TRUE
	var/obj/item/organ/external/genital/genital = getorganslot(ORGAN_SLOT_ANUS)
	if(!genital)
		return FALSE

	switch(required_state)
		if(REQUIRE_GENITAL_ANY)
			return TRUE
		if(REQUIRE_GENITAL_EXPOSED)
			return genital.visibility_preference == GENITAL_ALWAYS_SHOW || is_bottomless()
		if(REQUIRE_GENITAL_UNEXPOSED)
			return genital.visibility_preference != GENITAL_ALWAYS_SHOW && !is_bottomless()
		else
			return TRUE

/// Returns true if the human has a accessible feet for the parameter, returning the number of feet the human has if they do. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_arms(required_state = REQUIRE_GENITAL_ANY)
	var/hand_count = 0
	var/covered = 0
	var/is_covered = FALSE
	for(var/obj/item/bodypart/l_arm/left_arm in bodyparts)
		hand_count++
	for(var/obj/item/bodypart/r_arm/right_arm in bodyparts)
		hand_count++
	if(get_item_by_slot(ITEM_SLOT_HANDS))
		var/obj/item/clothing/gloves/worn_gloves = get_item_by_slot(ITEM_SLOT_HANDS)
		covered = worn_gloves.body_parts_covered
	if(covered & HANDS)
		is_covered = TRUE
	switch(required_state)
		if(REQUIRE_GENITAL_ANY)
			return hand_count
		if(REQUIRE_GENITAL_EXPOSED)
			if(is_covered)
				return FALSE
			else
				return hand_count
		if(REQUIRE_GENITAL_UNEXPOSED)
			if(!is_covered)
				return FALSE
			else
				return hand_count
		else
			return hand_count

/// Returns true if the human has a accessible feet for the parameter, returning the number of feet the human has if they do. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_feet(required_state = REQUIRE_GENITAL_ANY)
	var/feet_count = 0

	for(var/obj/item/bodypart/l_leg/left_leg in bodyparts)
		feet_count++
	for(var/obj/item/bodypart/r_leg/right_leg in bodyparts)
		feet_count++

	switch(required_state)
		if(REQUIRE_GENITAL_ANY)
			return feet_count
		if(REQUIRE_GENITAL_EXPOSED)
			if(!is_barefoot())
				return FALSE
			else
				return feet_count
		if(REQUIRE_GENITAL_UNEXPOSED)
			if(is_barefoot())
				return FALSE
			else
				return feet_count
		else
			return feet_count

/// Gets the number of feet the human has.
/mob/living/carbon/human/proc/get_num_feet()
	return has_feet(REQUIRE_GENITAL_ANY)

/// Returns true if the human has a accessible ears for the parameter. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_ears(required_state = REQUIRE_GENITAL_ANY)
	var/obj/item/organ/genital = getorganslot(ORGAN_SLOT_EARS)
	if(!genital)
		return FALSE

	switch(required_state)
		if(REQUIRE_GENITAL_ANY)
			return TRUE
		if(REQUIRE_GENITAL_EXPOSED)
			return !get_item_by_slot(ITEM_SLOT_EARS)
		if(REQUIRE_GENITAL_UNEXPOSED)
			return get_item_by_slot(ITEM_SLOT_EARS)
		else
			return TRUE

/// Returns true if the human has accessible eyes for the parameter. Accepts any of the `REQUIRE_GENITAL_` defines.
/mob/living/carbon/human/proc/has_eyes(required_state = REQUIRE_GENITAL_ANY)
	var/obj/item/organ/genital = getorganslot(ORGAN_SLOT_EYES)
	if(!genital)
		return FALSE

	switch(required_state)
		if(REQUIRE_GENITAL_ANY)
			return TRUE
		if(REQUIRE_GENITAL_EXPOSED)
			return !get_item_by_slot(ITEM_SLOT_EYES)
		if(REQUIRE_GENITAL_UNEXPOSED)
			return get_item_by_slot(ITEM_SLOT_EYES)
		else
			return TRUE


/*
*	This code needed for changing character's gender by chems
*/

/// Sets the gender of the human, respecting prefs unless it's forced. Do not force in non-admin operations.
/mob/living/carbon/human/proc/set_gender(ngender = NEUTER, silent = FALSE, update_icon = TRUE, forced = FALSE)
	var/bender = gender != ngender
	if((!client?.prefs?.read_preference(/datum/preference/toggle/erp/gender_change) && !forced) || !dna || !bender)
		return FALSE

	if(ngender == MALE || ngender == FEMALE)
		dna.features["body_model"] = ngender
		if(!silent)
			var/adj = ngender == MALE ? "masculine" : "feminine"
			visible_message(span_boldnotice("[src] suddenly looks more [adj]!"), span_boldwarning("You suddenly feel more [adj]!"))
	else if(ngender == NEUTER)
		dna.features["body_model"] = MALE
	gender = ngender
	if(update_icon)
		update_body()

/*
*	ICON UPDATING EXTENTION
*/

/// Updating vagina slot
/mob/living/carbon/human/proc/update_inv_vagina()
	// on_mob stuff
	remove_overlay(VAGINA_LAYER)

	var/obj/item/clothing/sextoy/sex_toy = vagina

	if(wear_suit && (wear_suit.flags_inv & HIDESEXTOY)) // You can add proper flags here if required
		return

	var/icon_file = vagina?.worn_icon
	var/mutable_appearance/vagina_overlay

	if(!vagina_overlay)
		vagina_overlay = sex_toy?.build_worn_icon(default_layer = VAGINA_LAYER, default_icon_file = 'icons/mob/clothing/under/default.dmi', isinhands = FALSE, override_file = icon_file)

	if(OFFSET_UNIFORM in dna.species.offset_features)
		vagina_overlay?.pixel_x += dna.species.offset_features[OFFSET_UNIFORM][1]
		vagina_overlay?.pixel_y += dna.species.offset_features[OFFSET_UNIFORM][2]
	overlays_standing[VAGINA_LAYER] = vagina_overlay

	apply_overlay(VAGINA_LAYER)
	update_mutant_bodyparts()

/// Updating anus slot
/mob/living/carbon/human/proc/update_inv_anus()
	// on_mob stuff
	remove_overlay(ANUS_LAYER)

	var/obj/item/clothing/sextoy/sex_toy = anus

	if(wear_suit && (wear_suit.flags_inv & HIDESEXTOY)) // You can add proper flags here if required
		return

	var/icon_file = anus?.worn_icon
	var/mutable_appearance/anus_overlay

	if(!anus_overlay)
		anus_overlay = sex_toy?.build_worn_icon(default_layer = ANUS_LAYER, default_icon_file = 'icons/mob/clothing/under/default.dmi', isinhands = FALSE, override_file = icon_file)

	if(OFFSET_UNIFORM in dna.species.offset_features)
		anus_overlay?.pixel_x += dna.species.offset_features[OFFSET_UNIFORM][1]
		anus_overlay?.pixel_y += dna.species.offset_features[OFFSET_UNIFORM][2]
	overlays_standing[ANUS_LAYER] = anus_overlay

	apply_overlay(ANUS_LAYER)
	update_mutant_bodyparts()

/// Updating nipples slot
/mob/living/carbon/human/proc/update_inv_nipples()
	// on_mob stuff
	remove_overlay(NIPPLES_LAYER)

	var/obj/item/clothing/sextoy/sex_toy = nipples

	if(wear_suit && (wear_suit.flags_inv & HIDESEXTOY)) // You can add proper flags here if required
		return

	var/icon_file = nipples?.worn_icon
	var/mutable_appearance/nipples_overlay

	if(!nipples_overlay)
		nipples_overlay = sex_toy?.build_worn_icon(default_layer = NIPPLES_LAYER, default_icon_file = 'icons/mob/clothing/under/default.dmi', isinhands = FALSE, override_file = icon_file)

	if(OFFSET_UNIFORM in dna.species.offset_features)
		nipples_overlay?.pixel_x += dna.species.offset_features[OFFSET_UNIFORM][1]
		nipples_overlay?.pixel_y += dna.species.offset_features[OFFSET_UNIFORM][2]
	overlays_standing[NIPPLES_LAYER] = nipples_overlay

	apply_overlay(NIPPLES_LAYER)
	update_mutant_bodyparts()

/// Updating penis slot
/mob/living/carbon/human/proc/update_inv_penis()
	// on_mob stuff
	remove_overlay(PENIS_LAYER)

	var/obj/item/clothing/sextoy/sex_toy = penis

	if(wear_suit && (wear_suit.flags_inv & HIDESEXTOY)) // You can add proper flags here if required
		return

	var/icon_file = penis?.worn_icon
	var/mutable_appearance/penis_overlay

	if(!penis_overlay)
		penis_overlay = sex_toy?.build_worn_icon(default_layer = PENIS_LAYER, default_icon_file = 'icons/mob/clothing/under/default.dmi', isinhands = FALSE, override_file = icon_file)

	if(OFFSET_UNIFORM in dna.species.offset_features)
		penis_overlay?.pixel_x += dna.species.offset_features[OFFSET_UNIFORM][1]
		penis_overlay?.pixel_y += dna.species.offset_features[OFFSET_UNIFORM][2]
	overlays_standing[PENIS_LAYER] = penis_overlay

	apply_overlay(PENIS_LAYER)
	update_mutant_bodyparts()

/// Helper proc for calling all the lewd slot update_inv_ procs.
/mob/living/carbon/human/proc/update_inv_lewd()
	update_inv_vagina()
	update_inv_anus()
	update_inv_nipples()
	update_inv_penis()

/*
*	MISC LOGIC
*/

// Handles breaking out of gloves that restrain people.
/mob/living/carbon/human/resist_restraints()
	if(gloves?.breakouttime)
		changeNext_move(CLICK_CD_BREAKOUT)
		last_special = world.time + CLICK_CD_BREAKOUT
		cuff_resist(gloves)
	else
		..()

/// Checks if the human is wearing a condom, and also hasn't broken it.
/mob/living/carbon/human/proc/is_wearing_condom()
	if(!penis || !istype(penis, /obj/item/clothing/sextoy/condom))
		return FALSE

	var/obj/item/clothing/sextoy/condom/condom = penis
	return condom.condom_state == CONDOM_BROKEN

// For handling things that don't already have handcuff handlers.
/mob/living/carbon/human/set_handcuffed(new_value)
	if(wear_suit && istype(wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		return FALSE
	..()
