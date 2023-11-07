#define BOOK_OPEN_RANGE 2

/obj/structure/destructible/clockwork/gear_base/technologists_lectern
	name = "technologist's lectern"
	desc = "A small pedestal with a glowing book floating over it.."
	clockwork_desc = "A small pedestal, glowing with a divine energy. Used to research new abilities and objects."
	base_icon_state = "lectern"
	icon_state = "lectern"
	anchored = TRUE
	break_message = "<span class='warning'>The lectern collapses.</span>"
	can_unwrench = FALSE
	max_integrity = 400
	/// If the last process() found a clock cultist in range
	var/mobs_in_range = FALSE
	/// Ref to the effect of the lectern's book
	var/obj/effect/lectern_light/hologram
	/// Ref to the currently selected research
	var/datum/clockwork_research/selected_research
	/// If there is a research ritual already occurring
	var/static/researching = FALSE
	/// If we are the lectern actively doing the researching
	var/primary_researcher = FALSE
	/// The highest tier researched
	var/static/highest_tier_researched = 0
	/// Ref to the research sigil this created
	var/obj/structure/destructible/clockwork/sigil/research/research_sigil
	/// ID of the research timer
	var/research_timer_id



// Base procs
/obj/structure/destructible/clockwork/gear_base/technologists_lectern/Initialize(mapload)
	. = ..()
	if(!length(GLOB.clockwork_research))
		GLOB.clockwork_research = setup_clockwork_research()

	hologram = new(get_turf(src))

	START_PROCESSING(SSobj, src)

	selected_research = locate(/datum/clockwork_research/start) in GLOB.clockwork_research

	set_light(1.5)
	set_light_color(COLOR_THEME_CLOCKWORK)


/obj/structure/destructible/clockwork/gear_base/technologists_lectern/Destroy()
	STOP_PROCESSING(SSobj, src)
	selected_research = null

	if(research_sigil)
		QDEL_NULL(research_sigil)

	if(hologram)
		QDEL_NULL(hologram)

	return ..()


/obj/structure/destructible/clockwork/gear_base/technologists_lectern/deconstruct(disassembled)
	if(primary_researcher)
		deltimer(research_timer_id)
		researching = FALSE
		primary_researcher = FALSE
		log_game("A research ritual of [selected_research] was cancelled by deconstruction of [src].")
		send_clock_message(null, "A research ritual has been disrupted in [get_area(src)]! All research data has been lost.", msg_ghosts = FALSE)
		notify_ghosts("A research ritual was disrupted in [get_area(src)]",
			source = get_turf(src),
			action = NOTIFY_ORBIT,
			notify_flags = NOTIFY_CATEGORY_NOFLASH,
			header = "Research ritual cancelled",
		)

	return ..()


/obj/structure/destructible/clockwork/gear_base/technologists_lectern/examine(mob/user)
	. = ..()
	if(researching && IS_CLOCK(user))
		. += span_brass("The researching of [selected_research.name] will take another [DisplayTimeText(timeleft(research_timer_id))].")


/obj/structure/destructible/clockwork/gear_base/technologists_lectern/process(seconds_per_tick)
	if(researching)
		if(SPT_PROB(5, seconds_per_tick))
			new /obj/effect/temp_visual/steam_release(get_turf(src))

		if(SPT_PROB(2, seconds_per_tick))
			var/text = pick("[src]'s book flips a page as it hums away.", "[src] makes a creaking noise.", "[src] whirrs lightly.", "A faint clank is heard from inside [src].")
			visible_message(span_brass(text))

	var/mob_nearby = FALSE
	for(var/mob/living/person in viewers(BOOK_OPEN_RANGE, get_turf(src)))
		if(IS_CLOCK(person))
			mob_nearby = TRUE
			break

	if(mob_nearby && !mobs_in_range)
		hologram.open()
		mobs_in_range = TRUE

	else if(!mob_nearby && mobs_in_range)
		hologram.close()
		mobs_in_range = FALSE


/obj/structure/destructible/clockwork/gear_base/technologists_lectern/attack_hand(mob/living/user, list/modifiers)
	if(!IS_CLOCK(user))
		return

	if(!anchored)
		balloon_alert(user, "not fastened!")
		return

	ui_interact(user)


// UI code
/obj/structure/destructible/clockwork/gear_base/technologists_lectern/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "ClockworkResearch")
		ui.open()

/obj/structure/destructible/clockwork/gear_base/technologists_lectern/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/research_designs),
	)

