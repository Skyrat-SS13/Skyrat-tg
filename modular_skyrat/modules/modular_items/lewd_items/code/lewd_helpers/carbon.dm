// Let's not force lewd emotes from folk who don't want them, mmm~?
/mob/living/proc/try_lewd_autoemote(emote)
	if(!client?.prefs?.read_preference(/datum/preference/toggle/erp/autoemote))
		return
	emote(emote)
