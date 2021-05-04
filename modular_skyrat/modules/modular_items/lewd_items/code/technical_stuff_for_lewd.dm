//////////////////////////////////////////////////////////////////////////
//THIS IS NOT HERESY, DO NOT TOUCH IT IN THE NAME OF GOD//////////////////
//I made this file to prevent myself from touching normal files///////////
//////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////This code is supposed to be placed in "code/modules/mob/living/carbon/human/inventory.dm"/////////////
//If you are nice person you can transfer this part of code to it, but i didn't for modularisation reasons//
//////////////////////////////////////////for ball mittens//////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

/mob/living/carbon/human/equip_to_slot(obj/item/I, slot, initial = FALSE, redraw_mob = FALSE)
	. = ..()
	if(ITEM_SLOT_GLOVES)
		if(I)
			if(I.breakouttime) //when equipping a ball mittens
				ADD_TRAIT(src, TRAIT_RESTRAINED, SUIT_TRAIT)
				stop_pulling()
				update_action_buttons_icon() //certain action buttons will no longer be usable.
				return
			update_inv_gloves()

/mob/living/carbon/human/doUnEquip(obj/item/I, force, newloc, no_move, invdrop = TRUE, silent = FALSE)
	. = ..() //See mob.dm for an explanation on this and some rage about people copypasting instead of calling ..() like they should.
	if(I)
		if(I.breakouttime) //when unequipping a ball mittens
			REMOVE_TRAIT(src, TRAIT_RESTRAINED, SUIT_TRAIT)
			drop_all_held_items()
			update_action_buttons_icon() //certain action buttons may be usable again.
		I = null
		if(!QDELETED(src))
			update_inv_gloves()

/mob/living/carbon/human/resist_restraints()
	var/obj/item/clothing/gloves/G = usr.get_item_by_slot(ITEM_SLOT_GLOVES)
	if(G != null)
		if(istype(G, /obj/item/clothing/gloves/))
			if(G.breakouttime)
				to_chat(usr, "You try to unequip [G].")
				if(do_after(usr,G.breakouttime, usr))
					REMOVE_TRAIT(src, TRAIT_RESTRAINED, SUIT_TRAIT)
					usr.put_in_hands(G)
					drop_all_held_items()
					update_inv_gloves()
					to_chat(usr, "You succesefuly unequipped [src].")
				else
					to_chat(usr, "You failed to unequipped [G].")
					return
	..()

//////////////////////////////////////////////////////////////////////////////////
/////////this shouldn't be put anywhere, get your dirty hands off!////////////////
/////////////////////////////for dancing pole/////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////

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

//////////////////////////////////////////////////////////////////////////////////
//this code needed to determine if human/m is naked in that part of body or not///
//////////////You can you for your own stuff if you want, haha.///////////////////
//////////////////////////////////////////////////////////////////////////////////

