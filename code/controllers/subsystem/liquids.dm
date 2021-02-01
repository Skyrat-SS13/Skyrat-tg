SUBSYSTEM_DEF(liquids)
	name = "Liquid Turfs"
	wait = 1 SECONDS
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/list/active_turfs = list()
	var/list/currentrun_active_turfs = list()

	var/list/active_groups = list()

	var/list/active_immutables = list()

	var/run_type = SSLIQUIDS_RUN_TYPE_TURFS


/datum/controller/subsystem/liquids/stat_entry(msg)
	msg += "AT:[active_turfs.len] | AG:[active_groups.len]"
	return ..()


/datum/controller/subsystem/liquids/fire(resumed = FALSE)
	if(run_type == SSLIQUIDS_RUN_TYPE_TURFS)
		if(!currentrun_active_turfs.len && active_turfs.len)
			currentrun_active_turfs = active_turfs.Copy()
		for(var/tur in currentrun_active_turfs)
			if(MC_TICK_CHECK)
				return
			var/turf/T = tur
			T.process_liquid_cell()
			currentrun_active_turfs -= T //work off of index later
		if(!currentrun_active_turfs.len)
			run_type = SSLIQUIDS_RUN_TYPE_GROUPS
	if (run_type == SSLIQUIDS_RUN_TYPE_GROUPS)
		for(var/g in active_groups)
			var/datum/liquid_group/LG = g
			if(LG.dirty)
				LG.share()
				LG.dirty = FALSE
			else if(!LG.amount_of_active_turfs)
				LG.decay_counter++
				if(LG.decay_counter >= LIQUID_GROUP_DECAY_TIME)
					//Perhaps check if any turfs in here can spread before removing it? It's not unlikely they would
					LG.break_group()
			if(MC_TICK_CHECK)
				run_type = SSLIQUIDS_RUN_TYPE_IMMUTABLES //No currentrun here for now
				return
		run_type = SSLIQUIDS_RUN_TYPE_IMMUTABLES
	if(run_type == SSLIQUIDS_RUN_TYPE_IMMUTABLES)
		for(var/t in active_immutables)
			var/turf/T = t
			T.process_immutable_liquid()
		run_type = SSLIQUIDS_RUN_TYPE_TURFS

/datum/controller/subsystem/liquids/proc/add_active_turf(turf/T)
	if(!active_turfs[T])
		active_turfs[T] = TRUE
		if(T.lgroup)
			T.lgroup.amount_of_active_turfs++

/datum/controller/subsystem/liquids/proc/remove_active_turf(turf/T)
	if(active_turfs[T])
		active_turfs -= T
		if(T.lgroup)
			T.lgroup.amount_of_active_turfs--

/turf
	var/obj/effect/abstract/liquid_turf/liquids
	var/liquid_height = 0
	var/turf_height = 0

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
		T.add_liquid(r_type, volume_change, TRUE)
	liquids.has_cached_share = FALSE

/turf/proc/liquid_update_turf()
	if(liquids && liquids.immutable)
		SSliquids.active_immutables[src] = TRUE
		return
	//Check atmos adjacency to cut off any disconnected groups
	if(lgroup)
		var/assoc_atmos_turfs = list()
		for(var/tur in GetAtmosAdjacentTurfs())
			assoc_atmos_turfs[tur] = TRUE
		//Check any cardinals that may have a matching group
		for(var/direction in GLOB.cardinals)
			var/turf/T = get_step(src, direction)
			//Same group of which we do not share atmos adjacency
			if(!assoc_atmos_turfs[T] && T.lgroup && T.lgroup == lgroup)
				T.lgroup.check_adjacency(T)

	SSliquids.add_active_turf(src)

