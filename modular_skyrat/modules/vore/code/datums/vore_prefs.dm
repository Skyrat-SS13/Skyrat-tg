/datum/vore_prefs
	var/path
	var/datum/preferences/prefs //this is here because for modular reasons we aren't gonna set a client var every time

	var/vore_enabled = FALSE //master toggle
	var/vore_toggles
	var/list/bellies = list()

	var/has_unsaved = FALSE
	var/selected_belly = 1

	var/char_vars

	var/needs_update = UPDATE_ALL|UPDATE_STATIC_DATA

/datum/vore_prefs/New(client/holder = null, datum/preferences/_prefs=null)
	if (!holder || !_prefs)
		return
	prefs = _prefs
	path = "data/player_saves/[holder.ckey[1]]/[holder.ckey]/vore.sav"
	if (fexists(path))
		load_slotted_prefs(TRUE)
	else
		save_prefs()

/datum/vore_prefs/proc/load_prefs(slot = null, read_selected=FALSE)
	if (isnull(slot))
		slot = prefs?.default_slot || 0
	if (!path || !fexists(path))
		return FALSE
	var/savefile/S = new /savefile(path)
	if (!S)
		return FALSE
	. = TRUE
	S.cd = "/"
	READ_FILE(S["vore_enabled"], vore_enabled)
	//var/version
	//READ_FILE(S["savefile_version"], version)
	//do any sanity checks for version here in the future if you need to (create a new proc for it)
	S.cd = "/char[slot]"
	READ_FILE(S["vore_toggles"], vore_toggles)
	READ_FILE(S["char_vars"], char_vars)
	READ_FILE(S["bellies"], bellies)
	if (read_selected)
		READ_FILE(S["selected_belly"], selected_belly)
	has_unsaved = FALSE
	needs_update |= UPDATE_ALL
	sanitize_vars()

/datum/vore_prefs/proc/save_prefs(slot = null)
	if (isnull(slot))
		slot = prefs?.default_slot || 0
	if (!path)
		return FALSE
	var/savefile/S = new /savefile(path)
	if (!S)
		return FALSE
	. = TRUE
	S.cd = "/"
	WRITE_FILE(S["vore_enabled"], vore_enabled)
	WRITE_FILE(S["savefile_version"], VORE_SAVEFILE_VERSION)
	S.cd = "/char[slot]"
	sanitize_vars()
	WRITE_FILE(S["vore_toggles"], vore_toggles)
	WRITE_FILE(S["selected_belly"], selected_belly)
	WRITE_FILE(S["char_vars"], char_vars)
	WRITE_FILE(S["bellies"], bellies)
	has_unsaved = FALSE

/datum/vore_prefs/proc/sanitize_vars()
	//statics
	var/static/list/default_vore_toggles = list(VORE_MECHANICS_TOGGLES = VORE_MECHANICS_TOGGLES_DEFAULT,\
												VORE_CHAT_TOGGLES = VORE_CHAT_TOGGLES_DEFAULT/*,\
												VORE_SOUND_TOGGLES = VORE_SOUND_TOGGLES_DEFAULT*/)
	var/static/list/character_vars = list("tastes_of" = "nothing in particular")
	var/static/list/default_belly_vars = default_belly_info()

	if (isnull(vore_toggles) || !islist(vore_toggles))
		vore_toggles = default_vore_toggles.Copy()
	else
		for (var/item in default_vore_toggles)
			if (!(item in vore_toggles))
				vore_toggles[item] = default_vore_toggles[item]
	if (isnull(char_vars) || !islist(char_vars))
		char_vars = character_vars.Copy()
	else
		for (var/item in character_vars)
			if (!(item in char_vars))
				char_vars[item] = character_vars[item]
	if (!bellies || !bellies.len)
		bellies = list()
		bellies.Add(list(default_belly_info()))
	else
		for (var/belly in bellies)
			for (var/item in default_belly_vars)
				if (!(item in belly))
					belly[item] = default_belly_vars[item]
	selected_belly = clamp(selected_belly, 1, bellies.len)

