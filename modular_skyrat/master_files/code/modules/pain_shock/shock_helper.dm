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

		pain_score += getBruteLoss() + getFireLoss() + getToxLoss() + getOxyLoss() + (getStaminaLoss()/3) / 4
		return pain_score

	proc/calc_injuries()
		var/injuries
		for(var/i in all_wounds)
			injuries++
		return injuries
	proc/shock_helper(flow_rate)
		SIGNAL_HANDLER
		switch(flow_rate)
			if(FLOW_RATE_ARREST)
				if(stat != DEAD)
					set_stat(SOFT_CRIT)
			if(160 to FLOW_RATE_ARREST)
				to_chat(src, span_userdanger("Please! End the pain!"))
			if(90 to 110)
				to_chat(src, "I could use some painkillers right about now...")
			if(110 to 130)
				to_chat(src, span_userdanger("It hurts so much!"))
			if(130 to 160)
				to_chat(src, span_userdanger("Make the pain stop!"))

	updatehealth()
		. = ..()
		shock_helper()
		flow_control()
	update_health_hud(shown_health_amount)
		. = ..()
		var/atom/movable/screen/healths/pulse = hud_used.healths
		pulse.maptext = MAPTEXT(flow_rate)

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
			say("Excessive heartbeat! Possible Shock Detected!")
		else
			playsound(src, 'modular_skyrat/sound/effects/flatline.ogg', 20)
	if(beepvalid)	addtimer(CALLBACK(src, .proc/ekg, patient), 2 SECONDS)

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

