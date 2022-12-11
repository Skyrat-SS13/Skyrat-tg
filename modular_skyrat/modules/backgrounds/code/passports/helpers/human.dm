/mob/living/carbon/human
	var/origin
	var/social_background
	var/employment

/mob/living/carbon/human/get_passport(hand_first = TRUE)
	. = ..()
	if(. && hand_first)
		return
	// Check inventory slots
	return (passport?.get_passport() || belt?.get_passport())

/// Tries to give a passport to a human mob. If the user hasn't selected a social backgound, they'll spawn with the default passport.
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