/datum/vore_prefs/proc/load_slotted_prefs(read_selected=FALSE, slot_from_prefs=null)
	var/datum/component/vore/vore = prefs?.parent?.mob?.GetComponent(/datum/component/vore)
	if (vore)
		if (!isnull(slot_from_prefs))
			return TRUE
		var/slot_to_update = vore.update_current_slot()
		load_prefs(slot_to_update, read_selected)
		var/belly_to = max(bellies.len, vore.bellies.len)
		for (var/bellynum in 1 to belly_to)
			if (bellynum > vore.bellies.len)
				break
			var/belly_ref = vore.bellies[bellynum].belly_ref
			if (bellynum > bellies.len || isnull(belly_ref))
				vore.remove_belly(bellynum)
			if (belly_ref != bellynum)
				vore.bellies.Insert(bellynum, new /obj/vbelly(null, vore.owner, bellies[bellynum], bellynum))
		vore.update_bellies(TRUE)
	else
		if (has_unsaved && !isnull(slot_from_prefs))
			var/action = alert(prefs.parent, "Would you like to save your vore pref changes before you switch characters?", "Save", "Let me go back", "Discard Changes", "Save Changes")
			switch(action)
				if("Let me go back")
					return FALSE
				if("Discard Changes")
					load_prefs(slot_from_prefs, TRUE)
					return TRUE
				if("Save Changes")
					save_prefs()
					load_prefs(slot_from_prefs, TRUE)
					return TRUE
		load_prefs(slot_from_prefs, TRUE)
		has_unsaved = FALSE
	return TRUE

/datum/vore_prefs/ui_state(mob/user)
	return GLOB.always_state

/datum/vore_prefs/ui_status(mob/user, datum/ui_state/state)
	return user.client == prefs.parent ? UI_INTERACTIVE : UI_CLOSE

/datum/vore_prefs/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		needs_update |= UPDATE_ALL|UPDATE_STATIC_DATA
		ui = new(user, src, "VorePanel")
		ui.open()

/datum/vore_prefs/ui_data(mob/user)
	var/list/data = list()
	data["unsaved"] = has_unsaved

	return data

/proc/static_test()
	to_chat(usr, "static test called more than once")
	return 1
/proc/const_test()
	to_chat(usr, "const test called more than once")
	return 1

