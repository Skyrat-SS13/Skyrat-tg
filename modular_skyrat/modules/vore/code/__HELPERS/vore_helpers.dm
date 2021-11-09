/proc/vore_replace(messages, mob/living/pred=null, mob/living/prey=null, belly=null)
	if (!istext(messages) && !(islist(messages) && length(messages)))
		return ""
	var/message = istext(messages) ? messages : pick(messages)
	var/list/replacements = list("%pred" = "[pred]", "%prey" = "[prey]", "%belly" = "[belly]")
	for (var/replacement in replacements)
		message = replacetext(message, replacement, replacements[replacement])
	return message

//syntax: %a|what the text seen by the audience is|what the text seen by the pred is|what the text seen by the prey is|
//ie "%a|pred_here|You|pred_here| %a|manages|manage|manages| to eat %a|prey_here|prey_here|you|!"
/proc/person_vore_replace(message, mob/target, mob/living/pred=null, mob/living/prey=null)
	var/static/regex/audience_replace = regex(@"%a\|([\s\S]*?)\|[\s\S]*?\|[\s\S]*?\|", "g")
	var/static/regex/pred_replace = regex(@"%a\|[\s\S]*?\|([\s\S]*?)\|[\s\S]*?\|", "g")
	var/static/regex/prey_replace = regex(@"%a\|[\s\S]*?\|[\s\S]*?\|([\s\S]*?)\|", "g")
	if (target == pred)
		return pred_replace.Replace(message, "$1")
	if (target == prey)
		return prey_replace.Replace(message, "$1")
	return audience_replace.Replace(message, "$1")

/proc/send_vore_message(atom/movable/source, message, pref_respecting, prey=null, replace=TRUE, ignored=null)
	var/turf/T = get_turf(source)
	if (!message || !T)
		return
	var/list/hearers = get_hearers_in_view(DEFAULT_MESSAGE_RANGE, source)
	for (var/mob/hearer in hearers)
		if (!hearer.check_vore_toggle(pref_respecting))
			continue
		if (ignored && (hearer in ignored))
			continue
		if (hearer.lighting_alpha > LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE && T.is_softly_lit() && !in_range(T,hearer))
			continue
		if (replace)
			message = person_vore_replace(message, hearer, source, prey)
		to_chat(hearer, message)

/mob/proc/check_vore_toggle(toggle)
	return (client?.prefs?.vr_prefs?.vore_enabled && (client.prefs.vr_prefs.vore_toggles & toggle))

/mob/living/proc/release_belly_contents()
	var/datum/component/vore/vore = GetComponent(/datum/component/vore)
	for (var/obj/vbelly/belly as anything in vore?.bellies)
		belly.mass_release_from_contents()

/proc/default_belly_info()
	return list("name" = "belly", \
				"desc" = "", \
				"swallow_verb" = "swallow",\
				"mode" = VORE_MODE_HOLD,\
				LIST_DIGEST_PREY = list(),\
				LIST_DIGEST_PRED = list(),\
				LIST_STRUGGLE_INSIDE = list(),\
				LIST_STRUGGLE_OUTSIDE = list(),\
				LIST_EXAMINE = list())

/proc/static_belly_vars() //this could probably be better
	var/static/list/belly_vars = list(	"name", \
										"desc", \
										"swallow_verb",\
										"mode",\
										LIST_DIGEST_PREY,\
										LIST_DIGEST_PRED,\
										LIST_STRUGGLE_INSIDE,\
										LIST_STRUGGLE_OUTSIDE,\
										LIST_EXAMINE)
	return belly_vars
