// I guess some people enjoy it.

/// Adds or removes pain, this should be used instead of the modifying the var, due to quirk logic.
/// Makes the human scream and shiver when pain hits the soft limit, provided autoemote is enabled.
/mob/living/proc/adjust_pain(change_amount = 0)
	return

/mob/living/carbon/human/adjust_pain(change_amount = 0)
	if(stat >= DEAD || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return

	if(pain > pain_limit || change_amount > pain_limit / 10) // pain system // YOUR SYSTEM IS PAIN, WHY WE'RE GETTING AROUSED BY STEPPING ON ANTS?!
		if(HAS_TRAIT(src, TRAIT_MASOCHISM))
			var/arousal_adjustment = change_amount - (pain_limit / 10)
			if(arousal_adjustment > 0)
				adjust_arousal(-arousal_adjustment)
		else
			if(change_amount > 0)
				adjust_arousal(-change_amount)
		if(prob(2) && pain > pain_limit && change_amount > pain_limit / 10)
			try_lewd_autoemote(pick("scream", "shiver")) //SCREAM!!!

	else if(HAS_TRAIT(src, TRAIT_MASOCHISM))
		if(change_amount > 0)
			adjust_arousal(change_amount)
		adjust_pleasure(change_amount / 2)

	pain = clamp(pain + change_amount, AROUSAL_MINIMUM, AROUSAL_LIMIT)
