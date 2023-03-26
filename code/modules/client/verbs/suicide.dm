/// Verb to simply kill yourself (in a very visual way to all players) in game! How family-friendly. Can be governed by a series of multiple checks (i.e. confirmation, is it allowed in this area, etc.) which are
/// handled and called by the proc this verb invokes. It's okay to block this, because we typically always give mobs in-game the ability to Ghost out of their current mob irregardless of context. This, in contrast,
/// can have as many different checks as you desire to prevent people from doing the deed to themselves.
/mob/living/verb/suicide()
	set hidden = TRUE
	handle_suicide()

/// Actually handles the bare basics of the suicide process. Message type is the message we want to dispatch in the world regarding the suicide, using the defines in this file.
/// Override this ENTIRELY if you want to add any special behavior to your suicide handling, if you fuck up the order of operations then shit will break.
/mob/living/proc/handle_suicide()
	SHOULD_CALL_PARENT(FALSE)
	if(!suicide_alert())
		return

	set_suicide(TRUE)
	send_applicable_messages()
	final_checkout()

/// Proc that handles adding the TRAIT_SUICIDED on the mob in question, as well as additional operations to ensure that everything goes smoothly when we're certain that this person is going to kill themself.
/// suicide_state is a boolean, and we handle adding/removing the trait in question. Have the trait function reference this mob as the source if we want to do in-depth tracking of where a suicided trait comes from.
/// For example, the /mob/dead/observer that will inevitably come from the suicidee will inherit the suicided trait upon creation, and keep this reference. Handy for doing checking should we need it.
/mob/living/proc/set_suicide(suicide_state)
	if(suicide_state)
		ADD_TRAIT(src, TRAIT_SUICIDED, REF(src))
		add_to_mob_suicide_list()
	else
		REMOVE_TRAIT(src, TRAIT_SUICIDED, REF(src))
		remove_from_mob_suicide_list()

/mob/living/carbon/set_suicide(suicide_state) //you thought that box trick was pretty clever, didn't you? well now hardmode is on, boyo.
	. = ..()
	var/obj/item/organ/internal/brain/B = getorganslot(ORGAN_SLOT_BRAIN)
	if(B)
		B.suicided = suicide_state

/mob/living/silicon/robot/set_suicide(suicide_state)
	. = ..()
	if(mmi)
		if(mmi.brain)
			mmi.brain.suicided = suicide_state
		if(mmi.brainmob)
			mmi.brainmob.suiciding = suicide_state

