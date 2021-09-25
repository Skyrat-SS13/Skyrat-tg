#define CHAR_TAB_APPEARANCE 1
#define CHAR_TAB_MARKINGS 2
#define CHAR_TAB_BACKGROUND 3
#define CHAR_TAB_AUGMENTS 4

#define APPEARANCE_CATEGORY_COLUMN "<td valign='top' width='14%'>"
#define MAX_MUTANT_ROWS 4

/datum/preferences
	/// Loadout prefs. Assoc list of [typepaths] to [associated list of item info].
	var/list/loadout_list
	/// Associative list, keyed by language typepath, pointing to LANGUAGE_UNDERSTOOD, or LANGUAGE_SPOKEN, for whether we understand or speak the language
	var/list/languages = list()
	/// List of chosen augmentations. It's an associative list with key name of the slot, pointing to a typepath of an augment define
	var/augments = list()
	/// List of chosen preferred styles for limb replacements
	var/augment_limb_styles = list()
	/// Which augment slot we currently have chosen, this is for UI display
	var/chosen_augment_slot
	/// Has to include all information that extra organs from mutant bodyparts would need. (so far only genitals now)
	var/list/features = MANDATORY_FEATURE_LIST
	/// A list containing all of our mutant bodparts
	var/list/list/mutant_bodyparts = list()
	/// A list of all bodymarkings
	var/list/list/body_markings = list()
	/// Current tab of html advanced prefs
	var/character_settings_tab = CHAR_TAB_APPEARANCE

	/// Will the person see accessories not meant for their species to choose from
	var/mismatched_customization = FALSE

	/// Allows the user to freely color his body markings and mutant parts.
	var/allow_advanced_colors = FALSE

	/// Preference of how the preview should show the character.
	var/preview_pref = PREVIEW_PREF_JOB

	var/needs_update = TRUE

	var/arousal_preview = AROUSAL_NONE

	var/datum/species/pref_species

	/// Chosen cultural informations
	var/pref_culture = /datum/cultural_info/culture/generic
	var/pref_location = /datum/cultural_info/location/generic
	var/pref_faction = /datum/cultural_info/faction/none
	/// Whether someone wishes to see more information regarding either of those
	var/culture_more_info = FALSE
	var/location_more_info = FALSE
	var/faction_more_info = FALSE

	//BACKGROUND STUFF
	var/general_record = ""
	var/security_record = ""
	var/medical_record = ""

	var/background_info = ""
	var/exploitable_info = ""

	///Whether the user wants to see body size being shown in the preview
	var/show_body_size = FALSE

	///Alternative job titles stored in preferences. Assoc list, ie. alt_job_titles["Scientist"] = "Cytologist"
	var/list/alt_job_titles = list()

/datum/preferences/proc/species_updated(species_type)
	if(!update_pref_species())
		return
	var/list/new_features = pref_species.get_random_features() //We do this to keep flavor text, genital sizes etc.
	for(var/key in features)
		new_features[key] = features[key]
	features = new_features
	mutant_bodyparts = pref_species.get_random_mutant_bodyparts(features)
	body_markings = pref_species.get_random_body_markings(features)
	if(pref_species.use_skintones)
		features["uses_skintones"] = TRUE
	//We reset the quirk-based stuff
	augments = list()
	all_quirks = list()
	//Reset cultural stuff
	pref_culture = pref_species.cultures[1]
	pref_location = pref_species.locations[1]
	pref_faction = pref_species.factions[1]
	try_get_common_language()
	validate_languages()
	save_character()

/datum/preferences/proc/update_pref_species()
	var/species_type = read_preference(/datum/preference/choiced/species)
	if(pref_species)
		if(pref_species.type == species_type)
			return FALSE
		QDEL_NULL(pref_species)
	pref_species = new species_type()
	return TRUE

