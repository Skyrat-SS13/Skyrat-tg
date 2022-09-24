#define STORY_STAGE_PRE_BETRAYAL 1
#define STORY_STAGE_POST_BETRAYAL 2
#define STORY_STAGE_POST_RADAR 3

#define IDEAL_PLAYER_COUNT 4

/datum/away_controller/outbound_expedition
	name = "Away Controller: Outbound Expedition"
	ss_delay = 10 SECONDS
	/// Assoc list of mobs hooked up to the away mission, mob:objective datum
	var/list/participating_mobs = list()
	/// List of systems on the ship, destroyed ones still stay in the list, "Name":reference
	var/list/ship_systems = list()
	/// Reference to the puzzle controller
	var/datum/outbound_puzzle_controller/puzzle_controller
	/// If we've processed the available terminal landmarks before
	var/landmarks_checked = FALSE
	/// List of initialized event datums
	var/list/event_datums = list()
	/// What event are we currently in? Any event will block the shuttle from moving until it's resolved
	var/datum/outbound_random_event/current_event
	/// How many jumps to our destination
	var/jumps_to_dest = 0
	/// Assoc list of machine-to-datum for ship systems
	var/list/machine_datums = list()
	/// Time until the elevator hits the bottom, locking anyone else from entering
	var/elevator_time = 5 MINUTES
	/// Assoc list of initialized objective datums, type:datum
	var/list/objectives = list()
	/// List of mobs who have yet to cryo
	var/list/uncryoed_mobs = list()
	/// Typecache of areas to clear when you move
	var/static/list/area_clear_whitelist = typecacheof(list(/area/awaymission/outbound_expedition, /area/space/outbound_space))
	/// Typecache of areas NOT to clear when you move
	var/static/list/area_clear_blacklist = typecacheof(/area/awaymission/outbound_expedition/shuttle)
	/// Base list of probabilities for events
	var/list/event_chances = list(
		/datum/outbound_random_event/harmless = 1,
		/datum/outbound_random_event/harmful = 5,
		/datum/outbound_random_event/ruin = 3,
	)
	/// Ordered list of events.
	var/list/event_order = list(
		"random",
		"random",
		"random",
		"random",
		"random",
		/datum/outbound_random_event/story/betrayal,
	)
	/// Current story stage. Used for calculating difficulty
	var/current_stage = STORY_STAGE_PRE_BETRAYAL
	/// What extra landmarks to get rid of
	var/static/list/landmark_del_types = list(
		/obj/effect/landmark/outbound/ruin_shuttle_interdictor,
		/obj/effect/landmark/outbound/raider_spawn,
		/obj/effect/landmark/objective_update,
		/obj/effect/landmark/outbound/scrapper_evac_point,
	)

/datum/away_controller/outbound_expedition/New()
	. = ..()
	for(var/ship_sys in subtypesof(/datum/outbound_ship_system))
		var/datum/outbound_ship_system/new_system = new ship_sys
		ship_systems[new_system.name] = new_system
	for(var/type in subtypesof(/datum/outbound_random_event) - list(/datum/outbound_random_event/harmful, /datum/outbound_random_event/harmless, /datum/outbound_random_event/ruin, /datum/outbound_random_event/story)) // all subtypes except the parents
		var/datum/new_type = new type
		event_datums += new_type
	puzzle_controller = new /datum/outbound_puzzle_controller
	for(var/obj/machinery/machine_piece as anything in GLOB.outbound_ship_systems)
		for(var/ship_system in ship_systems)
			var/datum/outbound_ship_system/system_datum = ship_systems[ship_system]
			if(istype(machine_piece, system_datum.machine_type))
				machine_datums[machine_piece] = system_datum
				break
		RegisterSignal(machine_piece, COMSIG_ATOM_TAKE_DAMAGE, .proc/on_sys_damage)
	for(var/objective_type in subtypesof(/datum/outbound_objective))
		var/datum/new_objective = new objective_type
		objectives[objective_type] = new_objective
	RegisterSignal(src, COMSIG_AWAY_CRYOPOD_EXITED, .proc/exited_cryopod)
	RegisterSignal(src, COMSIG_AWAY_CRYOPOD_ENTERED, .proc/entered_cryopod)
	jumps_to_dest = event_order.Find(/datum/outbound_random_event/story/betrayal)

/datum/away_controller/outbound_expedition/Destroy(force, ...)
	for(var/datum/system as anything in ship_systems)
		system = ship_systems[system]
		QDEL_NULL(system)
	if(puzzle_controller)
		QDEL_NULL(puzzle_controller)
	return ..()

