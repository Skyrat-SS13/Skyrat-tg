/proc/vore_replace(messages, mob/living/pred=null, mob/living/prey=null)
	if (!istext(messages) && !(islist(messages) && length(messages)))
		return ""
	var/message = istext(messages) ? messages : pick(messages)
	var/list/replacements = list("%pred" = "[pred]", "%prey" = "[prey]")
	for (var/replacement in replacements)
		message = replacetext(message, replacement, replacements[replacement])
	return message

/proc/send_vore_message(atom/movable/source, message, pref_respecting)
	var/turf/T = get_turf(source)
	if (!message || !T)
		return
	var/list/hearers = get_hearers_in_view(DEFAULT_MESSAGE_RANGE, source)
	for (var/mob/hearer in hearers)
		if (!hearer.client?.prefs?.vr_prefs?.vore_enabled || !(hearer.client?.prefs?.vr_prefs?.vore_toggles & pref_respecting))
			continue
		if (hearer.lighting_alpha > LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE && T.is_softly_lit() && !in_range(T,hearer))
			continue
		to_chat(hearer, message)

/mob/living/proc/release_belly_contents()
	var/datum/component/vore/vore = GetComponent(/datum/component/vore)
	for (var/obj/vbelly/belly as anything in vore?.bellies)
		belly.mass_release_from_contents()

/proc/default_belly_info()
	return list(name = "belly", "desc" = "", "mode" = VORE_MODE_HOLD,\
				LIST_DIGEST_PREY = list(),\
				LIST_DIGEST_PRED = list(),\
				LIST_STRUGGLE_INSIDE = list(),\
				LIST_STRUGGLE_OUTSIDE = list(),\
				LIST_EXAMINE = list())
