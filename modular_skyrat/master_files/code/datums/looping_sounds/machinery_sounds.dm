/datum/looping_sound/drill
	start_sound = 'modular_skyrat/modules/mining_module/sound/drill/drill_start.ogg'
	start_length = 1 SECONDS
	mid_sounds = list('modular_skyrat/modules/mining_module/sound/drill/drill_loop.ogg'=1)
	mid_length = 1 SECONDS
	end_sound = 'modular_skyrat/modules/mining_module/sound/drill/drill_end.ogg'
	volume = 40

/datum/looping_sound/engine
	start_sound = 'modular_skyrat/master_files/sound/engine/enginestart.ogg'
	start_length = 1.4 SECONDS
	mid_sounds = list('modular_skyrat/master_files/sound/engine/engineloop.ogg'=1)
	mid_length = 1.4 SECONDS
	end_sound = 'modular_skyrat/master_files/sound/engine/engineend.ogg'
	volume = 10
	falloff_distance = 5
