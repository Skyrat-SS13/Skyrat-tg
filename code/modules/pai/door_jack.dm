#define CABLE_LENGTH 2

/**
 * Switch that handles door jack operations.
 *
 * @param {string} mode - The requested operation of the door jack.
 *
 * @returns {boolean} - TRUE if the door jack state was switched, FALSE otherwise.
 */
/mob/living/silicon/pai/proc/door_jack(mode)
	if(isnull(mode))
		return FALSE
	switch(mode)
		if(PAI_DOOR_JACK_CABLE)
			extend_cable()
			return TRUE
		if(PAI_DOOR_JACK_HACK)
			hack_door()
			return TRUE
		if(PAI_DOOR_JACK_CANCEL)
			QDEL_NULL(hacking_cable)
			visible_message(span_notice("The cable retracts into the pAI."))
			return TRUE
	return FALSE

/**
 * #Extend cable supporting proc
 *
 * When doorjack is installed, allows the pAI to drop
 * a cable which is placed either on the floor or in
 * someone's hands based (on distance).
 *
 * @returns {boolean} - TRUE if the cable was dropped, FALSE otherwise.
 */
/mob/living/silicon/pai/proc/extend_cable()
	QDEL_NULL(hacking_cable) //clear any old cables
	hacking_cable = new
	RegisterSignal(hacking_cable, COMSIG_QDELETING, PROC_REF(on_hacking_cable_del))
	var/mob/living/carbon/hacker = get_holder()
	if(iscarbon(hacker) && hacker.put_in_hands(hacking_cable)) //important to double check since get_holder can return non-null values that aren't carbons.
		hacker.visible_message(span_notice("A port on [src] opens to reveal a cable, which [hacker] quickly grabs."), span_notice("A port on [src] opens to reveal a cable, which you quickly grab."), span_hear("You hear the soft click of a plastic component and manage to catch the falling cable."))
		track_pai()
		track_thing(hacking_cable)
		return TRUE
	hacking_cable.forceMove(drop_location())
	hacking_cable.visible_message(message = span_notice("A port on [src] opens to reveal a cable, which promptly falls to the floor."), blind_message = span_hear("You hear the soft click of a plastic component fall to the ground."))
	track_pai()
	track_thing(hacking_cable)
	return TRUE

/** Tracks the associated pai */
/mob/living/silicon/pai/proc/track_pai()
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(handle_move))
	RegisterSignal(card, COMSIG_MOVABLE_MOVED, PROC_REF(handle_move))

/** Untracks the associated pai */
/mob/living/silicon/pai/proc/untrack_pai()
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	UnregisterSignal(card, COMSIG_MOVABLE_MOVED)

/** Tracks the associated hacking_cable */
/mob/living/silicon/pai/proc/track_thing(atom/movable/thing)
	RegisterSignal(thing, COMSIG_MOVABLE_MOVED, PROC_REF(handle_move))
	var/list/locations = get_nested_locs(thing, include_turf = FALSE)
	for(var/atom/movable/location in locations)
		RegisterSignal(location, COMSIG_MOVABLE_MOVED, PROC_REF(handle_move))

/** Untracks the associated hacking */
/mob/living/silicon/pai/proc/untrack_thing(atom/movable/thing)
	UnregisterSignal(thing, COMSIG_MOVABLE_MOVED)
	var/list/locations = get_nested_locs(thing, include_turf = FALSE)
	for(var/atom/movable/location in locations)
		UnregisterSignal(location, COMSIG_MOVABLE_MOVED)

/**
 * A periodic check to see if the source pAI is nearby.
 * Deletes the extended cable if the source pAI is not nearby.
 */
/mob/living/silicon/pai/proc/handle_move(atom/movable/source, atom/movable/old_loc)
	if(ismovable(old_loc))
		untrack_thing(old_loc)
	if(hacking_cable && (!IN_GIVEN_RANGE(src, hacking_cable, CABLE_LENGTH)))
		retract_cable()
		return
	if(ismovable(source.loc))
		track_thing(source.loc)

/**
 * Handles deleting the hacking cable and notifying the user.
 */
/mob/living/silicon/pai/proc/retract_cable()
	balloon_alert(src, "cable retracted")
	QDEL_NULL(hacking_cable)
	return TRUE

/**
 * #Door jacking supporting proc
 *
 * After a 15 second timer, the door will crack open,
 * provided they don't move out of the way.
 *
 * @returns {boolean} - TRUE if the door was jacked, FALSE otherwise.
 */
/mob/living/silicon/pai/proc/hack_door()
	if(!hacking_cable)
		return FALSE
	if(!hacking_cable.hacking_machine)
		balloon_alert(src, "nothing connected")
		return FALSE
	playsound(src, 'sound/machines/airlock_alien_prying.ogg', 50, TRUE)
	balloon_alert(src, "overriding...")
	// Now begin hacking
	if(!do_after(src, 15 SECONDS, hacking_cable.hacking_machine, timed_action_flags = NONE,	progress = TRUE))
		balloon_alert(src, "failed! retracting...")
		QDEL_NULL(hacking_cable)
		return FALSE
	var/obj/machinery/door/door = hacking_cable.hacking_machine
	balloon_alert(src, "success")
	door.open()
	QDEL_NULL(hacking_cable)
	return TRUE

#undef CABLE_LENGTH
