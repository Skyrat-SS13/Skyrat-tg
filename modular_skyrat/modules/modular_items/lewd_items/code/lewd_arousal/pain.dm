// I guess some people enjoy it.

/mob/living/carbon/human/proc/get_pain()
	return pain

/mob/living/carbon/human/proc/adjustPain(change_amount = 0)
	if(stat != DEAD && client?.prefs?.read_preference(/datum/preference/toggle/erp))
		if(pain > pain_limit || change_amount > pain_limit / 10) // pain system // YOUR SYSTEM IS PAIN, WHY WE'RE GETTING AROUSED BY STEPPING ON ANTS?!
			if(HAS_TRAIT(src, TRAIT_MASOCHISM))
				var/arousal_adjustment = change_amount - (pain_limit / 10)
				if(arousal_adjustment > 0)
					adjustArousal(-arousal_adjustment)
			else
				if(change_amount > 0)
					adjustArousal(-change_amount)
			if(prob(2) && pain > pain_limit && change_amount > pain_limit / 10)
				try_lewd_autoemote(pick("scream", "shiver")) //SCREAM!!!
		else
			if(change_amount > 0)
				adjustArousal(change_amount)
			if(HAS_TRAIT(src, TRAIT_MASOCHISM))
				var/pleasure_adjustment = change_amount / 2
				adjustPleasure(pleasure_adjustment)
		pain += change_amount
	else
		pain -= abs(change_amount)
	pain = min(max(pain, 0), 100)
