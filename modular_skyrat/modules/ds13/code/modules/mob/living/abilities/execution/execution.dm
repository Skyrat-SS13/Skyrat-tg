/*
	An execution is a multistage finishing ability that typically ends in the death and/or dismemberment of one helpless victim

	Executions can be interrupted by the user taking damage, or the victim escaping out of reach

	Executions happen in two main phases
		Aquisition:
			a victim is chosen and checked for validity
			The victim and attacker are moved closer together, if needed
			Often, the attacker will grab the victim

			Can be interrupted during this stage

		Stages
			After this a series of execution stage datums are executed, one by one
			One of them should be a finisher, which unlocks the rewards

	Rewards:
		Since they are high risk and flashy, performing executions is generally rewarded. The reward may be any (usually several) of the following:

		-Some bonus biomass is added to the marker
		-Signals watching the kill recieve some energy
		-The attacker is healed to some degree
		-The attacker gains some buff
		-Attacker's cooldowns are refreshed
		-Nearby crew take major sanity damage (in future)

*/

//Safety check flags
#define EXECUTION_CANCEL	-1	//The whole move has gone wrong, abort
#define EXECUTION_RETRY		0	//Its not right yet but will probably fix itself, delay and keep trying
#define EXECUTION_CONTINUE	1	//Its fine, keep going
#define EXECUTION_SUCCESS 2	//We have achieved victory conditions. Try to skip to the end
#define EXECUTION_SAFETY	var/result = safety_check();\
if (result == EXECUTION_CANCEL && can_interrupt){\
	interrupt();\
	return}
/datum/extension/execution
	name = "Execution"
	base_type = /datum/extension/execution
	expected_type = /atom
	flags = EXTENSION_FLAG_IMMEDIATE

	var/status
	var/mob/living/carbon/human/user
	var/mob/living/carbon/human/victim
	var/cooldown = 20 SECOND

	var/started_at
	var/stopped_at

	var/ongoing_timer

	//Weapon vars: Indicates a tool, implement, bodypart, etc, which we are using to do this execution.
	//Optional, not always used
	var/atom/movable/weapon

	//Reward Handling
	//-------------------
	//Used to make sure finish only runs once
	var/success = FALSE	//If true, we have already finished the success condition. Check this to skip things in other stages
	var/finished = FALSE

	var/reward_biomass = 0
	var/reward_energy	=	0
	var/reward_heal	=	0


	//Stat modifiers
	//---------------
	//While performing an execution, the user has lower vision range and cannot evade attacks
	var/evasion_mod = -100
	var/vision_mod = -4

	var/evasion_delta = 0
	var/vision_delta = 0

	//Aquisition vars
	//-----------------------
	//If true, this execution requires the victim to be grabbed at the start, and held in a grab throughout the move
	var/require_grab = TRUE

	//If true this cannot be performed on corpses, victim must be alive at the start
	var/require_alive = TRUE

	//The victim must remain with this distance of the attacker, or the move fails
	var/range = 1

	//A delay before acquisition happens
	var/windup_time = 0

	//If the user of this is a necromorph, send a message on necromorph channel telling everyone to come watch
	var/notify_necromorphs = TRUE



	//Stage handling
	//----------------------
	//All the stages that we will eventually execute
	//This should be a list of typepaths
	var/list/all_stages = list()


	//List of execution stage datums that have been started
	//We'll consult these for safety checks, cancelling, completing, etc
	var/list/entered_stages = list()

	//What entry in the all stages list we're currently working on
	var/current_stage_index = 0

	//The datum of the current stage
	var/datum/execution_stage/current_stage



	//Interrupt Handling
	//--------------------
	var/interrupt_damage_threshold = 40	//If the user takes this much total damage from hits while performing the attack, it is cancelled
	var/hit_damage_taken = 0

	//Is the execution currently in a state where it could be interrupted?
	//This is set true on the start of stages, and set false after a finisher stage
	var/can_interrupt	= FALSE



	//Runtime stuff
	var/obj/item/grab/grab	//The grab object we're using to hold the victim




