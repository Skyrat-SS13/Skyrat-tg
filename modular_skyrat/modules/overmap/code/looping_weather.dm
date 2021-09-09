/datum/looping_sound_skyrat/weather/wind
	mid_sounds = list(
		'modular_skyrat/master_files/sound/effects/wind/wind1.ogg' = 1,
		'modular_skyrat/master_files/sound/effects/wind/wind2.ogg' = 1,
		'modular_skyrat/master_files/sound/effects/wind/wind3.ogg' = 1,
		'modular_skyrat/master_files/sound/effects/wind/wind4.ogg' = 1,
		'modular_skyrat/master_files/sound/effects/wind/wind5.ogg' = 1,
		'modular_skyrat/master_files/sound/effects/wind/wind6.ogg' = 1
		)
	mid_length = 10 SECONDS // The lengths for the files vary, but the longest is ten seconds, so this will make it sound like intermittent wind.
	volume = 50

// Don't have special sounds so we just make it quieter indoors.
/datum/looping_sound_skyrat/weather/wind/indoors
	volume = 30

/datum/looping_sound_skyrat/weather/rain
	mid_sounds = list(
		'sound/ambience/acidrain_mid.ogg' = 1
		)
	mid_length = 15 SECONDS // The lengths for the files vary, but the longest is ten seconds, so this will make it sound like intermittent wind.
	start_sound = 'sound/ambience/acidrain_start.ogg'
	start_length = 13 SECONDS
	end_sound = 'sound/ambience/acidrain_end.ogg'
	volume = 50

/datum/looping_sound_skyrat/weather/rain/indoors
	volume = 30
