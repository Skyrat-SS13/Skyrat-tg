#define INTERACTION_JSON_FOLDER "config/skyrat/interactions/"

GLOBAL_LIST_EMPTY_TYPED(interaction_instances, /datum/interaction)

// Special values
#define INTERACTION_MAX_CHAR 255
#define INTERACTION_COOLDOWN 0.5 SECONDS

// If an interaction has this category it will not be shown to players
#define INTERACTION_CAT_HIDE "hide"

// I want these to be bitflags; but that would make json loading painful beyond compare
// If you add a new requirement you also need to implement its checking. See /datum/interaction/proc/allow_act
#define INTERACTION_REQUIRE_SELF_HAND "self_hand"
#define INTERACTION_REQUIRE_SELF_SPEAK "self_speak"
#define INTERACTION_REQUIRE_TARGET_HAND "target_hand"
#define INTERACTION_REQUIRE_TARGET_SPEAK "target_speak"

// Interaction Types: Do we do it to ourself or someone else
#define INTERACTION_SELF "self"
#define INTERACTION_OTHER "other"

/mob/living/carbon/human/CtrlShiftClickOn(atom/atom_on)
	. = ..()
	if(.) // already handled, ignore
		return .
	if(ishuman(atom_on))
		var/mob/living/carbon/human/clicked_living = atom_on
		var/datum/component/interactable/clicked_int = clicked_living.GetComponent(/datum/component/interactable)
		if(!clicked_int)
			message_admins("Interactable CtrlShiftClickOn failure. Inform Coders.")
		clicked_int.ui_interact(src)

/proc/populate_interaction_instances()
	if(GLOB.interaction_instances.len)
		return
	for(var/spath in subtypesof(/datum/interaction))
		var/datum/interaction/interaction = new spath()
		GLOB.interaction_instances[interaction.name] = interaction
	populate_interaction_jsons(INTERACTION_JSON_FOLDER)

/proc/populate_interaction_jsons(directory)
	for(var/file in flist(directory))
		if(flist(directory + file) && !findlasttext(directory + file, ".json"))
			populate_interaction_instances(directory + file)
			continue
		if(findlasttext(directory + file, ".master.json")) // This is a master json which has special handling
			populate_interaction_jsons_master(directory + file)
			continue
		var/datum/interaction/int = new()
		if(int.load_from_json(directory + file))
			GLOB.interaction_instances[int.name] = int
		else message_admins("Error loading interaction from file: '[directory + file]'. Inform coders.")

/proc/populate_interaction_jsons_master(path)
	if(!fexists(path))
		message_admins("We are attempting to load an interaction master without the file existing! '[path]'")
		return
	var/file = file(path)
	var/list/json = json_load(file)

	for(var/iname in json)
		if(GLOB.interaction_instances[iname])
			message_admins("Interaction Master '[path]' contained a duplicate interaction! '[iname]'")
			continue

		var/list/ijson = json[iname]
		if(ijson["name"] != iname)
			message_admins("Interaction Master '[path]' contained an invalid interaction! '[iname]'")
			continue

		var/datum/interaction/int = new()

		int.distance_allowed = sanitize_integer(ijson["distance_allowed"], 0, 1, 0)
		int.message = sanitize_islist(ijson["message"], list("json error"))
		int.category = sanitize_text(ijson["category"])
		int.usage = sanitize_text(ijson["usage"])
		int.sound_use = sanitize_integer(ijson["sound_use"], 0, 1, 0)
		int.sound_range = sanitize_integer(ijson["sound_range"], 1, 7, 1)
		int.sound_possible = sanitize_islist(ijson["sound_possible"], list("json error"))
		int.interaction_requires = sanitize_islist(ijson["interaction_requires"], list())

		int.user_messages = sanitize_islist(ijson["user_messages"], list())
		int.user_required_parts = sanitize_islist(ijson["user_required_parts"], list())
		int.user_arousal = sanitize_integer(ijson["user_arousal"], 0, 100, 0)
		int.user_pleasure = sanitize_integer(ijson["user_pleasure"], 0, 100, 0)
		int.user_pain = sanitize_integer(ijson["user_pain"], 0, 100, 0)
		int.target_messages = sanitize_islist(ijson["target_messages"], list())
		int.target_required_parts = sanitize_islist(ijson["target_required_parts"], list())
		int.target_arousal = sanitize_integer(ijson["target_arousal"], 0, 100, 0)
		int.target_pleasure = sanitize_integer(ijson["target_pleasure"], 0, 100, 0)
		int.target_pain = sanitize_integer(ijson["target_pain"], 0, 100, 0)
		int.lewd = sanitize_integer(ijson["lewd"], 0, 1, 0)

		GLOB.interaction_instances[iname] = int

