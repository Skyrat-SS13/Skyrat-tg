/datum/round_event_control/wizard/lava //THE LEGEND NEVER DIES
	name = "The Floor Is LAVA!"
	weight = 2
	typepath = /datum/round_event/wizard/lava
	max_occurrences = 3
	earliest_start = 0 MINUTES

/datum/round_event/wizard/lava
	endWhen = 0
	var/started = FALSE

/datum/round_event/wizard/lava/start()
	if(!started)
		started = TRUE
		//SKYRAT EDIT ADDITION
		var/datum/weather_controller/weather = STATION_WEATHER_CONTROLLER
		weather.RunWeather(/datum/weather/floor_is_lava)
		//SKYRAT EDIT END