/datum/extension/execution/New(var/atom/user, var/mob/living/victim, var/atom/movable/weapon)
	.=..()
	if (isliving(user))
		src.user = user
	src.victim = victim

	if (weapon)
		src.weapon = weapon

	//Lets compile the list of stages
	for (var/i in 1 to all_stages.len)
		var/stagetype = all_stages[i]
		all_stages[i] = new stagetype(src)

	//ongoing_timer = addtimer(CALLBACK(src, /datum/extension/execution/proc/start), 0, TIMER_STOPPABLE)


/datum/extension/execution/proc/start()
	if (!can_start())
		stop()
		return

	started_at	=	world.time

	//First of all, we do windup
	windup()

	//If we failed to aquire a target, just stop immediately
	if (acquire_target() != EXECUTION_CONTINUE)
		stop()
		return


	//Getting past this point is considered a success
	.= TRUE



	//Alright we're clear to proceed
	if (user.is_necromorph() && notify_necromorphs)
		link_necromorphs_to(SPAN_EXECUTION("[user] is performing [name] at LINK"), victim)
	//Modify user stats
	user.evasion += evasion_mod
	evasion_delta = evasion_mod

	user.view_range += vision_mod
	vision_delta = vision_mod

	//Lets setup handling for future interruption
	can_interrupt = TRUE
	if (user)
		GLOB.damage_hit_event.register(user, src, /datum/extension/execution/proc/user_damaged)


	try_advance_stage()

/datum/extension/execution/Destroy()
	current_stage = null
	QDEL_NULL_LIST(all_stages)
	entered_stages = null
	.=..()


/datum/extension/execution/proc/stop()
	deltimer(ongoing_timer)
	stopped_at = world.time

	//Lets remove observations
	GLOB.damage_hit_event.unregister(user, src, /datum/extension/execution/proc/user_damaged)



	for (var/datum/execution_stage/ES as anything in entered_stages)
		ES.stop()

	//Fix the user back to default animation
	user.animate_to_default(1 SECOND)


	user.evasion -= evasion_delta
	evasion_delta = 0

	user.view_range -= vision_delta
	vision_delta = 0

	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/execution/proc/finish_cooldown), cooldown, TIMER_STOPPABLE)


/datum/extension/execution/proc/finish_cooldown()
	deltimer(ongoing_timer)
	remove_extension(holder, base_type)




//Called if we take too much damage, or the victim escapes, we get moved out of range, etc.
//Cancels the move partway through without succeeding
/datum/extension/execution/proc/interrupt()
	if (can_interrupt && !stopped_at)
		for (var/datum/execution_stage/ES as anything in entered_stages)
			ES.interrupt()

		//We stop immediately
		stop()

//This is called when a finisher stage is entered, or if we complete all the stages
//It will never be called in the case of an interruption
/datum/extension/execution/proc/complete()
	if (finished)
		return

	finished = TRUE

	//We are past the point of no return now
	can_interrupt = FALSE

	for (var/datum/execution_stage/ES as anything in entered_stages)
		ES.complete()

	distribute_rewards()
	//We don't call stop here, we may have a few more post-completion stages


//Here we payout any rewards
/datum/extension/execution/proc/distribute_rewards()
	if (reward_biomass)
		var/obj/machinery/marker/M = SSnecromorph.marker
		if (istype(M))
			M.biomass += reward_biomass
			message_necromorphs(SPAN_EXECUTION("The marker gains [reward_biomass]kg biomass from [user] completing [name]"))
			reward_biomass = 0

	if (reward_heal)
		user.heal_overall_damage(reward_heal)
		to_chat(user, SPAN_EXECUTION("Execution complete, you have recovered [reward_heal] health!"))
		reward_heal = 0

	if (reward_energy)
		for (var/mob/observer/eye/signal/S in trange(10, user))
			var/datum/extension/psi_energy/PE	= get_energy_extension()
			if (PE)
				to_chat(S, SPAN_EXECUTION("You are invigorated by the spectacle before you, and gain [reward_energy] energy!"))
				PE.energy += reward_energy


/datum/extension/execution/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed

/*------------------------
	Target Aquisition
---------------------------*/
//Called before acquire target
/datum/extension/execution/proc/windup()
	if (user)
		user.disable(windup_time)
	sleep(windup_time)

