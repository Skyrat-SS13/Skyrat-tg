// Start Backgrounds overrides.
/mob/living/carbon/human
	/// The origin datum of the human. Can be null.
	var/origin
	/// The social background datum of the human. Can be null.
	var/social_background
	/// The employment datum of the human. Can be null.
	var/employment

/mob/living/carbon/human/get_passport(hand_first = TRUE)
	. = ..()
	if(. && hand_first)
		return
	// Check inventory slots
	return (passport?.get_passport() || belt?.get_passport())

/// Tries to give a passport to a human mob. If the mob hasn't got a social backgound, they'll spawn with the default passport.
/mob/living/carbon/human/proc/give_passport()
	var/obj/item/passport/passport = /obj/item/passport

	if(social_background)
		var/datum/background_info/social_background/faction = GLOB.social_backgrounds[social_background]
		passport = faction.passport

	passport = new passport()
	passport.imprint_owner(real_name, age, social_background, employment)

	if(!equip_to_slot_if_possible(passport, ITEM_SLOT_PASSPORT, disable_warning = TRUE, bypass_equip_delay_self = TRUE, initial = TRUE) && !dropItemToGround(passport, force = TRUE, silent = TRUE))
		message_admins("ERROR: Unable to drop item [passport] from [src] (\ref[src])!")
		CRASH("ERROR: Unable to drop item [passport] from [src] (\ref[src])!")
		// Not qdeleting cause admins might want to debug this.

// End Backgrounds overrides.

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
