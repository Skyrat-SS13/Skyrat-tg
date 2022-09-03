// Moved from my old interactions file 'cause skyrats already did interactions

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
*	Looping sound for vibrating stuff
*/

/datum/looping_sound/vibrator
	start_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bzzz-loop-1.ogg'
	start_length = 1
	mid_sounds = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bzzz-loop-1.ogg'
	mid_length = 1
	end_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bzzz-loop-1.ogg'
	falloff_distance = 1
	falloff_exponent = 5
	extra_range = SILENCED_SOUND_EXTRARANGE
	ignore_walls = FALSE

/datum/looping_sound/vibrator/low
	volume = 80

/datum/looping_sound/vibrator/medium
	volume = 90

/datum/looping_sound/vibrator/high
	volume = 100

/*
*	Boxes for vending machine, to spawn stuff with important cheap tools in pack
*/

// Milking machine
/obj/item/storage/box/milking_kit
	name = "DIY milking machine kit"
	desc = "Contains everything you need to build your own milking machine!"

/obj/item/storage/box/milking_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/milking_machine/constructionkit = 1)
	generate_items_inside(items_inside, src)

// X-Stand
/obj/item/storage/box/xstand_kit
	name = "DIY x-stand kit"
	desc = "Contains everything you need to build your own X-stand!"

/obj/item/storage/box/xstand_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/x_stand_kit = 1)
	generate_items_inside(items_inside, src)

// BDSM bed
/obj/item/storage/box/bdsmbed_kit
	name = "DIY BDSM bed kit"
	desc = "Contains everything you need to build your own BDSM bed!"

/obj/item/storage/box/bdsmbed_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/bdsm_bed_kit = 1)
	generate_items_inside(items_inside, src)

// Striptease pole
/obj/item/storage/box/strippole_kit
	name = "DIY stripper pole kit"
	desc = "Contains everything you need to build your own stripper pole!"

/obj/item/storage/box/strippole_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/polepack = 1)
	generate_items_inside(items_inside, src)

// Shibari stand
/obj/item/storage/box/shibari_stand
	name = "DIY shibari stand kit"
	desc = "Contains everything you need to build your own shibari stand!"

/obj/item/storage/box/shibari_stand/PopulateContents()
	var/static/items_inside = list(
		/obj/item/shibari_stand_kit = 1,
		/obj/item/paper/shibari_kit_instructions = 1)
	generate_items_inside(items_inside, src)

// Paper instructions for shibari kit

/obj/item/paper/shibari_kit_instructions
	default_raw_text = "Hello! Congratulations on your purchase of the shibari kit by LustWish! Some newbies may get confused by our ropes, so we prepared a small instructions for you! First of all, you have to have a wrench to construct the stand itself. Secondly, you can use screwdrivers to change the color of your shibari stand. Just replace the plastic fittings! Thirdly, if you want to tie somebody to a bondage stand you need to fully tie their body, on both groin and chest!. To do that you need to use rope on body and then on groin of character, then you can just buckle them to the stand like any chair. Don't forget to have some ropes on your hand to actually tie them to the stand, as there's no ropes included with it! And that's it!"

/*
*	This code is supposed to be placed in "code/modules/mob/living/carbon/human/inventory.dm"
*	If you are nice person you can transfer this part of code to it, but i didn't for modularisation reasons
*/

/mob/living/carbon/human/resist_restraints()
	if(gloves?.breakouttime)
		changeNext_move(CLICK_CD_BREAKOUT)
		last_special = world.time + CLICK_CD_BREAKOUT
		cuff_resist(gloves)
	else
		..()

/*
*	I needed this code for ballgag, because it doesn't muzzle, it kinda voxbox
*	wearer for moaning. So i really need it, don't touch or whole ballgag will be broken
*	for ballgag mute audible emotes
*	adding is_ballgagged() proc here. Hope won't break anything important.
*	This is kinda shitcode, but they said don't touch main code or they will break my knees.
*	i love my knees, please merge.
*	more shitcode can be found in code/datums/emotes.dm
*	in /datum/emote/proc/select_message_type(mob/user, intentional) proc. Sorry for that, i had no other choise.
*/

//false for default
/mob/proc/is_ballgagged()
	return FALSE

