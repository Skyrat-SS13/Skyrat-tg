/datum/signal_ability/breach
	name = "Breaching Growth"
	energy_cost = 100
	target_string = "an airlock on or near a corrupted tile"
	desc = "Breaching Growth allows you to slowly break open an airlock by having corruption force it with repeated hits. <br>\
	This takes quite a long time to work, generally 5-10 minutes. It will be cancelled if anyone opens the door, or removes the corruption around it, but any damage dealt up to that point will remain."

	marker_active_required = TRUE

	target_types = list(/obj/machinery/door)
	require_corruption = FALSE
	require_necrovision = FALSE


/datum/signal_ability/breach/special_check(var/obj/machinery/door/D)
	var/list/turfs = D.get_cardinal_corruption()
	if (!turfs.len)
		return "No nearby corruption."

	for (var/turf/T in turfs)
		var/obj/effect/vine/corruption/C = locate(/obj/effect/vine/corruption) in T
		if (C && get_extension(C, /datum/extension/breaching_growth))
			return "A breaching growth is already working on this door"
	return TRUE



/datum/signal_ability/breach/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/list/turfs = target.get_cardinal_corruption()
	var/turf/T = pick(turfs)
	var/obj/effect/vine/corruption/C = locate(/obj/effect/vine/corruption) in T
	set_extension(C, /datum/extension/breaching_growth, target)


/*
	Extension, added to a piece of corruption
*/
/datum/extension/breaching_growth
	expected_type = /obj/effect/vine/corruption
	flags = EXTENSION_FLAG_IMMEDIATE
	base_type = /datum/extension/breaching_growth
	var/power = 0
	var/power_growth = 0.3
	var/strike_interval = 4 SECONDS
	var/obj/machinery/door/target
	var/obj/effect/vine/corruption/user

/datum/extension/breaching_growth/New(var/atom/user, var/atom/target)
	.=..()
	src.user = user
	src.target = target
	tick()

/datum/extension/breaching_growth/proc/safety_check()
	if (QDELETED(target) || !target.density)
		return FALSE	//If the door is gone or open, we are done

	if (QDELETED(user))
		return FALSE

	return TRUE

/datum/extension/breaching_growth/proc/tick()
	//If we fail a safety check, end the process
	if (!safety_check())
		if (user)
			remove_extension(user, src)
		return

	power += power_growth
	target.hit(user, null, power, FALSE)

	addtimer(CALLBACK(src, /datum/extension/breaching_growth/proc/tick), strike_interval)