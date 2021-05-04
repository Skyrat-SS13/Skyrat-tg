/mob/living/proc/has_hands()
	return FALSE

/mob/living/has_hands()
	return TRUE//(can_use_hand("l_hand") || can_use_hand("r_hand"))

/mob/living/proc/has_mouth()
	return TRUE

/mob/living/proc/mouth_is_free()
	return TRUE

/mob/living/proc/foot_is_free()
	return TRUE

/mob/living/carbon/human/has_mouth()
	var/obj/item/bodypart/head/headass
	for(var/obj/item/bodypart/head/shoeonhead in bodyparts)
		headass = shoeonhead
	if(headass)
		return TRUE
	return FALSE

/mob/living/mouth_is_free()
	if(istype(src, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = src
		return !H.wear_mask
	else
		return TRUE

/mob/living/foot_is_free()
	if(istype(src, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = src
		return !H.shoes
	else
		return TRUE

///atom/movable/attack_hand(mob/living/carbon/human/user)
//	. = ..()
//	if(can_buckle && buckled_mob)
//		if(user_unbuckle_mob(user))
//			return 1
/*
/atom/movable/MouseDrop_T(mob/living/carbon/human/M, mob/living/carbon/human/user)
	. = ..()
	if(can_buckle && istype(M) && !buckled_mob)
		if(user_buckle_mob(M, user))
			return TRUE

*/
