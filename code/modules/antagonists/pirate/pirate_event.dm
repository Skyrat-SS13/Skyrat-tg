/datum/round_event_control/pirates
	name = "Space Pirates"
	typepath = /datum/round_event/pirates
	weight = 10
	max_occurrences = 1
	min_players = 20
	dynamic_should_hijack = TRUE
	category = EVENT_CATEGORY_INVASION
	description = "The crew will either pay up, or face a pirate assault."
	admin_setup = /datum/event_admin_setup/pirates

/datum/round_event_control/pirates/preRunEvent()
	if (!SSmapping.empty_space)
		return EVENT_CANT_RUN
	return ..()

/datum/round_event/pirates
	///admin chosen pirate team
	var/datum/pirate_gang/chosen_gang

/datum/round_event/pirates/start()
	send_pirate_threat(chosen_gang)

/proc/send_pirate_threat(datum/pirate_gang/chosen_gang)
	if(!chosen_gang)
		chosen_gang = pick_n_take(GLOB.pirate_gangs)
	//set payoff
	var/payoff = 0
	var/datum/bank_account/account = SSeconomy.get_dep_account(ACCOUNT_CAR)
	if(account)
		payoff = max(PAYOFF_MIN, FLOOR(account.account_balance * 0.80, 1000))
	var/datum/comm_message/threat = chosen_gang.generate_message(payoff)
	//send message
	priority_announce("Incoming subspace communication. Secure channel opened at all communication consoles.", "Incoming Message", SSstation.announcer.get_rand_report_sound())
	threat.answer_callback = CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(pirates_answered), threat, chosen_gang, payoff, world.time)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(spawn_pirates), threat, chosen_gang, FALSE), RESPONSE_MAX_TIME)
	SScommunications.send_message(threat, unique = TRUE)

/proc/pirates_answered(datum/comm_message/threat, datum/pirate_gang/chosen_gang, payoff, initial_send_time)
	if(world.time > initial_send_time + RESPONSE_MAX_TIME)
		priority_announce(chosen_gang.response_too_late ,sender_override = chosen_gang.ship_name)
		return
	if(threat?.answered)
		var/datum/bank_account/plundered_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
		if(plundered_account)
			if(plundered_account.adjust_money(-payoff))
				priority_announce(chosen_gang.response_received, sender_override = chosen_gang.ship_name)
			else
				priority_announce(chosen_gang.response_not_enough, sender_override = chosen_gang.ship_name)
				spawn_pirates(threat, chosen_gang, TRUE)

/proc/spawn_pirates(datum/comm_message/threat, datum/pirate_gang/chosen_gang, skip_answer_check)
	if(!skip_answer_check && threat?.answered == 1)
		return

	var/list/candidates = poll_ghost_candidates("Do you wish to be considered for pirate crew?", ROLE_TRAITOR)
	shuffle_inplace(candidates)

	var/template_key = "pirate_[chosen_gang.ship_template_id]"
	var/datum/map_template/shuttle/pirate/ship = SSmapping.shuttle_templates[template_key]
	var/x = rand(TRANSITIONEDGE,world.maxx - TRANSITIONEDGE - ship.width)
	var/y = rand(TRANSITIONEDGE,world.maxy - TRANSITIONEDGE - ship.height)
	var/z = SSmapping.empty_space.z_value
	var/turf/T = locate(x,y,z)
	if(!T)
		CRASH("Pirate event found no turf to load in")

	if(!ship.load(T))
		CRASH("Loading pirate ship failed!")

	for(var/turf/A in ship.get_affected_turfs(T))
		for(var/obj/effect/mob_spawn/ghost_role/human/pirate/spawner in A)
			if(candidates.len > 0)
				var/mob/our_candidate = candidates[1]
				var/mob/spawned_mob = spawner.create(our_candidate)
				candidates -= our_candidate
				notify_ghosts("The pirate ship has an object of interest: [spawned_mob]!", source = spawned_mob, action = NOTIFY_ORBIT, header="Pirates!")
			else
				notify_ghosts("The pirate ship has an object of interest: [spawner]!", source = spawner, action = NOTIFY_ORBIT, header="Pirate Spawn Here!")

	priority_announce("Unidentified armed ship detected near the station.")

