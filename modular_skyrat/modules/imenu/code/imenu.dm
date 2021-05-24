#define INTERACTION_SELF "self" // X does thing
#define INTERACTION_OTHER "other" // X does thing [with/to] Y

// CATEGORIES ARE HARD CODED. IF YOU ADD A NEW CATEGORY YOU NEED TO ALSO CODE IN ITS RENDERING!

#define INTERACTION_CAT_HIDE "hide"
#define INTERACTION_CAT_NONE "none"

#define INTERACTION_JSON_FOLDER "modular_skyrat/modules/imenu/interactions/"

GLOBAL_LIST_EMPTY_TYPED(interaction_instances, /datum/interaction)

#define INTERACTION_MAX_CHAR 255
#define INTERACTION_COOLDOWN 0.5 SECONDS

#define INTERACTION_REQUIRE_SELF_HAND "self_hand"
#define INTERACTION_REQUIRE_SELF_SPEAK "self_speak"
#define INTERACTION_REQUIRE_TARGET_HAND "target_hand"
#define INTERACTION_REQUIRE_TARGET_SPEAK "target_speak"

/proc/populate_interaction_instances()
	if(GLOB.interaction_instances.len)
		return
	for(var/spath in subtypesof(/datum/interaction))
		var/datum/interaction/interaction = new spath()
		if(interaction.category == INTERACTION_CAT_HIDE)
			continue
		GLOB.interaction_instances[interaction.name] = interaction
	populate_interaction_jsons(INTERACTION_JSON_FOLDER)

/proc/populate_interaction_jsons(directory)
	for(var/file in flist(directory))
		message_admins(directory + file)
		if(flist(directory + file) && !findlasttext(directory + file, ".json"))
			populate_interaction_instances(directory + file)
			continue
		var/datum/interaction/int = new()
		if(int.load_from_json(directory + file))
			message_admins(int.name)
			GLOB.interaction_instances[int.name] = int
		else message_admins("Error loading interaction from file: '[directory + file]'. Inform coders.")

/datum/interaction/proc/load_from_json(path)
	message_admins("Attempting to load '[path]'")
	var/fpath = path
	if(!fexists(fpath))
		message_admins("Attempted to load an interaction from json and the file does not exist")
		qdel(src)
		return FALSE
	var/file = file(fpath)
	var/list/json = json_load(file)
	name = sanitize_text(json["name"])
	distance_allowed = sanitize_integer(json["distance_allowed"], 0, 1, 0)
	message = sanitize_islist(json["message"], list("json error"))
	category = sanitize_text(json["category"])
	usage = sanitize_text(json["usage"])
	sound_use = sanitize_integer(json["sound_use"], 0, 1, 0)
	sound_range = sanitize_integer(json["sound_range"], 1, 7, 1)
	sound_possible = sanitize_islist(json["sound_possible"], list("json error"))
	interaction_requires = sanitize_islist(json["interaction_requires"], list())
	return TRUE

/datum/interaction/proc/json_save(path)
	var/fpath = path
	if(fexists(fpath))
		fdel(fpath)
	var/list/json = list(
		"name" = name,
		"distance_allowed" = distance_allowed,
		"message" = message,
		"category" = category,
		"usage" = usage,
		"sound_use" = sound_use,
		"sound_range" = sound_range,
		"sound_possible" = sound_possible,
		"interaction_requires" = interaction_requires
	)
	var/file = file(fpath)
	WRITE_FILE(file, json_encode(json))
	return TRUE

/datum/interaction
	var/name = "broken interaction"
	var/distance_allowed = FALSE
	var/message = list()
	var/category = INTERACTION_CAT_HIDE
	var/usage = INTERACTION_OTHER
	var/sound_use = FALSE
	var/sound_range = 1
	var/sound_cache = null
	var/sound_possible = list()
	var/list/interaction_requires = list()

