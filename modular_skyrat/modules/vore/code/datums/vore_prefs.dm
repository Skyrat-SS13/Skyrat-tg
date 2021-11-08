/datum/vore_prefs
	var/path
	var/datum/preferences/prefs //this is here because for modular reasons we aren't gonna set a client var every time

	var/vore_enabled = FALSE //master toggle
	var/vore_toggles = VORE_TOGGLES_DEFAULT
	var/tastes_of = ""
	var/list/bellies = list()

	var/list/unsaved_changes = null
	var/has_unsaved = FALSE
	var/selected_belly = 1
	var/static/list/belly_vars = list("name", "desc", "mode", LIST_DIGEST_PREY, LIST_DIGEST_PRED, LIST_STRUGGLE_INSIDE, LIST_STRUGGLE_OUTSIDE, LIST_EXAMINE)
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
	READ_FILE(S["selected_belly"], selected_belly)
	if(!selected_belly || !isnum(selected_belly))
		selected_belly = 1
	READ_FILE(S["vore_taste"], tastes_of)
	READ_FILE(S["bellies"], bellies)
	if (!bellies)
		bellies = list()
		bellies.Add(list(default_belly_info()))

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
	if (!bellies)
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

	data["selected_belly"] = selected_belly
	var/list/belly_names = list()
	var/list/keep_track = list()
	for (var/belly in 1 to bellies.len)
		var/bellyname = get_temp("name", belly=belly)
		keep_track[bellyname] = keep_track[bellyname] ? (keep_track[bellyname] + 1) : 1
		belly_names += bellyname + ((keep_track[bellyname] > 1) ? " (" + num2text(keep_track[bellyname]) + ")" : "")
	if (bellies.len < MAX_BELLIES)
		belly_names += "New Belly"
	data["bellies"] = belly_names

	var/datum/component/vore/vore = user.GetComponent(/datum/component/vore)
	var/list/belly_data = list()
	belly_data["name"] = get_temp("name", belly=selected_belly)
	belly_data["desc"] = get_temp("desc", belly=selected_belly)
	belly_data["mode"] = get_temp("mode", belly=selected_belly)
	belly_data["has_contents"] = FALSE
	belly_data["string_types"] = list(LIST_DIGEST_PREY, \
										LIST_DIGEST_PRED, \
										LIST_STRUGGLE_INSIDE, \
										LIST_STRUGGLE_OUTSIDE, \
										LIST_EXAMINE)
	if (vore)
		belly_data["has_contents"] = TRUE
		belly_data["contents"] = vore.get_belly_contents(selected_belly)
	data["current_belly"] = belly_data

	data["toggles"] = list()
	data["toggles"] += get_temp("vore_toggles", toggle=SEE_EXAMINES)
	data["toggles"] += get_temp("vore_toggles", toggle=SEE_STRUGGLES)
	data["toggles"] += get_temp("vore_toggles", toggle=SEE_OTHER_MESSAGES)
	data["toggles"] += get_temp("vore_toggles", toggle=DEVOURABLE)
	data["toggles"] += get_temp("vore_toggles", toggle=DIGESTABLE)
	data["toggles"] += get_temp("vore_toggles", toggle=ABSORBABLE)

	return data

/datum/vore_prefs/ui_static_data(mob/user)
	var/list/data = list()

	data["string_types"] = list(LIST_DIGEST_PREY, \
								LIST_DIGEST_PRED, \
								LIST_STRUGGLE_INSIDE, \
								LIST_STRUGGLE_OUTSIDE, \
								LIST_EXAMINE)
	return data

/datum/vore_prefs/ui_act(action, list/params)
	. = ..()
	if (.)
		return

	. = TRUE

	to_chat(usr, "[action]")
	for (var/x in params)
		to_chat(usr, "[x]: [params[x]]")

	switch(action)
		if("save_prefs")
			save_prefs()
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
			set_temp(var_name, get_input(usr, var_name, belly), belly)
		if("select_belly")
			var/belly = params["belly"]
			if (!isnum(belly))
				return FALSE
			if (belly > bellies.len)
				bellies.Add(list(default_belly_info()))
				unsaved_changes["bellies"] += list(list())
				selected_belly = bellies.len
				if (isliving(prefs?.parent?.mob))
					var/datum/component/vore/vore = prefs.parent.mob.LoadComponent(/datum/component/vore)
					vore.update_bellies()
			else
				selected_belly = belly

