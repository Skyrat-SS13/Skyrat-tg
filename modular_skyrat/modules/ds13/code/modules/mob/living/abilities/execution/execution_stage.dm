/*
	execution stage datum

	vars
		duration: attempt to exit the stage when this much time has passed after entering it

	contains procs:
		enter:	Called to enter this stage. After a stage is entered, it is added to the entered_stages list on the execution
		safety:	Called whenever the parent execution does a safety check. This can be useful if this stage adds extra safety conditions
		can_advance: called once duration expires, checking if we can advance yet
		exit: called just before we exit this stage and enter the next one

		cancel: Called when the parent execution is interrupted/cancelled/etc. Cancel and complete will never be called in the same execution
		complete: Called when the parent execution successfully finishes all stages and is done

		stop: Called when the parent execution finishes in any circumstance. This will ALWAYS be called, in addition to one of cancel or complete
*/
/datum/execution_stage
	//The extension instance we're attached to
	var/datum/extension/execution/host

	//How long to remain in this stage before moving to the next one
	var/duration = 1 SECOND

/datum/execution_stage/New(var/datum/extension/execution/host)
	src.host = host
	.=..()

/datum/execution_stage/Destroy()
	host = null
	.=..()

/datum/execution_stage/proc/enter()
	return TRUE


//Here, do safety checks to see if everything is in order for being able to advance to the next stage. Return true/false appropriately
/datum/execution_stage/proc/can_advance()
	return TRUE


//Here, do safety checks to see if its okay to continue the execution move
/datum/execution_stage/proc/safety()
	return EXECUTION_CONTINUE

//Called when we finish this stage and move to the next one
/datum/execution_stage/proc/exit()
	return TRUE


/datum/execution_stage/proc/interrupt()
	return TRUE

/datum/execution_stage/proc/complete()
	return TRUE

/datum/execution_stage/proc/stop()
	return TRUE


/*
	A finisher is a special stage which marks the endpoint of an execution move.
	It should typically kill the victim, or at least deal the strongest blow that will be dealt

	When a finisher stage is entered, the execution is considered a success, rewards are distributed,
	and the execution becomes non-interruptible for the remaining stages.

	Any stages after a finisher are basically a victory lap and shouldn't contain too much meaningful effects, just winding down

*/
/datum/execution_stage/finisher


/datum/execution_stage/finisher/enter()
	host.complete()




/*
	Generic States
*/
/datum/execution_stage/scream/enter()
	host.user.do_shout(SOUND_SHOUT_LONG, FALSE)


//Retract a tether used as a weapon
/datum/execution_stage/retract/enter()
	var/obj/effect/projectile/tether/T = host.weapon
	if (istype(T))
		T.retract(duration)