//More efficient than add_liquid for multiples
/turf/proc/add_liquid_list(reagent_list, no_react = FALSE)
	if(!liquids)
		liquids = new(src)
	if(liquids.immutable)
		return

	for(var/reagent in reagent_list)
		if(!liquids.reagent_list[reagent])
			liquids.reagent_list[reagent] = 0
		liquids.reagent_list[reagent] += reagent_list[reagent]
		liquids.total_reagents += reagent_list[reagent]

	if(!no_react)
		//We do react so, make a simulation
		create_reagents(10000) //Reagents are on turf level, should they be on liquids instead?
		reagents.add_reagent_list(liquids.reagent_list, no_react = TRUE)
		if(reagents.handle_reactions())//Any reactions happened, so re-calculate our reagents
			liquids.reagent_list = list()
			liquids.total_reagents = 0
			for(var/r in reagents.reagent_list)
				var/datum/reagent/R = r
				liquids.reagent_list[R.type] = R.volume
				liquids.total_reagents += R.volume

			if(!liquids.total_reagents) //Our reaction exerted all of our reagents, remove self
				qdel(reagents)
				qdel(liquids)
				return
		qdel(reagents)

	liquids.calculate_height()
	liquids.set_reagent_color_for_liquid()
	liquids.has_cached_share = FALSE
	SSliquids.add_active_turf(src)
	if(lgroup)
		lgroup.dirty = TRUE

/turf/proc/add_liquid(reagent, amount, no_react = FALSE)
	if(!liquids)
		liquids = new(src)
	if(liquids.immutable)
		return

	if(!liquids.reagent_list[reagent])
		liquids.reagent_list[reagent] = 0
	liquids.reagent_list[reagent] += amount
	liquids.total_reagents += amount

	if(!no_react)
		//We do react so, make a simulation
		create_reagents(10000)
		reagents.add_reagent_list(liquids.reagent_list, no_react = TRUE)
		if(reagents.handle_reactions())//Any reactions happened, so re-calculate our reagents
			liquids.reagent_list = list()
			liquids.total_reagents = 0
			for(var/r in reagents.reagent_list)
				var/datum/reagent/R = r
				liquids.reagent_list[R.type] = R.volume
				liquids.total_reagents += R.volume
		qdel(reagents)

	liquids.calculate_height()
	liquids.set_reagent_color_for_liquid()
	liquids.has_cached_share = FALSE
	SSliquids.add_active_turf(src)
	if(lgroup)
		lgroup.dirty = TRUE

/obj/effect/abstract/liquid_turf
	name = "liquid"
	icon = 'icons/horizon/obj/effects/liquid.dmi'
	icon_state = "liquid"
	anchored = TRUE
	plane = FLOOR_PLANE
	color = "#DDF"
	//layer = MID_LANDMARK_LAYER
	//invisibility = INVISIBILITY_ABSTRACT
	mouse_opacity = FALSE
	var/height = 1
	var/only_big_diffs = 1
	var/turf/my_turf
	var/liquid_state = LIQUID_STATE_PUDDLE
	var/has_cached_share = FALSE

	var/attrition = 0

	var/immutable = FALSE

	var/list/reagent_list = list()
	var/total_reagents = 0
	var/temp = T20C

/obj/effect/abstract/liquid_turf/proc/set_new_liquid_state(new_state)
	liquid_state = new_state
	cut_overlays()
	switch(liquid_state)
		if(LIQUID_STATE_ANKLES)
			var/mutable_appearance/overlay = mutable_appearance('icons/horizon/obj/effects/liquid_overlays.dmi', "stage1_bottom")
			var/mutable_appearance/underlay = mutable_appearance('icons/horizon/obj/effects/liquid_overlays.dmi', "stage1_top")
			overlay.plane = GAME_PLANE
			overlay.layer = ABOVE_MOB_LAYER
			underlay.plane = GAME_PLANE
			underlay.layer = GATEWAY_UNDERLAY_LAYER
			add_overlay(overlay)
			add_overlay(underlay)
		if(LIQUID_STATE_WAIST)
			var/mutable_appearance/overlay = mutable_appearance('icons/horizon/obj/effects/liquid_overlays.dmi', "stage2_bottom")
			var/mutable_appearance/underlay = mutable_appearance('icons/horizon/obj/effects/liquid_overlays.dmi', "stage2_top")
			overlay.plane = GAME_PLANE
			overlay.layer = ABOVE_MOB_LAYER
			underlay.plane = GAME_PLANE
			underlay.layer = GATEWAY_UNDERLAY_LAYER
			add_overlay(overlay)
			add_overlay(underlay)
		if(LIQUID_STATE_SHOULDERS)
			var/mutable_appearance/overlay = mutable_appearance('icons/horizon/obj/effects/liquid_overlays.dmi', "stage3_bottom")
			var/mutable_appearance/underlay = mutable_appearance('icons/horizon/obj/effects/liquid_overlays.dmi', "stage3_top")
			overlay.plane = GAME_PLANE
			overlay.layer = ABOVE_MOB_LAYER
			underlay.plane = GAME_PLANE
			underlay.layer = GATEWAY_UNDERLAY_LAYER
			add_overlay(overlay)
			add_overlay(underlay)
		if(LIQUID_STATE_FULLTILE)
			var/mutable_appearance/overlay = mutable_appearance('icons/horizon/obj/effects/liquid_overlays.dmi', "stage4_bottom")
			overlay.plane = GAME_PLANE
			overlay.layer = ABOVE_MOB_LAYER
			add_overlay(overlay)


