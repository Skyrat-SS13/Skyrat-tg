/datum/component/alert_locked
	var/alert_level = SEC_LEVEL_GREEN

/datum/component/alert_locked/Initialize(required_level)
	. = ..()
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	var/atom/movable/parent_atom = parent
	alert_level = required_level
	parent_atom.name = "alert-locked [parent_atom.name]"
	RegisterSignal(SSsecurity_level, COMSIG_SECURITY_LEVEL_CHANGED, .proc/check_security_level)

/datum/component/alert_locked/proc/check_security_level(datum/source, new_level)
	SIGNAL_HANDLER
	if(alert_level > new_level)
		var/atom/movable/parent_atom = parent
		parent_atom.balloon_alert_to_viewers("dematerializes due to alert level!")
		qdel(parent_atom)
