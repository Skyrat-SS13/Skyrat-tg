#define COMSIG_SHOCK_UPDATE "shock_update"
/mob/living/carbon

	var/shock_stage
	var/flow_rate = BASE_FLOW_RATE
	var/injuries
	Initialize(mapload)
		. = ..()
		RegisterSignal(src, COMSIG_SHOCK_UPDATE, .proc/shock_helper)
	proc/flow_control()
		SIGNAL_HANDLER
		injuries = calc_injuries()
//		var/pain_score = injuries + length(all_wounds) // old, backup and sketchy
		calc_pain()
		if(stat == DEAD)	flow_rate = 0
		else	flow_rate = clamp(rand(BASE_FLOW_RATE, BASE_FLOW_RATE_UPPER) + calc_pain(), 0, FLOW_RATE_ARREST)
		shock_helper(flow_rate)

	proc/calc_pain()
		var/pain_score = 1
		for(var/i in all_wounds)
			var/datum/wound/iterwound = i
			if(iterwound.severity == WOUND_SEVERITY_SEVERE || WOUND_SEVERITY_CRITICAL || WOUND_SEVERITY_LOSS)
				pain_score += SHOCK_STAGE_MODERATE
			if(iterwound.severity == WOUND_SEVERITY_MODERATE || WOUND_SEVERITY_TRIVIAL)
				pain_score += SHOCK_STAGE_MINOR

		pain_score += getBruteLoss() + getFireLoss() + getToxLoss() + getOxyLoss() + (getStaminaLoss()) / 6
		return pain_score

	proc/calc_injuries()
		var/injuries
		for(var/i in all_wounds)
			injuries++
		return injuries
	proc/shock_helper(flow_rate)
		var/list/close2death = list("a human", "a moth", "a felinid", "a lizard", "a particularly resilient slime", "a syndicate agent", "a clown", "a mime", "a mortal foe", "an innocent bystander")

		SIGNAL_HANDLER
		if(HAS_TRAIT(src, TRAIT_KNOCKEDOUT) && stat != DEAD)
			set_stat(UNCONSCIOUS)
		switch(flow_rate)
			if(FLOW_RATE_ARREST)
				if(stat != HARD_CRIT && !HAS_TRAIT(src, TRAIT_NOSOFTCRIT))
					set_stat(SOFT_CRIT)
					to_chat(src, span_unconscious(pick("As your dying body begins to shut down...", "... you see [pick(close2death)]...")))
				if(health <= hardcrit_threshold && !HAS_TRAIT(src, TRAIT_NOHARDCRIT))
					set_stat(HARD_CRIT)
					to_chat(src, span_unconscious(pick("Where am I?", "What's going on?")))
				if(health <= HEALTH_THRESHOLD_DEAD && !HAS_TRAIT(src, TRAIT_NODEATH))
					to_chat(src, span_unconscious("Death..."))
					death()
					set_stat(DEAD)

			if(180 to 299)
				to_chat(src, span_redtext("Please! End the pain!"))
				set_stat(CONSCIOUS)
			if(120 to 14)
				to_chat(src, "I could use some painkillers right about now...")
				set_stat(CONSCIOUS)
			if(140 to 160)
				to_chat(src, span_redtext("It hurts so much!"))
				set_stat(CONSCIOUS)
			if(160 to 180)
				to_chat(src, span_redtext("Make the pain stop!"))
				set_stat(CONSCIOUS)

	updatehealth()
		. = ..()
		shock_helper()
		flow_control()
	update_health_hud(shown_health_amount)
		. = ..()
		if(!client || !hud_used)
			return
		var/atom/movable/screen/healths/pulse = hud_used.healths
		pulse.maptext = MAPTEXT(flow_rate)
		if(hud_used.healths) // MOVED TO MODULAR
			. = 1
			if(shown_health_amount == null)
				shown_health_amount = health
			switch(flow_rate)
				if(60 to 90)
					hud_used.healths.icon_state = "health1"
				if(90 to 110)
					hud_used.healths.icon_state = "health2"
				if(110 to 130)
					hud_used.healths.icon_state = "health3"
				if(130 to 160)
					hud_used.healths.icon_state = "health4"
				if(160 to 190)
					hud_used.healths.icon_state = "health5"
				if(190 to 299 || stat != SOFT_CRIT || stat != HARD_CRIT)
					hud_used.healths.icon_state = "health5"
				if(0 to 60, 300 || stat == SOFT_CRIT || stat == HARD_CRIT)
					hud_used.healths.icon_state = "health6"
				if(0)
					hud_used.healths.icon_state = "health7"
