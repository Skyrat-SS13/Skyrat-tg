/proc/pick_and_replace(messages, list/replacements)
	if (!length(messages))
		return ""
	var/message = pick(messages)
	for (var/replacement in replacements)
		message = replacetext(message, replacement, replacements[replacement])
	return message

/proc/send_vore_message(atom/movable/source, message, pref_respecting)
	var/turf/T = get_turf(source)
	if (!message || !T)
		return
	var/list/hearers = get_hearers_in_view(DEFAULT_MESSAGE_RANGE, source)
	for (var/mob/hearer in hearers)
		if (!hearer.client?.vr_prefs?.vore_enabled || !(hearer.client?.vr_prefs?.vore_toggles & pref_respecting))
			continue
		if (hearer.lighting_alpha > LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE && T.is_softly_lit() && !in_range(T,hearer))
			continue
		to_chat(hearer, message)

/mob/living/proc/release_belly_contents()
	var/datum/component/vore/vore = GetComponent(/datum/component/vore)
	if (vore?.bellies)
		for (var/obj/vbelly/belly as anything in bellies)
			belly.mass_release_from_contents()