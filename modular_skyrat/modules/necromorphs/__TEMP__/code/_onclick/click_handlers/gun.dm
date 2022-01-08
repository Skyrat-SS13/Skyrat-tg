/datum/click_handler/gun
	var/datum/firemode/firemode
	var/datum/reciever //The thing we send firing signals to.
	var/fire_proc = /datum/firemode/proc/do_fire	//Called to fire
	var/start_proc = /datum/firemode/proc/start_firing	//Called to start firing
	var/stop_proc = /datum/firemode/proc/stop_firing	//Called to stop firing
	var/get_firing_proc = /datum/firemode/proc/is_firing //Called to check if we are currently firing
	var/change_target_proc = /datum/firemode/proc/set_target
	var/last_clickparams
	var/vector2/last_click_location


/datum/click_handler/gun/proc/start_firing()
	if (start_proc)
		call(reciever, start_proc)()

/datum/click_handler/gun/proc/fire()
	if (fire_proc)
		call(reciever, fire_proc)()

/datum/click_handler/gun/proc/stop_firing()
	if (stop_proc)
		call(reciever, stop_proc)()

/datum/click_handler/gun/proc/is_firing()
	if (get_firing_proc)
		return call(reciever, get_firing_proc)()

/datum/click_handler/gun/proc/set_target(var/atom/newtarget)
	if (change_target_proc)
		call(reciever, change_target_proc)(newtarget)

/datum/click_handler/gun/proc/update_clickparams(var/clickparams)
	last_clickparams = clickparams
	if (user?.client)
		if (last_click_location)
			release_vector(last_click_location)
		last_click_location = get_global_pixel_click_location(last_clickparams, user.client)