/obj/item/boulder/proc/manual_process(obj/item/weapon, mob/living/user, override_speed_multiplier, continued = FALSE)
	var/process_speed = 0
	var/skill_modifier = user.mind?.get_skill_modifier(/datum/skill/mining, SKILL_SPEED_MODIFIER) || 1
	//Handle weapon conditions.
	if(weapon)
		if(HAS_TRAIT(weapon, TRAIT_INSTANTLY_PROCESSES_BOULDERS))
			durability = 0

		process_speed = weapon.toolspeed
		weapon.play_tool_sound(src, 50)
		if(!continued)
			to_chat(user, span_notice("You swing at \the [src]..."))

	// Handle user conditions/override conditions.
	else if (override_speed_multiplier || HAS_TRAIT(user, TRAIT_BOULDER_BREAKER))
		if(user)
			if(HAS_TRAIT(user, TRAIT_INSTANTLY_PROCESSES_BOULDERS))
				durability = 0

		else if(override_speed_multiplier)
			process_speed = override_speed_multiplier

		else
			process_speed = INATE_BOULDER_SPEED_MULTIPLIER

		playsound(src, 'sound/effects/rocktap1.ogg', 50)
		if(!continued)
			to_chat(user, span_notice("You scrape away at \the [src]... speed is [process_speed]."))

	else
		CRASH("No weapon, acceptable user, or override speed multiplier passed to manual_process()")

	if(durability > 0)
		if(!do_after(user, ((2 * process_speed SECONDS) * skill_modifier), target = src))
			return

		if(!user.Adjacent(src))
			return

		durability--
		user.apply_damage((4 * skill_modifier), STAMINA)

	if(durability <= 0)
		convert_to_ore()
		to_chat(user, span_notice("You finish working on \the [src], and it crumbles into ore."))
		playsound(src, 'sound/effects/rock_break.ogg', 50)
		user.mind?.adjust_experience(/datum/skill/mining, MINING_SKILL_BOULDER_SIZE_XP * 0.5)
		qdel(src)
		return

	var/msg = (durability == 1 ? "is crumbling!" : "looks weaker!")
	to_chat(user, span_notice("\The [src] [msg]"))
	manual_process(weapon, user, override_speed_multiplier, continued = TRUE)