//SKYRAT EDIT REMOVAL BEGIN - SUICIDE_VERB
/*
/mob/living/carbon/human/verb/suicide()
	set hidden = TRUE
	if(!canSuicide())
		return
	var/oldkey = ckey
	var/confirm = tgui_alert(usr,"Are you sure you want to commit suicide?", "Confirm Suicide", list("Yes", "No"))
	if(ckey != oldkey)
		return
	if(!canSuicide())
		return
	if(confirm == "Yes")
		if(suiciding)
			to_chat(src, span_warning("You're already trying to commit suicide!"))
			return
		set_suicide(TRUE) //need to be called before calling suicide_act as fuck knows what suicide_act will do with your suicider
		var/obj/item/held_item = get_active_held_item()

		var/damagetype = SEND_SIGNAL(src, COMSIG_HUMAN_SUICIDE_ACT) || held_item?.suicide_act(src)
		if(damagetype)
			if(damagetype & SHAME)
				adjustStaminaLoss(200)
				set_suicide(FALSE)
				add_mood_event("shameful_suicide", /datum/mood_event/shameful_suicide)
				return

/// Checks if we are in a valid state to suicide (not already suiciding, capable of actually killing ourselves, area checks, etc.) Returns TRUE if we can suicide, FALSE if we can not.
/mob/living/proc/can_suicide()
	if(HAS_TRAIT_FROM_ONLY(src, TRAIT_SUICIDED, REF(src)))
		to_chat(src, span_warning("You are already commiting suicide!"))
		return FALSE

			suicide_log()

			var/damage_mod = 0
			for(var/T in list(BRUTELOSS, FIRELOSS, TOXLOSS, OXYLOSS))
				damage_mod += (T & damagetype) ? 1 : 0
			damage_mod = max(1, damage_mod)

			//Do 200 damage divided by the number of damage types applied.
			if(damagetype & BRUTELOSS)
				adjustBruteLoss(200/damage_mod)

			if(damagetype & FIRELOSS)
				adjustFireLoss(200/damage_mod)

			if(damagetype & TOXLOSS)
				adjustToxLoss(200/damage_mod)

			if(damagetype & OXYLOSS)
				adjustOxyLoss(200/damage_mod)

			if(damagetype & MANUAL_SUICIDE) //Assume the object will handle the death.
				investigate_log("has died from committing suicide[held_item ? " with [held_item]" : ""].", INVESTIGATE_DEATHS)
				return

			//If something went wrong, just do normal oxyloss
			if(!(damagetype & (BRUTELOSS | FIRELOSS | TOXLOSS | OXYLOSS) ))
				adjustOxyLoss(max(200 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))

			investigate_log("has died from committing suicide[held_item ? " with [held_item]" : ""].", INVESTIGATE_DEATHS)
			death(FALSE)
			ghostize(FALSE) // Disallows reentering body and disassociates mind

			return

		var/suicide_message

		if(!combat_mode)
			var/obj/item/organ/internal/brain/userbrain = getorgan(/obj/item/organ/internal/brain)
			if(userbrain?.damage >= 75)
				suicide_message = "[src] pulls both arms outwards in front of [p_their()] chest and pumps them behind [p_their()] back, repeats this motion in a smaller range of motion \
						down to [p_their()] hips two times once more all while sliding [p_their()] legs in a faux walking motion, claps [p_their()] hands together \
						in front of [p_them()] while both [p_their()] knees knock together, pumps [p_their()] arms downward, pronating [p_their()] wrists and abducting \
						[p_their()] fingers outward while crossing [p_their()] legs back and forth, repeats this motion again two times while keeping [p_their()] shoulders low\
						and hunching over, does finger guns with right hand and left hand bent on [p_their()] hip while looking directly forward and putting [p_their()] left leg forward then\
						crossing [p_their()] arms and leaning back a little while bending [p_their()] knees at an angle! It looks like [p_theyre()] trying to commit suicide."
			else
				suicide_message = pick("[src] is hugging [p_them()]self to death! It looks like [p_theyre()] trying to commit suicide.", \
							"[src] is high-fiving [p_them()]self to death! It looks like [p_theyre()] trying to commit suicide.", \
							"[src] is getting too high on life! It looks like [p_theyre()] trying to commit suicide.")
		else
			suicide_message = pick("[src] is attempting to bite [p_their()] tongue off! It looks like [p_theyre()] trying to commit suicide.", \
								"[src] is jamming [p_their()] thumbs into [p_their()] eye sockets! It looks like [p_theyre()] trying to commit suicide.", \
								"[src] is twisting [p_their()] own neck! It looks like [p_theyre()] trying to commit suicide.", \
								"[src] is holding [p_their()] breath! It looks like [p_theyre()] trying to commit suicide.")

		visible_message(span_danger("[suicide_message]"), span_userdanger("[suicide_message]"))

		suicide_log()

		adjustOxyLoss(max(200 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		investigate_log("has died from committing suicide[held_item ? " with [held_item]" : ""].", INVESTIGATE_DEATHS)
		death(FALSE)
		ghostize(FALSE) // Disallows reentering body and disassociates mind

/mob/living/brain/verb/suicide()
	set hidden = TRUE
	if(!canSuicide())
		return
	var/confirm = tgui_alert(usr,"Are you sure you want to commit suicide?", "Confirm Suicide", list("Yes", "No"))
	if(!canSuicide())
		return
	if(confirm == "Yes")
		set_suicide(TRUE)
		visible_message(span_danger("[src]'s brain is growing dull and lifeless. [p_they(TRUE)] look[p_s()] like [p_theyve()] lost the will to live."), \
						span_userdanger("[src]'s brain is growing dull and lifeless. [p_they(TRUE)] look[p_s()] like [p_theyve()] lost the will to live."))

		suicide_log()

		death(FALSE)
		ghostize(FALSE) // Disallows reentering body and disassociates mind

/mob/living/silicon/ai/verb/suicide()
	set hidden = TRUE
	if(!canSuicide())
		return
	var/confirm = tgui_alert(usr,"Are you sure you want to commit suicide?", "Confirm Suicide", list("Yes", "No"))
	if(!canSuicide())
		return
	if(confirm == "Yes")
		set_suicide(TRUE)
		visible_message(span_danger("[src] is powering down. It looks like [p_theyre()] trying to commit suicide."), \
				span_userdanger("[src] is powering down. It looks like [p_theyre()] trying to commit suicide."))

		suicide_log()

		//put em at -175
		adjustOxyLoss(max(maxHealth * 2 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		death(FALSE)
		ghostize(FALSE) // Disallows reentering body and disassociates mind

/mob/living/silicon/robot/verb/suicide()
	set hidden = TRUE
	if(!canSuicide())
		return
	var/confirm = tgui_alert(usr,"Are you sure you want to commit suicide?", "Confirm Suicide", list("Yes", "No"))
	if(!canSuicide())
		return
	if(confirm == "Yes")
		set_suicide(TRUE)
		visible_message(span_danger("[src] is powering down. It looks like [p_theyre()] trying to commit suicide."), \
				span_userdanger("[src] is powering down. It looks like [p_theyre()] trying to commit suicide."))

		suicide_log()

		//put em at -175
		adjustOxyLoss(max(maxHealth * 2 - getToxLoss() - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		death(FALSE)
		ghostize(FALSE) // Disallows reentering body and disassociates mind
*/
//SKYRAT EDIT REMOVAL END

