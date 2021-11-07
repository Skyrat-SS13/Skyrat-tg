#define VORE_MODE_HOLD		0
#define VORE_MODE_DIGEST	1
#define VORE_MODE_ABSORB	2
#define LIST_DIGEST_PREY			"digest_messages_prey"
#define LIST_DIGEST_PRED			"digest_messages_owner"
#define LIST_STRUGGLE_INSIDE		"struggle_messages_inside"
#define LIST_STRUGGLE_OUTSIDE		"struggle_messages_outside"
#define LIST_EXAMINE				"examine_messages"

/obj/vbelly
	name = "belly"
	desc = ""
	invisibility = INVISIBILITY_MAXIMUM
	var/mob/living/owner = null
	var/mode = VORE_MODE_HOLD
	var/list/data = list()

/obj/vbelly/Initialize(mapload, mob/living/holder = null, data = default_belly_info())
	. = ..()
	if (!holder)
		return INITIALIZE_HINT_QDEL
	if (!SSair.planetary[OPENTURF_DEFAULT_ATMOS])
		var/datum/gas_mixture/immutable/planetary/mix = new
		mix.parse_string_immutable(OPENTURF_DEFAULT_ATMOS)
		SSair.planetary[OPENTURF_DEFAULT_ATMOS] = mix
	forceMove(holder)
	name = data["name"]
	desc = data["desc"]
	mode = data["mode"]

/obj/vbelly/return_air()
	return SSair.planetary[OPENTURF_DEFAULT_ATMOS] //people don't want to have to wear internals while inside someone

/obj/vbelly/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if (isliving(arrived))
		var/mob/living/arrived_mob = arrived
		if (desc)
			to_chat(arrived_mob, span_notice(desc))
		if (owner && arrived_mob.client?.prefs?.vr_prefs?.tastes_of)
			to_chat(owner, span_notice("[arrived_mob] tastes of [arrived_mob.client?.prefs?.vr_prefs?.tastes_of]."))
		check_mode()

/obj/vbelly/Exited(atom/movable/gone, direction)
	. = ..()
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
			prey.apply_damage(4, BURN)
			if (prey.stat != DEAD)
				all_done = FALSE
			else
				var/pred_message = vore_replace(data[LIST_DIGEST_PRED], owner, prey)
				var/prey_message = vore_replace(data[LIST_DIGEST_PREY], owner, prey)
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
	send_vore_message(owner, span_warning("[owner] ejects the [to_release] from their [src]!"), SEE_OTHER_MESSAGES)

// MISC PROCS

/mob/living/carbon/human/update_sensor_list()
	if (loc && istype(loc, /obj/vbelly))
		return
	. = ..()

/* DEBUGGING
/proc/write_belly_info(savefile/S, slot, data)
	if (!islist(data) || !S || !S.dir.Find("slot[slot]"))
		return FALSE
	S.cd = "slot[slot]"
	WRITE_FILE(S[LIST_DIGEST_PREY], data[LIST_DIGEST_PREY])
	WRITE_FILE(S[LIST_DIGEST_PRED], data[LIST_DIGEST_PRED])
	WRITE_FILE(S[LIST_STRUGGLE_INSIDE], data[LIST_STRUGGLE_INSIDE])
	WRITE_FILE(S[LIST_STRUGGLE_OUTSIDE], data[LIST_STRUGGLE_OUTSIDE])
	WRITE_FILE(S[LIST_EXAMINE], data[LIST_EXAMINE])
	WRITE_FILE(S["name"], data["name"])
	WRITE_FILE(S["desc"], data["desc"])
	WRITE_FILE(S["mode"], data["mode"])
	S.cd = ".."
	return data
*/
