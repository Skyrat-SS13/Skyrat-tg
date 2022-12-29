/datum/preference/toggle/enable_status_indicators
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "enable_status_indicators"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/enable_status_indicators/create_default_value()
	return TRUE


/datum/preference/toggle/enable_status_indicators/apply_to_client(client/client, value)
	if(client.mob)
		var/datum/component/status_indicator/mystatus = client.mob.GetComponent(/datum/component/status_indicator)
		if(mystatus)
			mystatus.apply_pref_on_login()

/* 	if(client && client.prefs)
		. = client?.prefs?.read_preference(/datum/preference/toggle/enable_status_indicators)
		var/atom/movable/screen/plane_master/status/status_indicators = locate() in client.screen
		if(isnull(status_indicators))
			new /atom/movable/screen/plane_master/status in client.screen
			status_indicators = locate() in client.screen
		if(length(status_indicators) < 1)
			pop(status_indicators)
		(.) ? (status_indicators.alpha = 255) : (status_indicators.alpha = 0)

 */
