#define REQUIRE_NONE 0
#define REQUIRE_EXPOSED 1
#define REQUIRE_UNEXPOSED 2
#define REQUIRE_ANY 3

/mob/living/carbon/human
	var/has_penis = FALSE
	var/has_vagina = FALSE
	var/has_breasts = FALSE
	var/has_anus = FALSE

/*
*	This code needed to determine if the human is naked in that part of body or not
*	You can you for your own stuff if you want, haha.
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

/mob/living/carbon/human/proc/has_penis(required_state = REQUIRE_ANY)
	if(issilicon(src) && has_penis)
		return TRUE
	var/obj/item/organ/external/genital/peepee = getorganslot(ORGAN_SLOT_PENIS)
	if(peepee)
		switch(required_state)
			if(REQUIRE_ANY)
				return TRUE
			if(REQUIRE_EXPOSED)
				if(peepee.visibility_preference == GENITAL_ALWAYS_SHOW || is_bottomless())
					return TRUE
				else
					return FALSE
			if(REQUIRE_UNEXPOSED)
				if(peepee.visibility_preference != GENITAL_ALWAYS_SHOW && !is_bottomless())
					return TRUE
				else
					return FALSE
			else
				return TRUE
	return FALSE

/mob/living/carbon/human/proc/has_balls(required_state = REQUIRE_ANY)
	var/obj/item/organ/external/genital/peepee = getorganslot(ORGAN_SLOT_TESTICLES)
	if(peepee)
		switch(required_state)
			if(REQUIRE_ANY)
				return TRUE
			if(REQUIRE_EXPOSED)
				if(peepee.visibility_preference == GENITAL_ALWAYS_SHOW || is_bottomless())
					return TRUE
				else
					return FALSE
			if(REQUIRE_UNEXPOSED)
				if(peepee.visibility_preference != GENITAL_ALWAYS_SHOW && !is_bottomless())
					return TRUE
				else
					return FALSE
			else
				return TRUE
	return FALSE

/mob/living/carbon/human/proc/has_vagina(required_state = REQUIRE_ANY)
	if(issilicon(src) && has_vagina)
		return TRUE
	var/obj/item/organ/external/genital/peepee = getorganslot(ORGAN_SLOT_VAGINA)
	if(peepee)
		switch(required_state)
			if(REQUIRE_ANY)
				return TRUE
			if(REQUIRE_EXPOSED)
				if(peepee.visibility_preference == GENITAL_ALWAYS_SHOW || is_bottomless())
					return TRUE
				else
					return FALSE
			if(REQUIRE_UNEXPOSED)
				if(peepee.visibility_preference != GENITAL_ALWAYS_SHOW && !is_bottomless())
					return TRUE
				else
					return FALSE
			else
				return TRUE
	return FALSE

/mob/living/carbon/human/proc/has_breasts(required_state = REQUIRE_ANY)
	var/obj/item/organ/external/genital/peepee = getorganslot(ORGAN_SLOT_BREASTS)
	if(peepee)
		switch(required_state)
			if(REQUIRE_ANY)
				return TRUE
			if(REQUIRE_EXPOSED)
				if(peepee.visibility_preference == GENITAL_ALWAYS_SHOW || is_topless())
					return TRUE
				else
					return FALSE
			if(REQUIRE_UNEXPOSED)
				if(peepee.visibility_preference != GENITAL_ALWAYS_SHOW && !is_topless())
					return TRUE
				else
					return FALSE
			else
				return TRUE
	return FALSE

/mob/living/carbon/human/proc/has_anus(required_state = REQUIRE_ANY)
	if(issilicon(src))
		return TRUE
	var/obj/item/organ/external/genital/peepee = getorganslot(ORGAN_SLOT_ANUS)
	if(peepee)
		switch(required_state)
			if(REQUIRE_ANY)
				return TRUE
			if(REQUIRE_EXPOSED)
				if(peepee.visibility_preference == GENITAL_ALWAYS_SHOW || is_bottomless())
					return TRUE
				else
					return FALSE
			if(REQUIRE_UNEXPOSED)
				if(peepee.visibility_preference != GENITAL_ALWAYS_SHOW && !is_bottomless())
					return TRUE
				else
					return FALSE
			else
				return TRUE

/mob/living/carbon/human/proc/has_arms(required_state = REQUIRE_ANY)
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
		if(REQUIRE_ANY)
			return hand_count
		if(REQUIRE_EXPOSED)
			if(is_covered)
				return FALSE
			else
				return hand_count
		if(REQUIRE_UNEXPOSED)
			if(!is_covered)
				return FALSE
			else
				return hand_count
		else
			return hand_count

/mob/living/carbon/human/proc/has_feet(required_state = REQUIRE_ANY)
	var/feet_count = 0
	var/covered = 0
	var/is_covered = FALSE
	for(var/obj/item/bodypart/l_leg/left_leg in bodyparts)
		feet_count++
	for(var/obj/item/bodypart/r_leg/right_leg in bodyparts)
		feet_count++
	if(!is_barefoot())
		covered = TRUE
	if(covered)
		is_covered = TRUE
	switch(required_state)
		if(REQUIRE_ANY)
			return feet_count
		if(REQUIRE_EXPOSED)
			if(is_covered)
				return FALSE
			else
				return feet_count
		if(REQUIRE_UNEXPOSED)
			if(!is_covered)
				return FALSE
			else
				return feet_count
		else
			return feet_count

/mob/living/carbon/human/proc/get_num_feet()
	return has_feet(REQUIRE_ANY)

// Weird procs go here
/mob/living/carbon/human/proc/has_ears(required_state = REQUIRE_ANY)
	var/obj/item/organ/peepee = getorganslot(ORGAN_SLOT_EARS)
	if(peepee)
		switch(required_state)
			if(REQUIRE_ANY)
				return TRUE
			if(REQUIRE_EXPOSED)
				if(get_item_by_slot(ITEM_SLOT_EARS))
					return FALSE
				else
					return TRUE
			if(REQUIRE_UNEXPOSED)
				if(!get_item_by_slot(ITEM_SLOT_EARS))
					return FALSE
				else
					return TRUE
			else
				return TRUE
	return FALSE

/mob/living/carbon/human/proc/has_earsockets(required_state = REQUIRE_ANY)
	var/obj/item/organ/peepee = getorganslot(ORGAN_SLOT_EARS)
	if(!peepee)
		switch(required_state)
			if(REQUIRE_ANY)
				return TRUE
			if(REQUIRE_EXPOSED)
				if(get_item_by_slot(ITEM_SLOT_EARS))
					return FALSE
				else
					return TRUE
			if(REQUIRE_UNEXPOSED)
				if(!get_item_by_slot(ITEM_SLOT_EARS))
					return FALSE
				else
					return TRUE
			else
				return TRUE
	return FALSE

/mob/living/carbon/human/proc/has_eyes(required_state = REQUIRE_ANY)
	var/obj/item/organ/peepee = getorganslot(ORGAN_SLOT_EYES)
	if(peepee)
		switch(required_state)
			if(REQUIRE_ANY)
				return TRUE
			if(REQUIRE_EXPOSED)
				if(get_item_by_slot(ITEM_SLOT_EYES))
					return FALSE
				else
					return TRUE
			if(REQUIRE_UNEXPOSED)
				if(!get_item_by_slot(ITEM_SLOT_EYES))
					return FALSE
				else
					return TRUE
			else
				return TRUE
	return FALSE

/mob/living/carbon/human/proc/has_eyesockets(required_state = REQUIRE_ANY)
	var/obj/item/organ/peepee = getorganslot(ORGAN_SLOT_EYES)
	if(!peepee)
		switch(required_state)
			if(REQUIRE_ANY)
				return TRUE
			if(REQUIRE_EXPOSED)
				if(get_item_by_slot(ITEM_SLOT_EYES))
					return FALSE
				else
					return TRUE
			if(REQUIRE_UNEXPOSED)
				if(!get_item_by_slot(ITEM_SLOT_EYES))
					return FALSE
				else
					return TRUE
			else
				return TRUE
	return FALSE


/*
*	This code needed for changing character's gender by chems
*/

