/datum/preference/toggle/carrier_overlays
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_identifier = PREFERENCE_PLAYER
	savefile_key = "soulcatcher_overlays"
	default_value = TRUE

/datum/preference/toggle/carrier_overlays/apply_to_client_updated(client/client, value)
	apply_to_client(client, value)
	var/mob/living/target = client?.mob
	if(!value && istype(target))
		target.clear_fullscreen("carrier", FALSE)

