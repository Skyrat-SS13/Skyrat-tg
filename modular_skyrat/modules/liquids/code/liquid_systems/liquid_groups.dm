/***************************************************/
/********************PROPER GROUPING**************/

//Whenever you add a liquid cell add its contents to the group, have the group hold the reference to total reagents for processing sake
//Have the liquid turfs point to a partial liquids reference in the group for any interactions
//Have the liquid group handle the total reagents datum, and reactions too (apply fraction?)

GLOBAL_VAR_INIT(liquid_debug_colors, FALSE)

///A group of any liquids, helps not make processing a pain in the ass by handling all the turfs as one big group
/datum/liquid_group
	///All the turfs with liquids on them
	var/list/members = list()
	///The color of the liquid group
	var/color
	var/next_share = 0
	var/dirty = TRUE
	var/amount_of_active_turfs = 0
	var/decay_counter = 0
	var/expected_turf_height = 0
	var/cached_color
	var/list/last_cached_fraction_share
	///Last calculated volume of the liquid group, see /datum/liquid_group/proc/share()
	var/last_cached_total_volume = 0
	///Last calculated heat of the liquid group
	var/last_cached_thermal = 0
	var/last_cached_overlay_state = LIQUID_STATE_PUDDLE

/datum/liquid_group/proc/add_to_group(turf/T)
	members[T] = TRUE
	T.lgroup = src
	if(SSliquids.active_turfs[T])
		amount_of_active_turfs++
	if(T.liquids)
		T.liquids.has_cached_share = FALSE

/datum/liquid_group/proc/remove_from_group(turf/T)
	members -= T
	T.lgroup = null
	if(SSliquids.active_turfs[T])
		amount_of_active_turfs--
	if(!members.len)
		qdel(src)

/datum/liquid_group/New(height)
	SSliquids.active_groups[src] = TRUE
	color = "#[random_short_color()]"
	expected_turf_height = height

/datum/liquid_group/proc/can_merge_group(datum/liquid_group/otherg)
	if(expected_turf_height == otherg.expected_turf_height)
		return TRUE
	return FALSE

/datum/liquid_group/proc/merge_group(datum/liquid_group/otherg)
	amount_of_active_turfs += otherg.amount_of_active_turfs
	for(var/turf/liquid_turf as anything in otherg.members)
		liquid_turf.lgroup = src
		members[liquid_turf] = TRUE
		if(liquid_turf.liquids)
			liquid_turf.liquids.has_cached_share = FALSE
	otherg.members = list()
	qdel(otherg)
	share()

/datum/liquid_group/proc/break_group()
	//Flag puddles to the evaporation queue
	for(var/turf/liquid_turf in members)
		if(liquid_turf.liquids?.liquid_state >= LIQUID_STATE_PUDDLE)
			SSliquids.evaporation_queue[liquid_turf] = TRUE

	share(TRUE)
	qdel(src)

/datum/liquid_group/Destroy()
	SSliquids.active_groups -= src
	for(var/turf/liquid_turf as anything in members)
		liquid_turf.lgroup = null
	members = null
	return ..()

/datum/liquid_group/proc/check_adjacency(turf/liquid_turf)
	var/list/recursive_adjacent = list()
	var/list/current_adjacent = list()
	current_adjacent[liquid_turf] = TRUE
	recursive_adjacent[liquid_turf] = TRUE
	var/getting_new_turfs = TRUE
	var/indef_loop_safety = 0
	while(getting_new_turfs && indef_loop_safety < LIQUID_RECURSIVE_LOOP_SAFETY)
		indef_loop_safety++
		getting_new_turfs = FALSE
		var/list/new_adjacent = list()
		for(var/turf/adjacent as anything in current_adjacent)
			for(var/y in adjacent.get_atmos_adjacent_turfs())
				if(!recursive_adjacent[y])
					new_adjacent[y] = TRUE
					recursive_adjacent[y] = TRUE
					getting_new_turfs = TRUE
		current_adjacent = new_adjacent
	//All adjacent, somehow
	if(recursive_adjacent.len == members.len)
		return
	var/datum/liquid_group/new_group = new(expected_turf_height)
	for(var/t in members)
		if(!recursive_adjacent[t])
			remove_from_group(t)
			new_group.add_to_group(t)

