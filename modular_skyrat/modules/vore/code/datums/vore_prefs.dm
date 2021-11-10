/datum/vore_prefs
	var/path
	var/datum/preferences/prefs //this is here because for modular reasons we aren't gonna set a client var every time

	var/vore_enabled = FALSE //master toggle
	var/vore_toggles = VORE_TOGGLES_DEFAULT
	var/tastes_of = "nothing in particular"
	var/list/bellies = list()

	var/list/unsaved_changes = null
	var/has_unsaved = FALSE
	var/selected_belly = 1
	/* someone else can do this
	can hear noises toggle + vore noises
	simplemob vore
	*/

/datum/vore_prefs/New(client/holder = null, datum/preferences/_prefs=null)
	if (!holder)
		return
	prefs = _prefs
	var/current_slot = prefs.default_slot
	path = "data/player_saves/[holder.ckey[1]]/[holder.ckey]/vore.sav"
	if (fexists(path))
		load_prefs(current_slot)
	else
		save_prefs(current_slot)
	lazy_init_temp()

/datum/vore_prefs/proc/load_prefs(slot = null)
	slot = slot || prefs.default_slot || 1
	if (!path || !fexists(path))
		return FALSE
	var/savefile/S = new /savefile(path)
	if (!S)
		return FALSE
	. = TRUE
	S.cd = "/"
	READ_FILE(S["vore_enabled"], vore_enabled)
	S.cd = "/char[slot]"
	READ_FILE(S["vore_toggles"], vore_toggles)
	if(!selected_belly || !isnum(selected_belly))
		selected_belly = 1
	READ_FILE(S["vore_taste"], tastes_of)
	READ_FILE(S["bellies"], bellies)
	if (!bellies || !bellies.len)
		bellies = list()
		bellies.Add(list(default_belly_info()))
	READ_FILE(S["selected_belly"], selected_belly)
	selected_belly = clamp(selected_belly, 1, bellies.len)

/datum/vore_prefs/proc/save_prefs(slot = null)
	slot = slot || prefs.default_slot || 1
	if (!path)
		return FALSE
	var/savefile/S = new /savefile(path)
	if (!S)
		return FALSE
	. = TRUE
	S.cd = "/"
	save_temp()
	WRITE_FILE(S["vore_enabled"], vore_enabled)
	S.cd = "/char[slot]"
	WRITE_FILE(S["vore_toggles"], vore_toggles)
	WRITE_FILE(S["selected_belly"], selected_belly)
	WRITE_FILE(S["vore_taste"], tastes_of)
	if (!bellies || !bellies.len)
		bellies = list()
		bellies.Add(list(default_belly_info()))
	WRITE_FILE(S["bellies"], bellies)
	has_unsaved = FALSE

/datum/vore_prefs/proc/get_belly_info(slot = 1)
	if (slot > length(bellies) || slot < 1)
		return default_belly_info()
	return bellies[slot]

/datum/vore_prefs/ui_state(mob/user)
	return GLOB.always_state

/datum/vore_prefs/ui_status(mob/user, datum/ui_state/state)
	return user.client == prefs.parent ? UI_INTERACTIVE : UI_CLOSE

/datum/vore_prefs/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "VorePanel")
		ui.open()

