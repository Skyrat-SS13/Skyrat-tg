/mob/living/carbon/human/proc/adjustPleasure(pleas = 0)
	if(stat >= DEAD)
		return
	if(client?.prefs?.read_preference(/datum/preference/toggle/erp))
		pleasure += pleas
		if(pleasure >= 100) // lets cum
			climax(FALSE)
	else
		pleasure -= abs(pleas)
	pleasure = clamp(pleasure, 0, AROUSAL_LIMIT)