/datum/away_controller/outbound_expedition/fire()
	if(!landmarks_checked)
		landmark_check()
	for(var/puzzle in puzzle_controller.puzzles)
		var/datum/outbound_teamwork_puzzle/continuous/cont_puzzle = puzzle_controller.puzzles[puzzle]
		if(!istype(cont_puzzle, /datum/outbound_teamwork_puzzle/continuous))
			continue
		cont_puzzle.puzzle_process()

// Objective procs

/datum/away_controller/outbound_expedition/proc/clear_objective(mob/living/person_cleared)
	person_cleared?.hud_used?.away_dialogue.clear_text()
	var/datum/status_effect/pinpointer = person_cleared.has_status_effect(/datum/status_effect/agent_pinpointer/away_objective)
	qdel(pinpointer)
	participating_mobs[person_cleared] = null

/datum/away_controller/outbound_expedition/proc/objective_pinpoint(mob/living/person_to_point, atom/point_to)
	if(!point_to)
		person_to_point.balloon_alert(person_to_point, "no objective!")
		return
	var/datum/status_effect/agent_pinpointer/away_objective/away_pinpointer = person_to_point.apply_status_effect(/datum/status_effect/agent_pinpointer/away_objective)
	away_pinpointer.scan_target = point_to

/datum/away_controller/outbound_expedition/proc/give_objective(mob/living/person_chosen, datum/outbound_objective/chosen_objective)
	var/datum/status_effect/pinpointer = person_chosen.has_status_effect(/datum/status_effect/agent_pinpointer/away_objective)
	if(pinpointer)
		qdel(pinpointer)
	person_chosen?.hud_used?.away_dialogue.clear_text()

	var/obj/effect/landmark/away_objective/corresponding_landmark = GLOB.outbound_objective_landmarks[chosen_objective.landmark_id]
	if(corresponding_landmark)
		objective_pinpoint(person_chosen, corresponding_landmark)
		corresponding_landmark.enable()
	INVOKE_ASYNC(person_chosen.hud_used?.away_dialogue, /atom/movable/screen/screentip/away_dialogue.proc/set_text_slow, chosen_objective.desc)
	chosen_objective.on_give(person_chosen)
	participating_mobs[person_chosen] = chosen_objective

/datum/away_controller/outbound_expedition/proc/give_objective_all(datum/outbound_objective/chosen_objective)
	for(var/mob/living/person as anything in participating_mobs)
		give_objective(person, chosen_objective)

/datum/away_controller/outbound_expedition/proc/tell_objective(mob/living/target)
	var/datum/outbound_objective/target_objective = participating_mobs[target]
	to_chat(target, span_notice(span_bold("You recall that your most recent objective was: [isnull(target_objective) ? "nothing at all." : target_objective.desc]")))

// Event stuff

/datum/away_controller/outbound_expedition/proc/select_event()
	if(jumps_to_dest == -1)
		event_order += "random"

	if(event_order[1] != "random")
		var/datum/current_event_sel = locate(event_order[1]) in event_datums
		event_order.Cut(1, 2)
		return current_event_sel
	var/list/final_event_prob = list()
	var/calculated_difficulty = calculate_difficulty()
	for(var/event_type in event_chances)
		if(event_type == /datum/outbound_random_event/harmless)
			final_event_prob[event_type] = round(event_chances[event_type] / calculated_difficulty)
		else
			final_event_prob[event_type] = round(event_chances[event_type] * calculated_difficulty)
	var/event_type = pick_weight(final_event_prob)
	var/list/possible_events = event_datums.Copy()
	for(var/datum/event as anything in possible_events)
		if(!istype(event, event_type))
			possible_events.Remove(event)
	var/pos_num = event_order.Find("random")
	if(!is_system_dead("Sensors")) //thrusters shot? You'll only make a jump half the time
		event_order.Cut(pos_num, pos_num + 1)
	else if(prob(50))
		event_order.Cut(pos_num, pos_num + 1)
	return pick(possible_events)

/datum/away_controller/outbound_expedition/proc/calculate_difficulty()
	var/calculated_difficulty = 1
	switch(length(participating_mobs))
		if(1)
			calculated_difficulty = 0.75
		// 2-4 people have a difficulty of 1
		if(5 to INFINITY)
			calculated_difficulty = length(participating_mobs) * 0.25 //maybe make exponential
	switch(current_stage)
		if(STORY_STAGE_POST_BETRAYAL)
			calculated_difficulty *= 1.5
		if(STORY_STAGE_POST_RADAR)
			calculated_difficulty *= 2
	return calculated_difficulty

