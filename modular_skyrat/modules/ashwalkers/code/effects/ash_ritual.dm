/datum/ash_ritual
	/// the name of the ritual
	var/name = "Summon Coders"
	/// the description of the ritual
	var/desc

	/// the components necessary for a successful ritual
	var/list/required_components = list()
	/// the list that checks whether the components will be consumed
	var/list/consumed_components = list()

	/// if the ritual is successful, it will go through each item in the list to be spawned
	var/list/ritual_success_items

	/// the effect that is spawned when the components are consumed, etc.
	var/ritual_effect = /obj/effect/particle_effect/sparks

	/// the time it takes to process each stage of the ritual
	var/ritual_time = 5 SECONDS

	/// whether the ritual is in use
	var/in_use = FALSE

/datum/ash_ritual/proc/ritual_start(obj/effect/ash_rune/rune)

	if(in_use)
		return
	in_use = TRUE

	rune.balloon_alert_to_viewers("ritual has begun...")
	new ritual_effect(rune.loc)

	// it is entirely possible to have your own effects here... this is just a suggestion
	var/atom/movable/warp_effect/warp = new(rune)
	rune.vis_contents += warp

	sleep(ritual_time)

	if(!check_component_list(rune))
		rune.vis_contents -= warp
		warp = null
		return

	ritual_success(rune)

	// make sure to remove your effects at the end
	rune.vis_contents -= warp
	warp = null

/datum/ash_ritual/proc/check_component_list(obj/effect/ash_rune/checked_rune)
	for(var/checked_component in required_components)
		var/set_direction = text2dir(checked_component)
		var/turf/checked_turf = get_step(checked_rune, set_direction)
		var/atom_check = locate(required_components[checked_component]) in checked_turf.contents
		if(!atom_check)
			ritual_fail(checked_rune)
			return FALSE
		if(is_type_in_list(atom_check, consumed_components))
			qdel(atom_check)
			checked_rune.balloon_alert_to_viewers("[checked_component] component has been consumed...")
		else
			checked_rune.balloon_alert_to_viewers("[checked_component] component has been checked...")
		new ritual_effect(checked_rune.loc)
		sleep(ritual_time)
	return TRUE

/datum/ash_ritual/proc/ritual_fail(obj/effect/ash_rune/failed_rune)
	new ritual_effect(failed_rune.loc)
	failed_rune.balloon_alert_to_viewers("ritual has failed...")
	failed_rune.current_ritual = null
	in_use = FALSE
	return

/datum/ash_ritual/proc/ritual_success(obj/effect/ash_rune/success_rune)
	new ritual_effect(success_rune.loc)
	success_rune.balloon_alert_to_viewers("ritual has been successful...")
	var/turf/rune_turf = get_turf(success_rune)
	if(length(ritual_success_items))
		for(var/type in ritual_success_items)
			new type(rune_turf)
	success_rune.current_ritual = null
	in_use = FALSE
	return TRUE
