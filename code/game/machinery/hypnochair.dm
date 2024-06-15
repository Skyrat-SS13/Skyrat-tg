/obj/machinery/hypnochair
	name = "enhanced interrogation chamber"
	desc = "A device used to perform \"enhanced interrogation\" through invasive mental conditioning."
	icon = 'icons/obj/machines/implant_chair.dmi'
	icon_state = "hypnochair"
	base_icon_state = "hypnochair"
	circuit = /obj/item/circuitboard/machine/hypnochair
	density = TRUE
	opacity = FALSE
	interaction_flags_mouse_drop = NEED_DEXTERITY

	///Keeps track of the victim to apply effects if it teleports away
	var/mob/living/carbon/victim = null
	///Is the device currently interrogating someone?
	var/interrogating = FALSE
	///Time when the interrogation was started, to calculate effect in case of interruption
	var/start_time = 0
	///Trigger phrase to implant
	var/trigger_phrase = ""
	///Timer ID for interrogations
	var/timerid = 0
	///Cooldown for breakout message
	var/message_cooldown = 0

/obj/machinery/hypnochair/Initialize(mapload)
	. = ..()
	open_machine()
	update_appearance()

/obj/machinery/hypnochair/attackby(obj/item/I, mob/user, params)
	if(!occupant && default_deconstruction_screwdriver(user, icon_state, icon_state, I))
		update_appearance()
		return
	if(default_pry_open(I))
		return
	if(default_deconstruction_crowbar(I))
		return
	return ..()

/obj/machinery/hypnochair/ui_state(mob/user)
	return GLOB.notcontained_state

/obj/machinery/hypnochair/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "HypnoChair", name)
		ui.open()

/obj/machinery/hypnochair/ui_data()
	var/list/data = list()
	var/mob/living/mob_occupant = occupant

	data["occupied"] = mob_occupant ? 1 : 0
	data["open"] = state_open
	data["interrogating"] = interrogating

	data["occupant"] = list()
	if(mob_occupant)
		data["occupant"]["name"] = mob_occupant.name
		data["occupant"]["stat"] = mob_occupant.stat

	data["trigger"] = trigger_phrase

	return data

/obj/machinery/hypnochair/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("door")
			if(state_open)
				close_machine()
			else
				if(!interrogating)
					open_machine()
			. = TRUE
		if("set_phrase")
			set_phrase(params["phrase"])
			. = TRUE
		if("interrogate")
			if(!interrogating)
				interrogate()
			else
				interrupt_interrogation()
			. = TRUE

/obj/machinery/hypnochair/proc/set_phrase(phrase)
	trigger_phrase = phrase

/obj/machinery/hypnochair/proc/interrogate()
	if(!trigger_phrase)
		playsound(get_turf(src), 'sound/machines/buzz-sigh.ogg', 25, TRUE)
		return
	var/mob/living/carbon/C = occupant
	if(!istype(C))
		playsound(get_turf(src), 'sound/machines/buzz-sigh.ogg', 25, TRUE)
		return
	victim = C
	if(C.get_eye_protection() <= 0)
		to_chat(C, span_warning("Strobing coloured lights assault you relentlessly! You're losing your ability to think straight!"))
		C.become_blind(HYPNOCHAIR_TRAIT)
		ADD_TRAIT(C, TRAIT_DEAF, HYPNOCHAIR_TRAIT)
	interrogating = TRUE
	START_PROCESSING(SSobj, src)
	start_time = world.time
	update_appearance()
	timerid = addtimer(CALLBACK(src, PROC_REF(finish_interrogation)), 450, TIMER_STOPPABLE)

