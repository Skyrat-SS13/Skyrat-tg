/*
	Click Handler
*/
/datum/click_handler/gun/tracked/asteroidcannon
	automatic = TRUE
	fire_proc = /datum/firemode/proc/do_fire	//Called to fire
	start_proc = /obj/structure/asteroidcannon/proc/start_firing	//Called to start firing
	stop_proc = /obj/structure/asteroidcannon/proc/stop_firing	//Called to stop firing
	get_firing_proc = /obj/structure/asteroidcannon/proc/is_firing //Called to check if we are currently firing
	change_target_proc = /obj/structure/asteroidcannon/proc/set_target