/mob/living/carbon/is_ballgagged()
	return(istype(src.wear_mask, /obj/item/clothing/mask/ballgag) || istype(src.wear_mask, /obj/item/clothing/head/helmet/space/deprivation_helmet))

//proc for condoms. Need to prevent cum appearing on the floor.
/mob/proc/wear_condom()
	return FALSE

/mob/living/carbon/human/wear_condom()
	. = ..()
	if(.)
		return TRUE
	if(penis != null && istype(penis, /obj/item/clothing/sextoy/condom))
		return TRUE
	return FALSE

/*
*	This shouldn't be put anywhere, get your dirty hands off!
*	For dancing pole
*/

/atom
	var/pseudo_z_axis

/atom/proc/get_fake_z()
	return pseudo_z_axis

/obj/structure/table
	pseudo_z_axis = 8

/turf/open/get_fake_z()
	var/objschecked
	for(var/obj/structure/structurestocheck in contents)
		objschecked++
		if(structurestocheck.pseudo_z_axis)
			return structurestocheck.pseudo_z_axis
		if(objschecked >= 25)
			break
	return pseudo_z_axis

/mob/living/Move(atom/newloc, direct)
	. = ..()
	if(.)
		pseudo_z_axis = newloc.get_fake_z()
		pixel_z = pseudo_z_axis

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
*	INVENTORY SYSTEM EXTENTION
*/

// SLOT GROUP HELPERS
#define ITEM_SLOT_ERP_INSERTABLE (ITEM_SLOT_VAGINA|ITEM_SLOT_ANUS)
#define ITEM_SLOT_ERP_ATTACHABLE (ITEM_SLOT_NIPPLES|ITEM_SLOT_PENIS)

// Strippable Defines
#define ERP_SLOT_EQUIP_DELAY (5 SECONDS) // Lamella TODO: delay need to be balanced

#define STRIPPABLE_ITEM_VAGINA "vagina"
#define STRIPPABLE_ITEM_ANUS "anus"
#define STRIPPABLE_ITEM_NIPPLES "nipples"
#define STRIPPABLE_ITEM_PEINS "penis"

// Just by analogy with the TG code. No ideas for what this is.
/mob/proc/update_inv_vagina()
	return
/mob/proc/update_inv_anus()
	return
/mob/proc/update_inv_nipples()
	return
/mob/proc/update_inv_penis()
	return

// Add variables for slots to the Carbon class
/mob/living/carbon/human
	var/obj/item/vagina = null
	var/obj/item/anus = null
	var/obj/item/nipples = null
	var/obj/item/penis = null

/*
* SEXTOY CLOTH TYPE
*/

/obj/item/clothing/sextoy
	name = "sextoy"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	equip_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg'
	drop_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'
	slot_flags = ITEM_SLOT_VAGINA | ITEM_SLOT_ANUS | ITEM_SLOT_PENIS | ITEM_SLOT_NIPPLES

/obj/item/clothing/sextoy/dropped(mob/user)
	..()

	update_appearance()
	if(!ishuman(loc))
		return

	var/mob/living/carbon/human/holder = loc
	holder.update_inv_vagina()
	holder.update_inv_anus()
	holder.update_inv_nipples()
	holder.update_inv_penis()
	holder.fan_hud_set_fandom()

/// A check to confirm if you can open the toy's color/design radial menu
/obj/item/clothing/sextoy/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

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

/*
*	STRIPPING ERP SYSTEM EXTENTION
*/

// Extends default proc check for hidden ears for supporting our sleepbag and catsuit to
/datum/sprite_accessory/ears/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	/*
	// Default proc code
	if(target_human.head && (target_human.head.flags_inv & HIDEHAIR) || (target_human.wear_mask && (target_human.wear_mask.flags_inv & HIDEHAIR)) || !HD)
		//return TRUE
	return FALSE
	*/

	// First lets proc default code
	. = ..()
	if(!.) // If true, ears already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			if(sleeping_bag.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden frills for supporting our sleepbag and catsuit to
/datum/sprite_accessory/frills/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	/*
	// Default proc code
	if(target_human.head && (target_human.try_hide_mutant_parts || (target_human.head.flags_inv & HIDEEARS) || !HD || HD.status == BODYPART_ROBOTIC))
		//return TRUE
	return FALSE
	*/

	. = ..()
	if(!.) // If true, frills already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			if(sleeping_bag.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden head accessory for supporting our sleepbag and catsuit to
