/// Returns a list of minds of staff in a particular job
/datum/controller/subsystem/job/proc/get_job_staff_records(job_trim)
	if(isnull(job_trim))
		CRASH("get_job_staff_records called without a job argument")

	. = list()
	for(var/datum/record/locked/target in GLOB.manifest.locked)
		if(target.trim == job_trim)
			. += target

/obj/item/circuitboard/machine/export_gate
	name = "Export Gate"
	greyscale_colors = CIRCUIT_COLOR_SUPPLY
	build_path = /obj/machinery/export_gate
	req_components = list(
		/datum/stock_part/scanning_module = 3,
		/datum/stock_part/card_reader = 1,
	)

/obj/item/flatpack/export_gate
	board = /obj/item/circuitboard/machine/export_gate

/obj/item/flatpack/export_gate/Initialize(mapload)
	. = ..()
	var/turf/our_turf = get_turf(src)
	new /obj/item/paper/fluff/export_gate(our_turf)

/obj/item/flatpack/export_gate/multitool_act(mob/living/user, obj/item/tool)
	if(isturf(loc))
		var/turf/location = loc
		if(!locate(/obj/machinery/conveyor) in location)
			balloon_alert(user, "needs conveyor belt!")
			return ITEM_INTERACT_BLOCKING

	return ..()

/datum/supply_pack/service/export_gate
	name = "Bounty Cube Export Gate"
	desc = "Automatically registers bounty cube exports, for the logistics automation nerd in you."
	cost = CARGO_CRATE_VALUE * 2
	contains = list(/obj/item/flatpack/export_gate)
	crate_name = "export gate crate"

/obj/machinery/export_gate
	name = "export gate"
	desc = "Automatically registers bounty cube exports, for the logistics automation nerd in you. Pays out to active cargo techs."
	icon = 'icons/obj/machines/scangate.dmi'
	icon_state = "scangate_black"
	circuit = /obj/item/circuitboard/machine/export_gate
	/// Cooldown on the scanner's beep
	COOLDOWN_DECLARE(scanner_beep)
	/// Cooldown on payout calculation
	COOLDOWN_DECLARE(export_payout)
	/// Internal timer for scanlines
	var/scanline_timer
	/// Bool to check if the scanner's controls are locked by an ID.
	var/locked = FALSE
	/// The holding bank account used for the export gate
	var/datum/bank_account/holding_account
	/// List of crew accounts who split the scanned bounties
	var/list/payment_accounts
	///Our internal radio
	var/obj/item/radio/radio
	///The key our internal radio uses
	var/radio_key = /obj/item/encryptionkey/headset_cargo
	/// The amount of cubes scanned
	var/cubes_registered = 0
	/// The share paid to each cargo tech last cycle
	var/income_share = 0
	/// Total payments sent out last cycle
	var/income_previous = 0
	/// Total payments sent lifetime
	var/income_total = 0

/obj/machinery/export_gate/Initialize(mapload)
	. = ..()
	id_tag = assign_random_name()
	if(name == initial(name))
		name = "[initial(name)] [id_tag]"
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	register_context()
	AddElement(/datum/element/connect_loc, loc_connections)
	holding_account = new(name, player_account = FALSE)
	holding_account.replaceable = FALSE
	radio = new(src)
	radio.keyslot = new radio_key
	radio.set_listening(FALSE)
	radio.recalculateChannels()
	align_to_belt()

	return INITIALIZE_HINT_LATELOAD

/obj/machinery/export_gate/post_machine_initialize()
	. = ..()
	set_scanline("passive")

/obj/machinery/export_gate/proc/align_to_belt()
	if(isturf(loc))
		var/turf/location = loc
		var/obj/machinery/conveyor/my_conveyor = locate(/obj/machinery/conveyor) in location
		if(my_conveyor)
			dir = my_conveyor.dir
			set_scanline("passive")
		else
			clear_scanline()

/obj/machinery/export_gate/Destroy()
	disperse_earnings()
	QDEL_NULL(radio)
	return ..()