// Landmark check

/datum/away_controller/outbound_expedition/proc/landmark_check()
	var/list/landmark_list = list()
	for(var/obj/effect/landmark/puzzle_terminal_spawn/terminal in GLOB.landmarks_list)
		landmark_list |= terminal

	for(var/puzzle_name in puzzle_controller.puzzles)
		var/datum/outbound_teamwork_puzzle/puzzle_datum = puzzle_controller.puzzles[puzzle_name]
		var/obj/landmark = pick_n_take(landmark_list)
		var/obj/machinery/outbound_expedition/puzzle_terminal/term = new (get_turf(landmark))
		qdel(landmark)
		term.puzzle_datum = puzzle_datum
		term.tgui_id = puzzle_datum.tgui_name
		term.name = puzzle_datum.terminal_name
		term.desc = puzzle_datum.terminal_desc
		puzzle_datum.terminal = term

	for(var/obj/landmark as anything in landmark_list)
		qdel(landmark)
	landmarks_checked = TRUE

// System code

/datum/away_controller/outbound_expedition/proc/on_sys_damage(datum/source, damage_amount, damage_type, damage_flag, sound_effect, attack_dir, aurmor_penetration)
	SIGNAL_HANDLER
	// code is probably bad and can be improved
	for(var/obj/machinery/ship_system as anything in machine_datums)
		if(!(source == ship_system))
			continue
		var/datum/outbound_ship_system/system_datum = machine_datums[source]
		system_datum.adjust_health(-damage_amount, base_machine = source)
		break

/// A check that takes a system (by name or by reference) and outputs if it is destroyed or not
/datum/away_controller/outbound_expedition/proc/is_system_dead(sys_name_or_type)
	if(isdatum(sys_name_or_type))
		var/datum/outbound_ship_system/typed_system = sys_name_or_type
		if(typed_system.health <= 0)
			return TRUE
		return FALSE
	var/datum/outbound_ship_system/gotten_system = ship_systems[sys_name_or_type]
	if(gotten_system.health <= 0)
		return TRUE
	return FALSE

// """Moving""" the ship

/datum/away_controller/outbound_expedition/proc/move_shuttle(list/affected_areas = area_clear_whitelist)
	if(jumps_to_dest != -1)
		jumps_to_dest--
	var/area/important_space_region = GLOB.areas_by_type[/area/space/outbound_space]
	for(var/affected_area as anything in affected_areas)
		if(is_type_in_typecache(affected_area, area_clear_blacklist))
			continue
		var/area/affected_area_datum = GLOB.areas_by_type[affected_area]
		for(var/turf/to_delete in affected_area_datum)
			var/turf/to_change = to_delete
			to_change.empty(/turf/open/space)
			for(var/obj/effect/landmark/outbound_landmark in to_change.contents)
				if(is_type_in_list(outbound_landmark, landmark_del_types))
					qdel(outbound_landmark)
			important_space_region.contents += to_change
			to_change.transfer_area_lighting(affected_area_datum, important_space_region)

/datum/away_controller/outbound_expedition/proc/tick_elevator_time()
	elevator_time -= 1 SECONDS
	if((elevator_time > 60 SECONDS) && (length(participating_mobs) >= IDEAL_PLAYER_COUNT))
		elevator_time = 60 SECONDS
	if(elevator_time > 1 SECONDS)
		addtimer(CALLBACK(src, .proc/tick_elevator_time), 1 SECONDS)
	else
		var/area/our_area = GLOB.areas_by_type[/area/awaymission/outbound_expedition/dock]
		for(var/obj/machinery/door/poddoor/shutters/indestructible/shutter in our_area)
			addtimer(CALLBACK(shutter, /obj/machinery/door/poddoor/shutters.proc/open), 0 SECONDS)
		for(var/obj/effect/landmark/awaystart/landmark in our_area)
			qdel(landmark)

// Cryopod procs

/datum/away_controller/outbound_expedition/proc/entered_cryopod(datum/source, mob/living/living_mob)
	SIGNAL_HANDLER
	uncryoed_mobs -= living_mob
	if(!length(uncryoed_mobs))
		everyones_gone_to_the_cryopods()

/datum/away_controller/outbound_expedition/proc/exited_cryopod(datum/source, mob/living/living_mob)
	SIGNAL_HANDLER
	if(length(uncryoed_mobs))
		uncryoed_mobs |= living_mob