// Most data is passed through static, so that we can update it on command, rather than having the server sending boatloads of data all the time
/datum/vore_prefs/ui_static_data(mob/user)
	var/list/data = list()

	var/static/a = static_test()

	//true static data goes here

	var/static/list/string_types = list(LIST_DIGEST_PREY, \
										LIST_DIGEST_PRED, \
										LIST_ABSORB_PREY, \
										LIST_ABSORB_PRED, \
										LIST_UNABSORB_PREY, \
										LIST_UNABSORB_PRED, \
										LIST_STRUGGLE_INSIDE, \
										LIST_STRUGGLE_OUTSIDE, \
										LIST_EXAMINE)
	var/static/list/other_belly_types = list("name", \
										"desc", \
										"mode", \
										"swallow_verb", \
										"can_taste")
	var/static/list/character_types = list("tastes_of")

	var/datum/component/vore/vore = user.GetComponent(/datum/component/vore)

	if (needs_update & UPDATE_STATIC_DATA)
		needs_update &= ~UPDATE_STATIC_DATA

		var/list/toggletypes = list()
		for (var/num_toggle in 1 to VORE_TOGGLE_SECTION_AMOUNT)
			toggletypes += list(switch_toggles(num_toggle))
		data["toggle_types"] = toggletypes

		data["string_types"] = string_types
		data["other_belly_types"] = other_belly_types
		data["character_types"] = character_types

	//data that gets updated whenever called goes here
	data["enabled"] = vore_enabled
	if (!vore_enabled) //not gonna get used anyway so no point in sending all the rest
		return data

	if (needs_update & UPDATE_INSIDE)
		needs_update &= ~UPDATE_INSIDE
		//What belly we're inside
		data["in_belly"] = istype(user.loc, /obj/vbelly)
		if (istype(user.loc, /obj/vbelly))
			var/obj/vbelly/bellyobj = user.loc
			var/list/inside_data = list()
			inside_data["belly_inside"] = ref(bellyobj)
			inside_data["absorbed"] = (user in bellyobj.absorbed)
			inside_data["desc"] = bellyobj.desc
			inside_data["name"] = "[bellyobj.owner]'s [bellyobj.name]"
			inside_data["contents"] = bellyobj.get_belly_contents(as_string=TRUE, ignored=user, full=TRUE)
			data["inside_data"] = inside_data

	if (needs_update & UPDATE_BELLY_LIST)
		needs_update &= ~UPDATE_BELLY_LIST
		//Selected belly and list of belly names for the dropdown
		data["selected_belly"] = selected_belly
		var/list/belly_names = belly_name_list()
		if (belly_names.len < MAX_BELLIES)
			belly_names += "New Belly"
		data["bellies"] = belly_names

	if (needs_update & UPDATE_BELLY_VARS)
		needs_update &= ~UPDATE_BELLY_VARS
		//Belly vars like names and stuff for the current belly
		var/list/belly_data = list()
		for (var/other_type in other_belly_types)
			belly_data[other_type] = get_var(other_type, belly=selected_belly)
		data["current_belly"] = belly_data
		vore?.bellies[selected_belly].update_static_vore_data(force = TRUE, only_contents = TRUE) //keep theirs updated too

	if (needs_update & UPDATE_CONTENTS)
		needs_update &= ~UPDATE_CONTENTS
		//Contents
		var/list/contents = vore?.get_belly_contents(selected_belly, as_string=TRUE, full=TRUE)
		data["has_contents"] = !!contents?.len
		if (contents?.len)
			data["contents"] = contents

	if (needs_update & UPDATE_TOGGLES)
		needs_update &= ~UPDATE_TOGGLES
		data["toggles"] = list()
		for (var/num in 1 to VORE_TOGGLE_SECTION_AMOUNT)
			var/list/switch_list = switch_toggles(num)
			var/list/toggle_list = list()
			for (var/x in 1 to switch_list[3].len)
				toggle_list += get_var(switch_list[2], toggle=(1 << x))
			data["toggles"][switch_list[2]] = toggle_list

	if (needs_update & UPDATE_CHAR_VARS)
		needs_update &= ~UPDATE_CHAR_VARS
		data["character_prefs"] = list()
		for (var/char_var in character_types)
			data["character_prefs"][char_var] = get_var(char_var)

	return data