/obj/machinery/export_gate/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(held_item?.tool_behaviour == TOOL_WRENCH)
		context[SCREENTIP_CONTEXT_RMB] = "[anchored ? "un" : ""]anchor gate"
		return CONTEXTUAL_SCREENTIP_SET

	if(held_item?.tool_behaviour == TOOL_SCREWDRIVER)
		context[SCREENTIP_CONTEXT_LMB] = "[panel_open ? "close" : "open"] maintenance panel"
		return CONTEXTUAL_SCREENTIP_SET

	if(held_item?.tool_behaviour == TOOL_SCREWDRIVER && panel_open)
		context[SCREENTIP_CONTEXT_LMB] = "deconstruct gate"
		return CONTEXTUAL_SCREENTIP_SET

/obj/machinery/export_gate/proc/on_entered(datum/source, atom/movable/package)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(auto_scan), package)

/obj/machinery/export_gate/examine()
	. = ..()
	. += span_notice("The status display reads:")
	. += span_info("Income last cycle: <b>[income_previous] cr.</b>")
	. += span_info("Share per account last cycle: <b>[income_share] cr.</b>")
	. += span_info("Registered crew accounts last cycle: <b>[LAZYLEN(payment_accounts)]</b>")
	. += span_info("Total cubes registered: <b>[cubes_registered]</b>")
	. += span_info("Total income: <b>[income_total] cr.</b>")

/obj/machinery/export_gate/wrench_act(mob/living/user, obj/item/tool)
	default_unfasten_wrench(user, tool)
	density = !anchored
	if(anchored)
		align_to_belt()
	else
		clear_scanline()

	return ITEM_INTERACT_SUCCESS

/obj/machinery/export_gate/crowbar_act(mob/living/user, obj/item/tool)
	default_deconstruction_crowbar(tool)
	return TRUE

/obj/machinery/export_gate/screwdriver_act(mob/living/user, obj/item/tool)
	return default_deconstruction_screwdriver(user, "[initial(icon_state)]_open", initial(icon_state), tool)

/obj/machinery/export_gate/proc/clear_scanline()
	cut_overlays()
	deltimer(scanline_timer)

/obj/machinery/export_gate/proc/set_scanline(type, duration)
	cut_overlays()
	deltimer(scanline_timer)
	add_overlay(type)
	if(duration)
		scanline_timer = addtimer(CALLBACK(src, PROC_REF(set_scanline), "passive"), duration, TIMER_STOPPABLE)
	if(COOLDOWN_FINISHED(src, scanner_beep) && type != "passive")
		COOLDOWN_START(src, scanner_beep, 0.5 SECONDS)
		playsound(src, type == "alarm" ? 'sound/machines/buzz-sigh.ogg' : 'sound/machines/chime.ogg', 45, TRUE)

/obj/machinery/export_gate/proc/auto_scan(atom/movable/package)
	if(is_operational && istype(package, /obj/item/bounty_cube) && (!panel_open) && anchored)
		perform_scan(package)

/obj/machinery/export_gate/proc/perform_scan(obj/item/package)
	var/obj/item/bounty_cube/cube = package
	if(cube.bounty_handler_account)
		set_scanline("alarm", 1 SECONDS)
		say("Scan rejected. Error 403: Bank account for handling tip already registered!")

	else if(cube.bounty_value)
		set_scanline("scanning", 1 SECONDS)
		process_cube(cube)

	else if(cube.bounty_value == 0)
		set_scanline("alarm", 1 SECONDS)
		say("Scan rejected. Error 404: Bounty value not found!")

	else
		set_scanline("alarm", 1 SECONDS)
		say("Scan rejected. Error 500: Check cube for errors and try again.")

	use_energy(active_power_usage)

/obj/machinery/export_gate/proc/process_cube(obj/item/incoming_cube)
	var/obj/item/bounty_cube/cube = incoming_cube
	var/datum/export_report/cube_contents = export_item_and_contents(cube, dry_run = TRUE)
	var/cube_value = 0
	for(var/exported_datum in cube_contents.total_amount)
		cube_value += cube_contents.total_value[exported_datum]

	cube.AddComponent(/datum/component/pricetag, holding_account, cube.handler_tip, FALSE)
	cube.bounty_handler_account = holding_account
	cubes_registered += 1
	var/message = "Cube value of [cube_value ? "+[floor(cube_value * cube.handler_tip)]+ credits " : ""]successfully registered."
	say(message)
	for(var/datum/bank_account/tech_account as anything in payment_accounts)
		tech_account.bank_card_talk(message)

