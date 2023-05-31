#define BALLMER_PEAK_LOW_END 12.9
#define BALLMER_PEAK_HIGH_END 13.8
#define BALLMER_PEAK_WINDOWS_ME 26

/datum/status_effect/inebriated/drunk/on_tick_effects()
	// Handle the Ballmer Peak.
	// If our owner is a scientist (has the trait "TRAIT_BALLMER_SCIENTIST"), there's a 5% chance
	// that they'll say one of the special "ballmer message" lines, depending their drunk-ness level.
	var/obj/item/organ/internal/liver/liver_organ = owner.get_organ_slot(ORGAN_SLOT_LIVER)
	if(liver_organ && HAS_TRAIT(liver_organ, TRAIT_BALLMER_SCIENTIST) && prob(5))
		if(drunk_value >= BALLMER_PEAK_LOW_END && drunk_value <= BALLMER_PEAK_HIGH_END)
			owner.say(pick_list_replacements(VISTA_FILE, "ballmer_good_msg"), forced = "ballmer")

		if(drunk_value > BALLMER_PEAK_WINDOWS_ME) // by this point you're into windows ME territory
			owner.say(pick_list_replacements(VISTA_FILE, "ballmer_windows_me_msg"), forced = "ballmer")

	// Drunk slurring scales in intensity based on how drunk we are -at 41 you will likely not even notice it,
	// but when we start to scale up you definitely will. And drunk people will always lose jitteriness.
	if(drunk_value >= TIPSY_THRESHOLD)
		owner.adjust_jitter(-6 SECONDS)

	// Over 41, we have a 10% chance to gain confusion
	if(drunk_value >= 41)
		owner.adjust_timed_status_effect(4 SECONDS, /datum/status_effect/speech/slurring/drunk, max_duration = 20 SECONDS)
		if(prob(10))
			owner.adjust_confusion(4 SECONDS)

	// Over 61, we start to get blurred vision
	if(drunk_value >= 61)
		owner.set_dizzy_if_lower(45 SECONDS)
		if(prob(15))
			owner.adjust_eye_blur_up_to(4 SECONDS, 20 SECONDS)

	// Over 71, we will constantly have blurry eyes, we might vomit
	if(drunk_value >= 71)
		owner.set_eye_blur_if_lower(20 SECONDS)
		if(prob(3))
			owner.adjust_confusion(15 SECONDS)
			if(iscarbon(owner))
				var/mob/living/carbon/carbon_owner = owner
				carbon_owner.vomit() // Vomiting clears toxloss - consider this a blessing

	// Over 81, we will gain constant toxloss
	if(drunk_value >= 81)
		owner.adjustToxLoss(1)
		if(owner.stat == CONSCIOUS && prob(5))
			to_chat(owner, span_warning("Maybe you should lie down for a bit..."))

	// Over 91, we gain even more toxloss, brain damage, and have a chance of dropping into a long sleep
	if(drunk_value >= 91)
		owner.adjustToxLoss(1)
		owner.adjustOrganLoss(ORGAN_SLOT_BRAIN, 0.4)
		if(owner.stat == CONSCIOUS && prob(20))
			// Don't put us in a deep sleep if the shuttle's here. QoL, mainly.
			if(SSshuttle.emergency.mode == SHUTTLE_DOCKED && is_station_level(owner.z))
				to_chat(owner, span_warning("You're so tired... but you can't miss that shuttle..."))

			else
				to_chat(owner, span_warning("Just a quick nap..."))
				owner.Sleeping(90 SECONDS)

	// And finally, over 100 - let's be honest, you shouldn't be alive by now.
	if(drunk_value >= 101)
		owner.adjustToxLoss(2)

#undef BALLMER_PEAK_LOW_END
#undef BALLMER_PEAK_HIGH_END
#undef BALLMER_PEAK_WINDOWS_ME