/datum/event_admin_setup/pirates
	///admin chosen pirate team
	var/datum/pirate_gang/chosen_gang

/datum/event_admin_setup/pirates/prompt_admins()

	var/list/gang_choices = list("Random")

	for(var/datum/pirate_gang/possible_gang as anything in GLOB.pirate_gangs)
		gang_choices[possible_gang.name] = possible_gang

	var/chosen = tgui_input_list(usr, "Select pirate gang", "TICKETS TO THE SPONGEBOB MOVIE!!", gang_choices)
	if(!chosen)
		return ADMIN_CANCEL_EVENT
	if(chosen == "Random")
		return //still do the event, but chosen_gang is still null, so it will pick from the choices
	chosen_gang = gang_choices[chosen]

/datum/event_admin_setup/pirates/apply_to_event(datum/round_event/pirates/event)

/obj/machinery/shuttle_scrambler/interact(mob/user)
	if(active)
		dump_loot(user)
		return
	var/scramble_response = tgui_alert(user, "Turning the scrambler on will make the shuttle trackable by GPS. Are you sure you want to do it?", "Scrambler", list("Yes", "Cancel"))
	if(scramble_response != "Yes")
		return
	if(active || !user.canUseTopic(src, be_close = TRUE))
		return
	toggle_on(user)
	update_appearance()
	send_notification()

/obj/machinery/shuttle_scrambler/update_icon_state()
	icon_state = active ? "dominator-Blue" : "dominator"
	return ..()

/obj/machinery/shuttle_scrambler/Destroy()
	toggle_off()
	return ..()

/obj/machinery/computer/shuttle/pirate
	name = "pirate shuttle console"
	shuttleId = "pirate"
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = COLOR_SOFT_RED
	possible_destinations = "pirate_away;pirate_home;pirate_custom"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate
	name = "pirate shuttle navigation computer"
	desc = "Used to designate a precise transit location for the pirate shuttle."
	shuttleId = "pirate"
	lock_override = CAMERA_LOCK_STATION
	shuttlePortId = "pirate_custom"
	x_offset = 9
	y_offset = 0
	see_hidden = FALSE

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/pirate/psyker
	name = "psyker navigation warper"
	desc = "Used to designate a precise transit location for the psyker shuttle, using sent out brainwaves as detailed sight."
	icon_screen = "recharge_comp_on"
	interaction_flags_machine = INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_SET_MACHINE //blind friendly
	x_offset = 0
	y_offset = 11

/obj/docking_port/mobile/pirate
	name = "pirate shuttle"
	shuttle_id = "pirate"
	rechargeTime = 3 MINUTES

/obj/machinery/suit_storage_unit/pirate
	suit_type = /obj/item/clothing/suit/space
	helmet_type = /obj/item/clothing/head/helmet/space
	mask_type = /obj/item/clothing/mask/breath
	storage_type = /obj/item/tank/internals/oxygen

/obj/machinery/loot_locator/interact(mob/user)
	if(world.time <= next_use)
		to_chat(user,span_warning("[src] is recharging."))
		return
	next_use = world.time + cooldown
	var/atom/movable/AM = find_random_loot()
	if(!AM)
		say("No valuables located. Try again later.")
	else
		say("Located: [AM.name] at [get_area_name(AM)]")

/obj/machinery/piratepad/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if (istype(I))
		to_chat(user, span_notice("You register [src] in [I]s buffer."))
		I.buffer = src
		return TRUE

/obj/machinery/piratepad/screwdriver_act_secondary(mob/living/user, obj/item/screwdriver/screw)
	. = ..()
	if(!.)
		return default_deconstruction_screwdriver(user, "lpad-idle-open", "lpad-idle-off", screw)

/obj/machinery/piratepad/crowbar_act_secondary(mob/living/user, obj/item/tool)
	. = ..()
	default_deconstruction_crowbar(tool)
	return TRUE

