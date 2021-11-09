/obj/vbelly
	name = "belly"
	desc = ""
	invisibility = INVISIBILITY_MAXIMUM
	var/mob/living/owner = null
	var/mode = VORE_MODE_HOLD
	var/list/data = list()

/obj/vbelly/Initialize(mapload, mob/living/living_owner, list/belly_data)
	. = ..()
	if (!istype(living_owner))
		return INITIALIZE_HINT_QDEL
	owner = living_owner
	if (!SSair.planetary[OPENTURF_DEFAULT_ATMOS])
		var/datum/gas_mixture/immutable/planetary/mix = new
		mix.parse_string_immutable(OPENTURF_DEFAULT_ATMOS)
		SSair.planetary[OPENTURF_DEFAULT_ATMOS] = mix
	RegisterSignal(owner, COMSIG_PARENT_EXAMINE, .proc/on_examine)
	forceMove(owner)
	set_data(belly_data)

/obj/vbelly/proc/set_data(_data)
	for (var/varname in static_belly_vars())
		if (!(varname in _data))
			return FALSE
	data = _data
	name = data["name"]
	desc = data["desc"]
	mode = data["mode"]


/datum/gas_mixture/normalized //yeah I should REALLY find a different way to do this
/datum/gas_mixture/normalized/New()
	gases = list()
	add_gases(/datum/gas/oxygen, /datum/gas/nitrogen)
	temperature = T20C
	gases[/datum/gas/oxygen][MOLES] = MOLES_O2STANDARD
	gases[/datum/gas/nitrogen][MOLES] = MOLES_N2STANDARD

/obj/vbelly/assume_air()
	return 0

/obj/vbelly/return_air() //people don't want to have to wear internals while inside someone
	var/static/datum/gas_mixture/normalized/mix = new
	return mix.copy()

/obj/vbelly/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if (isliving(arrived))
		var/mob/living/arrived_mob = arrived
		if (desc)
			to_chat(arrived_mob, span_notice(desc))
		if (owner && arrived_mob.client?.prefs?.vr_prefs?.tastes_of)
			to_chat(owner, span_notice("[arrived_mob] tastes of [arrived_mob.client.prefs.vr_prefs.tastes_of]."))
		RegisterSignal(arrived, COMSIG_LIVING_RESIST, .proc/prey_resist)
		check_mode()

/obj/vbelly/Exited(atom/movable/gone, direction)
	. = ..()
	if (isliving(gone))
		UnregisterSignal(gone, COMSIG_LIVING_RESIST)
	//todo

/obj/vbelly/proc/check_mode()
	if (mode == VORE_MODE_HOLD)
		return
	START_PROCESSING(SSvore, src)

/obj/vbelly/process()
	if (mode == VORE_MODE_HOLD)
		STOP_PROCESSING(SSvore, src)
	var/all_done = TRUE
	if (mode == VORE_MODE_DIGEST)
		for (var/mob/living/prey in src)
			if (prey.stat == DEAD)
				continue
			if (prey.client?.prefs?.vr_prefs)
				if (!prey.check_vore_toggle(DIGESTABLE))
					continue
			prey.apply_damage(4, BURN)
			if (prey.stat != DEAD)
				all_done = FALSE
			else
				var/pred_message = vore_replace(data[LIST_DIGEST_PRED], owner, prey, name)
				var/prey_message = vore_replace(data[LIST_DIGEST_PREY], owner, prey, name)
				if (pred_message)
					to_chat(owner, span_warning(pred_message))
				if (prey_message)
					to_chat(prey, span_warning(prey_message))
				prey.release_belly_contents()
				for (var/obj/item/item in prey)
					if (!prey.dropItemToGround(item))
						qdel(item)
				qdel(prey)
	if (mode == VORE_MODE_ABSORB)
		//todo
		all_done = TRUE
	if (all_done == TRUE)
		STOP_PROCESSING(SSvore, src)

/obj/vbelly/drop_location()
	if (owner)
		return owner.drop_location()
	if (SSjob.latejoin_trackers.len)
		return pick(SSjob.latejoin_trackers)
	return SSjob.get_last_resort_spawn_points()

/obj/vbelly/proc/mass_release_from_contents()
	for (var/atom/movable/to_release as anything in contents)
		to_release.forceMove(drop_location())

/obj/vbelly/proc/release_from_contents(atom/movable/to_release)
	if (!(to_release in contents))
		return FALSE
	to_release.forceMove(drop_location())
	send_vore_message(owner, span_warning("%a|[owner]|You|| eject%a|s||| the [to_release] from %a|their|your|| [src]!"), SEE_OTHER_MESSAGES)

/obj/vbelly/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if (!user.check_vore_toggle(SEE_EXAMINES))
		return
	if (!isnull(data[LIST_EXAMINE]) && data[LIST_EXAMINE].len)
		for (var/mob/living/living_mob in contents)
			examine_list += span_warning(vore_replace(data[LIST_EXAMINE], owner, living_mob, name))
			break //not sure how you'd do this with multiple prey... hm.

/obj/vbelly/proc/prey_resist(datum/source, mob/living/prey)
	var/prey_message = span_warning(vore_replace(data[LIST_STRUGGLE_INSIDE], owner, prey, name))
	for (var/mob/living/prey_target in contents)
		if (!prey_target.check_vore_toggle(SEE_STRUGGLES))
			continue
		to_chat(prey_target, prey_message)
	send_vore_message(owner, vore_replace(data[LIST_STRUGGLE_INSIDE], owner, prey, name), SEE_STRUGGLES, prey)

// MISC PROCS

/mob/living/carbon/human/update_sensor_list()
	if (loc && istype(loc, /obj/vbelly))
		return
	. = ..()