/datum/preferences/proc/SkyratTopic(href, list/href_list, mob/user)
	if(update_pref_species())
		show_advanced_prefs(user)
		return
	if(href_list["task"])
		switch(href_list["task"])
			if("augment_style")
				needs_update = TRUE
				var/slot_name = href_list["slot"]
				var/new_style = input(user, "Choose your character's [slot_name] augmentation style:", "Character Preference")  as null|anything in GLOB.robotic_styles_list
				if(new_style)
					if(new_style == "None")
						if(augment_limb_styles[slot_name])
							augment_limb_styles -= slot_name
					else
						augment_limb_styles[slot_name] = new_style
			if("set_augment")
				if(pref_species.can_augment)
					needs_update = TRUE
					var/typed_path = text2path(href_list["type"])
					var/datum/augment_item/target_aug = GLOB.augment_items[typed_path]
					var/datum/augment_item/current
					if(augments[target_aug.slot])
						current = GLOB.augment_items[augments[target_aug.slot]]
					if(current == target_aug)
						augments -= target_aug.slot
					else if(CanBuyAugment(target_aug, current))
						augments[target_aug.slot] = typed_path
			if("augment_slot")
				var/slot_name = href_list["slot"]
				chosen_augment_slot = slot_name

			if("close_language")
				user << browse(null, "window=culture_lang")
				show_advanced_prefs(user)

			if("cultural")
				switch(href_list["preference"])
					if("general_record")
						var/msg = input(usr, "Set your general record. This is more or less public information, available from security, medical and command consoles", "General Record", general_record) as message|null
						if(!isnull(msg))
							general_record = STRIP_HTML_SIMPLE(msg, MAX_FLAVOR_LEN)

					if("medical_record")
						var/msg = input(usr, "Set your medical record. ", "Medical Record", medical_record) as message|null
						if(!isnull(msg))
							medical_record = STRIP_HTML_SIMPLE(msg, MAX_FLAVOR_LEN)

					if("security_record")
						var/msg = input(usr, "Set your security record. ", "Medical Record", security_record) as message|null
						if(!isnull(msg))
							security_record = STRIP_HTML_SIMPLE(msg, MAX_FLAVOR_LEN)

					if("background_info")
						var/msg = input(usr, "Set your background information. (Where you come from, which culture were you raised in and why you are working here etc.)", "Background Info", background_info) as message|null
						if(!isnull(msg))
							background_info = STRIP_HTML_SIMPLE(msg, MAX_FLAVOR_LEN)

					if("exploitable_info")
						var/msg = input(usr, "Set your exploitable information. This is sensitive informations that antagonists may get to see, recommended for better roleplay experience", "Exploitable Info", exploitable_info) as message|null
						if(!isnull(msg))
							exploitable_info = STRIP_HTML_SIMPLE(msg, MAX_FLAVOR_LEN)

					if("cultural_info_change")
						var/thing = href_list["info"]
						var/list/choice_list = list()
						var/list/iteration_list
						var/list/siphon_list
						switch(thing)
							if(CULTURE_CULTURE)
								iteration_list = pref_species.cultures
								siphon_list = GLOB.culture_cultures
							if(CULTURE_FACTION)
								iteration_list = pref_species.factions
								siphon_list = GLOB.culture_factions
							if(CULTURE_LOCATION)
								iteration_list = pref_species.locations
								siphon_list = GLOB.culture_locations
						for(var/cultural_entity in iteration_list)
							var/datum/cultural_info/CINFO = siphon_list[cultural_entity]
							choice_list[CINFO.name] = cultural_entity
						var/new_cultural_thing = input(user, "Choose your character's [thing]:", "Character Preference")  as null|anything in choice_list
						if(new_cultural_thing)
							switch(thing)
								if(CULTURE_CULTURE)
									pref_culture = choice_list[new_cultural_thing]
								if(CULTURE_FACTION)
									pref_faction = choice_list[new_cultural_thing]
								if(CULTURE_LOCATION)
									pref_location = choice_list[new_cultural_thing]
							validate_languages()

					if("cultural_info_toggle")
						var/thing = href_list["info"]
						switch(thing)
							if(CULTURE_CULTURE)
								culture_more_info = !culture_more_info
							if(CULTURE_FACTION)
								faction_more_info = !faction_more_info
							if(CULTURE_LOCATION)
								location_more_info = !location_more_info

					if("language")
						var/target_lang = text2path(href_list["lang"])
						var/level = text2num(href_list["level"])
						var/required_lang = get_required_languages()
						if(required_lang[target_lang]) //Can't do anything to a required language
							return TRUE
						var/opt_langs = get_optional_languages()
						if(!opt_langs[target_lang])
							return TRUE
						if(!level)
							languages -= target_lang
						else if(can_buy_language(target_lang, level))
							languages[target_lang] = level
						ShowLangMenu(user)
						return TRUE

					if("language_button")
						ShowLangMenu(user)
						return TRUE
			if("mutant_color")
				needs_update = TRUE
				var/new_mutantcolor = input(user, "Choose your character's primary color:", "Character Preference","#"+features["mcolor"]) as color|null
				if(new_mutantcolor)
					if(new_mutantcolor == "#000000")
						features["mcolor"] = pref_species.default_color
					else
						features["mcolor"] = sanitize_hexcolor(new_mutantcolor)
					if(!allow_advanced_colors)
						reset_colors()

			if("mutant_color2")
				needs_update = TRUE
				var/new_mutantcolor = input(user, "Choose your character's secondary color:", "Character Preference","#"+features["mcolor2"]) as color|null
				if(new_mutantcolor)
					if(new_mutantcolor == "#000000")
						features["mcolor2"] = pref_species.default_color
					else
						features["mcolor2"] = sanitize_hexcolor(new_mutantcolor)
					if(!allow_advanced_colors)
						reset_colors()

			if("mutant_color3")
				needs_update = TRUE
				var/new_mutantcolor = input(user, "Choose your character's tertiary color:", "Character Preference","#"+features["mcolor3"]) as color|null
				if(new_mutantcolor)
					if(new_mutantcolor == "#000000")
						features["mcolor3"] = pref_species.default_color
					else
						features["mcolor3"] = sanitize_hexcolor(new_mutantcolor)
					if(!allow_advanced_colors)
						reset_colors()

			if("change_marking")
				needs_update = TRUE
				switch(href_list["preference"])
					if("use_preset")
						var/action = tgui_alert(user, "Are you sure you want to use a preset (This will clear your existing markings)?", "", list("Yes", "No"))
						if(action && action == "Yes")
							var/list/candidates = GLOB.body_marking_sets.Copy()
							if(!mismatched_customization)
								for(var/name in candidates)
									var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
									if(BMS.recommended_species && !(pref_species.id in BMS.recommended_species))
										candidates -= name
							if(length(candidates) == 0)
								return
							var/desired_set = input(user, "Choose your new body markings:", "Character Preference") as null|anything in candidates
							if(desired_set)
								var/datum/body_marking_set/BMS = GLOB.body_marking_sets[desired_set]
								body_markings = assemble_body_markings_from_set(BMS, features, pref_species)

					if("reset_color")
						var/zone = href_list["key"]
						var/name = href_list["name"]
						if(!body_markings[zone] || !body_markings[zone][name])
							return
						var/datum/body_marking/BM = GLOB.body_markings[name]
						body_markings[zone][name] = BM.get_default_color(features, pref_species)
					if("change_color")
						var/zone = href_list["key"]
						var/name = href_list["name"]
						if(!body_markings[zone] || !body_markings[zone][name])
							return
						var/color = body_markings[zone][name]
						var/new_color = input(user, "Choose your markings color:", "Character Preference","#[color]") as color|null
						if(new_color)
							if(!body_markings[zone] || !body_markings[zone][name])
								return
							body_markings[zone][name] = sanitize_hexcolor(new_color)
					if("marking_move_up")
						var/zone = href_list["key"]
						var/name = href_list["name"]
						var/list/marking_list = LAZYACCESS(body_markings, zone)
						var/current_index = LAZYFIND(marking_list, name)
						if(!current_index || --current_index < 1)
							return
						var/marking_content = marking_list[name]
						marking_list -= name
						marking_list.Insert(current_index, name)
						marking_list[name] = marking_content
					if("marking_move_down")
						var/zone = href_list["key"]
						var/name = href_list["name"]
						var/list/marking_list = LAZYACCESS(body_markings, zone)
						var/current_index = LAZYFIND(marking_list, name)
						if(!current_index || ++current_index > length(marking_list))
							return
						var/marking_content = marking_list[name]
						marking_list -= name
						marking_list.Insert(current_index, name)
						marking_list[name] = marking_content
					if("add_marking")
						var/zone = href_list["key"]
						if(!GLOB.body_markings_per_limb[zone])
							return
						var/list/possible_candidates = GLOB.body_markings_per_limb[zone].Copy()
						if(body_markings[zone])
							//To prevent exploiting hrefs to bypass the marking limit
							if(body_markings[zone].len >= MAXIMUM_MARKINGS_PER_LIMB)
								return
							//Remove already used markings from the candidates
							for(var/list/this_list in body_markings[zone])
								possible_candidates -= this_list[MUTANT_INDEX_NAME]
						if(!mismatched_customization)
							for(var/name in possible_candidates)
								var/datum/body_marking/BD = GLOB.body_markings[name]
								if((BD.recommended_species && !(pref_species.id in BD.recommended_species)))
									possible_candidates -= name

						if(possible_candidates.len == 0)
							return
						var/desired_marking = input(user, "Choose your new marking to add:", "Character Preference") as null|anything in possible_candidates
						if(desired_marking)
							var/datum/body_marking/BD = GLOB.body_markings[desired_marking]
							if(!body_markings[zone])
								body_markings[zone] = list()
							body_markings[zone][BD.name] = BD.get_default_color(features, pref_species)

					if("remove_marking")
						var/zone = href_list["key"]
						var/name = href_list["name"]
						if(!body_markings[zone] || !body_markings[zone][name])
							return
						body_markings[zone] -= name
						if(body_markings[zone].len == 0)
							body_markings -= zone
					if("change_marking")
						var/zone = href_list["key"]
						var/changing_name = href_list["name"]

						var/list/possible_candidates = GLOB.body_markings_per_limb[zone].Copy()
						if(body_markings[zone])
							//Remove already used markings from the candidates
							for(var/keyed_name in body_markings[zone])
								possible_candidates -= keyed_name
						if(!mismatched_customization)
							for(var/name in possible_candidates)
								var/datum/body_marking/BD = GLOB.body_markings[name]
								if(BD.recommended_species && !(pref_species.id in BD.recommended_species))
									possible_candidates -= name
						if(possible_candidates.len == 0)
							return
						var/desired_marking = input(user, "Choose a marking to change the current one to:", "Character Preference") as null|anything in possible_candidates
						if(desired_marking)
							if(!body_markings[zone] || !body_markings[zone][changing_name])
								return
							var/held_index = LAZYFIND(body_markings[zone], changing_name)
							var/datum/body_marking/BD = GLOB.body_markings[desired_marking]
							var/marking_content
							if(allow_advanced_colors)
								marking_content = body_markings[zone][changing_name]
							else
								marking_content = BD.get_default_color(features, pref_species)
							body_markings[zone] -= changing_name
							body_markings[zone].Insert(held_index, desired_marking)
							body_markings[zone][desired_marking] = marking_content
			if("uses_skintones")
				needs_update = TRUE
				features["uses_skintones"] = !features["uses_skintones"]
			if("change_arousal_preview")
				var/list/gen_arous_trans = list("Not aroused" = AROUSAL_NONE,
					"Partly aroused" = AROUSAL_PARTIAL,
					"Very aroused" = AROUSAL_FULL
					)
				var/new_arousal = input(user, "Choose your character's arousal:", "Character Preference")  as null|anything in gen_arous_trans
				if(new_arousal)
					arousal_preview = gen_arous_trans[new_arousal]
					needs_update = TRUE
			if("change_genitals")
				needs_update = TRUE
				switch(href_list["preference"])
					if("breasts_size")
						var/new_size = input(user, "Choose your character's breasts size:", "Character Preference") as null|anything in GLOB.preference_breast_sizes
						if(new_size)
							features["breasts_size"] = breasts_cup_to_size(new_size)
					if("breasts_lactation")
						features["breasts_lactation"] = !features["breasts_lactation"]
					if("penis_taur_mode")
						features["penis_taur_mode"] = !features["penis_taur_mode"]
					if("penis_size")
						var/new_length = input(user, "Choose your penis length:\n([PENIS_MIN_LENGTH]-[PENIS_MAX_LENGTH] in inches)", "Character Preference") as num|null
						if(new_length)
							features["penis_size"] = clamp(round(new_length, 1), PENIS_MIN_LENGTH, PENIS_MAX_LENGTH)
							if(features["penis_girth"] >= new_length)
								features["penis_girth"] = new_length - 1
					if("penis_sheath")
						var/new_sheath = input(user, "Choose your penis sheath", "Character Preference") as null|anything in SHEATH_MODES
						if(new_sheath)
							features["penis_sheath"] = new_sheath
					if("penis_girth")
						var/max_girth = PENIS_MAX_GIRTH
						if(features["penis_size"] >= max_girth)
							max_girth = features["penis_size"]
						var/new_girth = input(user, "Choose your penis girth:\n(1-[max_girth] (based on length) in inches)", "Character Preference") as num|null
						if(new_girth)
							features["penis_girth"] = clamp(round(new_girth, 1), 1, max_girth)
					if("balls_size")
						var/new_size = input(user, "Choose your character's balls size:", "Character Preference") as null|anything in GLOB.preference_balls_sizes
						if(new_size)
							features["balls_size"] = balls_description_to_size(new_size)
			if("change_bodypart")
				needs_update = TRUE
				switch(href_list["preference"])
					if("change_name")
						var/key = href_list["key"]
						if(!mutant_bodyparts[key])
							return
						var/new_name
						if(mismatched_customization)
							new_name = input(user, "Choose your character's [key]:", "Character Preference") as null|anything in accessory_list_of_key_for_species(key, pref_species, TRUE, parent.ckey)
						else
							new_name = input(user, "Choose your character's [key]:", "Character Preference") as null|anything in accessory_list_of_key_for_species(key, pref_species, FALSE, parent.ckey)
						if(new_name && mutant_bodyparts[key])
							mutant_bodyparts[key][MUTANT_INDEX_NAME] = new_name
							validate_color_keys_for_part(key)
							if(!allow_advanced_colors)
								var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][new_name]
								mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)
					if("change_color")
						var/key = href_list["key"]
						if(!mutant_bodyparts[key])
							return
						var/list/colorlist = mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST]
						var/index = text2num(href_list["color_index"])
						if(colorlist.len < index)
							return
						var/new_color = input(user, "Choose your character's [key] color:", "Character Preference","#[colorlist[index]]") as color|null
						if(new_color)
							colorlist[index] = sanitize_hexcolor(new_color)
					if("reset_color")
						var/key = href_list["key"]
						if(!mutant_bodyparts[key])
							return
						var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]
						mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)
					if("reset_all_colors")
						var/action = tgui_alert(user, "Are you sure you want to reset all colors?", "", list("Yes", "No"))
						if(action == "Yes")
							reset_colors()
	else
		switch(href_list["preference"])
			if("custom_species")
				var/new_name = input(user, "Choose your character's species name:", "Character Preference")  as text|null
				if(new_name)
					if(new_name == "")
						features["custom_species"] = null
					else
						features["custom_species"] = reject_bad_name(new_name)
				else
					features["custom_species"] = null
			if("flavor_text")
				var/msg = input(usr, "Set the flavor text in your 'examine' verb. This is for describing what people can tell by looking at your character.", "Flavor Text", features["flavor_text"]) as message|null //Skyrat edit, removed stripped_multiline_input()
				if(!isnull(msg))
					features["flavor_text"] = STRIP_HTML_SIMPLE(msg, MAX_FLAVOR_LEN)
			if("silicon_flavor_text")
				var/msg = input(usr, "Set the flavor text in your 'examine' verb. This is for describing what people can tell by looking at your character.", "Silicon Flavor Text", features["silicon_flavor_text"]) as message|null
				if(!isnull(msg))
					features["silicon_flavor_text"] = STRIP_HTML_SIMPLE(msg, MAX_FLAVOR_LEN)
			if("show_body_size")
				needs_update = TRUE
				show_body_size = !show_body_size

			if("body_size")
				needs_update = TRUE
				var/new_body_size = input(user, "Choose your desired sprite size:\n([BODY_SIZE_MIN*100]%-[BODY_SIZE_MAX*100]%), Warning: May make your character look distorted", "Character Preference", features["body_size"]*100) as num|null
				if(new_body_size)
					new_body_size = clamp(new_body_size * 0.01, BODY_SIZE_MIN, BODY_SIZE_MAX)
					features["body_size"] = new_body_size
			if("character_tab")
				character_settings_tab = text2num(href_list["tab"])
			if("adv_colors")
				if(allow_advanced_colors)
					var/action = tgui_alert(user, "Are you sure you want to disable advanced colors (This will reset your colors back to default)?", "", list("Yes", "No"))
					if(action && action != "Yes")
						return
				allow_advanced_colors = !allow_advanced_colors
				if(!allow_advanced_colors)
					reset_colors()
			if("mismatch")
				mismatched_customization = !mismatched_customization
			if("reset_all_colors")
				var/action = tgui_alert(user, "Are you sure you want to reset all colors?", "", list("Yes", "No"))
				if(action == "Yes")
					reset_colors()
			if("save")
				save_character()
			if("load")
				load_character()
	show_advanced_prefs(user)

