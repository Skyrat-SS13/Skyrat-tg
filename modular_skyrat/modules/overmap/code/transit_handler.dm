/datum/component/transit_handler
	/// Our transit instance
	var/datum/transit_instance/transit_instance

/datum/component/transit_handler/Initialize(datum/transit_instance/transit_instance_)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	transit_instance = transit_instance_
	transit_instance.affected_movables[parent] = TRUE
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, .proc/on_parent_moved)

/datum/component/transit_handler/proc/on_parent_moved(atom/movable/source, atom/old_loc, Dir, Forced)
	var/turf/new_location = get_turf(parent)
	if(!istype(new_location, /turf/open/space/transit))
		qdel(src)
	transit_instance.MovableMoved(parent)

/datum/component/transit_handler/Destroy()
	UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)
	transit_instance.affected_movables -= parent
	return ..()
