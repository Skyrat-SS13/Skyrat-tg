/mob/living/carbon/human/proc/adjust_pleasure(pleas = 0)
	if(stat >= DEAD || !client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return

	if(pleasure >= 100) // lets cum
		climax(manual = FALSE)

	pleasure = clamp(pleasure + pleas, AROUSAL_MINIMUM, AROUSAL_LIMIT)