/datum/vore_prefs/ui_act(action, list/params)
	. = ..()
	if (.)
		return

	. = TRUE

	switch(action)
		if("save_prefs")
			var/datum/component/vore/vore = prefs?.parent?.mob?.GetComponent(/datum/component/vore)
			var/slot_to_save = vore?.update_current_slot()
			save_prefs(slot_to_save)
		if("discard_changes")
			load_slotted_prefs()
		if("toggle_vore")
			vore_enabled = params["toggle"]
			var/datum/component/vore/vore = prefs?.parent?.mob?.GetComponent(/datum/component/vore)
			vore?.vore_enabled = vore_enabled
			if(isliving(usr))
				var/mob/living/user = usr
				user.update_vore_verbs()
			has_unsaved = TRUE
			update_static_data(usr)
		if("toggle_act")
			set_var(params["varname"], params["toggle"], toggle=params["pref"])
		if("belly_act")
			var/var_name = params["varname"]
			var/belly = params["belly"]
			if (!isnum(belly))
				return FALSE
			var/input = get_input(usr, var_name, belly)
			set_var(var_name, input, belly)
		if("charvar_act")
			var/var_name = params["varname"]
			set_var(var_name, get_input(usr, var_name, 0))
		if("select_belly")
			var/belly = params["belly"]
			if (!isnum(belly) || belly == selected_belly)
				return FALSE
			if (belly > bellies.len)
				bellies += list(default_belly_info())
				selected_belly = bellies.len
				var/datum/component/vore/vore = prefs?.parent?.mob?.GetComponent(/datum/component/vore)
				vore?.update_bellies()
			else
				selected_belly = clamp(belly, 1, bellies.len)
			needs_update |= UPDATE_BELLY_VARS|UPDATE_BELLY_LIST|UPDATE_CONTENTS
			update_static_data(usr)
			has_unsaved = TRUE
		if("remove_belly")
			var/belly = params["belly"]
			if (!isnum(belly))
				return
			if (bellies.len <= 1)
				return
			var/yes = input(usr, "Confirm", "Are you certain you want to delete the [get_var("name", belly)]? If you decide afterwards that you want to un-delete it, just click the \"Discard Changes\" button. However, once you save your prefs, there will be no going back. Are you certain?", "No") as null|anything in list("Yes", "No")
			if (yes != "Yes")
				return
			var/datum/component/vore/vore = prefs?.parent?.mob?.GetComponent(/datum/component/vore)
			if (vore && vore.get_belly_contents(belly, living=TRUE)?.len)
				alert(usr, "You can't remove a belly with people still inside!", "What are you doing?!", "OK")
				return
			bellies.Cut(belly, belly+1)
			vore?.remove_belly(belly)
			selected_belly = clamp(selected_belly, 1, bellies.len)
			needs_update |= UPDATE_BELLY_VARS|UPDATE_BELLY_LIST|UPDATE_CONTENTS
			update_static_data(usr)
			has_unsaved = TRUE
		if("contents_act")
			var/ref = params["ref"]
			var/belly = params["belly"]
			if (!isnum(belly))
				return
			var/atom/movable/target = locate(ref)
			var/datum/component/vore/vore = prefs.parent?.mob?.GetComponent(/datum/component/vore)
			if (!vore || !target || !(target in vore.get_belly_contents(belly)))
				return
			var/action_choice = get_input(usr, "contents_act", belly, "[target]")
			switch(action_choice)
				if("Examine")
					if(ismob(usr) && (target in vore.get_belly_contents(belly)))
						usr.examinate(target)
				if("Eject")
					var/obj/vbelly/bellyobj = vore.bellies[belly]
					if (target in bellyobj.absorbed)
						vore_message(usr, "You can't eject someone who's been absorbed!", warning=TRUE)
						return
					bellyobj.release_from_contents(target, willing=TRUE)
				if("Transfer")
					var/belly_names = belly_name_list(TRUE, TRUE)
					if (target in vore.bellies[belly].absorbed)
						vore_message(usr, "You can't transfer someone who's been absorbed!", warning=TRUE)
						return
					var/choice = input(usr, "Which belly do you want to transfer to?", "Transfer", belly) as null|anything in belly_names
					if (isnull(choice) || choice == belly || !(target in vore.get_belly_contents(belly)))
						return
					target.forceMove(vore.bellies[belly_names[choice]])
					//add a message here?
				else
					return
		if("inside_act")
			var/ref = params["ref"]
			var/inside_of = params["belly_in"]
			var/atom/movable/target = locate(ref)
			var/obj/vbelly/inside = locate(inside_of)
			if (!istype(inside) || usr.loc != inside || !target || !(target in inside))
				return
			var/action_choice = get_input(usr, "inside_act[isliving(target) ? "_living" : ""]", 1, "[target]")
			if (!isliving(usr) || !(target in inside) || usr.loc != inside)
				return
			var/mob/living/user = usr
			switch(action_choice)
				if("Examine")
					user.examinate(target)
				if("Pick up")
					if (user.stat)
						to_chat(user, span_warning("You can't do this in your state!"))
					else
						user.put_in_active_hand(target)
				if("Devour")
					if (target in inside.absorbed)
						vore_message(user, "You can devour someone who's been absorbed into a bodypart!", warning=TRUE)
						return
					user.IngestInside(target, inside.owner, inside)
				else
					return
		if("eject_all")
			var/belly = params["belly"]
			if (!isnum(belly))
				return
			var/datum/component/vore/vore = prefs.parent?.mob?.GetComponent(/datum/component/vore)
			if (!vore)
				return
			var/obj/vbelly/bellyobj = vore.bellies[belly]
			bellyobj.mass_release_from_contents(willing=TRUE)

