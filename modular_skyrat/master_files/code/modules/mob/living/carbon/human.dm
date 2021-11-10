/mob/living/carbon/human/ZImpactDamage(turf/T, levels)
	// Cat-people always land on their feet
	if(isfelinid(src) || istajaran(src))
		//Check to make sure legs are working
		var/obj/item/bodypart/left_leg = get_bodypart(BODY_ZONE_L_LEG)
		var/obj/item/bodypart/right_leg = get_bodypart(BODY_ZONE_R_LEG)
		if(!left_leg || !right_leg || left_leg.bodypart_disabled || right_leg.bodypart_disabled)
			return ..()
		Stun(0.5 SECONDS) // You can't move and you can't use items
		//Nailed it!
		visible_message(span_notice("[src] lands elegantly on [p_their()] feet!"),
			span_warning("You fall [levels > 1 ? "[levels] levels" : "one level"] into [T], perfecting the landing!"))
		return
	
	if(!HAS_TRAIT(src, TRAIT_FREERUNNING) || levels > 1) // falling off one level
		return ..()
	visible_message(span_danger("[src] makes a hard landing on [T] but remains unharmed from the fall."), \
			span_userdanger("You brace for the fall. You make a hard landing on [T] but remain unharmed."))
	Knockdown(levels * 40)