/obj/structure/destructible/clockwork/gear_base/technologists_lectern/ui_data(mob/user)
	var/list/data = list()

	data["focused_research"] = list(
		"name" = selected_research.name,
		"desc" = selected_research.desc,
		"lore" = selected_research.lore,
		"researched" = selected_research.researched,
		"starting" = selected_research.starting,
		"can_research" = can_research(selected_research.tier),
		"research_location" = initial(selected_research.selected_area.name),
		"research_designs" = assemble_research_designs(selected_research),
		"research_scriptures" = assemble_research_scriptures(selected_research),
		"type" = selected_research.type,
	)

	data["in_area"] = (istype(get_area(src), selected_research.selected_area))

	return data

/obj/structure/destructible/clockwork/gear_base/technologists_lectern/ui_static_data(mob/user)
	var/list/data = list()

	data["research_tiers"] = list()
	data["starting_research"] = null

	var/highest_tier = 0
	for(var/datum/clockwork_research/research as anything in GLOB.clockwork_research)
		if(research.tier > highest_tier)
			highest_tier = research.tier

		if(research.starting)
			data["starting_research"] = list(
				"name" = research.name,
				"desc" = research.desc,
				"lore" = research.lore,
				"researched" = research.researched,
				"starting" = research.starting,
				"can_research" = TRUE,
				"research_location" = initial(research.selected_area.name),
				"research_designs" = assemble_research_designs(research),
				"research_scriptures" = assemble_research_scriptures(research),
				"type" = research.type,
			)

	for(var/i in 1 to highest_tier)
		data["research_tiers"] += list(list())

	for(var/datum/clockwork_research/research as anything in GLOB.clockwork_research)
		if(research.starting)
			continue

		data["research_tiers"][research.tier] += list(list(
			"name" = research.name,
			"desc" = research.desc,
			"lore" = research.lore,
			"researched" = research.researched,
			"starting" = research.starting,
			"can_research" = can_research(research.tier),
			"research_location" = initial(research.selected_area.name),
			"research_designs" = assemble_research_designs(research),
			"research_scriptures" = assemble_research_scriptures(research),
			"type" = research.type,
		))


	return data


/obj/structure/destructible/clockwork/gear_base/technologists_lectern/ui_act(action, params)
	. = ..()
	if (.)
		return

	switch(action)
		if("select_research")
			var/path = text2path(params["path"])

			if(!ispath(path, /datum/clockwork_research))
				return FALSE

			var/datum/clockwork_research/research_datum = locate(path) in GLOB.clockwork_research
			if(!research_datum || !can_research(research_datum.tier))
				return FALSE

			selected_research = research_datum
			return TRUE

		if("start_research")
			if(!selected_research || !can_research(selected_research.tier))
				return FALSE

			if(!selected_research.check_is_place_good(src))
				return FALSE

			check_room(usr)

			return TRUE

/// Provided a research datum, returns a list of icon states from tinker cache designs for use in the UI
/obj/structure/destructible/clockwork/gear_base/technologists_lectern/proc/assemble_research_designs(datum/clockwork_research/selected_research)
	RETURN_TYPE(/list)

	. = list()

	for(var/datum/tinker_cache_item/type as anything in selected_research.unlocked_recipes)
		var/atom/path = initial(type.item_path)

		. += list(list(
			"name" = initial(path.name),
			"icon" = sanitize_css_class_name(initial(type.research_icon_state) || initial(path.icon_state)),
			"icon2" = sanitize_css_class_name("[initial(type.research_icon) || initial(path.icon)][initial(type.research_icon_state) || initial(path.icon_state)]"),
		))

	return .

/// Provided a research datum, returns a list of icon states from scriptures for use in the UI
/obj/structure/destructible/clockwork/gear_base/technologists_lectern/proc/assemble_research_scriptures(datum/clockwork_research/selected_research)
	RETURN_TYPE(/list)

	. = list()

	for(var/datum/scripture/type as anything in selected_research.unlocked_scriptures)

		. += list(list(
			"name" = initial(type.name),
			"icon" = sanitize_css_class_name(initial(type.button_icon_state)),
			"icon2" = sanitize_css_class_name("modular_skyrat/modules/clock_cult/icons/actions_clock.dmi[initial(type.button_icon_state)]"),
		))

	return .


/// Helper to see if any given tier is researchable
/obj/structure/destructible/clockwork/gear_base/technologists_lectern/proc/can_research(tier)
	return (tier <= (highest_tier_researched + 1))


// Custom procs