/datum/vore_prefs/proc/get_input(user, var_name, belly, misc_info=null)
	if (!istext(var_name))
		return
	belly = belly || selected_belly //not sure if this needs to be here
	//things that can go in a non-multiline text box
	var/static/list/onelineinputs = list("name", "tastes_of", "swallow_verb")
	//things that only have two options, this is really only just because I like how it looks
	var/static/list/alertinputs = list(	"can_taste" = list("Yes", "No"),\
										"inside_act" = list("Examine", "Pick up"),\
										"inside_act_living" = list("Examine", "Devour"))
	//things that have more than two options - if the corresponding list doesn't have any arguments for the keys, then put the var name into the not_a_var list, along with a default value to select
	var/static/list/listinputs = list(	"mode" = list(	"Hold" = VORE_MODE_HOLD, \
														"Digest" = VORE_MODE_DIGEST, \
														"Absorb" = VORE_MODE_ABSORB, \
														"Unabsorb" = VORE_MODE_UNABSORB), \
										"contents_act" = list(	"Examine", \
																"Eject", \
																"Transfer"))
	//things that require a multiline text box - put the key as the var name, and the value as TRUE if it needs to be joined from a list and split into one afterwards
	var/static/list/multilineinputs = list("desc" = FALSE, \
											LIST_DIGEST_PREY = TRUE, \
											LIST_DIGEST_PRED = TRUE, \
											LIST_ABSORB_PREY = TRUE, \
											LIST_ABSORB_PRED = TRUE, \
											LIST_UNABSORB_PREY = TRUE, \
											LIST_UNABSORB_PRED = TRUE, \
											LIST_STRUGGLE_INSIDE = TRUE, \
											LIST_STRUGGLE_OUTSIDE = TRUE, \
											LIST_EXAMINE = TRUE)
	//name of var - value to take if output is null, null means take the previous value
	var/static/list/cant_be_empty = list("tastes_of" = "nothing in particular", "name" = null, "swallow_verb" = "swallow")
	var/static/list/not_a_var = list("contents_act" = "Examine") //name of the input - default value
	var/output
	var/name_and_desc = get_desc_for_input(var_name, misc_info)
	var/var_value = (var_name in not_a_var) ? not_a_var[var_name] : get_var(var_name, belly)
	if (var_name in onelineinputs)
		output = input(user, name_and_desc[2], name_and_desc[1], var_value) as null|text

	else if (!isnull(multilineinputs[var_name]))
		var/default = (multilineinputs[var_name] && !isnull(var_value)) ? jointext(var_value, "\n\n") : var_value
		output = input(user, name_and_desc[2], name_and_desc[1], default) as null|message
		if (isnull(output))
			return
		if (multilineinputs[var_name])
			var/static/regex/multilinehelper = regex(@"(\n\n)\n+", "g") //so the people who put three newlines instead of two won't get fucked over
			output = splittext(STRIP_HTML_SIMPLE(multilinehelper.Replace(output, "$1"), MAX_MESSAGE_LEN), "\n\n")

	else if (!isnull(listinputs[var_name]))
		output = input(user, name_and_desc[2], name_and_desc[1], var_value) as null|anything in listinputs[var_name]
		if (!(var_name in not_a_var))
			output = listinputs[var_name][output]

	else if (!isnull(alertinputs[var_name]))
		output = alert(user, name_and_desc[2], name_and_desc[1], alertinputs[var_name][1], alertinputs[var_name][2], "Cancel")
		if (output == "Cancel")
			output = null

	else
		return

	if (istext(output))
		output = STRIP_HTML_SIMPLE(output, MAX_MESSAGE_LEN) //yeet
	if (istext(output) && output == "")
		if (var_name in cant_be_empty)
			return cant_be_empty[var_name] || var_value
	if ((output == var_value && !(var_name in not_a_var)) || isnull(output))
		return
	return output