/datum/interaction/proc/load_from_json(path)
	var/fpath = path
	if(!fexists(fpath))
		message_admins("Attempted to load an interaction from json and the file does not exist")
		qdel(src)
		return FALSE
	var/file = file(fpath)
	var/list/json = json_load(file)
	name = sanitize_text(json["name"])
	description = sanitize_text(json["description"])
	distance_allowed = sanitize_integer(json["distance_allowed"], 0, 1, 0)
	message = sanitize_islist(json["message"], list("json error"))
	category = sanitize_text(json["category"])
	usage = sanitize_text(json["usage"])
	sound_use = sanitize_integer(json["sound_use"], 0, 1, 0)
	sound_range = sanitize_integer(json["sound_range"], 1, 7, 1)
	sound_possible = sanitize_islist(json["sound_possible"], list("json error"))
	interaction_requires = sanitize_islist(json["interaction_requires"], list())

	user_messages = sanitize_islist(json["user_messages"], list())
	user_required_parts = sanitize_islist(json["user_required_parts"], list())
	user_arousal = sanitize_integer(json["user_arousal"], 0, 100, 0)
	user_pleasure = sanitize_integer(json["user_pleasure"], 0, 100, 0)
	user_pain = sanitize_integer(json["user_pain"], 0, 100, 0)
	target_messages = sanitize_islist(json["target_messages"], list())
	target_required_parts = sanitize_islist(json["target_required_parts"], list())
	target_arousal = sanitize_integer(json["target_arousal"], 0, 100, 0)
	target_pleasure = sanitize_integer(json["target_pleasure"], 0, 100, 0)
	target_pain = sanitize_integer(json["target_pain"], 0, 100, 0)
	lewd = sanitize_integer(json["lewd"], 0, 1, 0)
	return TRUE

/datum/interaction/proc/json_save(path)
	var/fpath = path
	if(fexists(fpath))
		fdel(fpath)
	var/list/json = list(
		"name" = name,
		"description" = description,
		"distance_allowed" = distance_allowed,
		"message" = message,
		"category" = category,
		"usage" = usage,
		"sound_use" = sound_use,
		"sound_range" = sound_range,
		"sound_possible" = sound_possible,
		"interaction_requires" = interaction_requires,
		"user_messages" = user_messages,
		"user_required_parts" = user_required_parts,
		"user_arousal" = user_arousal,
		"user_pleasure" = user_pleasure,
		"user_pain" = user_pain,
		"target_messages" = target_messages,
		"target_required_parts" = target_required_parts,
		"target_arousal" = target_arousal,
		"target_pleasure" = target_pleasure,
		"target_pain" = target_pain,
		"lewd" = lewd,
	)
	var/file = file(fpath)
	WRITE_FILE(file, json_encode(json))
	return TRUE

/datum/interaction
	/// The name to be displayed in the interaction menu for this interaction
	var/name = "broken interaction"
	/// The description of the interacton.
	var/description = "broken"
	/// If it can be done at a distance.
	var/distance_allowed = FALSE
	/// A list of possible messages displayed loaded by the JSON.
	var/list/message = list()
	/// A list of possible messages displayed directly to the USER.
	var/list/user_messages = list()
	/// A list of possible messages displayed directly to the TARGET.
	var/list/target_messages = list()
	/// What category this interaction will fall under in the menu.
	var/category = INTERACTION_CAT_HIDE
	/// Defines how we interact with ourselves or others.
	var/usage = INTERACTION_OTHER
	/// Does this interaction play a sound?
	var/sound_use = FALSE
	/// If it plays a sound, how far does it travel?
	var/sound_range = 1
	/// Stores the sound for later.
	var/sound_cache = null
	/// Is this lewd?
	var/lewd = FALSE
	/// What parts do WE need(IMPORTANT TO GET IT TO THE CORRECT DEFINE, ORGAN SLOT)?
	var/list/user_required_parts = list()
	/// What parts do they need(IMPORTANT TO GET IT TO THE CORRECT DEFINE, ORGAN SLOT)?
	var/list/target_required_parts = list()
	/// The amount of pleasure the target recieves from this interaciton.
	var/target_pleasure = 0
	/// The amount of arousal the target recieves from this interaction.
	var/target_arousal = 0
	/// The amount of pain the target recieves.
	var/target_pain = 0
	/// The amount of pleasure the user recieves.
	var/user_pleasure = 0
	/// The amount of arousal the user recieves.
	var/user_arousal = 0
	/// The amount of pain the user recieves.
	var/user_pain = 0
	/// A list of possible sounds.
	var/list/sound_possible = list()
	/// What requirements does this interaction have? See defines.
	var/list/interaction_requires = list()

