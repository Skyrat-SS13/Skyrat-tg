/turf
	var/datum/liquid_group/lgroup
	var/obj/effect/abstract/liquid_turf/liquids
	var/liquid_height = 0
	var/turf_height = 0

/turf/proc/convert_immutable_liquids()
	if(!liquids || !liquids.immutable)
		return
	var/datum/reagents/tempr = liquids.take_reagents_flat(liquids.total_reagents)
	var/cached_height = liquids.height
	liquids.remove_turf(src)
	liquids = new(src)
	liquids.height = cached_height //Prevent height effects
	add_liquid_from_reagents(tempr)
	qdel(tempr)

/turf/proc/reasses_liquids()
	if(!liquids)
		return
	if(lgroup)
		lgroup.remove_from_group(src)
	SSliquids.add_active_turf(src)

/obj/effect/abstract/liquid_turf/proc/liquid_simple_delete_flat(flat_amount)
	if(flat_amount >= total_reagents)
		qdel(src, TRUE)
		return
	var/fraction = flat_amount/total_reagents
	for(var/reagent_type in reagent_list)
		var/amount = fraction * reagent_list[reagent_type]
		reagent_list[reagent_type] -= amount
		total_reagents -= amount
	has_cached_share = FALSE
	if(!my_turf.lgroup)
		calculate_height()

/turf/proc/liquid_fraction_delete(fraction)
	for(var/r_type in liquids.reagent_list)
		var/volume_change = liquids.reagent_list[r_type] * fraction
		liquids.reagent_list[r_type] -= volume_change
		liquids.total_reagents -= volume_change

/turf/proc/liquid_fraction_share(turf/T, fraction)
	if(!liquids)
		return
	if(fraction > 1)
		CRASH("Fraction share more than 100%")
	for(var/r_type in liquids.reagent_list)
		var/volume_change = liquids.reagent_list[r_type] * fraction
		liquids.reagent_list[r_type] -= volume_change
		liquids.total_reagents -= volume_change
		T.add_liquid(r_type, volume_change, TRUE, liquids.temp)
	liquids.has_cached_share = FALSE

/turf/proc/liquid_update_turf()
	if(liquids && liquids.immutable)
		SSliquids.active_immutables[src] = TRUE
		return
	//Check atmos adjacency to cut off any disconnected groups
	if(lgroup)
		var/assoc_atmos_turfs = list()
		for(var/tur in get_atmos_adjacent_turfs())
			assoc_atmos_turfs[tur] = TRUE
		//Check any cardinals that may have a matching group
		for(var/direction in GLOB.cardinals)
			var/turf/T = get_step(src, direction)
			//Same group of which we do not share atmos adjacency
			if(!assoc_atmos_turfs[T] && T.lgroup && T.lgroup == lgroup)
				T.lgroup.check_adjacency(T)

	SSliquids.add_active_turf(src)

/**
 * Adds liquid to a turf from a given reagents list.
 *
 * Tries to add liquid to an atom's turf location. The atom could also be the turf itself.
 * Calls add_liquid_list() on this turf if it exists.
 *
 * Arguments:
 * * datum/reagents/giver - the reagents to add to the liquid_turf
 * * no_react - whether or not we want to react immediately upon adding the reagents
 * * reagent_multiplier - multiplies the individual reagents' volumes by this value
 * * atom/thrown_from - the atom that the liquid is being thrown from (like a beaker). Null by default.
 * * atom/thrown_target - the atom that the liquid is being thrown at. Null by default.
 *
 */
/atom/proc/add_liquid_from_reagents(datum/reagents/giver, no_react = FALSE, reagent_multiplier = 1, atom/thrown_from = null, atom/thrown_to = null)
	// if we are throwing something, see if we should bounce the liquid off the target atom
	if(thrown_from)
		var/turf/bounced_to = throw_back_liquid(thrown_from)
		if(bounced_to)
			giver.expose(thrown_to, TOUCH) // make sure we expose the hit target, since we aren't directly adding liquid there
			bounced_to.add_liquid_from_reagents(giver, no_react, reagent_multiplier)
			return

	// otherwise business as usual
	var/list/compiled_list = list()
	for(var/r in giver.reagent_list)
		var/datum/reagent/R = r
		compiled_list[R.type] = R.volume * reagent_multiplier
	if(!compiled_list.len) //No reagents to add, don't bother going further
		return

	// is this a turf?
	var/turf/add_location = src
	if(!isturf(add_location))
		add_location = loc

	// still can't find a turf? get out of here
	if(!isturf(add_location))
		return

	add_location.add_liquid_list(compiled_list, no_react, giver.chem_temp)

