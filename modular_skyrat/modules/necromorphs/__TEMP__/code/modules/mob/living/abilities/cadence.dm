//Cadence: A passive ability that causes the user to gain speed with each step in a straight line, accelerating until they reach some cap

//cadence
//Cadence
//Cadence
///mob/living
/datum/extension/cadence
	name = "Cadence"
	base_type = /datum/extension/cadence
	expected_type = /mob/living
	flags = EXTENSION_FLAG_IMMEDIATE

	var/status
	var/mob/living/user
	var/power = 1
	var/duration = 1 SECOND

	var/started_at
	var/stopped_at

	var/ongoing_timer


	//The maximum percentage bonus the user can gain. As a percentage added to their base speed. 1 = 100% = double speed
	var/max_speed_buff = 1.0
	//How many consecutive steps in a straight line are needed to reach maximum speed?
	var/max_steps = 5


	//Runtime vars:
	//---------------
	//What speed bonus one step is wortth
	var/step_amount = 0

	//What speed stage the user is currently at
	var/current_speed_buff = 0

	//What we've actually added to the user's speed
	var/speed_delta = 0


	var/last_move_direction = NORTH

	statmods = list(STATMOD_MOVESPEED_ADDITIVE = -1)

/datum/extension/cadence/New(var/mob/living/_user)
	.=..()
	user = _user
	step_amount = max_speed_buff / max_steps
	start()



/datum/extension/cadence/proc/start()
	started_at	=	world.time
	GLOB.moved_event.register(holder, src, /datum/extension/cadence/proc/holder_moved)


//Stop is called when we move in the opposite direction or go too long without moving
/datum/extension/cadence/proc/stop()
	deltimer(ongoing_timer)
	stopped_at = world.time

	modify_speed(-max_steps)//This sets the speed buff to zero





/datum/extension/cadence/proc/holder_moved(var/atom/movable/am, var/atom/old_loc, var/atom/new_loc)
	//Going straight up or down a level causes a runtime without this
	if (old_loc.x == new_loc.x && old_loc.y == new_loc.y)
		return
	var/move_direction = get_dir(old_loc, new_loc)
	var/vector2/move_direction_vector = Vector2.DirectionBetween(old_loc, new_loc)
	//If we've moved in a straight line, increase our speed
	if (move_direction == last_move_direction)
		modify_speed(1)
	else
		//Alrighty, we've made a turn, lets see how much
		var/angle_delta = move_direction_vector.AngleFrom(Vector2.FromDir(last_move_direction), TRUE)//Pass in true to shorten it
		angle_delta = abs(angle_delta) //We care only about magnitude, not direction
		//If its a 45 or less degree angle, our speed is not modified
		if (angle_delta > 45)

			//90 degree turns costs us half of our speed
			if (angle_delta <= 90)
				modify_speed(max_steps * -0.5)
			else
				//Larger turns than that destroy all of our momentum, this will set speed bonus to zero
				stop()



	last_move_direction = move_direction

	//We restart thte timeout since we have moved
	deltimer(ongoing_timer)
	if (current_speed_buff > 0)	//If we're currently at zero no need to timeout
		ongoing_timer = addtimer(CALLBACK(src, /datum/extension/cadence/proc/stop), duration, TIMER_STOPPABLE)

//Increase or decrease the speed by a number of steps
/datum/extension/cadence/proc/modify_speed(var/steps)
	//If the mob has been deleted, we will be soon too. all is well, do nothing
	if (QDELETED(user))
		return

	//If the mob is asleep or dead, no speed buffs
	if (user.stat)
		current_speed_buff = 0
		return

	//Cache the prior value
	var/prev_speed = current_speed_buff
	var/delta = steps * step_amount
	current_speed_buff = clamp(current_speed_buff+delta, 0, max_speed_buff)

	if (current_speed_buff != prev_speed)
		user.update_movespeed_factor()

		if (current_speed_buff == max_speed_buff)
			max_speed_reached()

//Just return the speed we've cached
/datum/extension/cadence/get_statmod(var/modtype)
	if (modtype == STATMOD_MOVESPEED_ADDITIVE)
		return current_speed_buff
	.=..()


//Called whenever we accelerate up to maximum speed
/datum/extension/cadence/proc/max_speed_reached()