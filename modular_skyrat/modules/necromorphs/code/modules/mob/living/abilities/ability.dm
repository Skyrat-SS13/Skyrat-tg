/*
	Generic Ability Extension
	Note that most of the existing ones are not ported to this code yet
*/

/datum/extension/ability
	name = "Ability"
	var/ability_verb = "Doing stuff"	//Present tense verb to describe this ability. Jumping, swinging, reanimating, etc
	base_type = /datum/extension/ability
	expected_type = /mob
	var/expected_target_type = /atom
	flags = EXTENSION_FLAG_IMMEDIATE

	var/persist = FALSE

	//One of the INCAPACITATION_XXX defines, checked in can_use
	var/incapacitation_flags = INCAPACITATION_DEFAULT

	var/status
	var/mob/living/user
	var/mob/living/carbon/human/H
	var/cooldown = 1 SECOND
	var/duration = 1 SECOND
	var/tick_interval = 0	//Set this to a positive number to enable ticking

	var/reach	//If set to a positive number, the ability can only target things which are up to this many tiles away

	var/started_at
	var/stopped_at

	var/ongoing_timer
	var/tick_timer

	var/atom/target

	var/resource_cost_type	=	null
	var/resource_cost_quantity = 1
	var/resource_cost_paid = FALSE	//Used for refunding


	//The blurb is a long-ish bit of text that explains how this ability works
	//Up to 100 words or so, use good punctuation
	var/blurb = "An ability that does stuff."



/*
	Ability extensions should not be called directly, use do_ability, see the bottom of this file for how it works
*/

/datum/extension/ability/New(var/mob/user, var/list/parameters)
	.=..()
	if (isliving(user))
		src.user = user
		if (ishuman(user))
			H = user


//We've already safety checked it before this is called
/datum/extension/ability/proc/Initialize(var/list/parameters)
	//Copy over any parameters to ourselves with valid varnames
	for (var/thing in parameters)
		if (thing in vars)
			src.vars[thing] = parameters[thing]

	pre_calculate()
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/ability/proc/start), 0, TIMER_STOPPABLE)



/datum/extension/ability/proc/start()
	.=TRUE
	started_at	=	world.time
	stopped_at = null

	if (!handle_resource_cost())
		stop()
		return FALSE



	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/ability/proc/stop), duration, TIMER_STOPPABLE)

	if (tick_interval)
		tick_timer = addtimer(CALLBACK(src, .proc/tick), tick_interval, TIMER_STOPPABLE)

/datum/extension/ability/proc/handle_resource_cost()
	if (resource_cost_type)
		//We should never fail to have enough since we did safety checks, but you can never be sure
		if (!user.consume_resource(resource_cost_type, resource_cost_quantity))
			return FALSE
		resource_cost_paid = TRUE
	return TRUE

//Just an alternative path to stop that indicates an unsuccessful/failure state
/datum/extension/ability/proc/interrupt()
	deltimer(ongoing_timer)
	ongoing_timer = addtimer(CALLBACK(src, /datum/extension/ability/proc/stop), 1, TIMER_STOPPABLE)

/datum/extension/ability/proc/stop()
	if (!stopped_at)
		deltimer(ongoing_timer)
		deltimer(tick_timer)
		stopped_at = world.time
		ongoing_timer = addtimer(CALLBACK(src, /datum/extension/ability/proc/finish_cooldown), cooldown, TIMER_STOPPABLE)

/datum/extension/ability/proc/pre_calculate()
	//This is called in initialize, just after parameters are loaded, before the beginning of start, before anything functional happens.
	//Use it to modify variables and cache data. Generally don't alter the world at this stage


/datum/extension/ability/proc/finish_cooldown()
	deltimer(ongoing_timer)
	if (!persist)
		remove_self()


/datum/extension/ability/proc/get_cooldown_time()
	var/elapsed = world.time - stopped_at
	return cooldown - elapsed


/datum/extension/ability/proc/tick()
	tick_timer = addtimer(CALLBACK(src, .proc/tick), tick_interval, TIMER_STOPPABLE)

//Called periodically for certain ongoing procs, determines if they are allowed to keep going
/datum/extension/ability/proc/continue_safety()
	.=TRUE
	//Already finished
	if (stopped_at)
		return FALSE

/datum/extension/ability/proc/is_valid_target(var/datum/potential_target, var/mob/potential_user)
	.=TRUE
	if (!istype(potential_target, expected_target_type))
		return FALSE

	if (potential_user)
		if (reach && get_dist(potential_user, potential_target) > reach)
			return FALSE



/datum/extension/ability/proc/can_use(var/mob/potential_user, var/list/parameters, var/error_messages = TRUE)
	if (user.incapacitated(incapacitation_flags))
		return FALSE
	if (ongoing_timer)
		if (stopped_at)
			to_chat(potential_user, SPAN_NOTICE("[name] is cooling down. You can use it again in [get_cooldown_time() /10] seconds"))
			return FALSE
		else if (started_at)
			to_chat(src, SPAN_NOTICE("You're already [ability_verb]"))
			return FALSE

	if (!can_afford_resource_cost(potential_user, error_messages))
		return FALSE

	if (parameters["target"])
		if (!is_valid_target(parameters["target"], potential_user))
			return FALSE

	return TRUE


/***********************
	Safety Checks
************************/
/datum/extension/ability/proc/can_afford_resource_cost(var/mob/potential_user, var/error_messages = TRUE)
	if (resource_cost_type)
		if (!potential_user.can_afford_resource(resource_cost_type, resource_cost_quantity, error_message = TRUE))
			return FALSE
	return TRUE

//This has two modes
//1. Without a specified amount, we will try to refund what this ability costs by standard, but only if resource_cost_paid is true
//2. With a specified amount, we just pay that back to the user with no safety checks at all
/datum/extension/ability/proc/refund_resource_cost(var/mob/potential_user, var/amount)
	if (!amount)
		if (!resource_cost_paid)
			return FALSE
		amount = resource_cost_quantity

	if (amount)
		user.modify_resource(resource_cost_type, amount)

//Access Proc

/*
	Ability extensions should not be called directly, use do_ability. It works in a few phases
	First an extension is either found-existing, or created
	Secondly, we call can_use on it to see if it's ready to go
		If not, it will call remove_self and never reach the third stage
	Finally, we call Initialize, this will schedule the Start call and setup variables

	do_ability handles bootstrapping these phases, they must be done manually if you don't use it
*/
/mob/proc/do_ability(var/ability_type, var/list/parameters, var/error_message = TRUE)

	var/datum/extension/ability/E = get_extension(src, ability_type)
	var/remove_on_fail = TRUE
	if(istype(E))
		//It still exists and it's cooling down or something
		remove_on_fail	= FALSE	//If it already existed, we're not going to delete it


	//The ability doesnt exist so we create it
	if (!E)
		E = set_extension(src, ability_type, parameters)
	if (!E.can_use(src, parameters, error_message))
		//Fail, it can't be used now

		//We just made it but it's not going to be born, lets quickly unmake it
		if(remove_on_fail)
			E.remove_self()
		return FALSE


	//Alright we've made the ability and safety checked it, its time to go!
	E.Initialize(parameters)

	return TRUE


/*
	Helpers
*/
/*
/proc/get_ability_blurb(var/ability_type)
	var/datum/extension/ability/A = ability_type
	return initial(A.blurb)
*/