/obj/machinery/hypnochair/process(seconds_per_tick)
	var/mob/living/carbon/C = occupant
	if(!istype(C) || C != victim)
		interrupt_interrogation()
		return
	if(SPT_PROB(5, seconds_per_tick) && !(C.get_eye_protection() > 0))
		to_chat(C, "<span class='hypnophrase'>[pick(\
			"...blue... red... green... blue, red, green, blueredgreen[span_small("blueredgreen")]",\
			"...pretty colors...",\
			"...you keep hearing words, but you can't seem to understand them...",\
			"...so peaceful...",\
			"...an annoying buzz in your ears..."\
		)]</span>")

	use_energy(active_power_usage * seconds_per_tick)

/obj/machinery/hypnochair/proc/finish_interrogation()
	interrogating = FALSE
	STOP_PROCESSING(SSobj, src)
	update_appearance()
	var/temp_trigger = trigger_phrase
	trigger_phrase = "" //Erase evidence, in case the subject is able to look at the panel afterwards
	audible_message(span_notice("[src] pings!"))
	playsound(src, 'sound/machines/ping.ogg', 30, TRUE)

	if(QDELETED(victim) || victim != occupant)
		victim = null
		return
	victim.cure_blind(HYPNOCHAIR_TRAIT)
	REMOVE_TRAIT(victim, TRAIT_DEAF, HYPNOCHAIR_TRAIT)
	if(!(victim.get_eye_protection() > 0))
		victim.cure_trauma_type(/datum/brain_trauma/severe/hypnotic_trigger, TRAUMA_RESILIENCE_SURGERY)
		if(prob(90))
			victim.gain_trauma(new /datum/brain_trauma/severe/hypnotic_trigger(temp_trigger), TRAUMA_RESILIENCE_SURGERY)
		else
			victim.gain_trauma(new /datum/brain_trauma/severe/hypnotic_stupor(), TRAUMA_RESILIENCE_SURGERY)
	victim = null

/obj/machinery/hypnochair/proc/interrupt_interrogation()
	deltimer(timerid)
	interrogating = FALSE
	STOP_PROCESSING(SSobj, src)
	update_appearance()

	if(QDELETED(victim))
		victim = null
		return
	victim.cure_blind(HYPNOCHAIR_TRAIT)
	REMOVE_TRAIT(victim, TRAIT_DEAF, HYPNOCHAIR_TRAIT)
	if(!(victim.get_eye_protection() > 0))
		var/time_diff = world.time - start_time
		switch(time_diff)
			if(0 to 100)
				victim.adjust_confusion(10 SECONDS)
				victim.set_dizzy_if_lower(200 SECONDS)
				victim.set_eye_blur_if_lower(10 SECONDS)
			if(101 to 200)
				victim.adjust_confusion(15 SECONDS)
				victim.set_dizzy_if_lower(400 SECONDS)
				victim.set_eye_blur_if_lower(20 SECONDS)
				if(prob(25))
					victim.apply_status_effect(/datum/status_effect/trance, rand(50,150), FALSE)
			if(201 to INFINITY)
				victim.adjust_confusion(20 SECONDS)
				victim.set_dizzy_if_lower(600 SECONDS)
				victim.set_eye_blur_if_lower(30 SECONDS)
				if(prob(65))
					victim.apply_status_effect(/datum/status_effect/trance, rand(50,150), FALSE)
	victim = null

/obj/machinery/hypnochair/update_icon_state()
	icon_state = "[base_icon_state][state_open ? "_open" : null][occupant ? "_[interrogating ? "active" : "occupied"]" : null]"
	return ..()

/obj/machinery/hypnochair/container_resist_act(mob/living/user)
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	user.visible_message(span_notice("You see [user] kicking against the door of [src]!"), \
		span_notice("You lean on the back of [src] and start pushing the door open... (this will take about [DisplayTimeText(600)].)"), \
		span_hear("You hear a metallic creaking from [src]."))
	if(do_after(user,(600), target = src))
		if(!user || user.stat != CONSCIOUS || user.loc != src || state_open)
			return
		user.visible_message(span_warning("[user] successfully broke out of [src]!"), \
			span_notice("You successfully break out of [src]!"))
		open_machine()

/obj/machinery/hypnochair/relaymove(mob/living/user, direction)
	if(message_cooldown <= world.time)
		message_cooldown = world.time + 50
		to_chat(user, span_warning("[src]'s door won't budge!"))


/obj/machinery/hypnochair/mouse_drop_receive(atom/target, mob/user, params)
	if(!isliving(target))
		return
	close_machine(target)
