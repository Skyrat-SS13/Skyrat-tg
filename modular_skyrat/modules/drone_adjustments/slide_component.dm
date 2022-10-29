/datum/component/sliding_under
	///The atom that has this component
	var/atom/atom_parent
	///The list of allowed mobs to slide under
	var/static/list/allowed_mobs = list(
		/mob/living/basic/cortical_borer,
		/mob/living/simple_animal/drone,
	)

/datum/component/sliding_under/Initialize(allowed_mobs_override = null)
	//needs to be an atom
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	atom_parent = parent
	//if we have an override, go ahead
	if(allowed_mobs_override)
		allowed_mobs = allowed_mobs_override
	//either bumping or ctrl click
	RegisterSignal(atom_parent, COMSIG_CLICK_CTRL, .proc/check_conditions)
	//so that we can know how to do that (sliding under)
	RegisterSignal(atom_parent, COMSIG_PARENT_EXAMINE, .proc/ExamineMessage)

/datum/component/sliding_under/Destroy(force, silent)
	UnregisterSignal(atom_parent, list(COMSIG_CLICK_CTRL, COMSIG_PARENT_EXAMINE))
	return ..()

/datum/component/sliding_under/proc/check_conditions(datum/source, mob/user)
	//the parent needs to be dense in order to slide through
	if(!atom_parent.density)
		return
	// need to be in range
	if(!in_range(atom_parent, user))
		return
	//you have to be in the list
	if(!is_type_in_list(user, allowed_mobs))
		return
	//you need to have patience and can't move away
	if(!do_after(user, 5 SECONDS, atom_parent))
		return
	user.forceMove(get_turf(atom_parent))
	atom_parent.balloon_alert_to_viewers("something squeezes through!")

/datum/component/sliding_under/proc/ExamineMessage(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	if(!is_type_in_list(user, allowed_mobs))
		return
	examine_list += span_warning("Ctrl + Click [atom_parent] to slide under!")
