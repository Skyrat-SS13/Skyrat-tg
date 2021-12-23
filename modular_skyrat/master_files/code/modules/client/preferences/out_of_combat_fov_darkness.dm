/datum/preference/numeric/out_of_combat_fov_darkness
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "out_of_combat_fov_darkness"
	savefile_identifier = PREFERENCE_PLAYER

	minimum = 0
	maximum = 255

/datum/preference/numeric/out_of_combat_fov_darkness/create_default_value()
	return 0
