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

#define EXECUTION_DAMAGE_VULNERABILITY	1.5

//Execution status vars
#define STATUS_NOT_STARTED	0
#define STATUS_STARTING		1
#define STATUS_PRE_FINISH	2
#define STATUS_POST_FINISH	3
#define STATUS_ENDED		4

/datum/extension/execution
	name = "Execution"
	base_type = /datum/extension/execution
	expected_type = /atom
	flags = EXTENSION_FLAG_IMMEDIATE

	var/status = STATUS_NOT_STARTED
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
	//While performing an execution, the user has lower vision range, cannot evade attacks, and takes more damage from all sources
	statmods = list(STATMOD_EVASION = -100, STATMOD_VIEW_RANGE = -4, STATMOD_INCOMING_DAMAGE_MULTIPLICATIVE	=	EXECUTION_DAMAGE_VULNERABILITY)

	//Aquisition vars
	//-----------------------
	//If true, this execution requires the victim to be grabbed at the start, and held in a grab throughout the move
	//Can also be set to a number, in which case it only requires a grab from that step onwards
	//In either case, grab is no longer required after the finisher
	var/require_grab = TRUE

	//If true this cannot be performed on corpses, victim must be alive at the start
	var/require_alive = TRUE

	//The victim must remain with this distance of the attacker, or the move fails
	var/range = 1

	//Before the first stage, we can commence the execution within this range
	var/start_range	=	1

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

	//How many times we have retried the current stage when it failed to advance
	//If we hit the stage's max retries, we abort the whole execution
	//Reset to 0 upon entering a new stage
	var/retries = 0



	//Interrupt Handling
	//--------------------
	var/interrupt_damage_threshold = 40	//If the user takes this much total damage from hits while performing the attack, it is cancelled
	var/hit_damage_taken = 0

	//Is the execution currently in a state where it could be interrupted?
	//This is set true on the start of stages, and set false after a finisher stage
	var/can_interrupt	= FALSE



	//Runtime stuff
	var/obj/item/grab/grab	//The grab object we're using to hold the victim


	//If set, this is a proc which is called as part of safety checks
	//It should be one of the /datum/extension/execution/proc/weapon_check_XXXXX procs
	var/weapon_check


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





/*
	Starting
*/
/datum/extension/execution/proc/start()
	if (can_start() != EXECUTION_CONTINUE)
		stop()
		return

	started_at	=	world.time
	status = STATUS_STARTING
	//First of all, we do windup
	windup()

	//If we failed to aquire a target, just stop immediately
	if (acquire_target() != EXECUTION_CONTINUE)
		stop()
		return


	//Getting past this point is considered a success
	.= TRUE

	status = STATUS_PRE_FINISH



	//Alright we're clear to proceed
	if (user.is_necromorph() && notify_necromorphs)
		link_necromorphs_to(SPAN_EXECUTION("[user] is performing [name] at LINK"), victim)

	//Lets setup handling for future interruption
	can_interrupt = TRUE
	if (user)
		GLOB.damage_hit_event.register(user, src, /datum/extension/execution/proc/user_damaged)


	try_advance_stage()


/datum/extension/execution/proc/can_start()
	if (require_alive)
		if (victim.stat == DEAD)
			return EXECUTION_CANCEL
	return EXECUTION_CONTINUE


//Called when this execution is created but fails the can_start conditions. In most cases you just want to remove self
//This is a proc so it can be overridden for special cases, like refunding resource costs
/datum/extension/execution/proc/failed_start()
	remove_self()

/datum/extension/execution/Destroy()
	current_stage = null
	QDEL_NULL_LIST(all_stages)
	entered_stages = null
	.=..()


/datum/extension/execution/proc/stop()
	deltimer(ongoing_timer)
	stopped_at = world.time
	status = STATUS_ENDED
	//Lets remove observations
	GLOB.damage_hit_event.unregister(user, src, /datum/extension/execution/proc/user_damaged)
	unregister_statmods()


	for (var/datum/execution_stage/ES as anything in entered_stages)
		ES.stop()

	//Fix the user back to default animation
	user.animate_to_default(1 SECOND)



	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/execution/proc/finish_cooldown), cooldown, TIMER_STOPPABLE)


/datum/extension/execution/proc/finish_cooldown()
	deltimer(ongoing_timer)
	remove_self()




//Called if we take too much damage, or the victim escapes, we get moved out of range, etc.
//Cancels the move partway through without succeeding
/datum/extension/execution/proc/interrupt()
	if (can_interrupt && !stopped_at)
		for (var/datum/execution_stage/ES as anything in entered_stages)
			ES.interrupt()

		to_chat(user, SPAN_DANGER("[name] aborted!"))
		//We stop immediately
		stop()

//This is called when a finisher stage is entered, or if we complete all the stages
//It will never be called in the case of an interruption
/datum/extension/execution/proc/complete()
	if (finished)
		return
	status = STATUS_POST_FINISH
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
		for (var/mob/dead/observer/eye/signal/S in trange(10, user))
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
	if (require_grab == TRUE)
		grab = user.grab_with_any_limb(victim)

	user.face_atom(victim, TRUE)

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
		var/advance_result = current_stage.can_advance()
		switch(advance_result)
			if (EXECUTION_CANCEL)
				//Abort mission
				interrupt()
				return FALSE
			if (EXECUTION_RETRY)
				if (retries >= current_stage.max_retries)
					interrupt()
					return FALSE
				retries++
				ongoing_timer = addtimer(CALLBACK(src, /datum/extension/execution/proc/try_advance_stage), current_stage.retry_time, TIMER_STOPPABLE)
				return FALSE
			if (EXECUTION_CONTINUE)
				//Exit the previous stage
				current_stage.exit()
				current_stage = null
			//if (EXECUTION_SUCCESS)	//Not yet implemented for advancing

	//Okay we're advancing
	current_stage_index++
	if (current_stage_index > max_stages)
		//We just finished the last stage, time to stop.
		complete()
		ongoing_timer = addtimer(CALLBACK(src, /datum/extension/execution/proc/stop), 0, TIMER_STOPPABLE)
		return

	//Here's our new current stage, enter it
	if (!enter_next_stage())
		//If we somehow fail to enter it, the entire process is aborted
		interrupt()
		return FALSE

	//And set a timer to come back here
	if (user)
		user.disable(current_stage.duration)
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/execution/proc/try_advance_stage), current_stage.duration, TIMER_STOPPABLE)



//This is called from try advance stage
//After exiting the previous stage and then incrementing the index
/datum/extension/execution/proc/enter_next_stage()
	.=TRUE
	//If we just reached a stage where grabbing is required, lets do that
	if (require_grab && require_grab == current_stage_index && !grab)
		grab = user.grab_with_any_limb(victim)
		if (!grab)
			return FALSE

	retries = 0
	current_stage = all_stages[current_stage_index]
	if (!current_stage.enter())
		return FALSE
	entered_stages += current_stage




/***********************
	Safety Checks
************************/
/datum/extension/execution/proc/safety_check()
	.=EXECUTION_CONTINUE

	//If we needed a grab, check that we have it and its valid
	if (require_grab && require_grab <= current_stage_index)
		if (!grab || !grab.safety_check())
			return EXECUTION_CANCEL

	//Gotta be close enough
	if (get_dist(user, victim) > get_range())
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





/datum/extension/execution/proc/get_range()
	if (current_stage)
		if (!isnull(current_stage.range))
			return current_stage.range
	else
		//If no current stage, we havent started yet
		return start_range
	return range

