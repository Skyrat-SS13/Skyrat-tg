/mob/living/carbon/human/ZImpactDamage(turf/target_turf, levels)
	if(stat != CONSCIOUS) // you're not The One
		return ..()
	// Cat-people always land on their feet
	if(isfelinid(src) || istajaran(src))
		// Check to make sure legs are working
		var/obj/item/bodypart/left_leg = get_bodypart(BODY_ZONE_L_LEG)
		var/obj/item/bodypart/right_leg = get_bodypart(BODY_ZONE_R_LEG)
		if(left_leg || right_leg || !left_leg.bodypart_disabled || !right_leg.bodypart_disabled)
			Stun(0.5 SECONDS) // You can't move and you can't use items
			// Nailed it!
			visible_message(span_notice("[src] lands elegantly on [p_their()] feet!"),
				span_warning("You fall [levels > 1 ? "[levels] levels" : "one level"] into [target_turf], perfecting the landing!"))
			return

	var/obj/item/organ/external/wings/gliders = getorgan(/obj/item/organ/external/wings)
	if((HAS_TRAIT(src, TRAIT_FREERUNNING) && levels < 2) || gliders?.can_soften_fall()) // the power of parkour or wings allows falling short distances unscathed
		visible_message(span_danger("[src] makes a hard landing on [target_turf] but remains unharmed from the fall."), \
				span_userdanger("You brace for the fall. You make a hard landing on [target_turf] but remain unharmed."))
		Knockdown(levels * 40)
		return
	return ..()
