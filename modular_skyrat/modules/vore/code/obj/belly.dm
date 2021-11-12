/obj/vbelly
	name = "belly"
	desc = ""
	invisibility = INVISIBILITY_MAXIMUM
	var/datum/gas_mixture/air_contents = new()
	var/mob/living/owner = null
	var/mode = VORE_MODE_HOLD
	var/can_taste = FALSE
	var/swallow_verb = "nom"
	var/belly_ref
	var/list/data = list()
	var/list/absorbing = list()
	var/list/absorbed = list()
	var/static_data_cooldown = 0 //so we don't send data over and over and over
	var/static_timer = FALSE

/obj/vbelly/Initialize(mapload, mob/living/living_owner, list/belly_data, bellynum)
	. = ..()
	if (!isliving(living_owner))
		return INITIALIZE_HINT_QDEL
	air_contents.add_gases(/datum/gas/oxygen, /datum/gas/nitrogen)
	air_contents.temperature = T20C
	air_contents.gases[/datum/gas/oxygen][MOLES] = MOLES_O2STANDARD
	air_contents.gases[/datum/gas/nitrogen][MOLES] = MOLES_N2STANDARD
	owner = living_owner
	if (!SSair.planetary[OPENTURF_DEFAULT_ATMOS])
		var/datum/gas_mixture/immutable/planetary/mix = new
		mix.parse_string_immutable(OPENTURF_DEFAULT_ATMOS)
		SSair.planetary[OPENTURF_DEFAULT_ATMOS] = mix
	RegisterSignal(owner, COMSIG_PARENT_EXAMINE, .proc/on_examine)
	forceMove(owner)
	set_data(belly_data, bellynum)

/obj/vbelly/proc/set_data(_data, bellynum)
	for (var/varname in _data)
		if (!(varname in static_belly_vars()))
			_data -= varname
	data = _data
	name = data["name"]
	desc = data["desc"]
	mode = data["mode"]
	can_taste = data["can_taste"] == "Yes" ? TRUE : FALSE
	swallow_verb = data["swallow_verb"]
	check_mode()
	if (!isnull(bellynum))
		belly_ref = bellynum

//people don't want to have to wear internals while inside someone
//todo: should REALLY find a better way to do this tbh.
/obj/vbelly/assume_air(datum/gas_mixture/giver)
	var/datum/gas_mixture/copy = air_contents.copy()
	return copy.merge(giver)
/obj/vbelly/return_air()
	var/datum/gas_mixture/copy = air_contents.copy()
	return copy
/obj/vbelly/return_analyzable_air()
	var/datum/gas_mixture/copy = air_contents.copy()
	return copy
/obj/vbelly/remove_air(amount)
	var/datum/gas_mixture/copy = air_contents.copy()
	return copy.remove(amount)

/obj/vbelly/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if (isliving(arrived))
		var/mob/living/arrived_mob = arrived
		if (desc && arrived_mob.check_vore_toggle(SEE_OTHER_MESSAGES))
			to_chat(arrived_mob, span_notice(desc))
		var/datum/component/vore/vore = arrived_mob.GetComponent(/datum/component/vore)
		if (owner.check_vore_toggle(SEE_OTHER_MESSAGES) && can_taste && vore?.tastes_of)
			to_chat(owner, span_notice("[arrived_mob] tastes of [vore.tastes_of]."))
		RegisterSignal(arrived, COMSIG_LIVING_RESIST, .proc/prey_resist)
		check_mode()
	update_static_vore_data()

/obj/vbelly/Exited(atom/movable/gone, direction)
	. = ..()
	if (isliving(gone))
		UnregisterSignal(gone, COMSIG_LIVING_RESIST)
	check_mode()
	update_static_vore_data()

/obj/vbelly/proc/update_static_vore_data(force=FALSE, only_contents=FALSE)
	if (force)
		static_data_cooldown = 0
		static_timer = FALSE
	if (static_data_cooldown > world.time)
		if (!static_timer)
			static_timer = TRUE
			addtimer(CALLBACK(src, .proc/update_static_vore_data, TRUE), static_data_cooldown - world.time)
		return
	static_data_cooldown = world.time + 0.5 SECONDS
	for (var/mob/living/living in src)
		living.client?.prefs?.vr_prefs.update_static_data(living)
	if (!only_contents)
		owner.client?.prefs?.vr_prefs.update_static_data(owner)