/mob/living/carbon/human/proc/set_gender(ngender = NEUTER, silent = FALSE, update_icon = TRUE, forced = FALSE)
	if(forced || (!ckey || client?.prefs.read_preference(/datum/preference/toggle/erp/gender_change)))
		gender = ngender
		return TRUE
	return FALSE

/mob/living/carbon/human/set_gender(ngender = NEUTER, silent = FALSE, update_icon = TRUE, forced = FALSE)
	var/bender = !(gender == ngender)
	. = ..()
	if(!.)
		return
	if(dna && bender)
		if(ngender == MALE || ngender == FEMALE)
			dna.features["body_model"] = ngender
			if(!silent)
				var/adj = ngender == MALE ? "masculine" : "feminine"
				visible_message(span_boldnotice("[src] suddenly looks more [adj]!"), span_boldwarning("You suddenly feel more [adj]!"))
		else if(ngender == NEUTER)
			dna.features["body_model"] = MALE
	if(update_icon)
		update_body()

/*
*	ICON UPDATING EXTENTION
*/

// Updating vagina slot
/mob/living/carbon/human/update_inv_vagina()
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

// Updating anus slot
/mob/living/carbon/human/update_inv_anus()
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

// Updating nipples slot
/mob/living/carbon/human/update_inv_nipples()
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

// Updating penis slot
/mob/living/carbon/human/update_inv_penis()
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

#undef REQUIRE_NONE
#undef REQUIRE_EXPOSED
#undef REQUIRE_UNEXPOSED
#undef REQUIRE_ANY
