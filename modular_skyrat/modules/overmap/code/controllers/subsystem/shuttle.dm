/datum/controller/subsystem/shuttle/proc/get_transit_instance(atom/movable/movable_atom)
	for(var/datum/transit_instance/iterated_transit as anything in transit_instances)
		if(iterated_transit.reservation.IsInBounds(movable_atom))
			return iterated_transit