/datum/vore_prefs/ui_data(mob/user)
	var/list/data = list()
	data["enabled"] = vore_enabled ? TRUE : null //to help with the tgui code so that 0's don't show up.
	data["unsaved"] = has_unsaved
	if (!vore_enabled) //not gonna get used anyway so no point in sending all the rest
		return data

	data["in_belly"] = FALSE
	if (istype(user.loc, /obj/vbelly))
		var/obj/vbelly/bellyobj = user.loc
		data["in_belly"] = TRUE
		var/list/inside_data = list()
		inside_data["belly_inside"] = ref(bellyobj)
		inside_data["desc"] = bellyobj.desc
		inside_data["name"] = "[bellyobj.owner]'s [bellyobj.name]"
		inside_data["contents"] = bellyobj.get_belly_contents(ref=TRUE, as_string=TRUE, ignored=user)
		inside_data["contents_noref"] = bellyobj.get_belly_contents(ref=FALSE, as_string=TRUE, ignored=user)
		data["inside_data"] = inside_data

	data["selected_belly"] = selected_belly
	data["tastes_of"] = get_temp("tastes_of")
	var/list/belly_names = belly_name_list()
	if (belly_names.len < MAX_BELLIES)
		belly_names += "New Belly"
	data["bellies"] = belly_names

	var/datum/component/vore/vore = user.GetComponent(/datum/component/vore)
	var/list/belly_data = list()
	belly_data["name"] = get_temp("name", belly=selected_belly)
	belly_data["desc"] = get_temp("desc", belly=selected_belly)
	belly_data["mode"] = get_temp("mode", belly=selected_belly)
	belly_data["can_taste"] = get_temp("can_taste", belly=selected_belly)
	belly_data["swallow_verb"] = get_temp("swallow_verb", belly=selected_belly)
	belly_data["string_types"] = list(LIST_DIGEST_PREY, \
										LIST_DIGEST_PRED, \
										LIST_STRUGGLE_INSIDE, \
										LIST_STRUGGLE_OUTSIDE, \
										LIST_EXAMINE)
	data["has_contents"] = FALSE
	var/list/contents_of = vore?.get_belly_contents(unsaved_changes["bellies"][selected_belly]["belly_ref"], ref=TRUE, as_string=TRUE)
	if (contents_of && contents_of.len)
		data["has_contents"] = TRUE
		data["contents"] = contents_of
		data["contents_noref"] = vore.get_belly_contents(unsaved_changes["bellies"][selected_belly]["belly_ref"], ref=FALSE, as_string=TRUE)
	data["current_belly"] = belly_data

	data["toggles"] = list()
	for (var/num in 1 to VORE_TOGGLES_AMOUNT)
		data["toggles"] += get_temp("vore_toggles", toggle=(1 << (num - 1)))

	return data

/datum/vore_prefs/ui_static_data(mob/user)
	var/list/data = list()

	data["string_types"] = list(LIST_DIGEST_PREY, \
								LIST_DIGEST_PRED, \
								LIST_STRUGGLE_INSIDE, \
								LIST_STRUGGLE_OUTSIDE, \
								LIST_EXAMINE)
	data["other_belly_types"] = list("name", \
								"desc", \
								"mode", \
								"swallow_verb", \
								"can_taste")
	data["other_types"] = list("tastes_of")
	return data