//We already know who we're trying to target, that info is passed in.
//Here, we perform the first steps of starting the move. This may include moving towards the target, or pulling them to us
//If required, it will also involve grabbing the target
/datum/extension/execution/proc/acquire_target()
	if (require_grab)
		grab = user.grab_with_any_limb(victim)

	user.face_atom(victim)

	return acquisition_success()

//Runs after aquire target, checks the results of that proc.
//If everything looks good, returns true, allowing us to start the execution move.
//If it returns false, we fail
/datum/extension/execution/proc/acquisition_success()
	.=safety_check()

/*---------------------
	Stages
---------------------*/
/datum/extension/execution/proc/try_advance_stage()
	EXECUTION_SAFETY

	deltimer(ongoing_timer)
	var/max_stages = all_stages.len
	//If there's a current stage, ask it whether its ready to advance
	if (current_stage && current_stage_index)
		if (!current_stage.can_advance())
			//TODO Here: Decide if/when to try again, or whether to simply abort the whole move
			return FALSE

		//Exit the previous stage
		current_stage.exit()
		current_stage = null
	//Okay we're advancing
	current_stage_index++
	if (current_stage_index > max_stages)
		//We just finished the last stage, time to stop.
		complete()
		ongoing_timer = addtimer(CALLBACK(src, /datum/extension/execution/proc/stop), 0, TIMER_STOPPABLE)
		return

	//Here's our new current stage, enter it
	current_stage = all_stages[current_stage_index]
	current_stage.enter()
	entered_stages += current_stage

	//And set a timer to come back here
	if (user)
		user.disable(current_stage.duration)
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/execution/proc/try_advance_stage), current_stage.duration, TIMER_STOPPABLE)




/***********************
	Safety Checks
************************/
/datum/extension/execution/proc/safety_check()
	.=EXECUTION_CONTINUE
	//If we needed a grab, check that we have it and its valid
	if (require_grab)
		if (!grab || !grab.safety_check())
			return EXECUTION_CANCEL

	//Gotta be close enough
	if (get_dist(user, victim) > range)
		return EXECUTION_CANCEL

	//If user has ceased to exist, we're finished
	if (QDELETED(user))
		return EXECUTION_CANCEL

	for (var/datum/execution_stage/ES as anything in entered_stages)
		var/result = ES.safety()
		if (result != EXECUTION_CONTINUE)
			return result

//Called if the attacker takes a damaging impact while performing an execution
/datum/extension/execution/proc/user_damaged(var/mob/living/damaged_user, var/obj/item/organ/external/organ, var/brute, var/burn, var/damage_flags, var/used_weapon)
	hit_damage_taken += (brute + burn)
	if (can_interrupt && (hit_damage_taken >= interrupt_damage_threshold))
		to_chat(user, SPAN_WARNING("You took too much damage, execution interrupted! [hit_damage_taken] >= [interrupt_damage_threshold]"))
		interrupt()

/datum/extension/execution/proc/can_start()
	if (require_alive)
		if (victim.stat == DEAD)
			return FALSE
	return TRUE



//Access Proc
/atom/proc/can_execute(var/execution_type = /datum/extension/execution)

	var/datum/extension/execution/E = get_extension(src, execution_type)
	if(istype(E))
		if (E.stopped_at)
			to_chat(src, SPAN_NOTICE("[E.name] is cooling down. You can use it again in [E.get_cooldown_time() /10] seconds"))
		else
			to_chat(src, SPAN_NOTICE("You're already performing an execution"))
		return FALSE

	return TRUE


/mob/living/can_execute(var/error_messages = TRUE)
	if (incapacitated())
		return FALSE
	.=..()


/atom/proc/perform_execution(var/execution_type = /datum/extension/execution, var/atom/target)
	if (!can_execute(execution_type))
		return FALSE
	var/list/arguments = list(src, execution_type, target)
	if (args.len > 2)
		arguments += args.Copy(3)


	//Here we bootstrap the execution datum
	var/datum/extension/execution/E = set_extension(arglist(arguments))
	if (!E.can_start())
		.=FALSE
	E.ongoing_timer = addtimer(CALLBACK(E, /datum/extension/execution/proc/start), 0, TIMER_STOPPABLE)

	.= TRUE


