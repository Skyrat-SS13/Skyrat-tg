/*
	Asteroid cannon console.

	Used to repair the gun.
	How repair works:
		1. Someone presses a button onscreen to start repairs. This triggers an immediate 10 minute long meteor shower and
		starts the regular process tick. During this period, someone is expected to man the gun and shoot down the meteors

		2. Every second or so, the progress increments. If left alone it will take a total of 10 minutes.
			While someone is sitting at the computer, the progress goes 25% faster

		3. Every 30 seconds, a repair action becomes available. This simply requires the appropriate tool to be used on the computer
			Successfully using the right tool will add some progress to repairing. The amount added is based on user skill,
			and tool quality level

			The amount of progress gained for a repair action will be measured as X seconds' worth of normal progress

	Therefore, based on the performance of the repairer, the time taken to fully repair the cannon will generally be between 4-10 minutes
*/
/obj/machinery/computer/asteroidcannon
	name = "Asteroid Defense Mainframe"
	desc = "A console used to control the ship's automated asteroid defense systems."
	//circuit = /obj/item/weapon/circuitboard/asteroidcannon You know what. Gonna say no to this one. It'd be too easy to just decon the ADS console and dispose of the board.
	var/ui_template = "asteroidcannon.tmpl"
	var/obj/structure/asteroidcannon/gun = null

	var/rebooting = FALSE

	//What repair step are we currently operating on?
	var/list/current_repair_step
	var/next_repair_step	//When will the next repair step be enabled
	var/repair_step_interval = 30 SECONDS

	var/progress = 0
	var/progress_per_tick = 1 / ((10 MINUTES) / (MACHINE_PROCESS_INTERVAL))

	/*
		Things that a user can do to help repair the console
		Note that these are not executed in order, they are picked at random and can repeat
	*/
	var/list/repair_steps = list(
	list("text" = "Tighten Magnetic Accelerators", "tool" = QUALITY_BOLT_TURNING),
	list("text" = "Loosen Magnetic Accelerators", "tool" = QUALITY_BOLT_TURNING),
	list("text" = "Reset Flux Alignment Matrix", "tool" = QUALITY_PULSING),
	list("text" = "Recalibrate Targeting Sensors", "tool" = QUALITY_PULSING),
	list("text" = "Cut Earthing Cable", "tool" = QUALITY_WIRE_CUTTING),
	list("text" = "Cut Shorted Wire", "tool" = QUALITY_WIRE_CUTTING),
	list("text" = "Tighten Signal Wire", "tool" = QUALITY_SCREW_DRIVING)
	)

/obj/machinery/computer/asteroidcannon/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	if (!gun)
		to_chat(user,"<span class='warning'>Unable to establish link with the asteroid cannon.</span>")
		return

	var/list/data = get_ui_data()

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if(!ui)
		ui = new(user, src, ui_key, ui_template, "[name]", 470, 450)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(TRUE)

/obj/machinery/computer/asteroidcannon/attack_hand(user as mob)
	if(..(user))
		return
	if(!allowed(user))
		to_chat(user, "<span class='warning'>Access Denied.</span>")
		return TRUE

	ui_interact(user)


/obj/machinery/computer/asteroidcannon/Process()
	if (!rebooting)
		STOP_PROCESSING_MACHINE(src, MACHINERY_PROCESS_SELF)
		return

	var/multiplier = 1
	if (operated())
		multiplier += 0.25

	progress += progress_per_tick * multiplier
	check_progress()


//Returns true if someone is sitting at the computer
/obj/machinery/computer/asteroidcannon/proc/operated()
	var/turf/T = get_step(src, dir)
	for (var/mob/living/carbon/human/H in T)
		if (H.buckled && H.client && !H.stat)
			return TRUE

/obj/machinery/computer/asteroidcannon/proc/check_progress()
	if (progress >= 1)
		finish_reboot()
	else
		if (world.time >= next_repair_step)
			change_repair_action()



/obj/machinery/computer/asteroidcannon/proc/start_reboot()
	if (rebooting)
		return
	rebooting = TRUE
	trigger_event(/datum/event/meteor_wave/ishimura/final)
	START_PROCESSING_MACHINE(src, MACHINERY_PROCESS_SELF)


/obj/machinery/computer/asteroidcannon/proc/finish_reboot()
	gun.finish_repair()
	rebooting = FALSE
	playsound(src, 'sound/effects/compbeep5.ogg', 100, TRUE)


/obj/machinery/computer/asteroidcannon/proc/change_repair_action()
	current_repair_step = pick(repair_steps - current_repair_step)
	next_repair_step = world.time + repair_step_interval
	playsound(src, 'sound/machines/boop1.ogg', 100, TRUE)


/obj/machinery/computer/asteroidcannon/proc/finish_repair_action(var/mob/living/user, var/obj/item/I)

	//Effectiveness is measured in seconds of normal time taken off. Base 10
	var/effectiveness = 3

	//The quality of the tool matters
	var/required_quality = current_repair_step["tool"]
	var/quality = I.get_tool_quality(required_quality)
	var/precision = I.get_tool_precision()	//Precision improves it too. 1 point of precision = 1% bonus
	var/effective_quality = quality * (1 + (precision*0.01))
	effective_quality *= 0.15 //Finally, we use 15% of this total
	effectiveness += effective_quality



	//The user's stats also affect it
	var/stat_modifier = user.get_skill_percentage(SKILL_ELECTRICAL)
	effectiveness *= 1 + (stat_modifier*0.5)	//Up to a 50% bonus at max skill


	//Okay we are done, now lets add progress
	progress += progress_per_tick * effectiveness


	playsound(src, 'sound/machines/boop2.ogg', 100, TRUE)
	current_repair_step = null

	//That might have been enough to finish
	check_progress()

	SSnano.update_uis(src)


/obj/machinery/computer/asteroidcannon/attackby(obj/item/I, mob/living/user)
	if (current_repair_step)
		var/required_quality = current_repair_step["tool"]
		//This is the right kind of tool for the repair step?
		if (I.has_quality(required_quality))
			//Do the use_tool step
			if (!I.use_tool(user = user, target = src, base_time = 8 SECONDS, required_quality = required_quality, fail_chance = FAILCHANCE_NORMAL, required_stat = SKILL_ELECTRICAL))
				return

			//Check this again incase someone else finished it while we were working. Very common scenario
			if (!current_repair_step)
				return

			finish_repair_action(user, I)

/obj/machinery/computer/asteroidcannon/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD



/obj/machinery/computer/asteroidcannon/LateInitialize()
	. = ..()
	gun = GLOB.asteroidcannon
	gun.console = src	//Future TODO: Support multiple cannons and stop using global variables

/obj/machinery/computer/asteroidcannon/proc/get_ui_data()
	var/list/data = list()
	if(current_repair_step)
		data["repair"] = current_repair_step["text"]
	data["progress"] = progress

	//This is needed because java screws up something on the clientside converting the number to text
	//And shows a ton of unnecessary decimal places
	data["progresstext"] = "[round(progress*100, 0.01)]"

	data["canreboot"] = (rebooting == FALSE && !(gun?.is_operational()))
	data["is_operational"] = gun?.is_operational()
	data["cannon_status"] =  data["is_operational"] ? "ONLINE" : "OFFLINE"
	data["reboot_status"] = rebooting ? "REBOOTING...." : "IDLE" //It's set to -1 when it's "busy"
	if (rebooting)
		data["rebooting"] = TRUE
	return data

/obj/machinery/computer/asteroidcannon/OnTopic(user, href_list)
	if(!gun)
		return TOPIC_NOACTION

	if(href_list["reboot"])
		start_reboot()


