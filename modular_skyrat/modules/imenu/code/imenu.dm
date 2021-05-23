#define INTERACTION_SELF "self" // X does thing
#define INTERACTION_OTHER "other" // X does thing [with/to] Y

// CATEGORIES ARE HARD CODED. IF YOU ADD A NEW CATEGORY YOU NEED TO ALSO CODE IN ITS RENDERING!

#define INTERACTION_CAT_HIDE "hide"
#define INTERACTION_CAT_NONE "none"

GLOBAL_LIST_EMPTY_TYPED(interaction_instances, /datum/interaction)

#define INTERACTION_MAX_CHAR 255
#define INTERACTION_COOLDOWN 0.5 SECONDS

/proc/populate_interaction_instances()
	if(GLOB.interaction_instances.len)
		return
	for(var/spath in subtypesof(/datum/interaction))
		var/datum/interaction/interaction = new spath()
		if(interaction.category == INTERACTION_CAT_HIDE)
			continue
		GLOB.interaction_instances[spath] = interaction

/datum/interaction
	var/name = "default interaction"
	var/distance_allowed = FALSE
	var/message = "not implemented"
	var/category = INTERACTION_CAT_HIDE
	var/usage = INTERACTION_OTHER
	var/sound_use = FALSE
	var/sound_range = 1
	var/sound_cache = null
	var/sound = null

/datum/interaction/proc/allow_act(mob/living/user, mob/living/target)
	return TRUE

/datum/interaction/proc/act(mob/living/user, mob/living/target)
	// We replace %USER% with nothing because manual_emote already prepends it.
	var/msg = truncate(message, INTERACTION_MAX_CHAR)
	user.manual_emote(trim(replacetext(replacetext(msg, "%TARGET%", "[target]"), "%USER%", "")))
	if(sound_use)
		if(isnull(sound))
			message_admins("Interaction has sound_use set to TRUE but does not set sound! '[name]'")
			return
		else if(islist(sound))
			sound_cache = sound(pick(sound))
		else sound_cache = sound(sound)
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
		if(GLOB.interaction_instances[interaction].name == params["interaction"])
			GLOB.interaction_instances[interaction].act(locate(params["userref"]), locate(params["selfref"]))
			var/datum/component/interactable/int = locate(params["userref"]).GetComponent(/datum/component/interactable)
			int.interact_last = world.time
			int.interact_next = int.interact_last + INTERACTION_COOLDOWN
			return TRUE
	message_admins("Unhandled interaction '[params["interaction"]]'. Inform coders.")