/datum/preferences/proc/show_advanced_prefs(mob/user)
	update_pref_species()
	if(needs_update)
		character_preview_view?.update_body()
		needs_update = FALSE
	var/list/dat = list()
	dat += "<style>span.color_holder_box{display: inline-block; width: 20px; height: 8px; border:1px solid #000; padding: 0px;}</style>"
	dat += "<center>"
	dat += "<a href='?src=[REF(src)];preference=character_tab;tab=[CHAR_TAB_APPEARANCE]' [character_settings_tab == CHAR_TAB_APPEARANCE ? "class='linkOn'" : ""]>Appearance</a>"
	dat += "<a href='?src=[REF(src)];preference=character_tab;tab=[CHAR_TAB_MARKINGS]' [character_settings_tab == CHAR_TAB_MARKINGS ? "class='linkOn'" : ""]>Markings</a>"
	dat += "<a href='?src=[REF(src)];preference=character_tab;tab=[CHAR_TAB_BACKGROUND]' [character_settings_tab == CHAR_TAB_BACKGROUND ? "class='linkOn'" : ""]>Background</a>"
	dat += "<a href='?src=[REF(src)];preference=character_tab;tab=[CHAR_TAB_AUGMENTS]' [character_settings_tab == CHAR_TAB_AUGMENTS ? "class='linkOn'" : ""]>Augmentation</a>"
	dat += "</center>"
	dat += "<HR>"
	dat += "<center>"
	dat += "<table width='100%'>"
	dat += "<tr>"
	switch(character_settings_tab)
		if(CHAR_TAB_AUGMENTS)
			dat += "<td width=65%>"
			if(!(!SSquirks || !SSquirks.quirks.len))
				dat += "<b>Remaining quirk points: [GetQuirkBalance()]</b>"
			dat += "</td>"
		else
			dat += "<td width=35%>"
			dat += "<b>Mismatched parts:</b> <a href='?src=[REF(src)];preference=mismatch'>[(mismatched_customization) ? "Enabled" : "Disabled"]</a>"
			dat += "</td>"
			dat += "<td width=30%>"
			dat += "<b> Color customization:</b> <a href='?src=[REF(src)];preference=adv_colors'>[(allow_advanced_colors) ? "Enabled" : "Disabled"]</a>"
			if(allow_advanced_colors)
				dat += "<a href='?src=[REF(src)];preference=reset_all_colors'>Reset colors</a><BR>"
			dat += "</td>"
	dat += "</tr>"
	dat += "</table>"
	dat += "</center>"
	dat += "<HR>"
	switch(character_settings_tab)
		if(CHAR_TAB_APPEARANCE)
			//Mutant stuff
			dat += "<table width='100%'><tr>"
			dat += APPEARANCE_CATEGORY_COLUMN
			dat += "<b>Sprite body size:</b><BR><a href='?src=[REF(src)];preference=body_size'>[(features["body_size"] * 100)]%</a> <a href='?src=[REF(src)];preference=show_body_size'>[show_body_size ? "Hide preview" : "Show preview"]</a><BR>"
			dat += "<b>Species Naming:</b><BR><a href='?src=[REF(src)];preference=custom_species'>[(features["custom_species"]) ? features["custom_species"] : "Default"]</a><BR>"
			dat += "<h2>Flavor Text</h2>"
			// Carbon flavor text
			dat += "<a href='?src=[REF(src)];preference=flavor_text'><b>Set Examine Text</b></a><br>"
			if(length(features["flavor_text"]) <= 40)
				if(!length(features["flavor_text"]))
					dat += "\[...\]"
				else
					dat += "[html_encode(features["flavor_text"])]"
			else
				dat += "[copytext(html_encode(features["flavor_text"]), 1, 40)]..."
			dat += "<br>"
			// Silicon flavor text
			dat += "<a href='?src=[REF(src)];preference=silicon_flavor_text'><b>Set Silicon Examine Text</b></a><br>"
			if(length(features["silicon_flavor_text"]) <= 40)
				if(!length(features["silicon_flavor_text"]))
					dat += "\[...\]"
				else
					dat += "[html_encode(features["silicon_flavor_text"])]"
			else
				dat += "[copytext(html_encode(features["silicon_flavor_text"]), 1, 40)]..."
			dat += "</td>"
			var/mutant_category = 0
			var/list/generic_cache = GLOB.generic_accessories
			for(var/key in mutant_bodyparts)
				if(!generic_cache[key]) //This means that we have a mutant bodypart that shouldnt be bundled here (genitals)
					continue
				if(!mutant_category)
					dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<h3>[generic_cache[key]]</h3>"
				dat += print_bodypart_change_line(key)
				dat += "<BR>"
				mutant_category++
				if(mutant_category >= MAX_MUTANT_ROWS)
					dat += "</td>"
					mutant_category = 0
			if(mutant_category)
				dat += "</td>"
				mutant_category = 0
			dat += "</tr></table>"
			dat += "<table width='100%'><tr>"
			if(pref_species.can_have_genitals)
				dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<a href='?src=[REF(src)];task=change_arousal_preview'>Change arousal preview</a>"
				dat += "<h3>Penis</h3>"
				var/penis_name = mutant_bodyparts["penis"][MUTANT_INDEX_NAME]
				dat += print_bodypart_change_line("penis")
				if(penis_name != "None")
					dat += "<br><b>Length: </b> <a href='?src=[REF(src)];key=["penis"];preference=penis_size;task=change_genitals'>[features["penis_size"]]</a> inches."
					dat += "<br><b>Girth: </b> <a href='?src=[REF(src)];key=["penis"];preference=penis_girth;task=change_genitals'>[features["penis_girth"]]</a> inches circumference"
					dat += "<br><b>Sheath: </b> <a href='?src=[REF(src)];key=["penis"];preference=penis_sheath;task=change_genitals'>[features["penis_sheath"]]</a>"
				dat += "<h3>Testicles</h3>"
				var/balls_name = mutant_bodyparts["testicles"][MUTANT_INDEX_NAME]
				dat += print_bodypart_change_line("testicles")
				if(balls_name != "None")
					var/named_size = balls_size_to_description(features["balls_size"])
					dat += "<br><b>Size: </b> <a href='?src=[REF(src)];key=["testicles"];preference=balls_size;task=change_genitals'>[named_size]</a>"
				if(mutant_bodyparts["taur"])
					var/datum/sprite_accessory/taur/TSP = GLOB.sprite_accessories["taur"][mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
					if(TSP.factual && !(TSP.taur_mode & STYLE_TAUR_SNAKE))
						var/text_string = (features["penis_taur_mode"]) ? "Yes" : "No"
						dat += "<br><b>Taur Mode: </b> <a href='?src=[REF(src)];key=["penis"];preference=penis_taur_mode;task=change_genitals'>[text_string]</a>"
				dat += "</td>"
				dat += "</td>"
				dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<b>Uses skintones: </b> <a href='?src=[REF(src)];task=uses_skintones'>[(features["uses_skintones"]) ? "Yes" : "No"]</a>"
				dat += "<h3>Vagina</h3>"
				dat += print_bodypart_change_line("vagina")
				dat += "<h3>Womb</h3>"
				dat += print_bodypart_change_line("womb")
				dat += "</td>"
				dat += APPEARANCE_CATEGORY_COLUMN
				dat += "<BR>"
				dat += "<h3>Breasts</h3>"
				var/breasts_name = mutant_bodyparts["breasts"][MUTANT_INDEX_NAME]
				dat += print_bodypart_change_line("breasts")
				if(breasts_name != "None")
					var/named_size = breasts_size_to_cup(features["breasts_size"])
					var/named_lactation = (features["breasts_lactation"]) ? "Yes" : "No"
					dat += "<br><b>Size: </b> <a href='?src=[REF(src)];key=["breasts"];preference=breasts_size;task=change_genitals'>[named_size]</a>"
					dat += "<br><b>Can Lactate: </b> <a href='?src=[REF(src)];key=["breasts"];preference=breasts_lactation;task=change_genitals'>[named_lactation]</a>"
				dat += "</td>"
			dat += "</tr></table>"

		if(CHAR_TAB_MARKINGS)
			dat += "Use a <b>markings preset</b>: <a href='?src=[REF(src)];preference=use_preset;task=change_marking'>Choose</a>  "
			dat += "<table width='100%' align='center'>"
			dat += " Primary:<span style='border: 1px solid #161616; background-color: #[features["mcolor"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?src=[REF(src)];task=mutant_color'>Change</a>"
			dat += " Secondary:<span style='border: 1px solid #161616; background-color: #[features["mcolor2"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?src=[REF(src)];task=mutant_color2'>Change</a>"
			dat += " Tertiary:<span style='border: 1px solid #161616; background-color: #[features["mcolor3"]];'>&nbsp;&nbsp;&nbsp;</span> <a href='?src=[REF(src)];task=mutant_color3'>Change</a>"
			dat += "</table>"
			dat += "<table width='100%'>"
			dat += "<td valign='top' width='50%'>"
			var/iterated_markings = 0
			for(var/zone in GLOB.marking_zones)
				var/named_zone = " "
				switch(zone)
					if(BODY_ZONE_R_ARM)
						named_zone = "Right Arm"
					if(BODY_ZONE_L_ARM)
						named_zone = "Left Arm"
					if(BODY_ZONE_HEAD)
						named_zone = "Head"
					if(BODY_ZONE_CHEST)
						named_zone = "Chest"
					if(BODY_ZONE_R_LEG)
						named_zone = "Right Leg"
					if(BODY_ZONE_L_LEG)
						named_zone = "Left Leg"
					if(BODY_ZONE_PRECISE_R_HAND)
						named_zone = "Right Hand"
					if(BODY_ZONE_PRECISE_L_HAND)
						named_zone = "Left Hand"
				dat += "<center><h3>[named_zone]</h3></center>"
				dat += "<table align='center'; width='100%'; height='100px'; style='background-color:#13171C'>"
				dat += "<tr style='vertical-align:top'>"
				dat += "<td width=10%><font size=2> </font></td>"
				dat += "<td width=6%><font size=2> </font></td>"
				dat += "<td width=25%><font size=2> </font></td>"
				dat += "<td width=44%><font size=2> </font></td>"
				dat += "<td width=15%><font size=2> </font></td>"
				dat += "</tr>"
				if(body_markings[zone])
					for(var/key in body_markings[zone])
						var/datum/body_marking/BD = GLOB.body_markings[key]
						var/can_move_up = " "
						var/can_move_down = " "
						var/color_line = " "
						var/current_index = LAZYFIND(body_markings[zone], key)
						if(BD.always_color_customizable || allow_advanced_colors)
							var/color = body_markings[zone][key]
							color_line = "<a href='?src=[REF(src)];name=[key];key=[zone];preference=reset_color;task=change_marking'>R</a>"
							color_line += "<a href='?src=[REF(src)];name=[key];key=[zone];preference=change_color;task=change_marking'><span class='color_holder_box' style='background-color:["#[color]"]'></span></a>"
						if(current_index < length(body_markings[zone]))
							can_move_down = "<a href='?src=[REF(src)];name=[key];key=[zone];preference=marking_move_down;task=change_marking'>Down</a>"
						if(current_index > 1)
							can_move_up = "<a href='?src=[REF(src)];name=[key];key=[zone];preference=marking_move_up;task=change_marking'>Up</a>"
						dat += "<tr style='vertical-align:top;'>"
						dat += "<td>[can_move_up]</td>"
						dat += "<td>[can_move_down]</td>"
						dat += "<td><a href='?src=[REF(src)];name=[key];key=[zone];preference=change_marking;task=change_marking'>[key]</a></td>"
						dat += "<td>[color_line]</td>"
						dat += "<td><a href='?src=[REF(src)];name=[key];key=[zone];preference=remove_marking;task=change_marking'>Remove</a></td>"
						dat += "</tr>"
				if(!(body_markings[zone]) || body_markings[zone].len < MAXIMUM_MARKINGS_PER_LIMB)
					dat += "<tr style='vertical-align:top;'>"
					dat += "<td> </td>"
					dat += "<td> </td>"
					dat += "<td> </td>"
					dat += "<td> </td>"
					dat += "<td><a href='?src=[REF(src)];key=[zone];preference=add_marking;task=change_marking'>Add</a></td>"
					dat += "</tr>"
				dat += "</table>"
				iterated_markings += 1
				if(iterated_markings >= 4)
					dat += "<td valign='top' width='50%'>"
					iterated_markings = 0
			dat += "</tr></table>"
		if(CHAR_TAB_BACKGROUND)
			dat += "<b>THE ENTRIES AND THEIR DESCRIPTIONS ARE PLACEHOLDERS AND ARE NOT FINAL.</b><HR>"
			dat += "<table width='100%'>"
			dat += "<tr>"
			dat += "<td width='21%'></td>"
			dat += "<td width='70%'></td>"
			dat += "<td width='9%'></td>"
			dat += "</tr>"
			var/even = FALSE
			for(var/cultural_thing in list(CULTURE_CULTURE, CULTURE_LOCATION, CULTURE_FACTION))
				even = !even
				var/datum/cultural_info/cult
				var/prefix
				var/more = FALSE
				switch(cultural_thing)
					if(CULTURE_CULTURE)
						cult = GLOB.culture_cultures[pref_culture]
						prefix = "Culture"
						more = culture_more_info
					if(CULTURE_LOCATION)
						cult = GLOB.culture_locations[pref_location]
						prefix = "Location"
						more = location_more_info
					if(CULTURE_FACTION)
						cult = GLOB.culture_factions[pref_faction]
						prefix = "Faction"
						more = faction_more_info
				var/cult_desc
				if(more || length(cult.description) <= 160)
					cult_desc = cult.description
				else
					cult_desc = "[copytext(cult.description, 1, 160)]..."
				dat += "<tr style='background-color:[even ? "#13171C" : "#19232C"]'>"
				dat += "<td valign='top'><b>[prefix]:</b> <a href='?src=[REF(src)];preference=cultural_info_change;info=[cultural_thing];task=cultural'>[cult.name]</a><font color='#AAAAAA' size=1><b>[cult.get_extra_desc(more)]</b></font></td>"
				dat += "<td><i>[cult_desc]</i></td>"
				dat += "<td valign='top'><a href='?src=[REF(src)];preference=cultural_info_toggle;info=[cultural_thing];task=cultural'>[more ? "Show Less" : "Show More"]</a></td>"
				dat += "</tr>"
			dat += "</table>"
			dat += "<table width='100%'><tr>"
			dat += "<td valign='top' width=33%>"
			dat += "<center><h2>Languages</h2></center>"
			dat += "<b>Linguistic points: [get_linguistic_points()]</b>"
			for(var/language_path in languages)
				var/datum/language/lang_datum = language_path
				dat += "<BR>[initial(lang_datum.name)] - [languages[language_path] == LANGUAGE_SPOKEN ? "Spoken" : "Understood" ]"
			dat += "<BR><a href='?src=[REF(src)];preference=language_button;task=cultural'>Change Languages...</a>"
			dat += "</td>"
			dat += "<td valign='top' width=33%>"
			dat += "<center><h2>Records</h2></center>"
			dat += "<h2>General</h2>"
			dat += "<a href='?src=[REF(src)];preference=general_record;task=cultural'><b>Set general record</b></a><br>"
			if(length(general_record) <= 40)
				if(!length(general_record))
					dat += "\[...\]"
				else
					dat += "[html_encode(general_record)]"
			else
				dat += "[copytext(html_encode(general_record), 1, 40)]..."
			dat += "<br>"


			dat += "<h2>Medical</h2>"
			dat += "<a href='?src=[REF(src)];preference=medical_record;task=cultural'><b>Set medical record</b></a><br>"
			if(length(medical_record) <= 40)
				if(!length(medical_record))
					dat += "\[...\]"
				else
					dat += "[html_encode(medical_record)]"
			else
				dat += "[copytext(html_encode(medical_record), 1, 40)]..."
			dat += "<br>"


			dat += "<h2>Security</h2>"
			dat += "<a href='?src=[REF(src)];preference=security_record;task=cultural'><b>Set security record</b></a><br>"
			if(length(security_record) <= 40)
				if(!length(security_record))
					dat += "\[...\]"
				else
					dat += "[html_encode(security_record)]"
			else
				dat += "[copytext(html_encode(security_record), 1, 40)]..."
			dat += "<br>"
			dat += "</td>"


			dat += "<td valign='top' width=33%>"
			dat += "<center><h2>Information</h2></center>"
			dat += "<h2>Background</h2>"
			dat += "<a href='?src=[REF(src)];preference=background_info;task=cultural'><b>Set background information</b></a><br>"
			if(length(background_info) <= 40)
				if(!length(background_info))
					dat += "\[...\]"
				else
					dat += "[html_encode(background_info)]"
			else
				dat += "[copytext(html_encode(background_info), 1, 40)]..."
			dat += "<h2>Exploitable</h2>"
			dat += "<a href='?src=[REF(src)];preference=exploitable_info;task=cultural'><b>Set exploitable information</b></a><br>"
			if(length(exploitable_info) <= 40)
				if(!length(exploitable_info))
					dat += "\[...\]"
				else
					dat += "[html_encode(exploitable_info)]"
			else
				dat += "[copytext(html_encode(exploitable_info), 1, 40)]..."
			dat += "</td>"
			dat += "<td width=33%>"
			//Empty column for future stuff here
			dat += "</td>"
			dat += "</tr></table>"
		if(CHAR_TAB_AUGMENTS)
			if(!pref_species.can_augment)
				dat += "Sorry, but your species doesn't support augmentations"
			else if(!SSquirks || !SSquirks.quirks.len)
				dat += "The quirk subsystem is still initializing! Try again in a minute."
			else
				dat += "<table width='100%'><tr>"
				for(var/category_name in GLOB.augment_categories_to_slots)
					dat += "<td valign='top' width='23%'>"
					dat += "<h2>[category_name]:</h2>"
					var/list/slot_list = GLOB.augment_categories_to_slots[category_name]
					for(var/slot_name in slot_list)
						var/link = "href='?src=[REF(src)];task=augment_slot;slot=[slot_name]'"
						var/datum/augment_item/chosen_item
						if(augments[slot_name])
							chosen_item = GLOB.augment_items[augments[slot_name]]
						if(chosen_augment_slot && chosen_augment_slot == slot_name)
							link = "class='linkOn'"
						var/print_name = ""
						if(chosen_item)
							print_name = chosen_item.name
							var/font_color = "#AAAAFF"
							if(chosen_item.cost != 0)
								font_color = chosen_item.cost > 0 ? "#AAFFAA" : "#FFAAAA"
							print_name = "<font color='[font_color]'>[print_name]</font>"
						dat += "<table align='center'; width='100%'; height='100px'; style='background-color:#13171C'>"
						dat += "<tr style='vertical-align:top'><td width='100%' style='background-color:#23273C'><a [link]>[slot_name]</a>: [print_name]</td></tr>"
						if(category_name == AUGMENT_CATEGORY_LIMBS && chosen_item)
							var/datum/augment_item/limb/chosen_limb = chosen_item
							var/print_style = "<font color='#999999'>None</font>"
							if(augment_limb_styles[slot_name])
								print_style = augment_limb_styles[slot_name]
							if(chosen_limb.uses_robotic_styles)
								dat += "<tr style='vertical-align:top'><td width='100%' style='background-color:#16274C'><a href='?src=[REF(src)];task=augment_style;slot=[slot_name]'>Style</a>: [print_style]</td></tr>"
						dat += "<tr style='vertical-align:top'><td width='100%' height='100%'>[chosen_item ? "<i>[chosen_item.description]</i>" : ""]</td></tr>"
						dat += "</table>"
					dat += "</td>"
				dat += "<td valign='top' width='31%'>"
				if(chosen_augment_slot)
					var/list/augment_list = GLOB.augment_slot_to_items[chosen_augment_slot]
					if(augment_list)
						dat += "<table width=100%; style='background-color:#13171C'>"
						dat += "<center><h2>[chosen_augment_slot]</h2></center>"
						dat += "<tr style='vertical-align:top;background-color:#23273C'>"
						dat += "<td width=33%><b>Name</b></td>"
						dat += "<td width=7%><b>Cost</b></td>"
						dat += "<td width=60%><b>Description</b></td>"
						dat += "</tr>"
						var/even = FALSE
						for(var/type_thing in augment_list)
							var/datum/augment_item/aug_datum = GLOB.augment_items[type_thing]
							var/datum/augment_item/current
							even = !even
							if(augments[chosen_augment_slot])
								current = GLOB.augment_items[augments[chosen_augment_slot]]
							var/aug_link = "class='linkOff'"
							var/name_print = aug_datum.name
							if (current == aug_datum)
								aug_link = "class='linkOn' href='?src=[REF(src)];task=set_augment;type=[type_thing]'"
								name_print = "[name_print] (Remove)"
							else if(CanBuyAugment(aug_datum, current))
								aug_link = "href='?src=[REF(src)];task=set_augment;type=[type_thing]'"
							dat += "<tr style='background-color:[even ? "#13171C" : "#19232C"]'>"
							dat += "<td><b><a [aug_link]>[name_print]</a></b></td>"
							dat += "<td><center>[aug_datum.cost]</center></td>"
							dat += "<td><i>[aug_datum.description]</i></td>"
							dat += "</tr>"
						dat += "</table>"
				dat += "</td></tr></table>"
	dat += "<HR><center>"
	dat += "<a href='?src=[REF(src)];preference=load'>Undo</a> "
	dat += "<a href='?src=[REF(src)];preference=save'>Save Setup</a> "
	dat += "</center>"

	var/datum/browser/popup = new(user, "character_setup", "<div align='center'>Character Setup</div>", 840, 770)
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/print_bodypart_change_line(key)
	var/acc_name = mutant_bodyparts[key][MUTANT_INDEX_NAME]
	var/shown_colors = 0
	var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][acc_name]
	var/dat = ""
	if(SA.color_src == USE_MATRIXED_COLORS)
		shown_colors = 3
	else if (SA.color_src == USE_ONE_COLOR)
		shown_colors = 1
	if((allow_advanced_colors || SA.always_color_customizable) && shown_colors)
		dat += "<a href='?src=[REF(src)];key=[key];preference=reset_color;task=change_bodypart'>R</a>"
	dat += "<a href='?src=[REF(src)];key=[key];preference=change_name;task=change_bodypart'>[acc_name]</a>"
	if(allow_advanced_colors || SA.always_color_customizable)
		if(shown_colors)
			dat += "<BR>"
			var/list/colorlist = mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST]
			for(var/i in 1 to shown_colors)
				dat += " <a href='?src=[REF(src)];key=[key];color_index=[i];preference=change_color;task=change_bodypart'><span class='color_holder_box' style='background-color:["#[colorlist[i]]"]'></span></a>"
	return dat