/datum/vore_prefs/proc/get_desc_for_input(var_name, misc_info=null)
	var/static/common_insert = "%pred will be replaced with the predator's name, %prey with the prey's name, and %belly with the name of the belly. Make sure to put two lines between each seperate message."
	switch(var_name)
		if ("name")
			return list("Name", "Enter the new name of the [get_var("name", selected_belly)].")
		if ("desc")
			return list("Description", "Enter the new description for the [get_var("name", selected_belly)].")
		if ("mode")
			return list("Mode", "Select the new mode of the [get_var("name", selected_belly)].")
		if ("swallow_verb")
			return list("Swallow Verb", "Enter the new swallow verb of the [get_var("name", selected_belly)]. Remember to put it in the infinitive tense, ie swallow, gulp, etc.")
		if ("can_taste")
			return list("Can Taste", "Can the [get_var("name", selected_belly)] taste things?")
		if ("tastes_of")
			return list("Tastes like", "What does your character taste like?")
		if (LIST_DIGEST_PREY)
			return list("Prey Digest Messages", "Enter the new digest messages for prey to be shown, one will be selected when the prey is digested. [common_insert]")
		if (LIST_DIGEST_PRED)
			return list("Pred Digest Messages", "Enter the new digest messages for you to be shown, one will be selected when the prey is digested. [common_insert]")
		if (LIST_ABSORB_PREY)
			return list("Prey Absorb Messages", "Enter the new absorb messages for prey to be shown, one will be selected when the prey is absorbed into the [get_var("name", selected_belly)]. [common_insert]")
		if (LIST_ABSORB_PRED)
			return list("Pred Absorb Messages", "Enter the new absorb messages for you to be shown, one will be selected when the prey is absorbed into the [get_var("name", selected_belly)]. [common_insert]")
		if (LIST_UNABSORB_PREY)
			return list("Prey Unabsorb Messages", "Enter the new unabsorb messages for prey to be shown, one will be selected when the prey is unabsorbed from the [get_var("name", selected_belly)]. [common_insert]")
		if (LIST_UNABSORB_PRED)
			return list("Pred Unabsorb Messages", "Enter the new unabsorb messages for you to be shown, one will be selected when the prey is unabsorbed from the [get_var("name", selected_belly)]. [common_insert]")
		if (LIST_STRUGGLE_INSIDE)
			return list("Struggle Messages (Inside)", "Enter the new struggle messages (shown to those inside the belly), one will be selected when one of the prey resists. [common_insert]")
		if (LIST_STRUGGLE_OUTSIDE)
			return list("Struggle Messages (Outside)", "Enter the new struggle messages (shown to those outside the belly), one will be selected when one of the prey resists. [common_insert]")
		if (LIST_EXAMINE)
			return list("Examine Messages", "Enter the new examine messages, one will be selected when someone examines you. [common_insert]")
		if ("contents_act")
			return list("Perform Action", "What do you want to do with [misc_info]?")
		if ("inside_act")
			return list("Perform Action", "What do you want to do with [misc_info]?")
		if ("inside_act_living")
			return list("Perform Action", "What do you want to do with [misc_info]?")

	return list("Something went wrong", "Something went wrong, tell a coder to look at vore code for the [var_name] var being sent.")

