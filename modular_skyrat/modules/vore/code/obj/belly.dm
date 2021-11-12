/obj/vbelly
	name = "belly"
	desc = ""
	invisibility = INVISIBILITY_MAXIMUM
	var/datum/gas_mixture/air_contents = new()
	var/mob/living/owner = null
	var/mode = VORE_MODE_HOLD
	var/can_taste = FALSE
	var/swallow_verb = "nom"
	var/list/data = list()

/obj/vbelly/Initialize(mapload, mob/living/living_owner, list/belly_data)
	. = ..()
	if (!istype(living_owner))
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
	set_data(belly_data)

/obj/vbelly/proc/set_data(_data)
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

//todo: should REALLY find a better way to do this.
/obj/vbelly/assume_air(datum/gas_mixture/giver)
	var/datum/gas_mixture/copy = air_contents.copy()
	return copy.merge(giver)
/obj/vbelly/return_air() //people don't want to have to wear internals while inside someone
	var/datum/gas_mixture/copy = air_contents.copy()
	return copy
/obj/vbelly/return_analyzable_air() //people don't want to have to wear internals while inside someone
	var/datum/gas_mixture/copy = air_contents.copy()
	return copy
/obj/vbelly/remove_air(amount) //people don't want to have to wear internals while inside someone
	var/datum/gas_mixture/copy = air_contents.copy()
	return copy.remove(amount)

/obj/vbelly/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if (isliving(arrived))
		var/mob/living/arrived_mob = arrived
		if (desc)
			to_chat(arrived_mob, span_notice(desc))
		var/datum/component/vore/vore = arrived_mob.GetComponent(/datum/component/vore)
		if (owner && can_taste && vore?.tastes_of)
			to_chat(owner, span_notice("[arrived_mob] tastes of [vore.tastes_of]."))
		RegisterSignal(arrived, COMSIG_LIVING_RESIST, .proc/prey_resist)
		check_mode()
	if (owner.client?.prefs?.vr_prefs)
		SStgui.update_uis(owner.client.prefs.vr_prefs)

/obj/vbelly/Exited(atom/movable/gone, direction)
	. = ..()
	if (isliving(gone))
		UnregisterSignal(gone, COMSIG_LIVING_RESIST)
	if (owner.client?.prefs?.vr_prefs)
		SStgui.update_uis(owner.client.prefs.vr_prefs)
	//todo

/obj/vbelly/proc/get_belly_contents(ref=FALSE, living=FALSE, as_string=FALSE, ignored=null)
	var/list/belly_contents = list()
	var/list/keep_track = list()
	for (var/atom/movable/AM as anything in src)
		if (ignored && (AM == ignored || (AM in ignored)))
			continue
		if (living && !isliving(AM))
			continue
		var/key = as_string ? "[AM][keep_track["[AM]"] ? " ([keep_track["[AM]"]])" : ""]" : AM
		if (ref)
			belly_contents[key] = ref(AM) //ref(AM) returns a string that can be used in locate() to get that atom back
		else
			belly_contents += key
		keep_track["[AM]"] = keep_track["[AM]"] ? keep_track["[AM]"] + 1 : 2
	return belly_contents

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
			if (!prey.check_vore_toggle(DIGESTABLE))
				continue
			prey.apply_damage(4, BURN)
			if (prey.stat == DEAD)
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
			else
				all_done = FALSE
	if (mode == VORE_MODE_ABSORB)
		//todo
		all_done = TRUE
	if (all_done == TRUE)
		if (owner.client?.prefs?.vr_prefs)
			SStgui.update_uis(owner.client.prefs.vr_prefs)
		STOP_PROCESSING(SSvore, src)

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

/obj/vbelly/proc/mass_release_from_contents()
	for (var/atom/movable/to_release as anything in contents)
		to_release.forceMove(drop_location())
	//add a message here?

/obj/vbelly/proc/release_from_contents(atom/movable/to_release)
	if (!(to_release in contents))
		return FALSE
	to_release.forceMove(drop_location())
	send_vore_message(owner, span_warning("%a|[owner]|You|| eject%a|s||| [to_release] from %a|their|your|| [name]!"), SEE_OTHER_MESSAGES)

/obj/vbelly/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	if (!user.check_vore_toggle(SEE_EXAMINES))
		return
	if (!isnull(data[LIST_EXAMINE]) && data[LIST_EXAMINE].len)
		for (var/mob/living/living_mob in contents)
			examine_list += span_warning(vore_replace(data[LIST_EXAMINE], owner, living_mob, name))
			break //not sure how you'd do this with multiple prey... hm.

/obj/vbelly/proc/prey_resist(datum/source, mob/living/prey) //incorporate struggling mechanics later?
	var/prey_message = span_warning(vore_replace(data[LIST_STRUGGLE_INSIDE], owner, prey, name))
	var/list/ignored_mobs = list()
	for (var/mob/living/prey_target in contents)
		ignored_mobs += prey_target
		if (!prey_target.check_vore_toggle(SEE_STRUGGLES))
			continue
		if (!isnull(data[LIST_STRUGGLE_INSIDE]) && data[LIST_STRUGGLE_INSIDE].len)
			to_chat(prey_target, prey_message)
	if (!isnull(data[LIST_STRUGGLE_OUTSIDE]) && data[LIST_STRUGGLE_OUTSIDE].len)
		send_vore_message(owner, span_warning(vore_replace(data[LIST_STRUGGLE_OUTSIDE], owner, prey, name)), SEE_STRUGGLES, prey, ignored=ignored_mobs)

// MISC PROCS

/mob/living/carbon/human/update_sensor_list()
	if (loc && istype(loc, /obj/vbelly))
		return
	. = ..()