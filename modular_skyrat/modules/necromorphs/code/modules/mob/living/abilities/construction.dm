/*
	Construction abilities are used to create objects in the world.

	On initial use, they consume resources to spawn an in-progress object which the user works on until it is finished.
	When enough work is done, this is replaced by the end goal
*/
/datum/extension/ability/construction
	expected_target_type = /atom
	var/expected_turf_type = /turf/simulated/floor

	var/result_path
	var/in_progress_path

	var/require_clear	=	TRUE	//If true, the target turf must be clear of obstructions
	var/require_corruption = FALSE

	var/deposit = 0.2	//What percentage of the cost is paid upfront to start construction. The rest is paid over time
	var/construction_time	=	10	//This is in seconds not deciseconds

	reach = 1	//Gotta be adjacent

	duration = 0 //This starts instantly

/datum/extension/ability/construction/pre_calculate()
	.=..()
	target = get_turf(target)	//This ability requires a turf


/datum/extension/ability/construction/start()
	.=..()
	if (.)
		//Create the in progress object and force the user to touch it
		var/atom/A = new in_progress_path(target, result_path, user, resource_cost_type, resource_cost_quantity * (1 - deposit), construction_time)

		spawn()
			A.attack_hand(user)

/datum/extension/ability/construction/is_valid_target(var/datum/potential_target, var/mob/potential_user)
	.=..()
	if (.)
		var/turf/T = get_turf(potential_target)

		if (!istype(T, expected_turf_type))
			to_chat(potential_user, "The desired location is the wrong type of tile.")
			return FALSE

		if (require_clear && !turf_clear(T))
			to_chat(potential_user, "The tile is blocked by other things")
			return FALSE


		if (require_corruption && !turf_corrupted(T))
			to_chat(potential_user, "This can only be built on corruption.")
			return FALSE

//Subtype specifically for corruption nodes
/datum/extension/ability/construction/corruption
	resource_cost_type	=	RESOURCE_ESSENCE
	resource_cost_quantity = 1
	require_corruption = TRUE
	in_progress_path = /obj/partial_construction/corruption

/*
	Instead of paying the whole resource cost, a construction ability costs 20% of it
	This is just to start it and create the in-progress object
	The rest of the cost will be paid gradually while doing the construction
*/
/datum/extension/ability/construction/handle_resource_cost()
	if (resource_cost_type)
		//We should never fail to have enough since we did safety checks, but you can never be sure
		if (!user.consume_resource(resource_cost_type, resource_cost_quantity*deposit))
			return FALSE
	return TRUE

//We only need to afford the deposit to begin construction
/datum/extension/ability/construction/can_afford_resource_cost(var/mob/potential_user, var/error_messages = TRUE)
	if (resource_cost_type)
		if (!potential_user.can_afford_resource(resource_cost_type, resource_cost_quantity*deposit, error_message = TRUE))
			return FALSE
	return TRUE








/*
	This object represents something being built
*/
/obj/partial_construction
	name = "Half-finished object"
	var/atom/target_path	//What are we making
	var/mob/initiator	//Who started this
	var/resource_cost_type	//What do we spend to make it, if anything
	var/resource_cost_quantity	//How much of that do we spend?
	var/work	//How many work-seconds will it take?

	var/work_done = 0

	var/finished = FALSE	//Briefly set true in the stack just before deletion

	//Calculated vars
	var/cost_per_work

	var/list/workers = list()//Who is doing work on this?
	anchored = TRUE
	can_block_movement = FALSE
	max_health = 50	//Fragile while being made
	resistance = 0


	//To give it sound, set the worksound var. this already exists from base /obj class
	//This can be a single sound file or a list of files
	var/worksound_interval = 4.5 SECONDS	//How long do the worksounds play
	var/datum/extension/repeating_sound/worksound_datum	//Internally used to hold repeating sound datum


/obj/partial_construction/New(var/atom/location, var/atom/target_path, var/mob/initiator, var/resource_cost_type, var/resource_cost_quantity, var/work)

	.=..()
	src.target_path = target_path
	src.initiator = initiator
	src.resource_cost_type = resource_cost_type
	src.resource_cost_quantity = resource_cost_quantity
	src.work = work

	//Now some calculations
	cost_per_work = resource_cost_quantity / work

