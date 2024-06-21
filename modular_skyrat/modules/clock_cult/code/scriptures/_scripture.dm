GLOBAL_LIST_EMPTY(clock_scriptures)
GLOBAL_LIST_EMPTY(clock_scriptures_by_type)

// Scriptures are the "spells" of clock cultists
// They're usable through their clockwork slab, and cannot be invoked otherwise
/datum/scripture
	/// Name of the scripture
	var/name = ""
	/// Shown decription of the scripture in the UI
	var/desc = ""
	/// Tooltip shown on-hover. Keep to a few words
	var/tip = ""
	/// How much power this scripture costs to use
	var/power_cost = 0
	/// How much vitality this scripture costs to use
	var/vitality_cost = 0
	/// How many cogs are required to be used to use this
	var/cogs_required = 0
	/// Time required to invoke this while standing still
	var/invocation_time = 0
	/// Text said during invocation, automatically translates to Ratvarian
	var/list/invocation_text = list()
	/// Icon state of the action button
	var/button_icon_state = "telerune"
	/// How many people need to invoke this in sight of each other to use
	var/invokers_required = 1
	/// What category of scripture is this
	var/category = SPELLTYPE_ABSTRACT
	/// Only set to false if you call end_invoke somewhere in your scripture
	var/end_on_invocation = TRUE
	/// Ref to the mob invoking this
	var/mob/living/invoker
	/// Ref to the slab invoking this
	var/obj/item/clockwork/clockwork_slab/invoking_slab
	/// Timer object for the distance between invoking chants
	var/invocation_chant_timer = null
	/// Sound to play on finish
	var/sound/recital_sound = null
	/// If this scripture requires research to be unlocked
	var/research_required = FALSE

/datum/scripture/New()
	. = ..()
	if(invokers_required > 1)
		desc += " Requires [invokers_required] invokers, should you be in a group."
	if(research_required)
		desc += " Requires research to unlock."


/datum/scripture/Destroy(force, ...)
	invoker = null
	invoking_slab = null
	return ..()


/// Invoke this scripture, checking if there's valid power and vitality
/datum/scripture/proc/invoke()
	if(GLOB.clock_power < power_cost || GLOB.clock_vitality < vitality_cost)
		invoke_fail()

		if(invocation_chant_timer)
			deltimer(invocation_chant_timer)
			invocation_chant_timer = null

		end_invoke()

		return

	GLOB.clock_power -= power_cost
	GLOB.clock_vitality -= vitality_cost
	invoke_success()


/// On success of invoking the scripture
/datum/scripture/proc/invoke_success()
	return TRUE


/// On failure of invoking the scripture
/datum/scripture/proc/invoke_fail()
	return TRUE


/// The overall reciting proc for saying every single line for a scripture
/datum/scripture/proc/recital()
	if(!length(invocation_text))
		return

	var/steps = length(invocation_text)
	var/time_between_say = invocation_time / (steps + 1)

	if(invocation_chant_timer)
		deltimer(invocation_chant_timer)
		invocation_chant_timer = null

	recite(1, time_between_say, steps)


/// For reciting an individual line of a scripture
/datum/scripture/proc/recite(text_point, wait_time, stop_at = 0)
	if(QDELETED(src))
		return

	invocation_chant_timer = null

	if(!invoking_slab || !invoking_slab.invoking_scripture)
		return

	var/invokers_left = invokers_required
	if(invokers_left > 1)
		for(var/mob/living/potential_invoker in viewers(invoker))
			if(!invokers_left)
				break

			if(potential_invoker?.mind.has_antag_datum(/datum/antagonist/clock_cultist/solo)) // Solo cultists can use all scriptures alone, while group clock cult doesn't get so lucky
				invokers_left = 0
				clockwork_say(potential_invoker, text2ratvar(invocation_text[text_point]), TRUE)
				break

			if(potential_invoker.stat)
				continue

			if(IS_CLOCK(potential_invoker))
				clockwork_say(potential_invoker, text2ratvar(invocation_text[text_point]), TRUE)
				invokers_left--
	else
		clockwork_say(invoker, text2ratvar(invocation_text[text_point]), TRUE)

	if(recital_sound)
		SEND_SOUND(invoker, recital_sound)

	if(text_point < stop_at)
		invocation_chant_timer = addtimer(CALLBACK(src, PROC_REF(recite), text_point+1, wait_time, stop_at), wait_time, TIMER_STOPPABLE)