/// Check to see if there's enough room to ritual-ize, and invoke the ritual if so
/obj/structure/destructible/clockwork/gear_base/technologists_lectern/proc/check_room(mob/owner)
	var/turf/target_turf = get_turf(src)
	for(var/turf/nearby_turf as anything in RANGE_TURFS(1, target_turf))
		if(istype(nearby_turf, /turf/open/floor))
			continue

		owner.balloon_alert(owner, "not enough room!")
		return

	if(researching)
		owner.balloon_alert(owner, "already researching!")
		return

	INVOKE_ASYNC(src, PROC_REF(begin_research), owner, target_turf)


/// Begin the research after a delay, announcing it and starting everything
/obj/structure/destructible/clockwork/gear_base/technologists_lectern/proc/begin_research(mob/owner, turf/target_turf)
	if(!do_after(owner, 10 SECONDS, src))
		return FALSE

	researching = TRUE
	primary_researcher = TRUE

	AddComponent(/datum/component/brass_spreader, range = 6)

	playsound(target_turf, 'modular_skyrat/modules/clock_cult/sound/machinery/ark_deathrattle.ogg', 80, FALSE, pressure_affected = FALSE)
	research_sigil = new(target_turf)
	send_clock_message(null, "A research ritual has begun in [get_area(src)], ensure nobody stops it until it is completed in [DisplayTimeText(selected_research.time_to_research)]!", msg_ghosts = FALSE)
	notify_ghosts("[owner] has begun a research ritual in [get_area(src)]",
		source = src,
		action = NOTIFY_ORBIT,
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
		header = "Research ritual"
	)
	log_game("[owner] began a research ritual of [selected_research.name] in [get_area(src)].")

	research_timer_id = addtimer(CALLBACK(src, PROC_REF(finish_research), owner), selected_research.time_to_research, TIMER_STOPPABLE)

	sleep(10 SECONDS)

	send_message("You hear the echoing of cogs ")

	addtimer(CALLBACK(src, PROC_REF(send_message), "The echoing of cogs returns, even louder, "), (selected_research.time_to_research / 2), 90)

/// Send a message to everyone on the Z level with directions to the lectern
/obj/structure/destructible/clockwork/gear_base/technologists_lectern/proc/send_message(initial_message = "You hear the echoing of cogs ", volume = 70)
	for(var/mob/living/living_mob as anything in GLOB.mob_living_list)
		if((living_mob.z != z) || IS_CLOCK(living_mob) || !living_mob.can_hear())
			continue


		var/turf/mob_turf = get_turf(living_mob)
		var/dist = get_dist(mob_turf, src)
		var/dir = get_dir(mob_turf, src)
		var/message = initial_message
		switch(dist)
			if (0 to 15)
				message += "very nearby, to your [dir2text(dir)]!"
			if (16 to 31)
				message += "nearby, to your [dir2text(dir)]!"
			if (32 to 127)
				message += "far away, to your [dir2text(dir)]!"
			else
				message += "very far, to your [dir2text(dir)]!"

		living_mob.playsound_local(get_turf(src), 'modular_skyrat/modules/clock_cult/sound/machinery/research_notice.ogg', volume, FALSE, pressure_affected = FALSE)
		to_chat(living_mob, span_brass(message))


/// Called when the research finishes, cleaning up everything and triggering the appropriate effects
/obj/structure/destructible/clockwork/gear_base/technologists_lectern/proc/finish_research(mob/owner)
	if(QDELETED(src) || QDELETED(research_sigil))
		return

	send_clock_message(null, "The research ritual in [get_area(src)] has completed, rejoice!", msg_ghosts = FALSE)
	notify_ghosts("A research ritual in [get_area(src)] has been completed",
		source = src,
		action = NOTIFY_ORBIT,
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
		header = "Research ritual completed",
	)
	log_game("Finished a research ritual of [selected_research.name] in [get_area(src)].")

	researching = FALSE
	primary_researcher = FALSE

	var/datum/component/spreader = GetComponent(/datum/component/brass_spreader)
	if(spreader)
		qdel(spreader)

	selected_research.on_research()

	if(selected_research.tier > highest_tier_researched)
		highest_tier_researched = selected_research.tier

	selected_research = locate(/datum/clockwork_research/start) in GLOB.clockwork_research


	research_sigil.finish_research()

	priority_announce("An outburst of anomalous energy has been detected at [get_area(src)]. Please ensure the safety of any nearby crew.")

	addtimer(CALLBACK(src, PROC_REF(side_effect)), 10 SECONDS)