/datum/vore_prefs/ui_act(action, list/params)
	. = ..()
	if (.)
		return

	. = TRUE

	to_chat(usr, "[action]")
	for (var/x in params)
		to_chat(usr, "[x]: [params[x]]") //debugging code

	switch(action)
		if("save_prefs")
			save_prefs()
		if("discard_changes")
			unsaved_changes = list()
			has_unsaved = FALSE
			lazy_init_temp()
		if("toggle_vore")
			vore_enabled = params["toggle"]
			has_unsaved = TRUE
			if (!vore_enabled)
				return
		if("toggle_act")
			set_temp("vore_toggles", params["toggle"], toggle=params["pref"])
		if("belly_act")
			var/var_name = params["varname"]
			var/belly = params["belly"]
			if (!isnum(belly))
				return FALSE
			var/input = get_input(usr, var_name, belly)
			to_chat(usr, "<span class='red bold'>[var_name]</span>: [isnull(input) ? "null" : input]")
			set_temp(var_name, input, belly)
		if("othervar_act")
			var/var_name = params["varname"]
			set_temp(var_name, get_input(usr, var_name, 0))
		if("select_belly")
			var/belly = params["belly"]
			if (!isnum(belly))
				return FALSE
			if (belly > unsaved_changes["bellies"].len)
				unsaved_changes["bellies"] += list(list("belly_ref" = 0))
				selected_belly = unsaved_changes["bellies"].len
			else
				selected_belly = clamp(belly, 1, unsaved_changes["bellies"].len)
			has_unsaved = TRUE
		if("remove_belly")
			var/belly = params["belly"]
			if (!isnum(belly))
				return
			if (unsaved_changes["bellies"].len <= 1)
				return
			var/yes = input(usr, "Confirm", "Are you certain you want to delete the [get_temp("name", belly)]? If you decide afterwards that you want to un-delete it, just click the \"Discard Changes\" button. However, once you save your prefs, there will be no going back. Are you certain?", "No") as null|anything in list("Yes", "No")
			if (yes != "Yes")
				return
			unsaved_changes["bellies"] -= unsaved_changes["bellies"][belly]
			has_unsaved = TRUE
		if("contents_act")
			var/ref = params["ref"]
			var/belly = params["belly"]
			if (!isnum(belly))
				return
			var/atom/movable/target = locate(ref)
			var/datum/component/vore/vore = prefs.parent?.mob?.GetComponent(/datum/component/vore)
			if (!vore || !target || !(target in vore.get_belly_contents(unsaved_changes["bellies"][belly]["belly_ref"])))
				return
			var/action_choice = get_input(usr, "contents_act", belly, "[target]")
			switch(action_choice)
				if("Examine")
					if(ismob(usr) && (target in vore.get_belly_contents(unsaved_changes["bellies"][belly]["belly_ref"])))
						usr.examinate(target)
				if("Eject")
					var/obj/vbelly/bellyobj = vore.bellies[belly]
					bellyobj.release_from_contents(target)
				if("Transfer")
					var/belly_names = belly_name_list(TRUE, TRUE)
					var/choice = input(usr, "Which belly do you want to transfer to?", "Transfer", belly) as null|anything in belly_names
					if (isnull(choice) || choice == belly || !(target in vore.get_belly_contents(unsaved_changes["bellies"][belly]["belly_ref"])))
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
				if("Pick Up")
					if (user.stat)
						to_chat(user, span_warning("You can't do this in your state!"))
					else
						user.put_in_active_hand(target)
				if("Devour")
					user.IngestInside(target, inside.owner)
				else
					return
		if("eject_all")
			var/belly = params["belly"]
			if (!isnum(belly))
				return
			var/datum/component/vore/vore = prefs.parent?.mob?.GetComponent(/datum/component/vore)
			if (!vore)
				return
			var/obj/vbelly/bellyobj = vore.bellies[unsaved_changes["bellies"][belly]["belly_ref"]]
			bellyobj.mass_release_from_contents()