/// Check for any special requriements such as not having enough invokers, or not holding the slab
/datum/scripture/proc/check_special_requirements(mob/user)
	if(!invoker || !invoking_slab)
		message_admins("No invoker for [name]")
		return FALSE

	if(invoker.get_active_held_item() != invoking_slab && !iscyborg(invoker))
		to_chat(invoker, span_brass("You fail to invoke [name]."))
		return FALSE

	var/invokers = 0
	for(var/mob/living/potential_invoker in viewers(invoker))
		if(potential_invoker.stat)
			continue

		if(IS_CLOCK(potential_invoker))
			invokers++

		if(potential_invoker.mind?.has_antag_datum(/datum/antagonist/clock_cultist/solo)) // They count for infinite so they can do all scriptures solo
			invokers = INFINITY
			break

	if(invokers < invokers_required)
		to_chat(invoker, span_brass("You need [invokers_required] servants to channel [name]!"))
		return FALSE

	return TRUE


/// Start invoking a scripture, calling end_invoke() if it doesn't finish
/datum/scripture/proc/begin_invoke(mob/living/invoking_mob, obj/item/clockwork/clockwork_slab/slab, bypass_unlock_checks = FALSE)
	if(invoking_mob.get_active_held_item() != slab && !iscyborg(invoking_mob))
		to_chat(invoking_mob, span_brass("You need to have the [slab.name] in your active hand to recite scriptures."))
		return

	slab.invoking_scripture = src
	invoker = invoking_mob
	invoking_slab = slab

	if(!(type in slab.purchased_scriptures) && !bypass_unlock_checks)
		log_runtime("CLOCKCULT: Attempting to invoke a scripture that has not been unlocked. Either there is a bug, or [ADMIN_LOOKUP(invoker)] is using some wacky exploits.")
		end_invoke()
		return

	if(!check_special_requirements(invoking_mob))
		end_invoke()
		return

	recital()

	if(do_after(invoking_mob, invocation_time, target = invoking_mob, extra_checks = CALLBACK(src, PROC_REF(check_special_requirements), invoking_mob)))
		invoke()

		to_chat(invoking_mob, span_brass("You invoke <b>[name]</b>."))

		if(end_on_invocation)
			end_invoke()
	else
		invoke_fail()

		if(invocation_chant_timer)
			deltimer(invocation_chant_timer)
			invocation_chant_timer = null

		end_invoke()


/// End the invoking, nulling things out
/datum/scripture/proc/end_invoke()
	invoking_slab.invoking_scripture = null


// Base create structure scripture
/datum/scripture/create_structure
	/// Typepath for the structure to create
	var/summoned_structure


/datum/scripture/create_structure/check_special_requirements(mob/user)
	. = ..()
	if(!.)
		return FALSE

	for(var/obj/structure/destructible/clockwork/clockwork_struct in get_turf(invoker))
		if(istype(clockwork_struct, /obj/structure/destructible/clockwork/trap))
			continue

		invoker.balloon_alert(invoker, "structure already on tile!")
		return FALSE

	return TRUE


/datum/scripture/create_structure/invoke_success()
	var/created_structure = new summoned_structure(get_turf(invoker))
	var/obj/structure/destructible/clockwork/clockwork_structure = created_structure

	if(istype(clockwork_structure))
		clockwork_structure.owner = invoker.mind