/obj/effect/abstract/liquid_turf/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	SSvis_overlays.add_vis_overlay(src, icon, "shine", layer, plane, add_appearance_flags = RESET_COLOR)
	//cut_overlays()
	//Helper overlay handling
	if(height > 99) //Out of bounds for this lil system
		return
	var/height_text = num2text(height)
	var/len = length(height_text)
	if(len > 1)
		var/pos1 = copytext(height_text,1,2)
		var/pos2 = copytext(height_text,2,3)
		//add_overlay("first[pos1]")
		//add_overlay("second[pos2]")
		SSvis_overlays.add_vis_overlay(src, icon, "first[pos1]", layer, plane, add_appearance_flags = RESET_COLOR)
		SSvis_overlays.add_vis_overlay(src, icon, "second[pos2]", layer, plane, add_appearance_flags = RESET_COLOR)
	else
		//add_overlay("second[height_text]")
		SSvis_overlays.add_vis_overlay(src, icon, "second[height_text]", layer, plane, add_appearance_flags = RESET_COLOR)


/obj/effect/abstract/liquid_turf/proc/set_reagent_color_for_liquid()
	color = mix_color_from_reagent_list(reagent_list)

/obj/effect/abstract/liquid_turf/proc/calculate_height()
	var/new_height = CEILING(total_reagents, 1)/LIQUID_HEIGHT_DIVISOR
	set_height(new_height)
	var/determined_new_state
	switch(height)
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
	if(determined_new_state != liquid_state)
		set_new_liquid_state(determined_new_state)

/obj/effect/abstract/liquid_turf/proc/set_height(new_height)
	var/prev_height = height
	height = new_height
	if(abs(height - prev_height) > WATER_HEIGH_DIFFERENCE_DELTA_SPLASH)
		//Splash
		if(prob(WATER_HEIGH_DIFFERENCE_SOUND_CHANCE))
			playsound(my_turf, PICK_WATER_WADE_NOISES, 60, 0)
		var/obj/splashy = new /obj/effect/temp_visual/liquid_splash(my_turf)
		splashy.color = color
		if(height >= LIQUID_WAIST_LEVEL_HEIGHT)
			//Push things into some direction, like space wind
			var/turf/dest_turf
			var/last_height = height
			for(var/turf in my_turf.atmos_adjacent_turfs)
				var/turf/T = turf
				if(T.z != my_turf.z)
					continue
				if(!T.liquids) //Automatic winner
					dest_turf = T
					break
				if(T.liquids.height < last_height)
					dest_turf = T
					last_height = T.liquids.height
			if(dest_turf)
				var/dir = get_dir(my_turf, dest_turf)
				var/atom/movable/AM
				for(var/thing in my_turf)
					AM = thing
					if(!AM.anchored && !AM.pulledby)
						step(AM, dir)
						if(iscarbon(AM) && prob(60))
							var/mob/living/carbon/C = AM
							if(C.body_position != LYING_DOWN && !(C.shoes && C.shoes.clothing_flags & NOSLIP))
								to_chat(C, "<span class='userdanger'>The current knocks you down!</span>")
								C.Paralyze(60)

	//update_overlays()