/obj/partial_construction/Destroy()
	stop_worksound()
	.=..()

/obj/partial_construction/examine(var/mob/user)
	.=..()
	to_chat(user, SPAN_NOTICE("It is [round((work_done / work)*100, 0.1)]% complete"))

/obj/partial_construction/attack_hand(var/mob/user)
	if (is_valid_builder(user))
		do_build(user)

/obj/partial_construction/proc/get_construction_time()
	//Possible future todo: Construction cost discounts, for example, enhanced infector
	return 100

//Can the supplied mob work on this thing?
/obj/partial_construction/proc/is_valid_builder(var/mob/user)

	//Cant build twice at once
	if((user in workers))
		return FALSE
	return TRUE

/obj/partial_construction/proc/do_build(var/mob/user)
	user.face_atom(src)
	var/workrate = get_workrate(user)
	var/remaining_work = work - work_done
	var/time = ((remaining_work / workrate)+1) SECONDS
	workers |= user
	start_worksound()
	if (!do_after(user, time, src, proc_to_call = CALLBACK(src, /obj/partial_construction/proc/construction_tick, user)))
		user_stopped_building(user)


/obj/partial_construction/proc/start_worksound()
	if (worksound && !worksound_datum)
		worksound_datum = play_repeating_sound(worksound_interval, INFINITY, interval_variance = 0, _soundin = worksound, _vol = VOLUME_MID, _vary = TRUE, _extrarange  = 3)

/obj/partial_construction/proc/stop_worksound()
	if (worksound_datum)
		worksound_datum.stop()
		worksound_datum = null

//How much work does the user contribute per tick? Override to do some calculations
/obj/partial_construction/proc/get_workrate(var/mob/user)
	return 1

//Called once per second while construction is ongoing
/obj/partial_construction/proc/construction_tick(var/mob/user)
	//First of all, are we done?
	if (finished)
		user_stopped_building(user)	//Then this guy shouldn't be here
		return

	//Right lets do some work
	//First, lets calculate how much work the user can do
	var/workrate = get_workrate(user)
	if (!workrate)
		user_stopped_building(user)
		return

	var/remaining = work - work_done
	//We need to clamp this
	workrate = min(workrate, remaining)

	//Now, we have to pay the cost, if any
	if (resource_cost_type && !user.consume_resource(resource_cost_type, workrate*cost_per_work))
		user_stopped_building(user)	//If we get here, the user doesnt have enough resources left
		return

	//Alright we've paid, lets add it
	work_done += workrate
	if (prob(25))
		user.do_attack_animation(src)
		//TODO: Play sound here

	//Now check completion
	if (work_done >= work)
		construction_complete()

//Called when a specific mob aborts constructing, either due to cancelling the doafter or running out of resources
/obj/partial_construction/proc/user_stopped_building(var/mob/user)
	workers -= user
	set_extension(user, /datum/extension/interrupt_doafter, world.time + 2 SECONDS) //Stop the doafter

	if (length(workers) <= 0)
		stop_worksound()


/*
	Called when we are done
*/
/obj/partial_construction/proc/construction_complete()
	finished = TRUE
	new target_path(loc)
	for (var/thing in workers)
		user_stopped_building(thing)

	//Aaand goodnight
	qdel(src)




/*
	Corruption subtype
*/
/obj/partial_construction/corruption
	name = "amorphous organic mass"
	desc = "This looks like it's in the process of becoming something."

	layer = ABOVE_OBJ_LAYER	//Make sure nodes draw ontop of corruption
	icon = 'icons/effects/corruption.dmi'
	icon_state = "construction"
	worksound = list('sound/effects/creatures/necromorph/infector/infector_work_1.ogg',
	'sound/effects/creatures/necromorph/infector/infector_work_2.ogg',
	'sound/effects/creatures/necromorph/infector/infector_work_3.ogg')

/obj/partial_construction/corruption/is_valid_builder(var/mob/user)
	.=..()
	if (.)
		var/datum/species/S = user.get_species_datum()
		if (!istype(S, /datum/species/necromorph/infector))
			return FALSE	//Only infector can do this