//For scriptures that charge the slab, and the slab will affect something
//(stunning etc.)
/datum/scripture/slab
	name = "Charge Slab"
	end_on_invocation = FALSE
	/// Time to perform this
	var/use_time = 1 SECONDS
	/// Overlay for the item/inhand state while this is invoked
	var/slab_overlay = "volt"
	/// Progressbar datum for count_down()
	var/datum/progressbar/progress
	/// How many times this scripture can be used overall, is unchanging
	var/uses = 1
	/// Text displayed after use
	var/after_use_text = ""
	/// Internal spell for pointed/aimed spells
	var/datum/action/cooldown/spell/pointed/slab/pointed_spell
	/// How many times this can be used this particular invocation, can go down
	var/uses_left = 0
	/// How much time left to use this
	var/time_left = 0
	/// ID of the loop timer
	var/loop_timer_id

/datum/scripture/slab/New()
	. = ..()
	pointed_spell = new(src)
	pointed_spell.name = src.name
	pointed_spell.deactive_msg = ""
	pointed_spell.parent_scripture = src

/datum/scripture/slab/Destroy()
	if(progress)
		QDEL_NULL(progress)

	if(!QDELETED(pointed_spell))
		QDEL_NULL(pointed_spell)

	return ..()


/datum/scripture/slab/invoke()
	progress = new(invoker, use_time)
	uses_left = uses
	time_left = use_time
	invoking_slab.charge_overlay = slab_overlay
	invoking_slab.update_icon()
	invoking_slab.active_scripture = src
	pointed_spell.set_click_ability(invoker)
	count_down()
	GLOB.clock_power -= power_cost
	GLOB.clock_vitality -= vitality_cost
	invoke_success()


/// Count down the progress bar
/datum/scripture/slab/proc/count_down()
	if(QDELETED(src))
		return

	progress.update(time_left)
	time_left--
	loop_timer_id = null

	if(time_left > 0)
		loop_timer_id = addtimer(CALLBACK(src, PROC_REF(count_down)), 0.1 SECONDS, TIMER_STOPPABLE)
	else
		end_invocation()


/// What occurs when an atom is clicked on.
/datum/scripture/slab/proc/click_on(atom/clicked_atom)
	SHOULD_CALL_PARENT(TRUE)

	if(!invoker.can_interact_with(clicked_atom))
		return

	if(!apply_effects(clicked_atom))
		return

	uses_left--
	if(uses_left)
		return

	if(after_use_text)
		clockwork_say(invoker, text2ratvar(after_use_text), TRUE)

	end_invocation(TRUE)


/// What occurs when the invocation ends
/datum/scripture/slab/proc/end_invocation(silent = FALSE)
	SHOULD_CALL_PARENT(TRUE)

	//Remove the timer if there is one currently active
	if(loop_timer_id)
		deltimer(loop_timer_id)
		loop_timer_id = null

	if(!silent)
		to_chat(invoker, span_brass("You are no longer invoking <b>[name]</b>."))
	qdel(progress)

	pointed_spell.unset_click_ability(invoker)
	invoking_slab.charge_overlay = null
	invoking_slab.update_icon()
	invoking_slab.active_scripture = null

	end_invoke()


/// Apply the effects of a scripture to an atom
/datum/scripture/slab/proc/apply_effects(atom/applied_atom)
	return TRUE



/datum/action/cooldown/spell/pointed/slab
	/// The scripture datum that this spell is referring to
	var/datum/scripture/slab/parent_scripture

/datum/action/cooldown/spell/pointed/slab/Destroy()
	parent_scripture = null
	return ..()


/datum/action/cooldown/spell/pointed/slab/InterceptClickOn(mob/living/caller, params, atom/target)
	parent_scripture?.click_on(target)


/// Generate all scriptures in a global assoc of name:ref. Only needs to be done once
/proc/generate_clockcult_scriptures()
	for(var/categorypath in subtypesof(/datum/scripture))
		var/datum/scripture/clock_script = new categorypath
		GLOB.clock_scriptures += clock_script
		GLOB.clock_scriptures_by_type[clock_script.type] = clock_script
