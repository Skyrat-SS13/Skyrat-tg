/// Whether or not to toggle ambient occlusion, the shadows around people
/datum/preference/toggle/ambient_occlusion
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "ambientocclusion"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/ambient_occlusion/apply_to_client(client/client, value)
<<<<<<< HEAD
=======
	/// Backdrop for the game world plane.
>>>>>>> 19329cd74a3 (Fixes objects with bad planes and FoV bugs (#63412))
	var/atom/movable/screen/plane_master/game_world/plane_master = locate() in client?.screen
	if (!plane_master)
		return

	plane_master.backdrop(client.mob)
