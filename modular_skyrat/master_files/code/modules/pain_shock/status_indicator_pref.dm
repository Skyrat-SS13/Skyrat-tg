/datum/preference/toggle/enable_status_indicators
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "enable_status_indicators"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/enable_status_indicators/create_default_value()
	return TRUE

/datum/preference/toggle/enable_status_indicators/apply_to_client(client/client, value)
	if(client)
		var/mob/client_mob = client.mob
		INVOKE_ASYNC(client_mob, /mob.proc/apply_status_indicator_pref)

/mob/proc/apply_status_indicator_pref(datum/source)
	SIGNAL_HANDLER
	var/client/myclient = client
	var/value = myclient?.prefs?.read_preference(/datum/preference/toggle/enable_status_indicators)
	var/atom/movable/screen/plane_master/status/status_indicators = locate() in myclient?.screen
	if(value && status_indicators)
		status_indicators.Show()
	else if(!value && status_indicators)
		status_indicators.Hide()
