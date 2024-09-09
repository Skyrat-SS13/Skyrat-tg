/// list of dorms areas for doing event checks
GLOBAL_LIST_EMPTY(dorms_areas)

/area/station/commons/dorms/New()
	. = ..()
	GLOB.dorms_areas += src

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

/datum/weather/proc/enhanced_roleplay_filter(list/affectareas)
	return affectareas

/datum/weather/rad_storm/enhanced_roleplay_filter(list/affectareas)
	var/list/filtered_areas = affectareas
	for(var/area/engaged_roleplay_area as anything in GLOB.dorms_areas)
		for(var/mob/living/carbon/human/roleplayer in engaged_roleplay_area.contents)
			if(engaged_role_play_check(player = roleplayer, station = FALSE, dorms = TRUE))
				LAZYREMOVE(filtered_areas, engaged_roleplay_area)
				break
	return filtered_areas

/datum/weather/rad_storm/send_alert(alert_msg, alert_sfx)
	for(var/area/impacted_area as anything in impacted_areas)
		for(var/mob/living/player in impacted_area.contents)
			if(!can_get_alert(player))
				continue
			if(alert_msg)
				to_chat(player, alert_msg)
			if(alert_sfx)
				SEND_SOUND(player, sound(alert_sfx))