/datum/preferences/proc/reset_colors()
	for(var/key in mutant_bodyparts)
		var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]
		if(SA.always_color_customizable)
			continue
		mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)

	for(var/zone in body_markings)
		var/list/bml = body_markings[zone]
		for(var/key in bml)
			var/datum/body_marking/BM = GLOB.body_markings[key]
			bml[key] = BM.get_default_color(features, pref_species)

/datum/preferences/proc/get_linguistic_points()
	var/points
	points = (QUIRK_LINGUIST in all_quirks) ? LINGUISTIC_POINTS_LINGUIST : LINGUISTIC_POINTS_DEFAULT
	for(var/langpath in languages)
		points -= languages[langpath]
	return points

/datum/preferences/proc/get_required_languages()
	var/list/lang_list = list()
	for(var/cultural_thing in list(CULTURE_CULTURE, CULTURE_LOCATION, CULTURE_FACTION))
		var/datum/cultural_info/cult
		switch(cultural_thing)
			if(CULTURE_CULTURE)
				cult = GLOB.culture_cultures[pref_culture]
			if(CULTURE_LOCATION)
				cult = GLOB.culture_locations[pref_location]
			if(CULTURE_FACTION)
				cult = GLOB.culture_factions[pref_faction]
		if(cult.required_lang)
			lang_list[cult.required_lang] = TRUE
	return lang_list

