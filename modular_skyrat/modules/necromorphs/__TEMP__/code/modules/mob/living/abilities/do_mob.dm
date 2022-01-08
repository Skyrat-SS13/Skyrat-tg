/*
	A subset of abilities that require the user to grab onto a mob for some period
	user or target moving will interrupt it

	These abilities are only intended for use from one mob to another. Not for non-mob targets
*/
/datum/extension/ability/domob
	var/immobilise_user = FALSE

	var/immobilise_target = FALSE

	var/face = TRUE

	expected_target_type = /mob/living

	var/datum/callback/C
	var/proc_interval = (1 SECOND)
	var/refund_on_interrupt = TRUE

/datum/extension/ability/domob/pre_calculate()
	assemble_callback()

/datum/extension/ability/domob/start()
	.=..()
	if (immobilise_user)
		user.disable(duration)

	if (immobilise_target)
		var/mob/living/L = target
		L.disable(duration)	//TODO: Un-disable on stop

	if (face)
		user.face_atom(target)



	apply_start_effect()
	if (!do_mob(user, target, duration, proc_to_call = C, proc_interval = src.proc_interval))
		interrupt()
		return

	apply_effect()


//Populate the C var with a callback if we're going to use one. This is passed in to do_mob
/datum/extension/ability/domob/proc/assemble_callback()


//Effect applied just before the do_mob timer starts.
//Anything added here should support being interrupted later
/datum/extension/ability/domob/proc/apply_start_effect()


//Effect applied just after the do_mob timer finishes successfully. Will not fire if interrupted
/datum/extension/ability/domob/proc/apply_effect()


/datum/extension/ability/domob/interrupt()
	set_extension(user, /datum/extension/interrupt_doafter, world.time + 2 SECONDS)
	if (refund_on_interrupt)
		refund_resource_cost(user)
	stop()