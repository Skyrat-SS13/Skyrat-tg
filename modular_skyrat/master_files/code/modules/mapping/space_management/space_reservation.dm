/datum/turf_reservation
	var/edge_type

/datum/turf_reservation/transit
	edge_type = /turf/open/space/transit/edge

/datum/turf_reservation/proc/IsInBounds(atom/atom_check)
	var/low_x = bottom_left_coords[1]
	var/high_x = top_right_coords[1]
	var/low_y = bottom_left_coords[2]
	var/high_y = top_right_coords[2]
	if(atom_check.x >= low_x && atom_check.x <= high_x && atom_check.y >= low_y && atom_check.y <= high_y)
		return TRUE
	return FALSE

/datum/turf_reservation/proc/IsAtEdge(atom/atom_check)
	var/low_x = bottom_left_coords[1]
	var/high_x = top_right_coords[1]
	var/low_y = bottom_left_coords[2]
	var/high_y = top_right_coords[2]
	if((atom_check.x == low_x || atom_check.x == high_x) || (atom_check.y == low_y || atom_check.y == high_y))
		return TRUE
	return FALSE

//Hate me for this one but I'll be finding it real useful
/datum/turf_reservation/proc/IsAdjacentToEdgeOrOutOfBounds(atom/atom_check)
	var/low_x = bottom_left_coords[1] + 1
	var/high_x = top_right_coords[1] - 1
	var/low_y = bottom_left_coords[2] + 1
	var/high_y = top_right_coords[2] - 1
	if((atom_check.x <= low_x || atom_check.x >= high_x) || (atom_check.y <= low_y || atom_check.y >= high_y))
		return TRUE
	return FALSE