/datum/liquid_group/proc/share(use_liquids_color = FALSE)
	var/any_share = FALSE
	var/cached_shares = 0
	var/list/cached_add = list()
	var/cached_volume = 0
	var/cached_thermal = 0

	var/obj/effect/abstract/liquid_turf/cached_liquids
	for(var/turf/liquid_turf as anything in members)
		if(!isnull(liquid_turf.liquids))
			any_share = TRUE
			cached_liquids = liquid_turf.liquids

			if(cached_liquids.has_cached_share && last_cached_fraction_share)
				cached_shares++
				continue

			for(var/r_type in cached_liquids.reagent_list)
				if(!cached_add[r_type])
					cached_add[r_type] = 0
				cached_add[r_type] += cached_liquids.reagent_list[r_type]

			// So, due to reactions these turfs can sometimes become empty,
			// causing issues with divisions by 0
			// This is a very sloppy fix by making them delete if we find that to be a case
			// Whoever wrote this didn't document anything and honestly I barely understand it
			// Feel free to make this better~! - Waterpig

			var/turf_reagents = cached_liquids.total_reagents
			if(turf_reagents == 0) // Deletes empty liquid turfs. This should wipe them from our members too
				qdel(cached_liquids, TRUE)
				continue
			cached_volume += turf_reagents
			cached_thermal += cached_liquids.total_reagents * cached_liquids.temp

	if(!any_share || !cached_volume)
		return

	decay_counter = 0

	if(cached_shares)
		for(var/reagent_type in last_cached_fraction_share)
			if(!cached_add[reagent_type])
				cached_add[reagent_type] = 0
			cached_add[reagent_type] += last_cached_fraction_share[reagent_type] * cached_shares
		cached_volume += last_cached_total_volume * cached_shares
		cached_thermal += cached_shares * last_cached_thermal

	for(var/reagent_type in cached_add)
		cached_add[reagent_type] = cached_add[reagent_type] / members.len
	cached_volume = cached_volume / members.len
	cached_thermal = cached_thermal / members.len
	var/temp_to_set = cached_thermal / cached_volume
	last_cached_thermal = cached_thermal
	last_cached_fraction_share = cached_add
	last_cached_total_volume = cached_volume
	var/mixed_color = use_liquids_color ? mix_color_from_reagent_list(cached_add) : color
	if(use_liquids_color)
		mixed_color = mix_color_from_reagent_list(cached_add)
	else if (GLOB.liquid_debug_colors)
		mixed_color = color
	else
		if(!cached_color)
			cached_color = mix_color_from_reagent_list(cached_add)
		mixed_color = cached_color

	var/height = CEILING(cached_volume/LIQUID_HEIGHT_DIVISOR, 1)

	var/determined_new_state
	var/state_height = height
	if(expected_turf_height > 0)
		state_height += expected_turf_height
	switch(state_height)
		if(0 to LIQUID_ANKLES_LEVEL_HEIGHT-1)
			determined_new_state = LIQUID_STATE_PUDDLE
		if(LIQUID_ANKLES_LEVEL_HEIGHT to LIQUID_WAIST_LEVEL_HEIGHT-1)
			determined_new_state = LIQUID_STATE_ANKLES
		if(LIQUID_WAIST_LEVEL_HEIGHT to LIQUID_SHOULDERS_LEVEL_HEIGHT-1)
			determined_new_state = LIQUID_STATE_WAIST
		if(LIQUID_SHOULDERS_LEVEL_HEIGHT to LIQUID_FULLTILE_LEVEL_HEIGHT-1)
			determined_new_state = LIQUID_STATE_SHOULDERS
		if(LIQUID_FULLTILE_LEVEL_HEIGHT to INFINITY)
			determined_new_state = LIQUID_STATE_FULLTILE

	var/new_liquids = FALSE
	for(var/turf/liquid_turf in members)
		new_liquids = FALSE
		if(!liquid_turf.liquids)
			new_liquids = TRUE
			liquid_turf.liquids = new(liquid_turf)
		cached_liquids = liquid_turf.liquids

		cached_liquids.reagent_list = cached_add.Copy()
		cached_liquids.total_reagents = cached_volume
		cached_liquids.temp = temp_to_set

		cached_liquids.has_cached_share = TRUE
		cached_liquids.attrition = 0

		cached_liquids.color = mixed_color
		cached_liquids.set_height(height)

		if(determined_new_state != cached_liquids.liquid_state)
			cached_liquids.set_new_liquid_state(determined_new_state)

		//Only simulate a turf exposure when we had to create a new liquid tile
		if(new_liquids)
			cached_liquids.ExposeMyTurf()