/datum/vore_prefs/proc/get_input(user, var_name, belly)
	if (!istext(var_name))
		return
	belly = belly || selected_belly //not sure if this needs to be here
	var/static/list/onelineinputs = list("name", "tastes_of")
	var/static/list/listinputs = list("mode" = list("Hold" = VORE_MODE_HOLD, \
													"Digest" = VORE_MODE_DIGEST, \
													"Absorb" = VORE_MODE_ABSORB))
	var/static/list/multilineinputs = list("desc" = FALSE, \
											LIST_DIGEST_PREY = TRUE, \
											LIST_DIGEST_PRED = TRUE, \
											LIST_STRUGGLE_INSIDE = TRUE, \
											LIST_STRUGGLE_OUTSIDE = TRUE, \
											LIST_EXAMINE = TRUE) //name of var - is it a list that needs to be joined into a string
	var/static/list/cant_be_empty = list("tastes_of" = "nothing in particular", "name" = null) //null means take the previous value
	var/output
	var/name_and_desc = get_desc_for_input(var_name)
	var/var_value = get_temp(var_name, belly)
	if (var_name in onelineinputs)
		output = input(user, name_and_desc[2], name_and_desc[1], var_value) as null|text

	else if (!isnull(multilineinputs[var_name]))
		var/default = multilineinputs[var_name] ? jointext(var_value, "\n\n") : var_value
		output = input(user, name_and_desc[2], name_and_desc[1], default) as null|message
		if (multilineinputs[var_name])
			output = splittext(STRIP_HTML_SIMPLE(output, MAX_MESSAGE_LEN), "\n\n")

	else if (!isnull(listinputs[var_name]))
		output = input(user, name_and_desc[2], name_and_desc[1], var_value) as null|anything in listinputs[var_name]

	else
		return

	if (output == var_value)
		return
	if (istext(output))
		output = STRIP_HTML_SIMPLE(output, MAX_MESSAGE_LEN) //yeet
	if (istext(output) && output == "")
		if (var_name in cant_be_empty)
			return cant_be_empty[var_name] || var_value
	if (isnull(output))
		output = var_value
	return output

/datum/vore_prefs/proc/get_desc_for_input(var_name)
	var/static/common_insert = "%pred will be replaced with the predator's name, %prey with the prey's name, and %belly with the name of the belly. Make sure to put two lines between each seperate message."
	switch(var_name)
		if ("name")
			return list("Name", "Enter the new name of the [get_temp("name", selected_belly)].")
		if ("desc")
			return list("Description", "Enter the new description of the [get_temp("name", selected_belly)].")
		if ("mode")
			return list("Mode", "Select the new mode of the [get_temp("name", selected_belly)].")
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

	return list("Something went wrong", "Something went wrong, tell a coder to look at vore code for the [var_name] var being sent.")

//This should all be redone to be hardcoded for safety but for now it'll do
/datum/vore_prefs/proc/set_temp(var_name, value, belly=null, toggle=null)
	. = FALSE
	if (isnull(value))
		return
	if (!var_name || !istext(var_name) || (belly && !isnum(belly)) || (toggle && !isnum(toggle)))
		CRASH("Vore prefs attempted an unsafe set_temp: [STRIP_HTML_SIMPLE(var_name, 20)]!") //this should probably be taken out and merged with the above check before it's merged

	to_chat(usr, "\"<span class='red'><b>[var_name]</b></span>\"[(var_name in belly_vars) ? "" : " not"] in belly_vars.")
	if (belly && (var_name in belly_vars))
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
	for (var/belly in 1 to unsaved_changes["bellies"].len)
		for (var/var_name in unsaved_changes["bellies"][belly])
			bellies[belly][var_name] = unsaved_changes["bellies"][belly][var_name]
	unsaved_changes -= "bellies"
	for (var/var_name in unsaved_changes)
		if (var_name in vars)
			vars[var_name] = unsaved_changes[var_name]
	unsaved_changes = list()
	lazy_init_temp()
	if (isliving(prefs?.parent?.mob))
		var/datum/component/vore/vore = prefs.parent.mob.LoadComponent(/datum/component/vore)
		vore.update_bellies()

/datum/vore_prefs/proc/get_temp(var_name, belly=null, toggle=null)
	//to_chat(usr, "[isnull(var_name) ? "null" : var_name] - [isnull(belly) ? "null" : belly] - [isnull(toggle) ? "null" : toggle]")
	if (belly && (var_name in belly_vars) && belly <= unsaved_changes["bellies"].len)
		if (unsaved_changes["bellies"][belly].Find(var_name))
			return unsaved_changes["bellies"][belly][var_name]
		return bellies[belly][var_name]
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

/datum/vore_prefs/proc/lazy_init_temp()
	if(!unsaved_changes)
		unsaved_changes = list()
	if(!unsaved_changes["bellies"])
		unsaved_changes["bellies"] = list()
		for (var/belly in bellies)
			unsaved_changes["bellies"] += list(list())

//debug proc to clear bellies
/datum/vore_prefs/proc/clear_bellies()
	bellies = list(default_belly_info())
	unsaved_changes = list()
	lazy_init_temp()