/obj/vbelly/proc/get_belly_contents(ref=FALSE, living=FALSE, as_string=FALSE, ignored=null, full=FALSE)
	var/list/belly_contents = list()
	var/list/keep_track = list()
	for (var/atom/movable/AM as anything in src)
		if (ignored && (AM == ignored || (AM in ignored)))
			continue
		if (living && !isliving(AM))
			continue
		var/key = as_string ? "[AM][keep_track["[AM]"] ? " ([keep_track["[AM]"]])" : ""]" : AM
		if (full)
			belly_contents += list(list("name" = key, "absorbed" = (AM in absorbed), "ref" = ref(AM))) //double list because byond is dumb and this is the only way to add a list to a list afaik
		else if (ref)
			belly_contents[key] = ref(AM)
		else
			belly_contents += key
		keep_track["[AM]"] = keep_track["[AM]"] ? keep_track["[AM]"] + 1 : 2
	return belly_contents

/obj/vbelly/proc/check_mode()
	if (mode == VORE_MODE_HOLD)
		return
	START_PROCESSING(SSvore, src)

/obj/vbelly/process()
	var/all_done = TRUE //should it stop processing
	var/should_update = FALSE //should it call a vore prefs ui update on mobs inside, and on the owner
	if (mode == VORE_MODE_HOLD)
		STOP_PROCESSING(SSvore, src)
	if (mode == VORE_MODE_DIGEST)
		for (var/mob/living/prey in src)
			if (!prey.check_vore_toggle(DIGESTABLE))
				continue
			prey.apply_damage(4, BURN)
			if (prey.stat == DEAD)
				var/pred_message = vore_replace(data[LIST_DIGEST_PRED], owner, prey, name)
				var/prey_message = vore_replace(data[LIST_DIGEST_PREY], owner, prey, name)
				if (pred_message && owner.check_vore_toggle(SEE_OTHER_MESSAGES))
					to_chat(owner, span_warning(pred_message))
				if (prey_message && owner.check_vore_toggle(SEE_OTHER_MESSAGES))
					to_chat(prey, span_warning(prey_message))
				prey.release_belly_contents()
				for (var/obj/item/item in prey)
					if (!prey.dropItemToGround(item))
						qdel(item)
				qdel(prey)
				should_update = TRUE
			else
				all_done = FALSE

	if (mode == VORE_MODE_ABSORB)
		for (var/mob/living/prey in absorbed)
			if (!prey.check_vore_toggle(ABSORBABLE))
				absorbed -= prey
				should_update = TRUE
				continue
			if (absorbed[prey] < 100)
				absorbed[prey] += 2
				all_done = FALSE
		for (var/mob/living/prey in src)
			if ((prey in absorbed) || !prey.check_vore_toggle(ABSORBABLE))
				continue
			if (!absorbing[prey])
				absorbing[prey] = 0
			absorbing[prey] += 2 //fires every 2 seconds, so this will take 100 seconds
			if (absorbing[prey] >= 100)
				RegisterSignal(prey, COMSIG_PARENT_EXAMINE, .proc/examine_absorb)
				var/pred_message = vore_replace(data[LIST_ABSORB_PRED], owner, prey, name)
				var/prey_message = vore_replace(data[LIST_ABSORB_PREY], owner, prey, name)
				if (pred_message && owner.check_vore_toggle(SEE_OTHER_MESSAGES))
					to_chat(owner, span_warning(pred_message))
				if (prey_message && owner.check_vore_toggle(SEE_OTHER_MESSAGES))
					to_chat(prey, span_warning(prey_message))
				absorbing -= prey
				absorbed[prey] = 100
				should_update = TRUE
			else
				all_done = FALSE

	if (mode == VORE_MODE_UNABSORB)
		for (var/mob/living/prey in absorbed)
			if (!(prey in src))
				absorbed -= prey
				should_update = TRUE
				continue
			absorbed[prey] -= 2 //fires every 2 seconds, so this will take 100 seconds
			if (absorbed[prey] <= 0)
				UnregisterSignal(prey, COMSIG_PARENT_EXAMINE)
				var/pred_message = vore_replace(data[LIST_UNABSORB_PRED], owner, prey, name)
				var/prey_message = vore_replace(data[LIST_UNABSORB_PREY], owner, prey, name)
				if (pred_message && owner.check_vore_toggle(SEE_OTHER_MESSAGES))
					to_chat(owner, span_warning(pred_message))
				if (prey_message && owner.check_vore_toggle(SEE_OTHER_MESSAGES))
					to_chat(prey, span_warning(prey_message))
				absorbed -= prey
				should_update = TRUE
			else
				all_done = FALSE
		for (var/mob/living/prey in absorbing)
			if (!(prey in src))
				absorbing -= prey
				should_update = TRUE
				continue
			absorbing[prey] -= 2
			if (absorbing[prey] <= 0)
				absorbing -= prey
			else
				all_done = FALSE

	if (all_done)
		STOP_PROCESSING(SSvore, src)
	if (should_update)
		update_static_vore_data()