/datum/vore_prefs/proc/get_input(user, var_name, belly, misc_info=null)
	if (!istext(var_name))
		return
	belly = belly || selected_belly //not sure if this needs to be here
	var/static/list/onelineinputs = list("name", "tastes_of", "swallow_verb")
	var/static/list/alertinputs = list("can_taste" = list("Yes", "No", "Cancel"))
	var/static/list/listinputs = list(	"mode" = list(	"Hold" = VORE_MODE_HOLD, \
														"Digest" = VORE_MODE_DIGEST, \
														"Absorb" = VORE_MODE_ABSORB), \
										"contents_act" = list(	"Examine", \
																"Eject", \
																"Transfer"), \
										"inside_act" = list(	"Examine", \
																"Pick Up"), \
										"inside_act_living" = list(	"Examine", \
																	"Devour"))
	var/static/list/multilineinputs = list("desc" = FALSE, \
											LIST_DIGEST_PREY = TRUE, \
											LIST_DIGEST_PRED = TRUE, \
											LIST_STRUGGLE_INSIDE = TRUE, \
											LIST_STRUGGLE_OUTSIDE = TRUE, \
											LIST_EXAMINE = TRUE) //name of var - is it a list that needs to be joined into a string
	var/static/list/cant_be_empty = list("tastes_of" = "nothing in particular", "name" = null, "swallow_verb" = "swallow") //name of var - value to take if output is null, null means take the previous value
	var/static/list/not_a_var = list("contents_act" = "Examine", "inside_act" = "Examine", "inside_act_living" = "Examine") //name of the input - default value
	var/output
	var/name_and_desc = get_desc_for_input(var_name, misc_info)
	var/var_value = (var_name in not_a_var) ? not_a_var[var_name] : get_temp(var_name, belly)
	if (var_name in onelineinputs)
		output = input(user, name_and_desc[2], name_and_desc[1], var_value) as null|text

	else if (!isnull(multilineinputs[var_name]))
		var/default = multilineinputs[var_name] ? jointext(var_value, "\n\n") : var_value
		output = input(user, name_and_desc[2], name_and_desc[1], default) as null|message
		if (isnull(output))
			return
		if (multilineinputs[var_name])
			var/static/regex/multilinehelper = regex(@"(\n\n)\n+", "g") //so the people who put three newlines instead of two won't get fucked over
			output = splittext(STRIP_HTML_SIMPLE(multilinehelper.Replace(output, "$1"), MAX_MESSAGE_LEN), "\n\n")

	else if (!isnull(listinputs[var_name]))
		var/static/list/has_no_value = list("contents_act", "inside_act", "inside_act_living")
		output = input(user, name_and_desc[2], name_and_desc[1], var_value) as null|anything in listinputs[var_name]
		if (!(var_name in has_no_value))
			output = listinputs[var_name][output]

	else if (!isnull(alertinputs[var_name]))
		output = alert(user, name_and_desc[2], name_and_desc[1], alertinputs[var_name][1], alertinputs[var_name][2], alertinputs[var_name][3])
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
			return list("Name", "Enter the new name of the [get_temp("name", selected_belly)].")
		if ("desc")
			return list("Description", "Enter the new description of the [get_temp("name", selected_belly)].")
		if ("mode")
			return list("Mode", "Select the new mode of the [get_temp("name", selected_belly)].")
		if ("swallow_verb")
			return list("Swallow Verb", "Enter the new swallow verb of the [get_temp("name", selected_belly)]. Remember to put it in the infinitive tense, ie swallow, gulp, etc.")
		if ("can_taste")
			return list("Can Taste", "Can the [get_temp("name", selected_belly)] taste things?")
		if ("tastes_of")
			return list("Tastes like", "What does your character taste like?")
		if (LIST_DIGEST_PREY)
			return list("Prey Digest Messages", "Enter the new digest messages for prey, one will be selected when the prey is digested. [common_insert]")
		if (LIST_DIGEST_PRED)
			return list("Pred Digest Messages", "Enter the new digest messages for the predator, one will be selected when the prey is digested. [common_insert]")
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

/datum/vore_prefs/proc/belly_name_list(add_select=FALSE, current=FALSE)
	var/list/belly_names = list()
	var/list/keep_track = list()
	var/list_len = current ? bellies.len : unsaved_changes["bellies"].len
	for (var/belly in 1 to list_len)
		var/bellyname = current ? bellies[belly]["name"] : get_temp("name", belly=belly)
		keep_track[bellyname] = keep_track[bellyname] ? (keep_track[bellyname] + 1) : 1
		var/formatted_belly_name = bellyname + ((keep_track[bellyname] > 1) ? " ([keep_track[bellyname]])" : "")
		belly_names += formatted_belly_name
		if(add_select)
			belly_names[formatted_belly_name] = belly
	return belly_names