/datum/liquid_group/proc/process_cell(turf/T)
	if(T.liquids.height <= 1) //Causes a bug when the liquid hangs in the air and is supposed to fall down a level
		return FALSE
	for(var/turf/adjacent as anything in T.get_atmos_adjacent_turfs())
		//Immutable check thing
		if(adjacent.liquids && adjacent.liquids.immutable)
			if(T.z != adjacent.z)
				var/turf/Z_turf_below = GET_TURF_BELOW(T)
				if(adjacent == Z_turf_below)
					qdel(T.liquids, TRUE)
					return
				else
					continue

			//CHECK DIFFERENT TURF HEIGHT THING
			if(T.liquid_height != adjacent.liquid_height)
				var/my_liquid_height = T.liquid_height + T.liquids.height
				var/target_liquid_height = adjacent.liquid_height + adjacent.liquids.height
				if(my_liquid_height > target_liquid_height+2)
					var/coeff = (T.liquids.height / (T.liquids.height + abs(T.liquid_height)))
					var/height_diff = min(0.4,abs((target_liquid_height / my_liquid_height)-1)*coeff)
					T.liquid_fraction_delete(height_diff)
					. = TRUE
				continue

			if(adjacent.liquids.height > T.liquids.height + 1)
				SSliquids.active_immutables[adjacent] = TRUE
				. = TRUE
				continue
		//END OF IMMUTABLE MADNESS

		if(T.z != adjacent.z)
			var/turf/Z_turf_below = GET_TURF_BELOW(T)
			if(adjacent == Z_turf_below)
				if(!(adjacent.liquids && adjacent.liquids.height + adjacent.liquid_height >= LIQUID_HEIGHT_CONSIDER_FULL_TILE))
					T.liquid_fraction_share(adjacent, 1)
					qdel(T.liquids, TRUE)
					. = TRUE
			continue
		//CHECK DIFFERENT TURF HEIGHT THING
		if(T.liquid_height != adjacent.liquid_height)
			var/my_liquid_height = T.liquid_height + T.liquids.height
			var/target_liquid_height = adjacent.liquid_height + (adjacent.liquids ? adjacent.liquids.height : 0)
			if(my_liquid_height > target_liquid_height+1)
				var/coeff = (T.liquids.height / (T.liquids.height + abs(T.liquid_height)))
				var/height_diff = min(0.4,abs((target_liquid_height / my_liquid_height)-1)*coeff)
				T.liquid_fraction_share(adjacent, height_diff)
				. = TRUE
			continue
		//END OF TURF HEIGHT
		if(!T.can_share_liquids_with(adjacent))
			continue
		if(!adjacent.lgroup)
			add_to_group(adjacent)
		//Try merge groups if possible
		else if(adjacent.lgroup != T.lgroup && T.lgroup.can_merge_group(adjacent.lgroup))
			T.lgroup.merge_group(adjacent.lgroup)
		. = TRUE
		SSliquids.add_active_turf(adjacent)
	if(.)
		dirty = TRUE
			//return //Do we want it to spread once per process or many times?
	//Make sure to handle up/down z levels on adjacency properly