/obj/effect/abstract/liquid_turf/proc/movable_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(liquid_state >= LIQUID_STATE_ANKLES)
		if(prob(30))
			playsound(my_turf, PICK_WATER_WADE_NOISES, 50, 0)
		if(iscarbon(AM))
			var/mob/living/carbon/C = AM
			C.apply_status_effect(/datum/status_effect/water_slowdown)
	else if (iscarbon(AM))
		var/mob/living/carbon/C = AM
		if(prob(5) && !(C.movement_type & FLYING))
			C.slip(60, my_turf, NO_SLIP_WHEN_WALKING, 20, TRUE)


/obj/effect/abstract/liquid_turf/proc/mob_fall(datum/source, mob/M)
	SIGNAL_HANDLER
	if(liquid_state >= LIQUID_STATE_ANKLES && my_turf.has_gravity(my_turf))
		playsound(my_turf, 'hrzn/sound/effects/splash.ogg', 50, 0)
		if(iscarbon(M))
			var/mob/living/carbon/C = M
			if(C.wear_mask && C.wear_mask.flags_cover & MASKCOVERSMOUTH)
				to_chat(C, "<span class='userdanger'>You fall in the water!</span>")
			else
				C.adjustOxyLoss(5)
				C.emote("cough")
				to_chat(C, "<span class='userdanger'>You fall in and swallow some water!</span>")
		else
			to_chat(M, "<span class='userdanger'>You fall in the water!</span>")

/obj/effect/abstract/liquid_turf/Initialize()
	if(!SSliquids)
		CRASH("Liquid Turf created with the liquids sybsystem not yet initialized!")
	. = ..()
	my_turf = loc
	RegisterSignal(my_turf, COMSIG_ATOM_ENTERED, .proc/movable_entered)
	RegisterSignal(my_turf, COMSIG_TURF_MOB_FALL, .proc/mob_fall)
	//create_reagents(10000)
	SSvis_overlays.add_vis_overlay(src, icon, "shine", layer, plane, add_appearance_flags = RESET_COLOR)
	if(!immutable)
		SSliquids.add_active_turf(my_turf)

/obj/effect/abstract/liquid_turf/Destroy(force)
	if(force)
		UnregisterSignal(my_turf, list(COMSIG_ATOM_ENTERED, COMSIG_TURF_MOB_FALL))
		if(my_turf.lgroup)
			my_turf.lgroup.remove_from_group(my_turf)
		if(!immutable)
			SSliquids.remove_active_turf(my_turf)
		my_turf.liquids = null
		my_turf = null
		return ..()
	else
		return QDEL_HINT_LETMELIVE

/obj/effect/temp_visual/liquid_splash
	icon = 'icons/horizon/obj/effects/splash.dmi'
	icon_state = "splash"
	layer = FLY_LAYER
	randomdir = FALSE

/***************************************************/
/********************PROPER GROUPING**************/

//Whenever you add a liquid cell add its contents to the group, have the group hold the reference to total reagents for processing sake
//Have the liquid turfs point to a partial liquids reference in the group for any interactions
//Have the liquid group handle the total reagents datum, and reactions too (apply fraction?)

/datum/liquid_group
	var/list/members = list()
	var/list/not_enough_height_sharers = list() //Just make this an association in members. No actually dont - performance
	var/color
	var/next_share = 0
	var/dirty = TRUE
	var/amount_of_active_turfs = 0
	var/decay_counter = 0
	var/expected_turf_height = 0
	var/list/last_cached_fraction_share
	var/last_cached_total_volume = 0
	//Color cache too? For when all "taken" members are cached
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
	for(var/t in otherg.members)
		var/turf/T = t
		T.lgroup = src
		members[T] = TRUE
		if(T.liquids)
			T.liquids.has_cached_share = FALSE
	otherg.members = list()
	qdel(otherg)
	share()

/datum/liquid_group/proc/break_group()
	share(TRUE)
	qdel(src)

