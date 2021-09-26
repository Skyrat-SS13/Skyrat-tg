GLOBAL_LIST_INIT(bodyparts_to_convert, list("body_markings", \
"tail", \
"snout", \
"horns", \
"ears", \
"wings", \
"frills", \
"spines", \
"legs", \
"caps", \
"moth_antennae", \
"moth_markings", \
"fluff", \
"head_acc", \
"ipc_screen", \
"ipc_antenna", \
"ipc_chassis", \
"neck_acc", \
"skrell_hair", \
"taur", \
"xenodorsal", \
"xenohead", \
"penis", \
"testicles", \
"womb", \
"vagina", \
"breasts",))

/datum/preferences/proc/migrate_skyrat(savefile/S)
	if(features["flavor_text"])
		write_preference(GLOB.preference_entries[/datum/preference/text/flavor_text], features["flavor_text"])

	var/ooc_prefs
	READ_FILE(S["ooc_prefs"], ooc_prefs)
	if(ooc_prefs)
		write_preference(GLOB.preference_entries[/datum/preference/text/ooc_notes], ooc_prefs)

	if(features["mcolor"] || features["mcolor2"] || features["mcolor3"])
		var/list/colors = list()
		if(features["mcolor"])
			colors[1] = features["mcolor"]
		else
			colors[1] = random_color()
		if(features["mcolor2"])
			colors[2] = features["mcolor2"]
		else
			colors[2] = random_color()
		if(features["mcolor3"])
			colors[3] = features["mcolor3"]
		else
			colors[3] = random_color()

		colors[1] = expand_three_digit_color(colors[1])
		colors[2] = expand_three_digit_color(colors[2])
		colors[3] = expand_three_digit_color(colors[3])

		write_preference(GLOB.preference_entries[/datum/preference/tri_color/mutant_colors], colors)

/datum/preferences/proc/load_from_legacy_mutantparts()
	for(var/body_part in GLOB.bodyparts_to_convert)
		if(mutant_bodyparts[body_part])
			var/type = mutant_bodyparts[body_part][MUTANT_INDEX_NAME]
			var/list/colors = mutant_bodyparts[body_part][MUTANT_INDEX_COLOR_LIST]
			colors[1] = expand_three_digit_color(colors[1])
			colors[2] = expand_three_digit_color(colors[2])
			colors[3] = expand_three_digit_color(colors[3])
			for(var/datum/preference/preference as anything in get_preferences_in_priority_order())
				if(!preference.relevant_mutant_bodypart || preference.relevant_mutant_bodypart != body_part)
					continue
				if(type)
					if(istype(preference, /datum/preference/toggle))
						write_preference(preference, TRUE)
						continue
					if(istype(preference, /datum/preference/choiced))
						write_preference(preference, type)
						continue
				if(colors)
					if(istype(preference, /datum/preference/tri_color))
						write_preference(preference, colors)
						continue