/datum/interaction/proc/allow_act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target == user && usage == INTERACTION_OTHER)
		return FALSE

	if(lewd && !user.client?.prefs?.read_preference(/datum/preference/toggle/erp) || !target.client?.prefs?.read_preference(/datum/preference/toggle/erp))
		return FALSE

	if(user_required_parts.len)
		for(var/thing in user_required_parts)
			var/obj/item/organ/genital/required_part = user.getorganslot(thing)
			if(isnull(required_part))
				return FALSE
			if(!required_part.is_exposed())
				return FALSE

	if(target_required_parts.len)
		for(var/thing in target_required_parts)
			var/obj/item/organ/genital/required_part = target.getorganslot(thing)
			if(isnull(required_part))
				return FALSE
			if(!required_part.is_exposed())
				return FALSE

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
				message_admins("Unimplemented interaction requirement '[requirement]'.")
				CRASH("Unimplemented interaction requirement '[requirement]'")
	return TRUE

/datum/interaction/proc/act(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(!message)
		message_admins("Interaction had a null message list. '[name]'")
		return
	if(!islist(message) && istext(message))
		message_admins("Deprecated message handling for '[name]'. Correct format is a list with one entry. This message will only show once.")
		message = list(message)
	var/msg = pick(message)
	// We replace %USER% with nothing because manual_emote already prepends it.
	msg = trim(replacetext(replacetext(msg, "%TARGET%", "[target]"), "%USER%", ""), INTERACTION_MAX_CHAR)
	if(lewd)
		user.emote("subtler", null, msg, TRUE)
	else
		user.manual_emote(msg)
	var/user_msg = pick(user_messages)
	user_msg = replacetext(replacetext(user_msg, "%TARGET%", "[target]"), "%USER%", "[user]")
	to_chat(user, user_msg)
	var/target_msg = pick(user_messages)
	target_msg = replacetext(replacetext(target_msg, "%TARGET%", "[target]"), "%USER%", "[user]")
	to_chat(target, target_msg)
	if(sound_use)
		if(!sound_possible)
			message_admins("Interaction has sound_use set to TRUE but does not set sound! '[name]'")
			return
		if(!islist(sound_possible) && istext(sound_possible))
			message_admins("Deprecated sound handling for '[name]'. Correct format is a list with one entry. This message will only show once.")
			sound_possible = list(sound_possible)
		sound_cache = pick(sound_possible)
		for(var/mob/mob in view(sound_range, user))
			SEND_SOUND(sound_cache, mob)

	if(lewd)
		user.adjustPleasure(user_pleasure)
		user.adjustArousal(user_arousal)
		user.adjustPain(user_pain)
		target.adjustPleasure(target_pleasure)
		target.adjustArousal(target_arousal)
		target.adjustPain(target_pain)

/datum/component/interactable
	var/mob/living/carbon/human/self = null
	var/interact_last = 0
	var/interact_next = 0

/datum/component/interactable/proc/can_interact(datum/interaction/interaction, mob/living/carbon/human/user)
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

/datum/component/interactable/ui_status(mob/user, datum/ui_state/state)
	return UI_INTERACTIVE // This UI is always interactive as we handle distance flags via can_interact

/mob/living/carbon/human/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/interactable)

/datum/component/interactable/Initialize(...)
	. = ..()
	self = parent

/mob/living/carbon/human/verb/cmd_interact()
	set src in view()
	set category = "IC"
	set name = "Interact"

	if(isobserver(usr) || isdead(usr) || usr.stat == DEAD)
		to_chat(usr, "You are dead.")
		return

	var/datum/component/interactable/int = GetComponent(/datum/component/interactable)
	int.ui_interact(get_mob_by_ckey(usr.ckey))

/datum/component/interactable/ui_data(mob/user)
	var/list/data = list()
	var/list/datum/interaction/ints = mil_mob(user)

	var/list/descs = list()
	var/list/cats = list()
	for(var/datum/interaction/int in ints)
		if(!cats[int.category])
			cats[int.category] = list(int.name)
		else cats[int.category] += int.name
		descs[int.name] = int.description
	data["categories"] = list()
	data["descs"] = descs
	for(var/cat in cats)
		data["categories"] += cat

	data["ref_user"] = REF(user)
	data["ref_self"] = REF(self)
	data["self"] = self.name
	data["ints"] = cats
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
			var/mob/living/carbon/human/user = locate(params["userref"])
			var/datum/component/interactable/int = user.GetComponent(/datum/component/interactable)
			int.interact_last = world.time
			interact_next = int.interact_last + INTERACTION_COOLDOWN
			int.interact_next = interact_next
			return TRUE
	message_admins("Unhandled interaction '[params["interaction"]]'. Inform coders.")
