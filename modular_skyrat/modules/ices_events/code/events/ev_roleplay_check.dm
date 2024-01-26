/**
 * Checks if a player meets certain conditions to exclude them from event selection.
 */
/proc/engaged_role_play_check(mob/living/carbon/human/player, station = TRUE, dorms = TRUE)
	var/turf/player_turf = get_turf(player)
	var/area/player_area = get_area(player_turf)

	if(station && !is_station_level(player_turf.z))
		return TRUE
	if(dorms && istype(player_area, /area/station/commons/dorms))
		return TRUE

	return FALSE