///Are we wearing something that covers our chest?
/mob/living/proc/is_topless()
	if(istype(src, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = src
		if((!(H.wear_suit) || !(H.wear_suit.body_parts_covered & CHEST)) && (!(H.w_uniform) || !(H.w_uniform.body_parts_covered & CHEST)))
			return TRUE
	else
		return TRUE

///Are we wearing something that covers our groin?
/mob/living/proc/is_bottomless()
	if(istype(src, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = src
		if((!(H.wear_suit) || !(H.wear_suit.body_parts_covered & GROIN)) && (!(H.w_uniform) || !(H.w_uniform.body_parts_covered & GROIN)))
			return TRUE
	else
		return TRUE

///Are we wearing something that covers our shoes?
/mob/living/proc/is_barefoot()
	if(istype(src, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = src
		if((!(H.wear_suit) || !(H.wear_suit.body_parts_covered & GROIN)) && (!(H.shoes) || !(H.shoes.body_parts_covered & FEET)))
			return TRUE
	else
		return TRUE

/mob/living/proc/is_hands_uncovered()
    if(istype(src, /mob/living/carbon/human))
        var/mob/living/carbon/human/H = src
        if(H.gloves?.body_parts_covered & ARMS)
            return FALSE
    return TRUE

/mob/living/proc/is_head_uncovered()
    if(istype(src, /mob/living/carbon/human))
        var/mob/living/carbon/human/H = src
        if(H.head?.body_parts_covered & HEAD)
            return FALSE
    return TRUE

/mob/living/proc/has_penis(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(issilicon(src) && C.has_penis)
		return TRUE
	if(istype(C))
		var/obj/item/organ/genital/peepee = C.getorganslot(ORGAN_SLOT_PENIS)
		if(peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(peepee.visibility_preference == GENITAL_ALWAYS_SHOW || C.is_bottomless())
						return TRUE
					else
						return FALSE
				if(REQUIRE_UNEXPOSED)
					if(peepee.visibility_preference != GENITAL_ALWAYS_SHOW && !C.is_bottomless())
						return TRUE
					else
						return FALSE
				else
					return TRUE
	return FALSE

/mob/living/proc/has_balls(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(istype(C))
		var/obj/item/organ/genital/peepee = C.getorganslot(ORGAN_SLOT_TESTICLES)
		if(peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(peepee.visibility_preference == GENITAL_ALWAYS_SHOW || C.is_bottomless())
						return TRUE
					else
						return FALSE
				if(REQUIRE_UNEXPOSED)
					if(peepee.visibility_preference != GENITAL_ALWAYS_SHOW && !C.is_bottomless())
						return TRUE
					else
						return FALSE
				else
					return TRUE
	return FALSE

/mob/living/proc/has_vagina(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(issilicon(src) && C.has_vagina)
		return TRUE
	if(istype(C))
		var/obj/item/organ/genital/peepee = C.getorganslot(ORGAN_SLOT_VAGINA)
		if(peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(peepee.visibility_preference == GENITAL_ALWAYS_SHOW || C.is_bottomless())
						return TRUE
					else
						return FALSE
				if(REQUIRE_UNEXPOSED)
					if(peepee.visibility_preference != GENITAL_ALWAYS_SHOW && !C.is_bottomless())
						return TRUE
					else
						return FALSE
				else
					return TRUE
	return FALSE

/mob/living/proc/has_breasts(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(istype(C))
		var/obj/item/organ/genital/peepee = C.getorganslot(ORGAN_SLOT_BREASTS)
		if(peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(peepee.visibility_preference == GENITAL_ALWAYS_SHOW || C.is_topless())
						return TRUE
					else
						return FALSE
				if(REQUIRE_UNEXPOSED)
					if(peepee.visibility_preference != GENITAL_ALWAYS_SHOW && !C.is_topless())
						return TRUE
					else
						return FALSE
				else
					return TRUE
	return FALSE

/mob/living/proc/has_anus(var/nintendo = REQUIRE_ANY)
	if(issilicon(src))
		return TRUE
	switch(nintendo)
		if(REQUIRE_ANY)
			return TRUE
		if(REQUIRE_EXPOSED)
			switch(anus_exposed)
				if(-1)
					return FALSE
				if(1)
					return TRUE
				else
					if(is_bottomless())
						return TRUE
					else
						return FALSE
		if(REQUIRE_UNEXPOSED)
			if(anus_exposed == -1)
				if(!anus_exposed)
					if(!is_bottomless())
						return TRUE
					else
						return FALSE
				else
					return FALSE
			else
				return TRUE
		else
			return TRUE

/mob/living/proc/has_arms(var/nintendo = REQUIRE_ANY)
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		var/handcount = 0
		var/covered = 0
		var/iscovered = FALSE
		for(var/obj/item/bodypart/l_arm/L in C.bodyparts)
			handcount++
		for(var/obj/item/bodypart/r_arm/R in C.bodyparts)
			handcount++
		if(C.get_item_by_slot(ITEM_SLOT_HANDS))
			var/obj/item/clothing/gloves/G = C.get_item_by_slot(ITEM_SLOT_HANDS)
			covered = G.body_parts_covered
		if(covered & HANDS)
			iscovered = TRUE
		switch(nintendo)
			if(REQUIRE_ANY)
				return handcount
			if(REQUIRE_EXPOSED)
				if(iscovered)
					return FALSE
				else
					return handcount
			if(REQUIRE_UNEXPOSED)
				if(!iscovered)
					return FALSE
				else
					return handcount
			else
				return handcount
	return FALSE

/mob/living/proc/has_feet(var/nintendo = REQUIRE_ANY)
	if(iscarbon(src))
		var/mob/living/carbon/C = src
		var/feetcount = 0
		var/covered = 0
		var/iscovered = FALSE
		for(var/obj/item/bodypart/l_leg/L in C.bodyparts)
			feetcount++
		for(var/obj/item/bodypart/r_leg/R in C.bodyparts)
			feetcount++
		if(!C.is_barefoot())
			covered = TRUE
		if(covered)
			iscovered = TRUE
		switch(nintendo)
			if(REQUIRE_ANY)
				return feetcount
			if(REQUIRE_EXPOSED)
				if(iscovered)
					return FALSE
				else
					return feetcount
			if(REQUIRE_UNEXPOSED)
				if(!iscovered)
					return FALSE
				else
					return feetcount
			else
				return feetcount
	return FALSE

/mob/living/proc/get_num_feet()
	return has_feet(REQUIRE_ANY)

//weird procs go here
/mob/living/proc/has_ears(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(istype(C))
		var/obj/item/organ/peepee = C.getorganslot(ORGAN_SLOT_EARS)
		if(peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(C.get_item_by_slot(ITEM_SLOT_EARS))
						return FALSE
					else
						return TRUE
				if(REQUIRE_UNEXPOSED)
					if(!C.get_item_by_slot(ITEM_SLOT_EARS))
						return FALSE
					else
						return TRUE
				else
					return TRUE
	return FALSE

/mob/living/proc/has_earsockets(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(istype(C))
		var/obj/item/organ/peepee = C.getorganslot(ORGAN_SLOT_EARS)
		if(!peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(C.get_item_by_slot(ITEM_SLOT_EARS))
						return FALSE
					else
						return TRUE
				if(REQUIRE_UNEXPOSED)
					if(!C.get_item_by_slot(ITEM_SLOT_EARS))
						return FALSE
					else
						return TRUE
				else
					return TRUE
	return FALSE

/mob/living/proc/has_eyes(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(istype(C))
		var/obj/item/organ/peepee = C.getorganslot(ORGAN_SLOT_EYES)
		if(peepee)
			switch(nintendo)
				if(REQUIRE_ANY)
					return TRUE
				if(REQUIRE_EXPOSED)
					if(C.get_item_by_slot(ITEM_SLOT_EYES))
						return FALSE
					else
						return TRUE
				if(REQUIRE_UNEXPOSED)
					if(!C.get_item_by_slot(ITEM_SLOT_EYES))
						return FALSE
					else
						return TRUE
				else
					return TRUE
	return FALSE

/mob/living/proc/has_eyesockets(var/nintendo = REQUIRE_ANY)
	var/mob/living/carbon/C = src
	if(istype(C))
		var/obj/item/organ/peepee = C.getorganslot(ORGAN_SLOT_EYES)
		if(!peepee)
			switch(nintendo)
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
