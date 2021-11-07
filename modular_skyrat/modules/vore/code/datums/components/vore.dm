/datum/component/vore
	var/list/bellies = list()

/datum/component/vore/Initialize()
	if (!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, .proc/on_examine)
	RegisterSignal(parent, COMSIG_PARENT_PREQDELETED, .proc/handle_delete)

/datum/component/vore/Destroy()
	UnregisterSignal(parent, COMSIG_PARENT_EXAMINE)
	parent.release
	. = ..()

/datum/component/vore/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	//examine_list += text

/datum/component/vore/proc/handle_delete()
	SIGNAL_HANDLER

	parent.release_belly_contents()
