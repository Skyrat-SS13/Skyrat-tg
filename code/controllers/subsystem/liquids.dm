SUBSYSTEM_DEF(liquids)
	name = "Liquid Turfs"
	wait = 1 SECONDS
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/list/active_turfs = list()
	var/list/currentrun_active_turfs = list()

	var/list/active_groups = list()

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
	else if (run_type == SSLIQUIDS_RUN_TYPE_GROUPS)
		for(var/g in active_groups)
			var/datum/liquid_group/LG = g
			if(LG.dirty)
				LG.share()
				LG.dirty = FALSE
			else if(!LG.amount_of_active_turfs)
				LG.decay_counter++
				if(LG.decay_counter >= LIQUID_GROUP_DECAY_TIME)
					active_groups -= LG
					LG.break_group()
			if(MC_TICK_CHECK)
				run_type = SSLIQUIDS_RUN_TYPE_TURFS //No currentrun here for now
				return
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

/turf/proc/add_liquid(reagent, amount)
	if(!liquids)
		liquids = new(src)
	liquids.reagents.add_reagent(reagent, amount)
	liquids.calculate_height()
	liquids.set_reagent_color_for_liquid()
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
	var/height = 1
	var/only_big_diffs = 1
	var/turf/my_turf

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
	color = mix_color_from_reagents(reagents.reagent_list)

/obj/effect/abstract/liquid_turf/proc/calculate_height()
	var/new_height = CEILING(reagents.total_volume, 1)/LIQUID_HEIGHT_DIVISOR
	set_height(new_height)

/obj/effect/abstract/liquid_turf/proc/set_height(new_height)
	var/prev_height = height
	height = new_height
	if(height - prev_height > WATER_HEIGH_DIFFERENCE_DELTA_SPLASH)
		//Splash
		var/obj/splashy = new /obj/effect/temp_visual/liquid_splash(get_turf(src))
		splashy.color = color
	update_overlays()

/obj/effect/abstract/liquid_turf/Initialize()
	if(!SSliquids)
		CRASH("Liquid Turf created with the liquids sybsystem not yet initialized!")
	. = ..()
	my_turf = loc
	create_reagents(10000)
	SSliquids.add_active_turf(my_turf)

/obj/effect/abstract/liquid_turf/Destroy(force)
	if(force)
		SSliquids.remove_active_turf(my_turf)
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

/datum/liquid_group/proc/add_to_group(turf/T)
	members[T] = TRUE
	T.lgroup = src
	if(SSliquids.active_turfs[T])
		amount_of_active_turfs++

/datum/liquid_group/New(turf/origin_turf)
	SSliquids.active_groups[src] = TRUE
	color = "#[random_short_color()]"
	expected_turf_height = origin_turf.liquid_height

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

/datum/liquid_group/proc/share(use_liquids_color = FALSE)
	var/datum/reagents/tempr = new(1000000)
	var/any_share = FALSE
	for(var/t in members)
		//var/share_type = members[t]
		var/turf/T = t
		if(T.liquids/* && share_type == LIQUID_MUTUAL_SHARE*/)
			any_share = TRUE
			T.liquids.reagents.trans_to(tempr, T.liquids.reagents.total_volume, no_react = TRUE)
	if(!any_share)
		return
	decay_counter = 0
	
	var/fraction = 1 / members.len
	var/mixed_color = use_liquids_color ? mix_color_from_reagents(tempr.reagent_list) : color
	var/height = CEILING(tempr.total_volume/members.len/LIQUID_HEIGHT_DIVISOR, 1)
	
	//message_admins("shared")
	for(var/t in members)
		var/turf/T = t
		if(!T.liquids)
			T.liquids = new(T)
		var/obj/effect/abstract/liquid_turf/cached_liquids = T.liquids
		tempr.copy_to(cached_liquids.reagents, tempr.total_volume, fraction, no_react = TRUE)
		
		cached_liquids.set_height(height)
		cached_liquids.color = mixed_color
	qdel(tempr)

/datum/liquid_group/proc/process_cell(turf/T)
	for(var/tur in T.GetAtmosAdjacentTurfs())
		var/turf/T2 = tur
		if(T.can_share_liquids_to(T2))
			if(!T2.lgroup)
				add_to_group(T2)
			. = TRUE
			SSliquids.add_active_turf(T2)
	if(.)
		dirty = TRUE
			//return //Do we want it to spread once per process or many times?
	//Make sure to handle up/down z levels on adjacency properly

/turf
	var/datum/liquid_group/lgroup

/turf/proc/can_share_liquids_to(turf/T)
	if(T.z != z) //No Z handling currently
		return FALSE
	if(T.lgroup && T.lgroup != lgroup) //TEMPORARY@!!!!!!!!
		return FALSE
	var/my_liquid_height = liquids ? liquids.height : 0
	var/target_height = T.liquids ? T.liquids.height : 0
	var/difference = abs(target_height - my_liquid_height)
	//The: sand effect or "piling" Very good for performance
	if(difference > 1) //SHOULD BE >= 1 or > 1? '>= 1' can lead into a lot of unnessecary processes, while ' > 1' will lead to a "piling" phenomena
		return TRUE
	return FALSE

/turf/proc/process_liquid_cell()
	if(!lgroup)
		for(var/tur in GetAtmosAdjacentTurfs())
			var/turf/T2 = tur
			if(T2.lgroup && T2.can_share_liquids_to(src))
				T2.lgroup.add_to_group(src)
				break
	if(!liquids)
		SSliquids.remove_active_turf(src)
		return
	if(!lgroup)
		lgroup = new(src)
		lgroup.add_to_group(src)
	var/shared = lgroup.process_cell(src)
	if(!shared)
		SSliquids.remove_active_turf(src)

/***************************************************/
