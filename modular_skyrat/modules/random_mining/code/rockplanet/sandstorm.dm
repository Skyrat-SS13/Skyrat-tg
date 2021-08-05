/datum/weather/ash_storm/sand	//Subtype of ash storms due to similarity. Means I dont have to mess with stats - only descriptions, overlays, the ZTRAIT, and the effect
	name = "sand storm"
	desc = "Constant winds paired with lack of vegetation leads to lots of dust pickup, causing massive dust storms across most of the planet."

	telegraph_message = "<span class='warning'>The dust stirs, picking up off the floor and blowing past your legs...</span>"
	telegraph_overlay = "light_ash"

	weather_message = "<span class='userdanger'><i>Harsh winds pick up, pulling up dust around you violently - it's a sandstorm!! Seek shelter!</i></span>"
	weather_overlay = "ash_storm"
	weather_duration_lower = 800
	weather_duration_upper = 1600	//They last longer because they're less dangerous

	end_message = "<span class='boldannounce'>The dust settles down, it should be safe to go outside again.</span>"
	end_overlay = "light_ash"

	target_trait = ZTRAIT_SANDSTORM
	//This inherits the same immunity type, WEATHER_ASH

/datum/weather/ash_storm/sand/weather_act(mob/living/L)
	if(is_ash_immune(L))
		return
	L.set_blurriness(5)
	L.adjustBruteLoss(2)

/datum/weather/ash_storm/sand/light_winds
	name = "light winds"
	desc = "The winds pick up, but not to dangerous speeds. Anxiety inducing at most."

	weather_message = "<span class='notice'>Dust picks up off the ground, dancing around your legs. It seems the winds arent getting any stronger, at least...</span>"
	weather_overlay = "light_ash"

	end_message = "<span class='notice'>As the winds die down, the dust falls back to the floor, resting upon a dead planet.</span>"
	end_sound = null

	aesthetic = TRUE

	probability = 10

/*
/datum/weather/ash_storm/sand/update_areas()	//Has to be re-written to give new sprites, unless I wanted non-modular sprites which is a hell nah from me
	for(var/V in impacted_areas)
		var/area/N = V
		N.layer = overlay_layer
		N.plane = overlay_plane
		N.icon = 'icons/effects/weather_effects.dmi'
		N.color = weather_color
		switch(stage)
			if(STARTUP_STAGE)
				N.icon_state = telegraph_overlay
			if(MAIN_STAGE)
				N.icon_state = weather_overlay
			if(WIND_DOWN_STAGE)
				N.icon_state = end_overlay
			if(END_STAGE)
				N.color = null
				N.icon_state = ""
				N.icon = 'icons/turf/areas.dmi'
				N.layer = initial(N.layer)
				N.plane = initial(N.plane)
				N.set_opacity(FALSE)
*/
//This file needs heavy cleanup, hopefully not having it a subtype of ash storms/maybe doing eye damage when the face is uncovered/custom sprites and overlays. But this is a fine placeholder for now.
