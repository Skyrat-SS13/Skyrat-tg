/obj/machinery/door/poddoor
	icon = 'modular_skyrat/modules/aesthetics/blast_door/icons/blast_door.dmi'
	animation_sound = 'modular_skyrat/modules/aesthetics/blast_door/sound/blast_door.ogg'

/obj/machinery/door/poddoor/shutters
	var/door_open_sound = 'modular_skyrat/modules/aesthetics/blast_door/sound/shutters_open.ogg'
	var/door_close_sound = 'modular_skyrat/modules/aesthetics/blast_door/sound/shutters_close.ogg'

/obj/machinery/door/poddoor/shutters/run_animation(animation)
	switch(animation)
		if(DOOR_OPENING_ANIMATION)
			playsound(src, door_open_sound, 30, TRUE)
		if(DOOR_OPENING_ANIMATION)
			playsound(src, door_close_sound, 30, TRUE)