/datum/liquid_group/Destroy()
	SSliquids.active_groups -= src
	for(var/t in members)
		var/turf/T = t
		T.lgroup = null
	members = null
	not_enough_height_sharers = null
	return ..()

/datum/liquid_group/proc/check_adjacency(turf/T)
	var/list/recursive_adjacent = list()
	var/list/current_adjacent = list()
	current_adjacent[T] = TRUE
	recursive_adjacent[T] = TRUE
	var/getting_new_turfs = TRUE
	var/indef_loop_safety = 0
	while(getting_new_turfs && indef_loop_safety < LIQUID_RECURSIVE_LOOP_SAFETY)
		indef_loop_safety++
		getting_new_turfs = FALSE
		var/list/new_adjacent = list()
		for(var/t in current_adjacent)
			var/turf/T2 = t
			for(var/y in T2.GetAtmosAdjacentTurfs())
				if(!recursive_adjacent[y])
					new_adjacent[y] = TRUE
					recursive_adjacent[y] = TRUE
					getting_new_turfs = TRUE
		current_adjacent = new_adjacent
	//All adjacent, somehow
	if(recursive_adjacent.len == members.len)
		CRASH("All liquid turfs in a group are adjacent despite being called for adjacent calculation")
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
	//log_game("BEGIN SHARE:.")
	var/turf/T
	for(var/t in members)
		//var/share_type = members[t]
		T = t
		if(T.liquids/* && share_type == LIQUID_MUTUAL_SHARE*/)
			any_share = TRUE

			if(T.liquids.has_cached_share && last_cached_fraction_share)
				cached_shares++
				continue

			//T.liquids.reagents.trans_to(tempr, T.liquids.reagents.total_volume, no_react = TRUE)
			//log_game("LIQUIDS FROM MEMBER:.")
			for(var/r_type in T.liquids.reagent_list)
				if(!cached_add[r_type])
					cached_add[r_type] = 0
				//log_game("[R.type] += [R.volume].")
				cached_add[r_type] += T.liquids.reagent_list[r_type]
			cached_volume += T.liquids.total_reagents
	if(!any_share)
		return
	decay_counter = 0


	if(cached_shares)
		for(var/reagent_type in last_cached_fraction_share)
			if(!cached_add[reagent_type])
				cached_add[reagent_type] = 0
			cached_add[reagent_type] += last_cached_fraction_share[reagent_type] * cached_shares
		cached_volume += last_cached_total_volume * cached_shares

	/*
	log_game("TOTAL REAGENTS:.")
	for(var/reagent_type in cached_add)
		log_game("[reagent_type] = [cached_add[reagent_type]].")
	log_game("FRACTIONED REAGENTS (MEMBERS: [members.len]):.")*/
	for(var/reagent_type in cached_add)
		cached_add[reagent_type] = cached_add[reagent_type] / members.len
	cached_volume = cached_volume / members.len
		//log_game("[reagent_type] = [cached_add[reagent_type]].")
	last_cached_fraction_share = cached_add
	last_cached_total_volume = cached_volume
	//tempr.add_reagent_list(cached_add, no_react = TRUE)
	var/mixed_color = use_liquids_color ? mix_color_from_reagent_list(cached_add) : color
	var/height = CEILING(cached_volume/LIQUID_HEIGHT_DIVISOR, 1)

	var/determined_new_state
	switch(height)
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

	//message_admins("shared")
	var/obj/effect/abstract/liquid_turf/cached_liquids
	for(var/t in members)
		T = t
		if(!T.liquids)
			T.liquids = new(T)
		cached_liquids = T.liquids
		//T.liquids.create_reagents(1000) //Computing nice way to clean the old ones
		//tempr.copy_to(cached_liquids.reagents, tempr.total_volume, no_react = TRUE)
		cached_liquids.reagent_list = cached_add.Copy()
		cached_liquids.total_reagents = cached_volume

		cached_liquids.has_cached_share = TRUE
		cached_liquids.attrition = 0

		cached_liquids.color = mixed_color
		cached_liquids.set_height(height)

		if(determined_new_state != cached_liquids.liquid_state)
			cached_liquids.set_new_liquid_state(determined_new_state)

