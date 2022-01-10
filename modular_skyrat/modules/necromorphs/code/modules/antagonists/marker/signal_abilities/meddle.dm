/*
	The meddle spell is mostly a fun thing, and allows signals to interact with the environment.

	It calls an overrideable proc on any object which can be varied. It is intended for mostly harmless spooky effects, not major gameplay advantage
*/
/datum/signal_ability/meddle
	name = "Meddle"
	id = "meddle"
	desc = "A context sensitive spell which does different things depending on the target. Interfaces with machines, moves items, messes with computers and office appliances. Try it on lots of things!"
	target_string = "any object"
	energy_cost = 8
	require_corruption = FALSE
	require_necrovision = TRUE
	autotarget_range = 0
	target_types = list(/obj)
	targeting_method	=	TARGET_CLICK
	cooldown = 1 SECOND



/datum/signal_ability/meddle/on_cast(var/mob/user, var/obj/target, var/list/data)
	target.meddle(user)


/datum/signal_ability/meddle/special_check(var/atom/thing)
	var/obj/O = thing
	if (istype(O) && isturf(O.loc))
		return TRUE
	else
		return FALSE


/obj/proc/meddle(var/mob/user)
	shake_animation()