/obj/machinery/computer/piratepad_control/Initialize(mapload)
	..()
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/computer/piratepad_control/multitool_act(mob/living/user, obj/item/multitool/I)
	. = ..()
	if (istype(I) && istype(I.buffer,/obj/machinery/piratepad))
		to_chat(user, span_notice("You link [src] with [I.buffer] in [I] buffer."))
		pad_ref = WEAKREF(I.buffer)
		return TRUE

/obj/machinery/computer/piratepad_control/LateInitialize()
	. = ..()
	if(cargo_hold_id)
		for(var/obj/machinery/piratepad/P in GLOB.machines)
			if(P.cargo_hold_id == cargo_hold_id)
				pad_ref = WEAKREF(P)
				return
	else
		var/obj/machinery/piratepad/pad = locate() in range(4, src)
		pad_ref = WEAKREF(pad)

/obj/machinery/computer/piratepad_control/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, interface_type, name)
		ui.open()

/obj/machinery/computer/piratepad_control/ui_data(mob/user)
	var/list/data = list()
	data["points"] = points
	data["pad"] = pad_ref?.resolve() ? TRUE : FALSE
	data["sending"] = sending
	data["status_report"] = status_report
	return data

/obj/machinery/computer/piratepad_control/ui_act(action, params)
	. = ..()
	if(.)
		return
	if(!pad_ref?.resolve())
		return

	switch(action)
		if("recalc")
			recalc()
			. = TRUE
		if("send")
			start_sending()
			. = TRUE
		if("stop")
			stop_sending()
			. = TRUE

	status_report = "Predicted value: "
	var/value = 0
	var/datum/export_report/ex = new
	var/obj/machinery/piratepad/pad = pad_ref?.resolve()
	for(var/atom/movable/AM in get_turf(pad))
		if(AM == pad)
			continue
		export_item_and_contents(AM, apply_elastic = FALSE, dry_run = TRUE, external_report = ex)

	for(var/datum/export/E in ex.total_amount)
		status_report += E.total_printout(ex,notes = FALSE)
		status_report += " "
		value += ex.total_value[E]

	if(!value)
		status_report += "0"

/datum/export/pirate/ransom
	cost = 3000
	unit_name = "hostage"
	export_types = list(/mob/living/carbon/human)

/datum/export/pirate/ransom/find_loot()
	var/list/head_minds = SSjob.get_living_heads()
	var/list/head_mobs = list()
	for(var/datum/mind/M as anything in head_minds)
		head_mobs += M.current
	if(head_mobs.len)
		return pick(head_mobs)

/datum/export/pirate/ransom/get_cost(atom/movable/AM)
	var/mob/living/carbon/human/H = AM
	if(H.stat != CONSCIOUS || !H.mind) //mint condition only
		return 0
	else if("pirate" in H.faction) //can't ransom your fellow pirates to CentCom!
		return 0
	else if(H.mind.assigned_role.departments_bitflags & DEPARTMENT_BITFLAG_COMMAND)
		return 3000
	else
		return 1000

/datum/export/pirate/parrot
	cost = 2000
	unit_name = "alive parrot"
	export_types = list(/mob/living/simple_animal/parrot)

/datum/export/pirate/parrot/find_loot()
	for(var/mob/living/simple_animal/parrot/P in GLOB.alive_mob_list)
		var/turf/T = get_turf(P)
		if(T && is_station_level(T.z))
			return P

/datum/export/pirate/cash
	cost = 1
	unit_name = "bills"
	export_types = list(/obj/item/stack/spacecash)

/datum/export/pirate/cash/get_amount(obj/O)
	var/obj/item/stack/spacecash/C = O
	return ..() * C.amount * C.value

/datum/export/pirate/holochip
	cost = 1
	unit_name = "holochip"
	export_types = list(/obj/item/holochip)

/datum/export/pirate/holochip/get_cost(atom/movable/AM)
	var/obj/item/holochip/H = AM
	return H.credits