/mob/living/carbon/update_damage_hud()
	. = ..()
	if(flow_rate)
		var/severity = 0
		switch(flow_rate)
			if(100 to 120)
				severity = 1
			if(120 to 140)
				severity = 2
			if(140 to 160)
				severity = 3
			if(160 to 180)
				severity = 4
			if(180 to 240)
				severity = 5
			if(240 to INFINITY)
				severity = 6
		overlay_fullscreen("brute", /atom/movable/screen/fullscreen/brute, severity)
	else
		clear_fullscreen("brute")
/obj/structure/table/optable
	var/beepvalid
/obj/structure/table/optable/set_patient(mob/living/carbon/patient)
	if(patient)
		addtimer(CALLBACK(src, .proc/ekg, patient), 2 SECONDS)
/obj/structure/table/optable/patient_deleted(datum/source)
	patient = null
/obj/structure/table/optable/proc/ekg(mob/living/carbon/patient)

	if(!beepvalid || !patient)
		return
	switch(patient.flow_rate)
		if(0 to 60)
			playsound(src, 'modular_skyrat/sound/effects/flatline.ogg', 20)
		if(60 to 90)
			playsound(src, 'modular_skyrat/sound/effects/quiet_beep.ogg', 40)
		if(90 to 130)
			playsound(src, 'modular_skyrat/sound/effects/quiet_double_beep.ogg', 40)
		if(130 to FLOW_RATE_ARREST)
			playsound(src, pick('modular_skyrat/sound/effects/ekg_alert.ogg', 'modular_skyrat/sound/effects/flatline.ogg'), 40)
			patient.stat ? say("Patient critical! Pulse rate at [patient.flow_rate] BPM, vital signs fading!") : say("Excessive heartbeat! Possible Shock Detected! Pulse rate at [patient.flow_rate] BPM.")

		else
			playsound(src, 'modular_skyrat/sound/effects/flatline.ogg', 20)
	if(beepvalid)
		addtimer(CALLBACK(src, .proc/ekg, patient), 2 SECONDS)
		if(!patient.stat == DEAD)
			SEND_SIGNAL(patient, COMSIG_SHOCK_UPDATE)

/obj/structure/table/optable/proc/chill_out(mob/living/target)
	var/freq = rand(24750, 26550)
	playsound(src, 'sound/effects/spray.ogg', 5, TRUE, 2, frequency = freq)
	target.apply_status_effect(/datum/status_effect/grouped/stasis, STASIS_MACHINE_EFFECT)
	ADD_TRAIT(target, TRAIT_TUMOR_SUPPRESSED, TRAIT_GENERIC)
	target.extinguish_mob()

/obj/structure/table/optable/proc/thaw_them(mob/living/target)
	target.remove_status_effect(/datum/status_effect/grouped/stasis, STASIS_MACHINE_EFFECT)
	REMOVE_TRAIT(target, TRAIT_TUMOR_SUPPRESSED, TRAIT_GENERIC)

/obj/structure/table/optable/post_buckle_mob(mob/living/L)
	beepvalid = TRUE
	set_patient(L)
	chill_out(L)

/obj/structure/table/optable/post_unbuckle_mob(mob/living/L)
	beepvalid = FALSE
	set_patient(null)
	thaw_them(L)

