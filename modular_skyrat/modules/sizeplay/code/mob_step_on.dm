/mob/living/proc/can_be_stepped_on(mob/living/stepper)
	. = TRUE

	if(is_type_in_typecache(src, GLOB.mob_type_sizeplay_blacklist))
		return FALSE

	var/relative_size = ((stepper.mob_size+1) * stepper.body_size_multiplier) / ((mob_size+1) * body_size_multiplier)
	if(relative_size < CONFIG_GET(number/mob_step_on_relative_size))
		return FALSE


/mob/living/carbon/human/Initialize()
	. = ..()
	if(CONFIG_GET(flag/mob_step_on))
		RegisterSignal(src, list(COMSIG_ATOM_BUMPED, COMSIG_MOVABLE_CROSSED), .proc/attempt_step_on)

/mob/living/proc/attempt_step_on(atom/source, mob/living/stepper)
	SIGNAL_HANDLER

	if(!iscarbon(stepper))
		return FALSE
	if(!can_be_stepped_on(stepper))
		return FALSE
	if(buckled)
		return FALSE

	if(stepper.combat_mode)
		if(prob(80))
			visible_message("<span class='warning'>[stepper] violently steps on [src]!</span>", "<span class='userdanger'>[stepper] crushes you with \his foot!</span>")
			apply_damage(damage = 20, damagetype = BRUTE, spread_damage = TRUE, wound_bonus = 10)
			Knockdown(20)
		else
			visible_message("<span class='warning'>[stepper] narrowly misses stepping on [src]!</span>", "<span class='userdanger'>You narrowly avoid being crushed by [stepper] \s foot!</span>")
	else
		if(prob(50))
			visible_message("<span class='warning'>[stepper] accidentally steps on [src]!</span>", "<span class='userdanger'>[stepper] steps you with \his foot!</span>")
			Knockdown(10)
	return TRUE