/datum/away_controller/outbound_expedition/proc/everyones_gone_to_the_cryopods()
	for(var/obj/machinery/outbound_expedition/cryopod/sleepytime as anything in GLOB.outbound_cryopods)
		sleepytime.locked = TRUE
		var/mob/living/carbon/human/human_content = locate(/mob/living/carbon/human) in sleepytime
		if(!human_content)
			continue
		human_content.playsound_local(get_turf(human_content), 'sound/runtime/hyperspace/hyperspace_begin.ogg', 100)
		human_content.overlay_fullscreen("cryopod", /atom/movable/screen/fullscreen/impaired, 2)
		addtimer(CALLBACK(human_content, /mob.proc/playsound_local, get_turf(human_content), 'sound/runtime/hyperspace/hyperspace_progress.ogg', 100), 7.8 SECONDS)

	move_shuttle()
	puzzle_controller.on_jump()
	addtimer(CALLBACK(src, .proc/post_move_act, select_event()), 13 SECONDS)

/datum/away_controller/outbound_expedition/proc/post_move_act(datum/outbound_random_event/picked_event)

	for(var/obj/machinery/outbound_expedition/cryopod/wakeytime as anything in GLOB.outbound_cryopods)
		wakeytime.locked = FALSE
		var/mob/living/carbon/human/human_content = locate(/mob/living/carbon/human) in wakeytime
		human_content?.playsound_local(get_turf(human_content), 'sound/runtime/hyperspace/hyperspace_end.ogg', 100)
		human_content?.clear_fullscreen("cryopod", FALSE)

	addtimer(CALLBACK(src, .proc/cause_event, picked_event), 6 SECONDS)

/datum/away_controller/outbound_expedition/proc/cause_event(datum/outbound_random_event/picked_event)
	//for(var/mob/living/carbon/human/person as anything in participating_mobs)
	//	person.clear_fullscreen("cryopod", FALSE)
	current_event = picked_event
	picked_event.on_select()

// ???

/datum/away_controller/outbound_expedition/proc/spawn_meteor(list/meteortypes = list(/obj/effect/meteor/medium = 5, /obj/effect/meteor/big = 4, /obj/effect/meteor/flaming = 2, /obj/effect/meteor/irradiated = 4))
	var/turf/pickedstart
	var/turf/pickedgoal
	var/max_i = 10 //number of tries to spawn meteor.
	var/list/meteor_spawns = list()
	var/list/ship_turfs = list()
	for(var/obj/effect/landmark/outbound/meteor_start/start in GLOB.landmarks_list)
		meteor_spawns += start
	var/area/ship_area = GLOB.areas_by_type[/area/awaymission/outbound_expedition/shuttle]
	for(var/turf/shuttle_turf in ship_area)
		ship_turfs += shuttle_turf
	while(!isspaceturf(pickedstart) || !isturf(pickedgoal))
		pickedstart = get_turf(pick(meteor_spawns))
		pickedgoal = pick(ship_turfs)
		max_i--
		if(max_i <= 0)
			return
	var/meteor = pick_weight(meteortypes)
	new meteor(pickedstart, pickedgoal)

/datum/away_controller/outbound_expedition/proc/add_mob(mob/living/living_mob)
	participating_mobs |= living_mob
	RegisterSignal(living_mob, COMSIG_PARENT_QDELETING, .proc/remove_mob)
	give_objective(living_mob, objectives[/datum/outbound_objective/talk_person])
	var/datum/action/outbound_objective/remember_obj = new
	remember_obj.Grant(living_mob)
	if(!HAS_TRAIT(living_mob, TRAIT_DNR))
		ADD_TRAIT(living_mob, TRAIT_DNR, src) // leaving for now, might remove idk

/datum/away_controller/outbound_expedition/proc/remove_mob(mob/living/living_mob, force)
	SIGNAL_HANDLER

	participating_mobs -= living_mob
	var/datum/action/found_action = locate(/datum/action/outbound_objective) in living_mob.actions
	if(found_action)
		found_action.Remove(found_action)
	if(HAS_TRAIT_FROM(living_mob, TRAIT_DNR, src))
		REMOVE_TRAIT(living_mob, TRAIT_DNR, src)

#undef STORY_STAGE_PRE_BETRAYAL
#undef STORY_STAGE_POST_BETRAYAL
#undef STORY_STAGE_POST_RADAR

#undef IDEAL_PLAYER_COUNT
