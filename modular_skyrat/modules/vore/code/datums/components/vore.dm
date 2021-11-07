/datum/component/vore
	var/list/bellies = list()

/datum/component/vore/Initialize()
	if (!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/on_examine)
	RegisterSignal(parent, COMSIG_PARENT_PREQDELETED, .proc/handle_delete)

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

/datum/component/vore/proc/get_belly_contents(name_of_belly)
	for (var/obj/vbelly/belly as anything in bellies)
		if (belly.name != name_of_belly)
			continue
		var/list/belly_contents = list()
		for (var/atom/movable/AM as anything in belly)
			belly_contents[AM.name] = ref(AM) //ref(AM) returns a string that can be used in locate() to get that atom back
		return belly_contents