/datum/game_mode/marker
	var/evac_points = 0
	var/evac_threshold = 100
	var/minimum_evac_time = 75// in minutes. How soon after marker setup that evac can be called, assuming all systems remain working (they won't)


	var/last_pointgain_time	= 0
	var/last_pointgain_quantity = 0
	var/pointgain_timer

	//used to determine approximate time till evac
	var/minutes_per_point = 0

	//admin warnings to show approaching evac time
	var/show_admin_warning_10 = TRUE
	var/show_admin_warning_5 = TRUE

/datum/game_mode/marker/proc/charge_evac_points()
	deltimer(pointgain_timer) //Recursive function that will slowly tick down the clock until the valour comes to rescue the ishimura's crew.

	//We get a basic pointgain based on ship systems
	var/pointgain = GLOB.shipsystem.get_point_gen()

	//The minimum time is used as a scalar on this
	pointgain *= evac_threshold / minimum_evac_time

	//And finally, we'll factor in the real time that has passed to compensate for lag and/or time dilation
	var/minutes_passed = (world.timeofday - last_pointgain_time) / 600	//In ideal circumstances, this value will be 1, but it may be more than 1 if server is lagging
	pointgain *= minutes_passed


	last_pointgain_quantity = pointgain
	evac_points += pointgain

	last_pointgain_time = world.timeofday

	if(evac_points >= evac_threshold)
		auto_recall_shuttle = FALSE //Allow shuttles now.
		evac_points = evac_threshold
		//No addtimer call here, so we'll stop gaining points now
	else
		check_admin_warnings()
		pointgain_timer = addtimer(CALLBACK(src, .proc/charge_evac_points), 1 MINUTE, TIMER_STOPPABLE) //Shuttle was unable to be called. Try again recursively.
	return FALSE

//proc that handles messages to admins regarding close evac time
/datum/game_mode/marker/proc/check_admin_warnings()
	var/time_till_evac = get_time_until_evac()	//for Nanako, this formula here needs checking
	if(time_till_evac <= 10 MINUTES)
		if(show_admin_warning_10)
			show_admin_warning_10 = FALSE
			message_admins("Approximate time until evacuation is unlocked is less than 10 minutes.")
		else
			if(time_till_evac <= 5 MINUTES && show_admin_warning_5)
				show_admin_warning_5 = FALSE
				message_admins("Approximate time until evacuation is unlocked is less than 5 minutes.")

//returns approximate time in minutes until evac at normal condititions based on current points and threshold will be unlocked
/datum/game_mode/marker/proc/get_time_until_evac()
	var/time_till_evac = (evac_threshold - evac_points) * minutes_per_point MINUTES	//for Nanako, this formula here needs checking
	return time_till_evac

//proc used to adjust evac threshold points (e.g. admin verb adjustment).
/datum/game_mode/marker/proc/adjust_evac_threshold(var/extra_time)
	if(extra_time > 0)
		show_admin_warning_10 = TRUE
		show_admin_warning_5 = TRUE
	evac_threshold += round(extra_time / minutes_per_point)

/datum/evacuation_predicate/travel_points/New()
	var/datum/game_mode/marker/GM = ticker.mode
	if(GM)
		GM.minutes_per_point = GM.minimum_evac_time / initial(GM.evac_threshold)
	return

/datum/evacuation_predicate/travel_points/Destroy()
	return 0

/datum/evacuation_predicate/travel_points/is_valid()
	var/datum/game_mode/marker/GM = ticker.mode
	if (istype(GM))
		return TRUE
	return FALSE

/datum/evacuation_predicate/travel_points/can_call(var/user)

	var/datum/game_mode/marker/GM = ticker.mode
	if (GM.evac_points >= GM.evac_threshold)
		return TRUE

	if (user && GM && GM.last_pointgain_quantity)

		var/time_remaining = ((GM.evac_threshold - GM.evac_points) / GM.last_pointgain_quantity) MINUTES	//for Nanako, this formula here needs checking
		to_chat(user, SPAN_DANGER("There is no viable site within range for evacuation at the present time. ETA: [time2text(time_remaining, "mm:ss")]"))

	return FALSE