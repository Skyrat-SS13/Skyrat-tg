#define COMSIG_SHOCK_UPDATE "shock_update"

/* /mob/living/carbon/Life(delta_time = SSMOBS_DT, times_fired)
	flow_control() */
/mob/living/carbon
	var/lastpainmessage
	var/in_shock = FALSE
	var/flow_rate = BASE_FLOW_RATE
	var/injuries
/mob/living/carbon/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_SHOCK_UPDATE, .proc/shock_helper)

/mob/living/carbon/proc/flow_control()
	SIGNAL_HANDLER
	injuries = calc_injuries()
//		var/pain_score = injuries + length(all_wounds) // old, backup and sketchy
	calc_pain()
	if(stat == DEAD)
		flow_rate = 0
		update_health_hud()
		return
	else if(!in_shock)	flow_rate = clamp(rand(BASE_FLOW_RATE, BASE_FLOW_RATE_UPPER) + calc_pain(), 0, FLOW_RATE_ARREST)
	in_shock ? shock_dying(flow_rate) : shock_helper(flow_rate)

	update_health_hud()

/mob/living/carbon/proc/calc_pain()
	var/pain_score = 1
	for(var/i in all_wounds)
		var/datum/wound/iterwound = i
		if(iterwound.severity == WOUND_SEVERITY_SEVERE || WOUND_SEVERITY_CRITICAL || WOUND_SEVERITY_LOSS)
			pain_score += SHOCK_STAGE_MODERATE
		if(iterwound.severity == WOUND_SEVERITY_MODERATE || WOUND_SEVERITY_TRIVIAL)
			pain_score += SHOCK_STAGE_MINOR

	pain_score += getBruteLoss() + getFireLoss() + getToxLoss() + getOxyLoss() + getStaminaLoss() / DAMAGE_TO_PAIN_DIVISION_FACTOR
	return pain_score

/mob/living/carbon/proc/calc_injuries()
	var/injuries
	for(var/i in all_wounds)
		injuries++
	return injuries

/mob/living/carbon/proc/shock_dying(last_bpm, pulsetimer)
	if(!in_shock || stat == DEAD)
		return
	if(can_leave_shock(last_bpm) && stat != DEAD)
		in_shock = FALSE
		set_stat(CONSCIOUS)
		to_chat(src, span_hypnophrase("You body tingles painfully as your nerves come back..."))
	else
		current_pain_message_helper("Shock")
		losebreath += 0.25
	flow_rate = clamp(flow_rate - losebreath, FLOW_RATE_DEAD, FLOW_RATE_ARREST) // Double negative when in crit?

	if(flow_rate <= 0)
		adjustOrganLoss(ORGAN_SLOT_BRAIN, losebreath)


/mob/living/carbon/proc/can_leave_shock(last_bpm)
	var/truepain = calc_pain()
	if(truepain <= 100)
		return TRUE
	return FALSE
/mob/living/carbon/proc/resetpainmsg()
	lastpainmessage = null
/mob/living/carbon/proc/current_pain_message_helper(current_pain)
	if(lastpainmessage)
		return
	lastpainmessage = TRUE
	addtimer(CALLBACK(src, .proc/resetpainmsg), 45 SECONDS)
	var/list/close2death = list("a human", "a moth", "a felinid", "a lizard", "a particularly resilient slime", "a syndicate agent", "a clown", "a mime", "a mortal foe", "an innocent bystander")

	switch(current_pain)
		if("Shock")
			to_chat(src, span_resonate("You feel your body shutting down..."))
			Jitter(15)
		if("Minor")
			to_chat(src, span_resonate("I could use some painkillers right about now..."))
		if("Moderate")
			to_chat(src, span_resonate("It hurts so much!"))
			Jitter(15)
		if("Major")
			to_chat(src, span_resonate("Make the pain stop!"))
			Jitter(15)
		if("Severe")
			to_chat(src, span_resonate("Please! End the pain!"))
			Jitter(15)
		if("Soft-crit")
			var/dream = span_italics(". . . You think about . . . ") + span_hypnophrase("[pick(close2death)]")
			to_chat(src, dream)
			Jitter(15)
		if("Dying")
			to_chat(src, span_unconscious(pick("Where am I?", "What's going on?")))

/mob/living/carbon/proc/shock_helper(flow_rate)
	SIGNAL_HANDLER
	switch(flow_rate)
		if(FLOW_RATE_ARREST)
			if(stat != HARD_CRIT || stat != SOFT_CRIT && !HAS_TRAIT(src, TRAIT_NOSOFTCRIT))
				set_stat(SOFT_CRIT)
				to_chat(src, "shock_helper made us [SOFT_CRIT]")
				in_shock = TRUE
//				shock_dying(flow_rate, pulsetimer)
				current_pain_message_helper("Soft-crit")
			if(calc_pain() > hardcrit_threshold || stat != HARD_CRIT && !HAS_TRAIT(src, TRAIT_NOHARDCRIT)) // testing..
				set_stat(HARD_CRIT)
				to_chat(src, "shock_helper made us [HARD_CRIT]")
				in_shock = TRUE
				current_pain_message_helper("Dying")


		if(180 to FLOW_RATE_ARREST - 1)
			current_pain_message_helper("Severe")
//			set_stat(CONSCIOUS)
		if(120 to 140)
			current_pain_message_helper("Minor")
//			set_stat(CONSCIOUS)
		if(140 to 160)
			current_pain_message_helper("Moderate")
//			set_stat(CONSCIOUS)
		if(160 to 180)
			current_pain_message_helper("Major")
//			set_stat(CONSCIOUS)

//mob/living/carbon/updatehealth()
//	. = ..()
//	shock_helper()
//		flow_control()
/mob/living/carbon/update_health_hud(shown_health_amount)
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
			if(130 to 200)
				hud_used.healths.icon_state = "health4"
			if(200 to 299)
				hud_used.healths.icon_state = "health5"
		if(in_shock && stat != DEAD)
			hud_used.healths.icon_state = "health6"
		if(stat == DEAD)
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
		addtimer(CALLBACK(src, .proc/ekg, patient), 2 SECONDS) // SFX length
		if(patient.stat != DEAD)
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