/// Called after research completes, making one of a few bad things happen to the station
/obj/structure/destructible/clockwork/gear_base/technologists_lectern/proc/side_effect(force_rand)
	var/side_effect_num = force_rand || rand(1, 40)

	switch(side_effect_num)
		if(1 to 10) // Cult-ify everything nearby
			playsound(src, 'modular_skyrat/modules/clock_cult/sound/machinery/ark_scream.ogg', 100, FALSE, pressure_affected = FALSE)
			for(var/atom/nearby_atom in range(8))
				if(istype(nearby_atom, /turf/open/floor))
					var/turf/floor_tile = nearby_atom
					floor_tile.ChangeTurf(/turf/open/floor/bronze)
					new /obj/effect/temp_visual/ratvar/floor(floor_tile)
					new /obj/effect/temp_visual/ratvar/beam(floor_tile)

				else if(istype(nearby_atom, /turf/closed/wall))
					var/turf/wall = nearby_atom
					wall.ChangeTurf(/turf/closed/wall/mineral/bronze)
					new /obj/effect/temp_visual/ratvar/wall(wall)
					new /obj/effect/temp_visual/ratvar/beam(wall)

				else if(istype(nearby_atom, /obj/structure/window))
					new /obj/structure/window/bronze/fulltile(nearby_atom.loc)
					new /obj/effect/temp_visual/ratvar/window(nearby_atom.loc)
					new /obj/effect/temp_visual/ratvar/beam(nearby_atom.loc)
					qdel(nearby_atom)

				else if(istype(nearby_atom, /obj/machinery/door/airlock/glass))
					new /obj/machinery/door/airlock/bronze/clock/glass(nearby_atom.loc)
					new /obj/effect/temp_visual/ratvar/door(nearby_atom.loc)
					new /obj/effect/temp_visual/ratvar/beam(nearby_atom.loc)
					qdel(nearby_atom)

				else if(istype(nearby_atom, /obj/machinery/door/airlock))
					new /obj/machinery/door/airlock/bronze/clock(nearby_atom.loc)
					new /obj/effect/temp_visual/ratvar/door(nearby_atom.loc)
					new /obj/effect/temp_visual/ratvar/beam(nearby_atom.loc)
					qdel(nearby_atom)

		if(11 to 20) // Spawn 4 ai-controlled marauders to fuck shit up
			visible_message(span_warning("A group of clockwork marauders appear, before being obscured by a cloud of smoke!"))

			for(var/direction in list(NORTH, SOUTH, EAST, WEST))
				var/turf/tile = get_step(src, direction)
				new /mob/living/basic/clockwork_marauder(tile)

				var/datum/effect_system/fluid_spread/smoke/smoke_cloud = new
				smoke_cloud.set_up(4, holder = src, location = src)
				smoke_cloud.start()

		if(21 to 30) // Fuck up the power
			priority_announce("A fatal power outage has occurred. Please ensure that all on-board devices are connected to an appropriate power generator.")

			apc_loop:
				for(var/obj/machinery/power/apc/controller as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/apc))
					var/area/apc_area = get_area(controller) // make sure that no "critical" APCs lose their power (SM, namely)
					for(var/turf/turf as anything in apc_area.contained_turfs)
						for(var/obj/machinery/depowered_machinery in turf)
							if(depowered_machinery.critical_machine)
								continue apc_loop

					controller.cell?.charge = 0

			for(var/obj/machinery/power/smes/battery_pack as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/power/smes))
				battery_pack.charge = 0

			GLOB.max_clock_power += 1500 // Extra bonus
			GLOB.clock_power = GLOB.max_clock_power // for stealing the entire station's power

			for(var/mob/living/living_mob as anything in GLOB.mob_living_list)
				if(!is_station_level(living_mob.z))
					continue

				if(IS_CLOCK(living_mob))
					to_chat(living_mob, span_brass("You feel as if something powerful is watching over you, as you feel the power in your Clockwork Slab increase."))
				else
					to_chat(living_mob, span_brass("You feel as if something powerful is watching over you as a low hum of machinery fills your mind."))


		if(31 to 40) // Fuck up the power, but in the other way instead
			priority_announce("An extreme power surge has been detected in on-board APCs. Surge will subside in [rand(3, 8)] minutes.") // Not always accurate, are we?

			force_apc_arcing(TRUE)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(force_apc_arcing), FALSE), 4 MINUTES)


/obj/effect/lectern_light
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_objects.dmi'
	icon_state = "lectern_closed"
	pixel_y = 10
	layer = FLY_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	alpha = 160
	anchored = TRUE

/// Open the book
/obj/effect/lectern_light/proc/open()
	icon_state = "lectern_open"
	flick("lectern_opening", src)

/// Close the book
/obj/effect/lectern_light/proc/close()
	icon_state = "lectern_closed"
	flick("lectern_closing", src)

#undef BOOK_OPEN_RANGE
