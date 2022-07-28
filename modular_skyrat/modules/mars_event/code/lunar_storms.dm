#define ZTRAIT_MOONWEATHER "Weather_Lunar"

/datum/weather/lunar_storm
	name = "particle shower"
	desc = "A dense cloud of small particles batter the surface of the moon, dealing damage to any caught out in the storm."

	telegraph_message = "<span class='boldwarning'>Tiny shadows dot the ground, the sky fills with a cloud of reflective dust, find shelter!.</span>"
	telegraph_duration = 300
	telegraph_overlay = "light_ash"

	weather_message = "<span class='userdanger'><i>Small meteorites and metallic particles batter the surface around you, get inside!</i></span>"
	weather_duration_lower = 1200
	weather_duration_upper = 2400
	weather_overlay = "snow_snow"

	end_message = "<span class='boldannounce'>The rain of rocks and metal finally slows down, a new layer of material added to the lunar regolith.</span>"
	end_duration = 300
	end_overlay = "light_ash"

	area_type = /area
	protect_indoors = TRUE
	target_trait = ZTRAIT_MOONWEATHER

	immunity_type = TRAIT_ASHSTORM_IMMUNE

	probability = 70

	barometer_predictable = TRUE
	var/list/weak_sounds = list()
	var/list/strong_sounds = list()

/datum/weather/lunar_storm/telegraph()
	var/list/eligible_areas = list()
	for (var/z in impacted_z_levels)
		eligible_areas += SSmapping.areas_in_z["[z]"]
	for(var/i in 1 to eligible_areas.len)
		var/area/place = eligible_areas[i]
		if(place.outdoors)
			weak_sounds[place] = /datum/looping_sound/weak_outside_ashstorm
			strong_sounds[place] = /datum/looping_sound/active_outside_ashstorm
		else
			weak_sounds[place] = /datum/looping_sound/weak_inside_ashstorm
			strong_sounds[place] = /datum/looping_sound/active_inside_ashstorm
		CHECK_TICK

	//We modify this list instead of setting it to weak/stron sounds in order to preserve things that hold a reference to it
	//It's essentially a playlist for a bunch of components that chose what sound to loop based on the area a player is in
	GLOB.ash_storm_sounds += weak_sounds
	return ..()

/datum/weather/lunar_storm/start()
	GLOB.ash_storm_sounds -= weak_sounds
	GLOB.ash_storm_sounds += strong_sounds
	return ..()

/datum/weather/lunar_storm/wind_down()
	GLOB.ash_storm_sounds -= strong_sounds
	GLOB.ash_storm_sounds += weak_sounds
	return ..()

/datum/weather/lunar_storm/end()
	GLOB.ash_storm_sounds -= weak_sounds
	return ..()

/datum/weather/lunar_storm/can_weather_act(mob/living/mob_to_check)
	. = ..()
	if(!. || !ishuman(mob_to_check))
		return
	var/mob/living/carbon/human/human_to_check = mob_to_check
	if(human_to_check.get_thermal_protection() >= FIRE_IMMUNITY_MAX_TEMP_PROTECT)
		return FALSE

/datum/weather/lunar_storm/weather_act(mob/living/victim)
	victim.adjustBruteLoss(4)

/datum/weather/lunar_storm/end()
	. = ..()
	for(var/turf/open/misc/asteroid/basalt/basalt as anything in GLOB.dug_up_basalt)
		if(!(basalt.loc in impacted_areas) || !(basalt.z in impacted_z_levels))
			continue
		GLOB.dug_up_basalt -= basalt
		basalt.dug = FALSE
		basalt.icon_state = "[basalt.base_icon_state]"
		if(prob(basalt.floor_variance))
			basalt.icon_state += "[rand(0,12)]"

/datum/weather/lunar_storm/flare
	name = "solar flare"
	desc = "A nearby star has a flare event, causing the surface of the moon to be showered in electromagnetic radiation."

	telegraph_message = "<span class='boldwarning'>Solar winds start blowing the lunar regolith around, and a wave of heat washes over you, find shelter!.</span>"
	telegraph_duration = 300
	telegraph_overlay = "light_ash"

	weather_message = "<span class='userdanger'><i>Searing heat washes over the surface, external electronics flickering in the radiation, get inside!</i></span>"
	weather_duration_lower = 600
	weather_duration_upper = 1200
	weather_overlay = "light_snow"
	weather_color = "#fff38b"

	end_message = "<span class='boldannounce'>The winds appear the calm down, regolith coming to rest once again.</span>"
	end_duration = 300
	end_overlay = "light_ash"

	probability = 30

/datum/weather/lunar_storm/flare/weather_act(mob/living/victim)
	victim.adjustFireLoss(4)
	empulse(victim, 0, 1)