/datum/preferences/proc/get_optional_languages()
	var/list/lang_list = list()
	for(var/lang in pref_species.learnable_languages)
		lang_list[lang] = TRUE
	for(var/cultural_thing in list(CULTURE_CULTURE, CULTURE_LOCATION, CULTURE_FACTION))
		var/datum/cultural_info/cult
		switch(cultural_thing)
			if(CULTURE_CULTURE)
				cult = GLOB.culture_cultures[pref_culture]
			if(CULTURE_LOCATION)
				cult = GLOB.culture_locations[pref_location]
			if(CULTURE_FACTION)
				cult = GLOB.culture_factions[pref_faction]
		if(cult.additional_langs)
			for(var/langtype in cult.additional_langs)
				lang_list[langtype] = TRUE
	return lang_list

/datum/preferences/proc/get_available_languages()
	var/list/lang_list = get_required_languages()
	for(var/lang_key in get_optional_languages())
		lang_list[lang_key] = TRUE
	return lang_list

/datum/preferences/proc/validate_languages()
	var/list/opt_langs = get_optional_languages()
	var/list/req_langs = get_required_languages()
	for(var/langkey in languages)
		if(!opt_langs[langkey] && !req_langs[langkey])
			languages -= langkey
	for(var/req_lang in req_langs)
		if(!languages[req_lang])
			languages[req_lang] = LANGUAGE_SPOKEN
	var/left_points = get_linguistic_points()
	//If we're below 0 points somehow, remove all optional languages
	if(left_points < 0)
		for(var/lang in languages)
			if(!req_langs[lang])
				languages -= lang