//SKYRAT EDIT PAI START - Returns ability to leave your PAI
/mob/living/silicon/pai/verb/suicide()
	set hidden = TRUE
	var/confirm = tgui_alert(usr,"Are you sure you want to commit suicide?", "Confirm Suicide", list("Yes", "No"))
	if(confirm == "Yes")
		var/turf/T = get_turf(src.loc)
		T.visible_message(span_notice("[src] flashes a message across its screen, \"Wiping core files. Please acquire a new personality to continue using pAI device functions.\""), null, \
			span_notice("[src] bleeps electronically."))

		suicide_log()

		death(FALSE)
		ghostize(FALSE) // Disallows reentering body and disassociates mind
	else
		to_chat(src, "Aborting suicide attempt.")
//SKYRAT EDIT PAI END

//SKYRAT EDIT REMOVAL START
/*
/mob/living/carbon/alien/adult/verb/suicide()
	set hidden = TRUE
	if(!canSuicide())
		return
	var/confirm = tgui_alert(usr,"Are you sure you want to commit suicide?", "Confirm Suicide", list("Yes", "No"))
	if(!canSuicide())
		return
	if(confirm == "Yes")
		set_suicide(TRUE)
		visible_message(span_danger("[src] is thrashing wildly! It looks like [p_theyre()] trying to commit suicide."), \
				span_userdanger("[src] is thrashing wildly! It looks like [p_theyre()] trying to commit suicide."), \
				span_hear("You hear thrashing."))

		suicide_log()

		//put em at -175
		adjustOxyLoss(max(200 - getFireLoss() - getBruteLoss() - getOxyLoss(), 0))
		death(FALSE)
		ghostize(FALSE) // Disallows reentering body and disassociates mind

/mob/living/simple_animal/verb/suicide()
	set hidden = TRUE
	if(!canSuicide())
		return
	var/confirm = tgui_alert(usr,"Are you sure you want to commit suicide?", "Confirm Suicide", list("Yes", "No"))
	if(!canSuicide())
		return
	if(confirm == "Yes")
		set_suicide(TRUE)
		visible_message(span_danger("[src] begins to fall down. It looks like [p_theyve()] lost the will to live."), \
						span_userdanger("[src] begins to fall down. It looks like [p_theyve()] lost the will to live."))

		suicide_log()

		death(FALSE)
		ghostize(FALSE)	// Disallows reentering body and disassociates mind
*/
//SKYRAT EDIT REMOVAL END

/mob/living/proc/suicide_log()
	investigate_log("has died from committing suicide.", INVESTIGATE_DEATHS)
	log_message("committed suicide as [src.type]", LOG_ATTACK)

/mob/living/carbon/human/suicide_log()
	log_message("(job: [src.job ? "[src.job]" : "None"]) committed suicide", LOG_ATTACK)

/mob/living/proc/canSuicide()
	var/area/A = get_area(src)
	if(A.area_flags & BLOCK_SUICIDE)
		to_chat(src, span_warning("You can't commit suicide here! You can ghost if you'd like."))
		return
	switch(stat)
		if(CONSCIOUS)
			return TRUE
		if(SOFT_CRIT)
			to_chat(src, span_warning("You can't commit suicide while in a critical condition!"))
		if(UNCONSCIOUS, HARD_CRIT)
			to_chat(src, span_warning("You need to be conscious to commit suicide!"))
		if(DEAD)
			to_chat(src, span_warning("You're already dead!"))
	return

/mob/living/carbon/canSuicide()
	if(!..())
		return
	if(!(mobility_flags & MOBILITY_USE)) //just while I finish up the new 'fun' suiciding verb. This is to prevent metagaming via suicide
		to_chat(src, span_warning("You can't commit suicide whilst immobile! ((You can type Ghost instead however.))"))
		return
	return TRUE
