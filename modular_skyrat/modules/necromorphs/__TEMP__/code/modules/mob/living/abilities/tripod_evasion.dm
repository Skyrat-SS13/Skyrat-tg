//tripod_evasion: Passive that causes the user to gain evasion based on the number of clear tiles nearby
/datum/extension/tripod_evasion
	name = "tripod_evasion"
	base_type = /datum/extension/tripod_evasion
	expected_type = /mob/living
	flags = EXTENSION_FLAG_IMMEDIATE

	var/status
	var/mob/living/user
	var/power = 1
	var/duration = 1 SECOND

	var/started_at
	var/stopped_at


	//The maximum evasion bonus the user can gain
	var/max_evasion_buff = TRIPOD_PERSONAL_SPACE_MAX_EVASION

	//How many clear tiles around the user are needed to reach max evasion
	var/max_clear_tiles = 24

	var/check_range = 2


	statmods = list(STATMOD_EVASION = 0)


	//Runtime vars:
	//---------------
	//When did we last check the free tiles around us?
	var/last_update = 0

	//Minimum time between space checks, because these are expensive
	var/check_cooldown = 3 SECONDS

	//How much evasion each tile is worth
	var/tile_evasion

	//This is temporarily set true if we have an update scheduled or are in the process of doing it. Set back to false once update is finished
	//While true, reject all other attempts to update
	var/updating


	var/evasion_delta



/datum/extension/tripod_evasion/New(var/mob/living/_user)
	.=..()
	user = _user
	tile_evasion = max_evasion_buff / max_clear_tiles
	start()



/datum/extension/tripod_evasion/proc/start()
	started_at	=	world.time

	GLOB.moved_event.register(holder, src, /datum/extension/tripod_evasion/proc/holder_moved)






/datum/extension/tripod_evasion/proc/holder_moved(var/atom/movable/am, var/atom/old_loc, var/atom/new_loc)
	if (updating)
		return

	updating = TRUE
	var/time_delta = world.time - last_update

	//If its been long enough since our last update, then do it immediately
	if (time_delta >= check_cooldown)
		update_space_evasion()

	else
		//Not quite long enough, schedule another update for when the time comes
		addtimer(CALLBACK(src, /datum/extension/tripod_evasion/proc/update_space_evasion), check_cooldown)


//Increase or decrease the speed by a number of steps
/datum/extension/tripod_evasion/proc/update_space_evasion()
	var/mob/living/L = holder

	//If the mob has been deleted, we will be soon too. all is well, do nothing
	if (QDELETED(L))
		return

	//Alright lets get the number of clear tiles around us
	var/clear_turfs = 0
	for (var/turf/T as anything in L.turfs_in_view(check_range))
		if (turf_clear(T))
			clear_turfs++
			if (clear_turfs >= max_clear_tiles)	//don't go over the max
				clear_turfs = max_clear_tiles
				break


	var/new_evasion = clear_turfs * tile_evasion

	//Only do this next bit if we actually changed
	if (statmods[STATMOD_EVASION] != new_evasion)
		statmods[STATMOD_EVASION] = new_evasion
		sync_evasion()

	//We are done with updating, set these
	last_update = world.time
	updating = FALSE


//This actually sets movespeed on the holder mob
/datum/extension/tripod_evasion/proc/sync_evasion()
	var/mob/living/L = holder

	//If the mob has been deleted, we will be soon too. all is well, do nothing
	if (QDELETED(L))
		return

	register_statmod(STATMOD_EVASION)