/datum/liquid_group/proc/process_cell(turf/T)
	if(T.liquids.height <= 1) //Causes a bug when the liquid hangs in the air and is supposed to fall down a level
		return FALSE
	for(var/tur in T.GetAtmosAdjacentTurfs())
		var/turf/T2 = tur
		//Immutable check thing
		if(T2.liquids && T2.liquids.immutable)
			if(T.z != T2.z)
				var/turf/Z_turf_below = SSmapping.get_turf_below(T)
				if(T2 == Z_turf_below)
					qdel(T.liquids, TRUE)
					return
				else
					continue

			//CHECK DIFFERENT TURF HEIGHT THING
			if(T.liquid_height != T2.liquid_height)
				var/my_liquid_height = T.liquid_height + T.liquids.height
				var/target_liquid_height = T2.liquid_height + T2.liquids.height
				if(my_liquid_height > target_liquid_height+2)
					var/coeff = (T.liquids.height / (T.liquids.height + abs(T.liquid_height)))
					var/height_diff = min(0.4,abs((target_liquid_height / my_liquid_height)-1)*coeff)
					T.liquid_fraction_delete(height_diff)
					. = TRUE
				continue

			if(T2.liquids.height > T.liquids.height + 1)
				SSliquids.active_immutables[T2] = TRUE
				. = TRUE
				continue
		//END OF IMMUTABLE MADNESS

		if(T.z != T2.z)
			var/turf/Z_turf_below = SSmapping.get_turf_below(T)
			if(T2 == Z_turf_below)
				if(!(T2.liquids && T2.liquids.height >= LIQUID_HEIGHT_CONSIDER_FULL_TILE))
					T.liquid_fraction_share(T2, 1)
					qdel(T.liquids, TRUE)
					. = TRUE
			continue
		//CHECK DIFFERENT TURF HEIGHT THING
		if(T.liquid_height != T2.liquid_height)
			var/my_liquid_height = T.liquid_height + T.liquids.height
			var/target_liquid_height = T2.liquid_height + (T2.liquids ? T2.liquids.height : 0)
			if(my_liquid_height > target_liquid_height+1)
				var/coeff = (T.liquids.height / (T.liquids.height + abs(T.liquid_height)))
				var/height_diff = min(0.4,abs((target_liquid_height / my_liquid_height)-1)*coeff)
				T.liquid_fraction_share(T2, height_diff)
				. = TRUE
			continue
		//END OF TURF HEIGHT
		if(!T.can_share_liquids_with(T2))
			continue
		if(!T2.lgroup)
			add_to_group(T2)
		//Try merge groups if possible
		else if(T2.lgroup != T.lgroup && T.lgroup.can_merge_group(T2.lgroup))
			T.lgroup.merge_group(T2.lgroup)
		. = TRUE
		SSliquids.add_active_turf(T2)
	if(.)
		dirty = TRUE
			//return //Do we want it to spread once per process or many times?
	//Make sure to handle up/down z levels on adjacency properly

/turf
	var/datum/liquid_group/lgroup

/turf/proc/can_share_liquids_with(turf/T)
	if(T.z != z) //No Z here handling currently
		return FALSE
	/*
	if(T.lgroup && T.lgroup != lgroup) //TEMPORARY@!!!!!!!!
		return FALSE
	*/
	if(T.liquids && T.liquids.immutable)
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
			for(var/tur in GetAtmosAdjacentTurfs())
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

/***************************************************/

/obj/effect/abstract/liquid_turf/immutable
	immutable = TRUE
	var/list/starting_mixture = list(/datum/reagent/water = 600)
	var/starting_temp = T20C

/obj/effect/abstract/liquid_turf/immutable/coldocean
	starting_temp = T20C-170

/obj/effect/abstract/liquid_turf/immutable/Initialize()
	..()
	reagent_list = starting_mixture.Copy()
	total_reagents = 0
	for(var/key in reagent_list)
		total_reagents += reagent_list[key]
	temp = starting_temp
	calculate_height()
	set_reagent_color_for_liquid()
	SSliquids.active_immutables[my_turf] = TRUE