/obj/machinery/export_gate/proc/refresh_payment_accounts()
	var/list/manifest_accounts = list()
	var/list/cargo_techs = SSjob.get_job_staff_records(JOB_CARGO_TECHNICIAN)
	if(isnull(cargo_techs))
		return

	for(var/datum/record/locked/cargo_tech as anything in cargo_techs)
		var/datum/mind/cargo_mind = cargo_tech.mind_ref.resolve()
		if(isnull(cargo_mind))
			continue

		var/datum/bank_account/tech_account = cargo_mind.current.get_bank_account()
		if(isnull(tech_account))
			continue

		if(tech_account.off_duty_check())
			continue

		LAZYADD(manifest_accounts, tech_account)

	payment_accounts = manifest_accounts

/obj/machinery/export_gate/proc/disperse_earnings()
	if(!COOLDOWN_FINISHED(src, export_payout))
		return

	COOLDOWN_START(src, export_payout, 3 MINUTES)
	refresh_payment_accounts()
	var/total_accounts = LAZYLEN(payment_accounts)

	if(!total_accounts)
		return
	if(holding_account.account_balance < 50)
		radio.talk_into(src, "No export scan income processed this cycle.", RADIO_CHANNEL_SUPPLY)
		return

	income_previous = 0
	income_share = floor(holding_account.account_balance / total_accounts)
	log_econ("[src.name] is dispersing [income_share * total_accounts] credits to associated accounts.")
	radio.talk_into(src, "Dispersing bounty cube export scan income of [income_share * total_accounts] credits to associated accounts.", RADIO_CHANNEL_SUPPLY)
	for(var/datum/bank_account/payout_account as anything in payment_accounts)
		if(payout_account.transfer_money(from = holding_account, amount = income_share, transfer_reason = "Export gate: bounty cube earnings"))
			income_previous += income_share
			income_total += income_share
			payout_account.bank_card_talk("Export gate payment of [income_share] cr. processed, account now holds [payout_account.account_balance] cr.")
		else
			stack_trace("[src.name] attempted to perform a bounty cube export payment to [payout_account.account_holder], but it failed!")

/datum/controller/subsystem/economy/issue_paydays()
	for(var/obj/machinery/export_gate/payout_gate as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/export_gate))
		payout_gate.disperse_earnings()

	return ..()

/obj/machinery/conveyor
	speed = 0.55 // the items move at the same speed as the belt animation. ~aesthetics~

/obj/machinery/conveyor_switch
	conveyor_speed = 0.55 // the items move at the same speed as the belt animation. ~aesthetics~

/datum/bank_account/proc/off_duty_check()
	for(var/obj/item/card/id/registered_card in bank_cards)
		var/datum/component/off_duty_timer/id_component = registered_card.GetComponent(/datum/component/off_duty_timer)
		if(!isnull(id_component))
			return TRUE

	return FALSE

/// Small explanation for engineering on how to set-up the radioactive nebula shielding
/obj/item/paper/fluff/export_gate
	name = "bounty cube export gate"
	default_raw_text = {"Export Gate Setup:<br>
		Set up the export gate on a conveyor belt, and anchor it to start scanning bounty cubes.<br>
		The gate will automatically register bounty cube exports and pay out to active cargo techs, split equally.<br>
		Never manually scan a bounty cube ever again! Get those belts and disposal pipes running.
	"}

/datum/area_spawn/export_gate
	target_areas = list(/area/station/cargo/storage)
	desired_atom = /obj/item/flatpack/export_gate

/datum/area_spawn/export_gate/try_spawn()
	// Turfs that are available
	var/list/available_turfs

	for(var/area_type in target_areas)
		var/area/found_area = GLOB.areas_by_type[area_type]
		if(!found_area)
			continue
		available_turfs = SSarea_spawn.get_turf_candidates(found_area, mode)
		if(LAZYLEN(available_turfs))
			break

	if(!LAZYLEN(available_turfs))
		return

	for(var/i in 1 to amount_to_spawn)
		var/turf/candidate_turf = SSarea_spawn.pick_turf_candidate(available_turfs)
		var/final_desired_atom = desired_atom
		new final_desired_atom(candidate_turf)

/datum/design/board/export_gate
	name = "Export Gate Board"
	desc = "The circuit board for an export gate."
	id = "export_gate"
	build_path = /obj/item/circuitboard/machine/export_gate
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_CARGO
	)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_CARGO

/datum/techweb_node/office_equip/New()
	. = ..()
	design_ids += list(
		"export_gate",
	)
