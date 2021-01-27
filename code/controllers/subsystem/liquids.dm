SUBSYSTEM_DEF(liquids)
	name = "Liquid Turfs"
	wait = 1 SECONDS
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/list/active_turfs = list()
	var/list/currentrun_active_turfs = list()


/datum/controller/subsystem/liquids/stat_entry(msg)
	msg += "AT:[active_turfs.len]"
	return ..()


/datum/controller/subsystem/liquids/fire(resumed = FALSE)
	if(!currentrun_active_turfs.len && active_turfs.len)
		currentrun_active_turfs = active_turfs.Copy()
	for(var/tur in currentrun_active_turfs)
		var/turf/T = tur
		T.process_liquid_cell()
		currentrun_active_turfs -= T
		if(MC_TICK_CHECK)
			return

/datum/controller/subsystem/liquids/proc/add_active_turf(turf/T)
	active_turfs[T] = TRUE

/datum/controller/subsystem/liquids/proc/remove_active_turf(turf/T)
	active_turfs -= T

/datum/controller/subsystem/liquids/proc/process_liquid_spread(list/spread_list)
	var/datum/reagents/tempr = new(10000)
	var/any_share = FALSE
	for(var/t in spread_list)
		var/share_type = spread_list[t]
		var/turf/T = t
		if(T.liquids && share_type == LIQUID_MUTUAL_SHARE)
			any_share = TRUE
			T.liquids.reagents.trans_to(tempr, T.liquids.reagents.total_volume*PARTIAL_TRANSFER_AMOUNT, no_react = TRUE)
	if(!any_share)
		return
	/*
	var/fraction = 1 / spread_list.len
	var/mixed_color = mix_color_from_reagents(tempr.reagent_list)
	var/height = CEILING(tempr.total_volume/spread_list.len/5, 1)
	*/
	var/fraction = 1 / spread_list.len
	for(var/t in spread_list)
		var/turf/T = t
		if(!T.liquids)
			T.liquids = new(T)
		var/obj/effect/abstract/liquid_turf/cached_liquids = T.liquids
		tempr.copy_to(cached_liquids.reagents, tempr.total_volume, fraction, no_react = TRUE)
		/*
		cached_liquids.set_height(height)
		cached_liquids.color = mixed_color
		*/
		cached_liquids.calculate_height()
		cached_liquids.color = mix_color_from_reagents(cached_liquids.reagents.reagent_list)

/turf/proc/process_liquid_cell()
	//Try sharing the liquids
	var/any_spread = FALSE
	var/list/share_list = list()
	share_list[src] = LIQUID_MUTUAL_SHARE
	for(var/tur in GetAtmosAdjacentTurfs())
		var/turf/T = tur
		if(T.z != src.z) //No Z handling currently
			continue
		var/my_liquid_height = liquids ? liquids.height : 0
		if(liquid_height + my_liquid_height < T.liquid_height)
			continue
		var/target_height = T.liquid_height + (T.liquids ? T.liquids.height : 0)
		var/difference = abs(target_height - my_liquid_height)
		if(difference > 1) //SHOULD BE >= 1 or > 1? '>= 1' can lead into a lot of unnessecary processes, while ' > 1' will lead to a "piling" phenomena
			//Idea: bundle sharing, height calculations and color calculations togehter, would have to be done up to 2 times due to non mutual shares
			if(liquid_height + my_liquid_height > target_height)
				//spread_liquid_to_turf(T, FALSE)
				share_list[T] = LIQUID_NOT_MUTUAL_SHARE
			else
				//spread_liquid_to_turf(T)
				share_list[T] = LIQUID_MUTUAL_SHARE
			//share_list[T] = LIQUID_MUTUAL_SHARE
			SSliquids.active_turfs[T] = TRUE
			//return //Do we want it to spread once per process or many times?
			any_spread = TRUE
	//Make sure to handle up/down z levels on adjacency properly
	SSliquids.active_turfs -= src //May become active again from adjacency
	SSliquids.process_liquid_spread(share_list)

/turf
	var/obj/effect/abstract/liquid_turf/liquids
	var/liquid_height = 0

/turf/proc/spread_liquid_to_turf(turf/T, mutual = TRUE)
	if(!T.liquids)
		T.liquids = new(T)
	var/obj/effect/abstract/liquid_turf/liquids2 = T.liquids //cache speed
	var/datum/reagents/tempr = new(10000)
	liquids.reagents.trans_to(tempr, liquids.reagents.total_volume, no_react = TRUE)
	if(mutual)
		liquids2.reagents.trans_to(tempr, liquids2.reagents.total_volume, no_react = TRUE)
	tempr.copy_to(liquids.reagents, tempr.total_volume, 0.5, no_react = TRUE)
	tempr.copy_to(liquids2.reagents, tempr.total_volume, 0.5, no_react = TRUE)

	// !!! Catch differences here and do "pressure" movements
	liquids.calculate_height()
	liquids.set_reagent_color_for_liquid()
	liquids2.calculate_height()
	liquids2.set_reagent_color_for_liquid()

/turf/proc/add_liquid(reagent, amount)
	if(!liquids)
		liquids = new(src)
	liquids.reagents.add_reagent(reagent, amount)
	liquids.calculate_height()
	liquids.set_reagent_color_for_liquid()
	SSliquids.active_turfs[src] = TRUE


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
	var/new_height = CEILING(reagents.total_volume, 1)/5
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
	reagents = new(10000)
	SSliquids.active_turfs[my_turf] = TRUE

/obj/effect/abstract/liquid_turf/Destroy(force)
	if(force)
		SSliquids.active_turfs -= my_turf
		my_turf = null
		return ..()
	else
		return QDEL_HINT_LETMELIVE

/obj/effect/temp_visual/liquid_splash
	icon = 'icons/horizon/obj/effects/splash.dmi'
	icon_state = "splash"
	layer = FLY_LAYER
	randomdir = FALSE