/obj/effect/abstract/liquid_turf/immutable/Destroy(force)
	if(force)
		SSliquids.active_immutables -= my_turf
	. = ..()

/turf/proc/process_immutable_liquid()
	var/any_share = FALSE
	for(var/tur in GetAtmosAdjacentTurfs())
		var/turf/T = tur
		if(can_share_liquids_with(T))
			//Move this elsewhere sometime later?
			if(T.liquids && T.liquids.height > liquids.height)
				continue

			any_share = TRUE
			T.add_liquid_list(liquids.reagent_list, TRUE)
	if(!any_share)
		SSliquids.active_immutables -= src

/turf/open/openspace/ocean
	name = "ocean"

/turf/open/openspace/ocean/Initialize()
	. = ..()
	if(liquids)
		qdel(liquids, TRUE)
	liquids = new /obj/effect/abstract/liquid_turf/immutable/coldocean(src)

/turf/open/floor/plating/ocean
	gender = PLURAL
	name = "ocean sand"
	baseturfs = /turf/open/floor/plating/ocean
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/ocean/Initialize()
	. = ..()
	if(liquids)
		qdel(liquids, TRUE)
	liquids = new /obj/effect/abstract/liquid_turf/immutable/coldocean(src)

/turf/open/floor/plasteel/ocean

/turf/open/floor/plasteel/ocean/Initialize()
	. = ..()
	if(liquids)
		qdel(liquids, TRUE)
	liquids = new /obj/effect/abstract/liquid_turf/immutable/coldocean(src)

//extremely low chance of rare ores, meant mostly for populating stations with large amounts of asteroid
/turf/closed/mineral/random/stationside
	icon_state = "rock_nochance"
	mineralChance = 4
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 1, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 3, /obj/item/stack/ore/titanium = 5,
		/obj/item/stack/ore/silver = 4, /obj/item/stack/ore/plasma = 3, /obj/item/stack/ore/iron = 50)

/turf/closed/mineral/random/stationside/ocean
	baseturfs = /turf/open/floor/plating/ocean

/obj/effect/abstract/liquid_turf/immutable/canal
	starting_mixture = list(/datum/reagent/water = 100)

/turf/open/floor/plating/canal
	gender = PLURAL
	name = "canal"
	baseturfs = /turf/open/floor/plating/canal
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	liquid_height = -30
	turf_height = -30

/turf/open/floor/plating/canal/Initialize()
	. = ..()
	if(liquids)
		qdel(liquids, TRUE)
	liquids = new /obj/effect/abstract/liquid_turf/immutable/canal(src)

/turf/open/floor/plating/canal_mutable
	gender = PLURAL
	name = "canal"
	baseturfs = /turf/open/floor/plating/canal_mutable
	icon = 'icons/turf/floors.dmi'
	icon_state = "asteroid"
	base_icon_state = "asteroid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	liquid_height = -30
	turf_height = -30

/datum/status_effect/water_slowdown
	id = "waterslowdown"
	alert_type = null
	duration = -1

/datum/status_effect/water_slowdown/on_apply()
	//We should be inside a liquid turf if this is applied
	calculate_water_slow()
	return TRUE

/datum/status_effect/water_slowdown/proc/calculate_water_slow()
	//Factor in swimming skill here?
	var/turf/T = get_turf(owner)
	var/slowdown_amount = T.liquids.liquid_state * 0.5
	owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/status_effect/water_slowdown, multiplicative_slowdown = slowdown_amount)

/datum/status_effect/water_slowdown/tick()
	var/turf/T = get_turf(owner)
	if(!T || !T.liquids || T.liquids.liquid_state == LIQUID_STATE_PUDDLE)
		qdel(src)
		return
	calculate_water_slow()
	return ..()

/datum/status_effect/water_slowdown/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/status_effect/water_slowdown)

/datum/movespeed_modifier/status_effect/water_slowdown
	variable = TRUE
	blacklisted_movetypes = (FLYING|FLOATING)