/datum/preferences/proc/can_buy_language(language_path, level)
	var/points = get_linguistic_points()
	if(languages[language_path])
		points += languages[language_path]
	if(points < level)
		return FALSE
	return TRUE

//Whenever we switch a species, we'll try to get common if we can to not confuse anyone
/datum/preferences/proc/try_get_common_language()
	var/list/langs = get_available_languages()
	if(langs[/datum/language/common])
		languages[/datum/language/common] = LANGUAGE_SPOKEN

/datum/preferences/proc/ShowLangMenu(mob/user)
	var/list/dat = list()
	dat += "<center><b>Choose your languages:</b></center><br>"
	dat += "Availability of the languages to choose from depends on your background. If you can't unlearn one, it means it is required for your background."
	dat += "<BR><center><a href='?src=[REF(src)];task=close_language'>Done</a></center>"
	dat += "<hr>"
	var/current_ling_points = get_linguistic_points()
	dat += "<b>Linguistic Points remaining: [current_ling_points]</b>"
	dat += "<table width='100%' align='center'><tr>"
	dat += "<td width=10%></td>"
	dat += "<td width=60%></td>"
	dat += "<td width=10%></td>"
	dat += "<td width=10%></td>"
	dat += "<td width=10%></td>"
	dat += "</tr>"
	var/list/avail_langs = get_available_languages()
	var/list/req_langs = get_required_languages()
	var/even = TRUE
	var/background_cl
	for(var/lang_path in avail_langs)
		even = !even
		var/datum/language/lang_datum = lang_path
		var/required = (req_langs[lang_path] ? TRUE : FALSE)
		if(even)
			background_cl = (required ? "#7A5A00" : "#17191C")
		else
			background_cl = (required ? "#856200" : "#23273C")
		var/language_skill = 0
		if(languages[lang_path])
			language_skill = languages[lang_path]
		var/unlearn_button
		if(language_skill && !required)
			unlearn_button = "<a href='?src=[REF(src)];lang=[lang_path];level=0;preference=language;task=cultural'>Unlearn</a>"
		else
			unlearn_button = "<span class='linkOff'>Unlearn</span>"
		var/understood_button
		if(languages[lang_path])
			//Has a href in case you want to downgrade from spoken to understood
			understood_button = "<a class='linkOn' href='?src=[REF(src)];lang=[lang_path];level=1;preference=language;task=cultural'>Understood</a>"
		else if(can_buy_language(lang_path, LANGUAGE_UNDERSTOOD))
			understood_button = "<a href='?src=[REF(src)];lang=[lang_path];level=1;preference=language;task=cultural'>Understood</a>"
		else
			understood_button = "<span class='linkOff'>Understood</span>"
		var/spoken_button
		if(languages[lang_path] >= LANGUAGE_SPOKEN)
			spoken_button = "<a class='linkOn' href='?src=[REF(src)];lang=[lang_path];level=2;preference=language;task=cultural'>Spoken</a>"
		else if(can_buy_language(lang_path, LANGUAGE_SPOKEN))
			spoken_button = "<a href='?src=[REF(src)];lang=[lang_path];level=2;preference=language;task=cultural'>Spoken</a>"
		else
			spoken_button = "<span class='linkOff'>Spoken</span>"
		dat += "<tr style='background-color: [background_cl]'>"
		dat += "<td><b>[initial(lang_datum.name)]</b></td>"
		dat += "<td><i>[initial(lang_datum.desc)]</i></td>"
		dat += "<td>[unlearn_button]</td>"
		dat += "<td>[understood_button]</td>"
		dat += "<td>[spoken_button]</td>"
		dat += "</tr>"
	dat += "<table>"
	var/datum/browser/popup = new(user, "culture_lang", "<div align='center'>Language Choice</div>", 900, 600)
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/validate_species_parts()
	update_pref_species()

	var/list/target_bodyparts = pref_species.default_mutant_bodyparts.Copy()

	//Remove all "extra" accessories
	for(var/key in mutant_bodyparts)
		if(!GLOB.sprite_accessories[key]) //That accessory no longer exists, remove it
			mutant_bodyparts -= key
			continue
		if(!pref_species.default_mutant_bodyparts[key])
			mutant_bodyparts -= key
			continue
		if(!GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]) //The individual accessory no longer exists
			mutant_bodyparts[key][MUTANT_INDEX_NAME] = pref_species.default_mutant_bodyparts[key]
		validate_color_keys_for_part(key) //Validate the color count of each accessory that wasnt removed

	//Add any missing accessories
	for(var/key in target_bodyparts)
		if(!mutant_bodyparts[key])
			var/datum/sprite_accessory/SA
			if(target_bodyparts[key] == ACC_RANDOM)
				SA = random_accessory_of_key_for_species(key, pref_species)
			else
				SA = GLOB.sprite_accessories[key][target_bodyparts[key]]
			var/final_list = list()
			final_list[MUTANT_INDEX_NAME] = SA.name
			final_list[MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)
			mutant_bodyparts[key] = final_list

	if(!allow_advanced_colors)
		reset_colors()

/datum/preferences/proc/validate_color_keys_for_part(key)
	var/datum/sprite_accessory/SA = GLOB.sprite_accessories[key][mutant_bodyparts[key][MUTANT_INDEX_NAME]]
	var/list/colorlist = mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST]
	if(SA.color_src == USE_MATRIXED_COLORS && colorlist.len != 3)
		mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)
	else if (SA.color_src == USE_ONE_COLOR && colorlist.len != 1)
		mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] = SA.get_default_color(features, pref_species)

/datum/preferences/proc/CanBuyAugment(datum/augment_item/target_aug, datum/augment_item/current_aug)
	//Check biotypes
	if(!(pref_species.inherent_biotypes & target_aug.allowed_biotypes))
		return
	var/quirk_points = GetQuirkBalance()
	var/leverage = 0
	if(current_aug)
		leverage += current_aug.cost
	if((quirk_points+leverage)>= target_aug.cost)
		return TRUE
	else
		return FALSE

#undef CHAR_TAB_APPEARANCE
#undef CHAR_TAB_MARKINGS
#undef CHAR_TAB_BACKGROUND
#undef CHAR_TAB_AUGMENTS

#undef APPEARANCE_CATEGORY_COLUMN
#undef MAX_MUTANT_ROWS
