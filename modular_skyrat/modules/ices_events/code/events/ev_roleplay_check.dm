/proc/engaged_role_play_check(mob/living/carbon/human/player)
	var/turf/player_turf = get_turf(player)
	var/area/player_area = get_area(player_turf)
	if(!is_station_level(player_turf.z))
		return TRUE

	if(istype(player_area, /area/station/commons/dorms))
		return TRUE

	return FALSE