/obj/vbelly/drop_location()
	if (owner)
		return owner.drop_location()
	if (SSjob.latejoin_trackers.len)
		return pick(SSjob.latejoin_trackers)
	return SSjob.get_last_resort_spawn_points()

/obj/vbelly/AllowDrop()
	return TRUE

/obj/vbelly/AllowClick()
	return TRUE

/obj/vbelly/proc/mass_release_from_contents(willing=FALSE)
	for (var/atom/movable/to_release as anything in contents)
		if (willing && (to_release in absorbed))
			continue
		to_release.forceMove(drop_location())
	//add a message here?

/obj/vbelly/proc/release_from_contents(atom/movable/to_release)
	if (!(to_release in contents))
		return FALSE
	to_release.forceMove(drop_location())
	send_vore_message(owner, span_warning("%a|[owner]|You|| eject%a|s||| [to_release] from %a|[owner.p_their()]|your|| [name]!"), SEE_OTHER_MESSAGES)

/obj/vbelly/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if (!user.check_vore_toggle(SEE_EXAMINES))
		return
	if (!isnull(data[LIST_EXAMINE]) && data[LIST_EXAMINE].len)
		for (var/mob/living/living_mob in contents)
			examine_list += span_warning(vore_replace(data[LIST_EXAMINE], owner, living_mob, name))
			break //not sure how you'd do this with multiple prey... hm.

/obj/vbelly/proc/examine_absorb(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if (!user.check_vore_toggle(SEE_EXAMINES))
		return
	for (var/mob/living/absorbee as anything in absorbed)
		if (!(absorbee in src))
			absorbed -= absorbee
			UnregisterSignal(absorbee, COMSIG_PARENT_EXAMINE)
			continue
		examine_list += "<span class='purple bold italic'>[absorbee] has been absorbed into [user == owner ? "your" : "[owner]'s"] [name]!</span>"

/obj/vbelly/proc/prey_resist(datum/source, mob/living/prey) //incorporate struggling mechanics later?
	if (prey in absorbed) //should this stay? or do we want absorbed victims to be able to struggle
		return
	var/prey_message = vore_replace(data[LIST_STRUGGLE_INSIDE], owner, prey, name)
	var/list/ignored_mobs = list()
	for (var/mob/living/prey_target in contents)
		ignored_mobs += prey_target
		if (!prey_message || !prey_target.check_vore_toggle(SEE_STRUGGLES))
			continue
		to_chat(prey_target, span_warning(prey_message))
	var/out_message = vore_replace(data[LIST_STRUGGLE_OUTSIDE], owner, prey, name)
	if (out_message)
		send_vore_message(owner, span_warning(out_message), SEE_STRUGGLES, prey, ignored=ignored_mobs)

// MISC PROCS

/mob/living/carbon/human/update_sensor_list()
	if (loc && istype(loc, /obj/vbelly))
		return
	. = ..()
