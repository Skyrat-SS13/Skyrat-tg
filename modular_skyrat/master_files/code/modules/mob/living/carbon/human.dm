/mob/living/carbon/human/ZImpactDamage(turf/T, levels)
	//Non cat-people smash into the ground
	if(!isfelinid(src))
		return ..()
	//Check to make sure legs are working
	var/obj/item/bodypart/left_leg = get_bodypart(BODY_ZONE_L_LEG)
	var/obj/item/bodypart/right_leg = get_bodypart(BODY_ZONE_R_LEG)
	if(!left_leg || !right_leg || left_leg.bodypart_disabled || right_leg.bodypart_disabled)
		return ..()
	//Nailed it!
	visible_message("<span class='notice'>[src] lands elegantly on [p_their()] feet!</span>",
		"<span class='warning'>You fall [levels] level[levels > 1 ? "s" : ""] into [T], perfecting the landing!</span>")