/**
 * Bounces a thrown liquid off of a some object that has density.
 *
 * Finds an adjacent turf to bounce the liquid to.
 *
 * Arguments:
 * * thrown_by - the mob throwing the atom that is doing the liquid spilling. Required.
 *
 * Returns: the found turf if there was one, null otherwise.
 */
/atom/proc/throw_back_liquid(atom/thrown_from)
	if(!thrown_from || !density)
		return

	// first check the direction the throw came from
	var/found_adjacent_turf = get_open_turf_in_dir(src, get_dir(src, thrown_from.loc))

	if(found_adjacent_turf)
		return found_adjacent_turf

	// there might not be an open turf in that direction (someone stuck in a wall perhaps?) so try to get any adjacent open turf nearby
	var/alternate_adjacent_turfs = get_adjacent_open_turfs(src)
	if(!length(alternate_adjacent_turfs))
		return

	return pick(alternate_adjacent_turfs)

/**
 * Can liquid spills on this atom?
 *
 * Returns: TRUE or FALSE
 */
/atom/proc/can_liquid_spill_on_hit()
	return isturf(src) || (flags_ricochet & RICOCHET_HARD) || !density

//More efficient than add_liquid for multiples
/turf/proc/add_liquid_list(reagent_list, no_react = FALSE, chem_temp = 300)
	if(!liquids)
		liquids = new(src)
	if(liquids.immutable)
		return

	var/prev_total_reagents = liquids.total_reagents
	var/prev_thermal_energy = prev_total_reagents * liquids.temp

	for(var/reagent in reagent_list)
		if(!liquids.reagent_list[reagent])
			liquids.reagent_list[reagent] = 0
		liquids.reagent_list[reagent] += reagent_list[reagent]
		liquids.total_reagents += reagent_list[reagent]

	var/received_thermal_energy = (liquids.total_reagents - prev_total_reagents) * chem_temp
	liquids.temp = (received_thermal_energy + prev_thermal_energy) / liquids.total_reagents

	if(!no_react)
		//We do react so, make a simulation
		create_reagents(10000) //Reagents are on turf level, should they be on liquids instead?
		reagents.add_noreact_reagent_list(liquids.reagent_list)
		reagents.chem_temp = liquids.temp
		if(reagents.handle_reactions())//Any reactions happened, so re-calculate our reagents
			liquids.reagent_list = list()
			liquids.total_reagents = 0
			for(var/r in reagents.reagent_list)
				var/datum/reagent/R = r
				liquids.reagent_list[R.type] = R.volume
				liquids.total_reagents += R.volume

			liquids.temp = reagents.chem_temp
			if(!liquids.total_reagents) //Our reaction exerted all of our reagents, remove self
				qdel(reagents)
				qdel(liquids)
				return
		qdel(reagents)
		//Expose turf
		liquids.ExposeMyTurf()

	liquids.calculate_height()
	liquids.set_reagent_color_for_liquid()
	liquids.has_cached_share = FALSE
	SSliquids.add_active_turf(src)
	if(lgroup)
		lgroup.dirty = TRUE

/turf/proc/add_liquid(reagent, amount, no_react = FALSE, chem_temp = 300)
	if(!liquids)
		liquids = new(src)
	if(liquids.immutable)
		return

	var/prev_thermal_energy = liquids.total_reagents * liquids.temp

	if(!liquids.reagent_list[reagent])
		liquids.reagent_list[reagent] = 0
	liquids.reagent_list[reagent] += amount
	liquids.total_reagents += amount

	liquids.temp = ((amount * chem_temp) + prev_thermal_energy) / liquids.total_reagents

	if(!no_react)
		//We do react so, make a simulation
		create_reagents(10000)
		reagents.add_noreact_reagent_list(liquids.reagent_list)
		if(reagents.handle_reactions())//Any reactions happened, so re-calculate our reagents
			liquids.reagent_list = list()
			liquids.total_reagents = 0
			for(var/r in reagents.reagent_list)
				var/datum/reagent/R = r
				liquids.reagent_list[R.type] = R.volume
				liquids.total_reagents += R.volume
			liquids.temp = reagents.chem_temp
		qdel(reagents)
		//Expose turf
		liquids.ExposeMyTurf()

	liquids.calculate_height()
	liquids.set_reagent_color_for_liquid()
	liquids.has_cached_share = FALSE
	SSliquids.add_active_turf(src)
	if(lgroup)
		lgroup.dirty = TRUE

