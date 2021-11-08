/datum/component/vore
	var/list/bellies = list()

/datum/component/vore/Initialize()
	if (!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/on_examine)
	RegisterSignal(parent, COMSIG_PARENT_PREQDELETED, .proc/handle_delete)
	update_bellies()

/datum/component/vore/Destroy()
	UnregisterSignal(parent, COMSIG_PARENT_EXAMINE)
	UnregisterSignal(parent, COMSIG_PARENT_PREQDELETED)
	handle_delete()
	. = ..()

/datum/component/vore/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	//examine_list += text

/datum/component/vore/proc/handle_delete()
	SIGNAL_HANDLER

	if (isliving(parent))
		var/mob/living/living_mob = parent
		living_mob?.release_belly_contents()

/datum/component/vore/proc/get_belly_contents(selected_belly)
	var/obj/vbelly/belly = bellies[selected_belly]
	if (belly.name != name_of_belly)
		continue
	var/list/belly_contents = list()
	for (var/atom/movable/AM as anything in belly)
		belly_contents[AM.name] = ref(AM) //ref(AM) returns a string that can be used in locate() to get that atom back
	return belly_contents

/datum/component/vore/proc/update_bellies()
	if (!parent?.client?.prefs?.vr_prefs)
		return
	var/datum/vore_prefs/vore = parent.client.prefs.vr_prefs
	//todo


//this could probably go somewhere else
/mob/living/Login()
	. = ..()
	if (!. || !client)
		return

	if (client.prefs?.vr_prefs?.vore_enabled)
		AddComponent(/datum/component/vore)