/datum/interaction/proc/allow_act(mob/living/user, mob/living/target)
	for(var/requirement in interaction_requires)
		switch(requirement)
			if(INTERACTION_REQUIRE_SELF_HAND)
				if(!user.get_active_hand())
					return FALSE
			if(INTERACTION_REQUIRE_SELF_SPEAK)
				if(!user.can_speak())
					return FALSE
			if(INTERACTION_REQUIRE_TARGET_HAND)
				if(!target.get_active_hand())
					return FALSE
			if(INTERACTION_REQUIRE_TARGET_SPEAK)
				if(!target.can_speak())
					return FALSE
			else
				message_admins("Unimplemented interaction requirement '[requirement]'. Blame coders.")
	return TRUE

/datum/interaction/proc/act(mob/living/user, mob/living/target)
	var/msg
	if(islist(message))
		msg = pick(message)
	else msg = message
	// We replace %USER% with nothing because manual_emote already prepends it.
	msg = trim(replacetext(replacetext(msg, "%TARGET%", "[target]"), "%USER%", ""))
	msg = truncate(msg, INTERACTION_MAX_CHAR)
	user.manual_emote(msg)
	if(sound_use)
		if(isnull(sound_possible))
			message_admins("Interaction has sound_use set to TRUE but does not set sound! '[name]'")
			return
		else if(islist(sound_possible))
			sound_cache = sound(pick(sound_possible))
		else sound_cache = sound(sound_possible)
		for(var/mob/mob in view(sound_range, user))
			SEND_SOUND(sound_cache, mob)

/datum/component/interactable
	var/mob/self = null
	var/interact_last = 0
	var/interact_next = 0

/datum/component/interactable/proc/can_interact(datum/interaction/interaction, mob/user)
	if(!interaction.allow_act(user, self))
		return FALSE
	if(!interaction.distance_allowed && !user.Adjacent(self))
		return FALSE
	if(interaction.category == INTERACTION_CAT_HIDE)
		return FALSE
	if(self == user && interaction.usage == INTERACTION_OTHER)
		return FALSE
	return TRUE

/datum/component/interactable/proc/make_interact_list(datum/component/interactable/other)
	populate_interaction_instances()
	var/list/ints = list()
	for(var/interaction in GLOB.interaction_instances)
		if(other.can_interact(GLOB.interaction_instances[interaction], self))
			ints += GLOB.interaction_instances[interaction]
	return ints

/datum/component/interactable/proc/mil_mob(mob/user)
	var/datum/other = user.GetComponent(/datum/component/interactable)
	if(!other)
		CRASH("Unable to locate the interactable component for the given mob.")
	return make_interact_list(other)

/datum/component/interactable/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "InteractionMenu")
		ui.set_autoupdate(TRUE)
		ui.open()

/mob/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/interactable)

/datum/component/interactable/Initialize(...)
	. = ..()
	self = parent

/mob/verb/cmd_interact()
	set src in view()
	set category = "IC"
	set name = "Interact"

	if(isobserver(usr) || isdead(usr) || !usr.stat)
		to_chat(usr, "You are dead.")
		return

	var/datum/component/interactable/int = GetComponent(/datum/component/interactable)
	int.ui_interact(get_mob_by_ckey(usr.ckey))

/datum/component/interactable/ui_data(mob/user)
	var/list/data = list()
	var/list/datum/interaction/ints = mil_mob(user)

	var/list/nones = list()
	for(var/datum/interaction/int in ints)
		switch(int.category)
			if(INTERACTION_CAT_NONE)
				nones += int.name
			if(INTERACTION_CAT_HIDE)
				continue
			else
				message_admins("Illegal Category for interaction. This needs to be reported to coders. '[int.category]'")

	data["ref_user"] = REF(user)
	data["ref_self"] = REF(self)
	data["self"] = self.name
	data["nones"] = nones
	data["block_interact"] = interact_next >= world.time
	return data

/datum/component/interactable/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	populate_interaction_instances()
	for(var/interaction in GLOB.interaction_instances)
		if(interaction == params["interaction"])
			GLOB.interaction_instances[interaction].act(locate(params["userref"]), locate(params["selfref"]))
			var/mob/living/user = locate(params["userref"])
			var/datum/component/interactable/int = user.GetComponent(/datum/component/interactable)
			int.interact_last = world.time
			int.interact_next = int.interact_last + INTERACTION_COOLDOWN
			return TRUE
	message_admins("Unhandled interaction '[params["interaction"]]'. Inform coders.")