/datum/sprite_accessory/head_accessory/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	/*
	// Default proc code
	if(target_human.head && (target_human.head.flags_inv & HIDEHAIR) || (target_human.wear_mask && (target_human.wear_mask.flags_inv & HIDEHAIR)))
		//return TRUE
	return FALSE
	*/

	. = ..()
	if(!.) // If true, head accessory already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			if(sleeping_bag.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden horns for supporting our sleepbag and catsuit to
/datum/sprite_accessory/horns/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	/*
	// Default proc code
	if(target_human.head && (target_human.head.flags_inv & HIDEHAIR) || (target_human.wear_mask && (target_human.wear_mask.flags_inv & HIDEHAIR)) || !HD)
		return TRUE
	return FALSE
	*/

	. = ..()
	if(!.) // If true, horns already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			if(sleeping_bag.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden antenna for supporting our sleepbag and catsuit to
/datum/sprite_accessory/antenna/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	/*
	// Default proc code
	if(target_human.head && (target_human.head.flags_inv & HIDEHAIR) || (target_human.wear_mask && (target_human.wear_mask.flags_inv & HIDEHAIR)) || !HD)
		//return TRUE
	return FALSE
	*/

	. = ..()
	if(!.) // If true, antenna already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			if(sleeping_bag.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden moth antenna for supporting our sleepbag and catsuit to
/datum/sprite_accessory/moth_antennae/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	/*
	// Default proc code
	if(target_human.head && (target_human.head.flags_inv & HIDEHAIR) || (target_human.wear_mask && (target_human.wear_mask.flags_inv & HIDEHAIR)) || !HD)
		//return TRUE
	return FALSE
	*/

	. = ..()
	if(!.) // If true, moth antenna already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			if(sleeping_bag.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden skrell hair for supporting our sleepbag and catsuit to
/datum/sprite_accessory/skrell_hair/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	/*
	// Default proc code
	if(target_human.head && (target_human.head.flags_inv & HIDEHAIR) || (target_human.wear_mask && (target_human.wear_mask.flags_inv & HIDEHAIR)))
		return TRUE
	return FALSE
	*/

	. = ..()
	if(!.) // If true, skrell hair already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			if(sleeping_bag.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden skrell hair for supporting our sleepbag and catsuit to
/datum/sprite_accessory/tails/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)

	. = ..()
	if(!.) // If true, tail already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			// var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			// if(sleeping_bag.state_thing == "inflated")
			// 	return TRUE
			return TRUE /* return FALSE */
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return TRUE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden wings for supporting our sleepbag and catsuit to
/datum/sprite_accessory/wings/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	. = ..()
	if(.)
		return TRUE
	if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		return TRUE
	return FALSE

/mob/living/carbon/human/set_handcuffed(new_value)
	if(wear_suit && istype(wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		return FALSE
	..()

/datum/sprite_accessory/xenodorsal/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		return TRUE
	else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
		return TRUE
	return FALSE

/datum/sprite_accessory/xenohead/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
		if(sleeping_bag.state_thing == "inflated")
			return TRUE
		return FALSE
	else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
		return FALSE
	return FALSE

/datum/preference/toggle/erp/sex_toy/apply_to_client_updated(client/client, value)
	. = ..()
	if(!client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		if(ishuman(client.mob))
			var/mob/living/carbon/human/target = client.mob
			if(target.vagina != null)
				target.dropItemToGround(target.vagina, TRUE, target.loc, TRUE, FALSE, TRUE)
			if(target.anus != null)
				target.dropItemToGround(target.anus, TRUE, target.loc, TRUE, FALSE, TRUE)
			if(target.nipples != null)
				target.dropItemToGround(target.nipples, TRUE, target.loc, TRUE, FALSE, TRUE)
			if(target.penis != null)
				target.dropItemToGround(target.penis, TRUE, target.loc, TRUE, FALSE, TRUE)


	client.mob.hud_used.hidden_inventory_update(client.mob)
	client.mob.hud_used.persistent_inventory_update(client.mob)

/obj/item/proc/is_in_genital(mob/living/carbon/human/the_guy)
	return !!(src == the_guy.penis || src == the_guy.vagina || src == the_guy.anus || src == the_guy.nipples)