/turf/proc/can_share_liquids_with(turf/T)
	if(T.z != z) //No Z here handling currently
		return FALSE

	if(T.liquids && T.liquids.immutable)
		return FALSE

	if(istype(T, /turf/open/space)) //No space liquids - Maybe add an ice system later
		return FALSE

	var/my_liquid_height = liquids ? liquids.height : 0
	if(my_liquid_height < 1)
		return FALSE
	var/target_height = T.liquids ? T.liquids.height : 0

	//Varied heights handling:
	if(liquid_height != T.liquid_height)
		if(my_liquid_height+liquid_height < target_height + T.liquid_height + 1)
			return FALSE
		else
			return TRUE

	var/difference = abs(target_height - my_liquid_height)
	//The: sand effect or "piling" Very good for performance
	if(difference > 1) //SHOULD BE >= 1 or > 1? '>= 1' can lead into a lot of unnessecary processes, while ' > 1' will lead to a "piling" phenomena
		return TRUE
	return FALSE

/turf/proc/process_liquid_cell()
	if(!liquids)
		if(!lgroup)
			for(var/tur in get_atmos_adjacent_turfs())
				var/turf/T2 = tur
				if(T2.liquids)
					if(T2.liquids.immutable)
						SSliquids.active_immutables[T2] = TRUE
					else if (T2.can_share_liquids_with(src))
						if(T2.lgroup)
							lgroup = new(liquid_height)
							lgroup.add_to_group(src)
						SSliquids.add_active_turf(T2)
						SSliquids.remove_active_turf(src)
						break
		SSliquids.remove_active_turf(src)
		return
	if(!lgroup)
		lgroup = new(liquid_height)
		lgroup.add_to_group(src)
	var/shared = lgroup.process_cell(src)
	if(QDELETED(liquids)) //Liquids may be deleted in process cell
		SSliquids.remove_active_turf(src)
		return
	if(!shared)
		liquids.attrition++
	if(liquids.attrition >= LIQUID_ATTRITION_TO_STOP_ACTIVITY)
		SSliquids.remove_active_turf(src)

/turf/proc/process_immutable_liquid()
	var/any_share = FALSE
	for(var/tur in get_atmos_adjacent_turfs())
		var/turf/T = tur
		if(can_share_liquids_with(T))
			//Move this elsewhere sometime later?
			if(T.liquids && T.liquids.height > liquids.height)
				continue

			any_share = TRUE
			T.add_liquid_list(liquids.reagent_list, TRUE, liquids.temp)
	if(!any_share)
		SSliquids.active_immutables -= src

/*
*	OPEN TURFS
*/
/turf/open
	/// Pollution stored on this turf
	var/datum/pollution/pollution

//Consider making all of these behaviours a smart component/element? Something that's only applied wherever it needs to be
//Could probably have the variables on the turf level, and the behaviours being activated/deactived on the component level as the vars are updated
/turf/open/CanPass(atom/movable/mover, turf/location)
	if(isliving(mover) && !(mover.movement_type & (FLYING | FLOATING)))
		var/turf/current_turf = get_turf(mover)
		if(current_turf && current_turf.turf_height - turf_height <= -TURF_HEIGHT_BLOCK_THRESHOLD)
			return FALSE
	return ..()

/turf/open/Exit(atom/movable/mover, atom/newloc)
	. = ..()
	if(. && isliving(mover) && mover.has_gravity() && isturf(newloc))
		var/mob/living/moving_mob = mover
		var/turf/new_turf = get_turf(newloc)
		if(new_turf && new_turf.turf_height - turf_height <= -TURF_HEIGHT_BLOCK_THRESHOLD)
			moving_mob.on_fall()
			moving_mob.onZImpact(new_turf, 1)

// Handles climbing up and down between turfs with height differences, as well as manipulating others to do the same.
/turf/open/mouse_drop_receive(mob/living/dropped_mob, mob/living/user, params)
	if(!isliving(dropped_mob) || !isliving(user) || !dropped_mob.has_gravity() || !Adjacent(user) || !dropped_mob.Adjacent(user) || !(user.stat == CONSCIOUS) || user.body_position == LYING_DOWN)
		return
	if(!dropped_mob.has_gravity())
		return
	var/turf/mob_turf = get_turf(dropped_mob)
	if(!mob_turf)
		return
	if(mob_turf.turf_height - turf_height <= -TURF_HEIGHT_BLOCK_THRESHOLD)
		//Climb up
		if(user == dropped_mob)
			user.balloon_alert_to_viewers("climbing...")
		else
			dropped_mob.balloon_alert_to_viewers("being pulled up...")
		if(do_after(user, 2 SECONDS, dropped_mob))
			dropped_mob.forceMove(src)
		return
	if(turf_height - mob_turf.turf_height <= -TURF_HEIGHT_BLOCK_THRESHOLD)
		//Climb down
		if(user == dropped_mob)
			user.balloon_alert_to_viewers("climbing down...")
		else
			dropped_mob.balloon_alert_to_viewers("being lowered...")
		if(do_after(user, 2 SECONDS, dropped_mob))
			dropped_mob.forceMove(src)
		return