/datum/vore_prefs/proc/switch_toggles(toggle_section) //returns a list with the first value being the name of the section, the second being the name of the var that it is linked to, and the third being a list of the name of each of the toggles in it, in order
	switch(toggle_section)
		if(1) //mechanics
			var/static/list/mechanics		= list("Mechanics", VORE_MECHANICS_TOGGLES, list("Devourable", "Digestable", "Absorbable"))
			return mechanics
		if(2) //chat
			var/static/list/chat_toggles	= list("Chat Toggles", VORE_CHAT_TOGGLES, list("See Examine Messages", "See Struggle Messages", "See Other Messages"))
			return chat_toggles
		/*
		if(3) //sound
			var/static/list/sound_toggles	= list("Sound", VORE_SOUND_TOGGLES, list("Hear Gulp Sounds", "Hear Idle Belly Sounds", "Hear Digest Sounds", "Hear Struggle Sounds", "Hear Death Sounds"))
			return sound_toggles
		*/
		else
			return null

/datum/vore_prefs/proc/belly_name_list(add_select=FALSE)
	var/list/belly_names = list()
	var/list/keep_track = list()
	for (var/belly in 1 to bellies.len)
		var/bellyname = get_var("name", belly=belly)
		keep_track[bellyname] = keep_track[bellyname] ? (keep_track[bellyname] + 1) : 1
		var/formatted_belly_name = bellyname + ((keep_track[bellyname] > 1) ? " ([keep_track[bellyname]])" : "")
		belly_names += formatted_belly_name
		if(add_select)
			belly_names[formatted_belly_name] = belly
	return belly_names

/datum/vore_prefs/proc/set_var(var_name, value, belly=null, toggle=null)
	. = FALSE
	if (isnull(value))
		return
	if (!var_name || !istext(var_name) || (belly && !isnum(belly)) || (toggle && !isnum(toggle)))
		CRASH("Vore prefs attempted an unsafe set_temp: [STRIP_HTML_SIMPLE(var_name, 20)]!") //this should probably be taken out and merged with the above check before it's merged

	if (belly && (var_name in static_belly_vars()))
		has_unsaved = TRUE
		bellies[belly][var_name] = value
		needs_update |= UPDATE_BELLY_VARS
		. = TRUE

	if (!. && !isnull(toggle))
		if (isnull(vore_toggles[var_name]))
			vore_toggles[var_name] = 0
		if (value)
			vore_toggles[var_name] |= (1 << toggle)
		else
			vore_toggles[var_name] &= ~(1 << toggle)
		has_unsaved = TRUE
		needs_update |= UPDATE_TOGGLES
		. = TRUE

	if (!. && (var_name in char_vars))
		has_unsaved = TRUE
		char_vars[var_name] = value
		needs_update |= UPDATE_CHAR_VARS
		. = TRUE

	if (.)
		var/datum/component/vore/vore = prefs.parent.mob.GetComponent(/datum/component/vore)
		if (needs_update & UPDATE_TOGGLES)
			if (istype(prefs.parent.mob.loc, /obj/vbelly))
				var/obj/vbelly/bellyobj = prefs.parent.mob.loc
				bellyobj.check_mode()
			vore?.vore_toggles = vore_toggles
		if (needs_update & UPDATE_CHAR_VARS)
			vore?.char_vars = char_vars
		if (needs_update & UPDATE_BELLY_VARS)
			vore?.update_belly(belly)
		update_static_data(usr)
	return

/datum/vore_prefs/proc/get_var(var_name, belly=null, toggle=null)
	if (belly && (var_name in static_belly_vars()))
		return bellies[belly][var_name]
	if (!isnull(toggle))
		return (vore_toggles[var_name] & toggle)
	if (!(var_name in char_vars))
		return
	return char_vars[var_name]

//debug proc to clear bellies
/datum/vore_prefs/proc/clear_bellies()
	bellies = list(default_belly_info())
