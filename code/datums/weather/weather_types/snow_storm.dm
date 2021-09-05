/datum/weather/snow_storm
	name = "snow storm"
	desc = "Harsh snowstorms roam the topside of this arctic planet, burying any area unfortunate enough to be in its path."
	//probability = 90 SKYRAT EDIT REMOVAL

	telegraph_message = "<span class='warning'>Drifting particles of snow begin to dust the surrounding area..</span>"
	telegraph_duration = 300
	telegraph_overlay = "snowfall_light" //SKYRAT EDIT CHANGE

	weather_message = "<span class='userdanger'><i>Harsh winds pick up as dense snow begins to fall from the sky! Seek shelter!</i></span>"
	weather_overlay = "snow_storm"
	weather_duration_lower = 600
	weather_duration_upper = 1500

	end_duration = 100
	end_message = "<span class='boldannounce'>The snowfall dies down, it should be safe to go outside again.</span>"

	area_type = /area
	protect_indoors = TRUE
	//target_trait = ZTRAIT_SNOWSTORM SKYRAT EDIT REMOVAL

	immunity_type = TRAIT_SNOWSTORM_IMMUNE

	barometer_predictable = TRUE

	//SKYRAT EDIT ADDITION
	sound_active_outside = /datum/looping_sound/active_outside_ashstorm
	sound_active_inside = /datum/looping_sound/active_inside_ashstorm
	sound_weak_outside = /datum/looping_sound/weak_outside_ashstorm
	sound_weak_inside = /datum/looping_sound/weak_inside_ashstorm

	affects_underground = FALSE
	//SKYRAT EDIT END

/datum/weather/snow_storm/weather_act(mob/living/L)
	L.adjust_bodytemperature(-rand(5,15))

