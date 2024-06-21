#define EFFECT_TIME (6.5 SECONDS)

// Clock cult's version of the "bullshit stun hand"
// Reworked to be a slightly stronger version of the mansus hand, except with the 1s windup required to invoke.

/datum/scripture/slab/kindle
	name = "Kindle"
	desc = "Stuns and mutes a target from a short range."
	tip = "Stuns and mutes a target from a short range."
	button_icon_state = "Kindle"
	power_cost = 125
	invocation_time = 1 SECONDS
	invocation_text = list("Divinity, show them your light!")
	after_use_text = "Let the power flow through you!"
	slab_overlay = "volt"
	use_time = 15 SECONDS
	cogs_required = 1
	category = SPELLTYPE_SERVITUDE


/datum/scripture/slab/kindle/apply_effects(mob/living/hit_mob)
	if(!istype(hit_mob))
		return FALSE

	if(!IS_CLOCK(invoker))
		hit_mob = invoker

	if(IS_CLOCK(hit_mob))
		return FALSE

	// Chaplains are understandably 100% immune
	if(hit_mob.can_block_magic(MAGIC_RESISTANCE_HOLY))
		hit_mob.mob_light(color = LIGHT_COLOR_HOLY_MAGIC, range = 2, duration = 10 SECONDS)

		var/mutable_appearance/forbearance = mutable_appearance('icons/mob/effects/genetics.dmi', "servitude", -MUTATIONS_LAYER)
		hit_mob.add_overlay(forbearance)
		addtimer(CALLBACK(hit_mob, TYPE_PROC_REF(/atom, cut_overlay), forbearance), 10 SECONDS)

		hit_mob.visible_message(span_warning("[hit_mob] stares blankly, as a field of energy flows around them."), \
									   span_userdanger("You feel a slight shock as a wave of energy flows past you."))

		playsound(invoker, 'sound/magic/mm_hit.ogg', 50, TRUE)
		return TRUE

	//To make battles more fun, both sides can't bullshit stun hand the other
	if(IS_CULTIST(hit_mob))
		hit_mob.mob_light(color = LIGHT_COLOR_BLOOD_MAGIC, range = 2, duration = 30 SECONDS)

		hit_mob.adjust_stutter(15 SECONDS)
		hit_mob.adjust_jitter(15 SECONDS)

		var/mob_color = hit_mob.color
		hit_mob.color = LIGHT_COLOR_BLOOD_MAGIC
		animate(hit_mob, color = mob_color, time = 30 SECONDS)

		hit_mob.say("Fwebar uloft'gib mirlig yro'fara!")

		to_chat(invoker, span_warning("Some force greater than you intervenes! [hit_mob] is protected by Nar'sie!"))
		to_chat(hit_mob, span_warning("You are protected by your faith to Nar'sie!"))

		playsound(invoker, 'sound/magic/mm_hit.ogg', 50, TRUE)
		return TRUE

	//Successful Invokation
	invoker.mob_light(color = LIGHT_COLOR_CLOCKWORK, range = 2, duration = 1 SECONDS)

	if(issilicon(hit_mob))
		var/mob/living/silicon/borgo = hit_mob

		borgo.emp_act(EMP_HEAVY)

	else if(iscarbon(hit_mob))
		var/mob/living/carbon/carbon_hit = hit_mob

		carbon_hit.adjust_stutter(15 SECONDS)
		carbon_hit.adjust_jitter(15 SECONDS)

		carbon_hit.adjust_timed_status_effect(12 SECONDS, /datum/status_effect/speech/slurring/cult)

		carbon_hit.adjust_silence(EFFECT_TIME)
		carbon_hit.AdjustKnockdown(EFFECT_TIME)

		carbon_hit.adjustStaminaLoss(80)

	if(hit_mob.client)
		var/client_color = hit_mob.client.color
		hit_mob.client.color = "#BE8700"
		animate(hit_mob.client, color = client_color, time = 2.5 SECONDS)

	playsound(invoker, 'sound/magic/staff_animation.ogg', 50, TRUE)
	return TRUE

#undef EFFECT_TIME