//This should all be redone to be hardcoded for safety but for now it'll do
/datum/vore_prefs/proc/set_temp(var_name, value, belly=null, toggle=null)
	. = FALSE
	if (isnull(value))
		return
	if (!var_name || !istext(var_name) || (belly && !isnum(belly)) || (toggle && !isnum(toggle)))
		CRASH("Vore prefs attempted an unsafe set_temp: [STRIP_HTML_SIMPLE(var_name, 20)]!") //this should probably be taken out and merged with the above check before it's merged

	to_chat(usr, "\"<span class='red'><b>[var_name]</b></span>\"[(var_name in static_belly_vars()) ? "" : " not"] in static_belly_vars().") //debugging code
	if (belly && (var_name in static_belly_vars()))
		has_unsaved = TRUE
		unsaved_changes["bellies"][belly][var_name] = value
		return TRUE

	if (!(var_name in vars))
		return

	has_unsaved = TRUE
	if (toggle)
		if (isnull(unsaved_changes[var_name]))
			unsaved_changes[var_name] = isnum(vars[var_name]) ? vars[var_name] : 0
		if (value)
			unsaved_changes[var_name] |= (1 << toggle)
		else
			unsaved_changes[var_name] &= ~(1 << toggle)
		return TRUE

	unsaved_changes[var_name] = value
	return TRUE

/datum/vore_prefs/proc/save_temp()
	if (!unsaved_changes)
		return
	for (var/belly in 1 to unsaved_changes["bellies"].len)
		while (unsaved_changes["bellies"][belly]["belly_ref"] > belly)
			bellies -= bellies[belly]
			var/datum/component/vore/vore = prefs?.parent?.mob?.GetComponent(/datum/component/vore)
			if (vore)
				vore.remove_belly(belly)
		for (var/var_name in unsaved_changes["bellies"][belly])
			if ((var_name in static_belly_vars()))
				bellies[belly][var_name] = unsaved_changes["bellies"][belly][var_name]
	unsaved_changes -= "bellies"
	for (var/var_name in unsaved_changes)
		if (var_name in vars)
			vars[var_name] = unsaved_changes[var_name]
	unsaved_changes = list()
	lazy_init_temp()
	if (isliving(prefs?.parent?.mob))
		if (istype(prefs.parent.mob.loc, /obj/vbelly))
			var/obj/vbelly/bellyobj = prefs.parent.mob.loc
			bellyobj.check_mode()
		var/datum/component/vore/vore = prefs.parent.mob.LoadComponent(/datum/component/vore)
		vore.update_bellies()

/datum/vore_prefs/proc/get_temp(var_name, belly=null, toggle=null)
	//to_chat(usr, "[isnull(var_name) ? "null" : var_name] - [isnull(belly) ? "null" : belly] - [isnull(toggle) ? "null" : toggle]") //debugging code
	if (belly && (var_name in static_belly_vars()) && belly <= unsaved_changes["bellies"].len)
		if (unsaved_changes["bellies"][belly].Find(var_name))
			return unsaved_changes["bellies"][belly][var_name]
		return bellies[unsaved_changes["bellies"][belly]["belly_ref"]][var_name]
	if (toggle)
		var/toggle_var = unsaved_changes[var_name]
		if(isnull(toggle_var) && (var_name in vars))
			toggle_var = vars[var_name]
		return (toggle_var & toggle)
	if (unsaved_changes[var_name])
		return unsaved_changes[var_name]
	if (var_name in vars)
		return vars[var_name]
	return null

/datum/vore_prefs/proc/get_belly_var(var_name, belly=selected_belly)
	if (belly &&(var_name in static_belly_vars()) && belly < bellies.len)
		return bellies[belly][var_name]

/datum/vore_prefs/proc/lazy_init_temp()
	if(!unsaved_changes)
		unsaved_changes = list()
	if(!unsaved_changes["bellies"])
		unsaved_changes["bellies"] = list()
		for (var/belly in 1 to bellies.len)
			unsaved_changes["bellies"] += list(list("belly_ref" = belly))

//debug proc to clear bellies
/datum/vore_prefs/proc/clear_bellies()
	bellies = list(default_belly_info())
	unsaved_changes = list()
	lazy_init_temp()
