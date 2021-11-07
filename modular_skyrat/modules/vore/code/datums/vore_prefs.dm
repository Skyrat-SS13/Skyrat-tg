/datum/vore_prefs
	var/path
	var/client/parent
	var/vore_enabled = FALSE //master toggle
	var/vore_toggles = VORE_TOGGLES_DEFAULT
	var/tastes_of = ""
	var/list/bellies = list()

	var/list/unsaved_changes = list()
	/* someone else can do this
	can hear noises toggle + vore noises
	simplemob vore
	*/

/datum/vore_prefs/New(client/holder = null)
	if (!holder)
		return
	parent = holder
	var/current_slot = parent?.prefs?.default_slot
	path = "data/player_saves/[parent.ckey[1]]/[parent.ckey]/vore.sav"
	if (fexists(path))
		load_prefs(current_slot)
	else
		save_prefs(current_slot)

/datum/vore_prefs/proc/load_prefs(slot = 1)
	if (!path || !fexists(path))
		return FALSE
	var/savefile/S = new /savefile(path)
	if (!S)
		return FALSE
	. = TRUE
	S.cd = "/"
	READ_FILE(S["vore_enabled"], vore_enabled)
	if (!vore_enabled)
		return
	S.cd = "/char[slot]"
	READ_FILE(S["vore_toggles"], vore_toggles)
	READ_FILE(S["vore_taste"], tastes_of)
	READ_FILE(S["bellies"], bellies)
	if (!length(bellies))
		bellies.Add(default_belly_info())

/datum/vore_prefs/proc/save_prefs(slot = 1)
	if (!path)
		return FALSE
	var/savefile/S = new /savefile(path)
	if (!S)
		return FALSE
	. = TRUE
	S.cd = "/"
	WRITE_FILE(S["vore_enabled"], vore_enabled)
	if (!vore_enabled)
		return
	S.cd = "/char[slot]"
	WRITE_FILE(S["vore_toggles"], vore_toggles)
	WRITE_FILE(S["vore_taste"], tastes_of)
	WRITE_FILE(S["bellies"], bellies)

/datum/vore_prefs/proc/get_belly_info(slot = 1)
	if (slot > length(bellies) || slot < 1)
		return default_belly_info()
	return bellies[slot]

/datum/vore_prefs/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	if (user.client != parent)
		to_chat(user, span_danger("Either you have tried to access someone else's vore prefs, or something has gone badly wrong and you should ahelp."))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "VorePanel")
		ui.open()

/datum/vore_prefs/ui_data(mob/user)
	var/list/data = list()
	data["enabled"] = vore_enabled
	if (!vore_enabled)
		return data
	data["unsaved"] = !!unsaved_changes
	var/list/bellies_data = list()
	var/datum/component/vore/vore = user.GetComponent(/datum/component/vore)
	for (var/belly in bellies)
		var/list/belly_data = list()
		belly_data["name"] = belly["name"]
		belly_data["desc"] = belly["desc"]
		belly_data["mode"] = belly["mode"]
		if (!vore)
			continue
		belly_data["contents"] = vore.get_belly_contents(belly["name"])
		bellies_data += list(belly_data)
	data["bellies"] = bellies_data
	data["toggles"] = list()
	data["toggles"] += (vore_toggles & SEE_EXAMINES)
	data["toggles"] += (vore_toggles & SEE_STRUGGLES)
	data["toggles"] += (vore_toggles & SEE_OTHER_MESSAGES)
	data["toggles"] += (vore_toggles & DEVOURABLE)
	data["toggles"] += (vore_toggles & DIGESTABLE)
	data["toggles"] += (vore_toggles & ABSORBABLE)
	return data

/datum/vore_prefs/ui_act(action, list/params)
	. = ..()
	if (.)
		return

	switch(action)
		if("toggle_vore")
			vore_enabled = params["toggle"]
		if("toggle_act")
			var/value = params["toggle"]
			if (value)
				vore_toggles |= (1 << params["pref"])
			else
				vore_toggles &= ~(1 << params["pref"])


