#define INTERACTION_SELF // X does thing
#define INTERACTION_OTHER // X does thing [with/to] Y

// CATEGORIES ARE HARD CODED. IF YOU ADD A NEW CATEGORY YOU NEED TO ALSO CODE IN ITS RENDERING!

#define INTERACTION_CAT_HIDE "hide"
#define INTERACTION_CAT_NONE "none"

GLOBAL_LIST_EMPTY_TYPED(interaction_instances, /datum/interaction)

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

/datum/interaction/proc/allow_act(mob/living/user, mob/living/target)
	return TRUE

/datum/interaction/proc/act(mob/living/user, mob/living/target)
	// We replace %USER% with nothing because manual_emote already prepends it.
	user.manual_emote(trim(replacetext(replacetext(message, "%TARGET%", "[target]"), "%USER%", "")))
	return

/datum/component/interactable
	var/mob/self = null

/datum/component/interactable/proc/can_interact(datum/interaction/interaction, mob/user)
	if(!interaction.allow_act(user, self))
		return FALSE
	if(!interaction.distance_allowed && !user.Adjacent(self))
		return FALSE
	if(interaction.category == INTERACTION_CAT_HIDE)
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

	if(isobserver(usr))
		message_admins("You are dead.")
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

	return data

/datum/component/interactable/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	populate_interaction_instances()
	for(var/p in params)
		message_admins("[p] = [params[p]]")
	for(var/interaction in GLOB.interaction_instances)
		if(GLOB.interaction_instances[interaction].name == params["interaction"])
			GLOB.interaction_instances[interaction].act(locate(params["userref"]), locate(params["selfref"]))
			return TRUE
	message_admins("Unhandled interaction '[params["interaction"]]'. Inform coders.")
