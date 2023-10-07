/datum/species/lizard/ashwalker
	mutanteyes = /obj/item/organ/internal/eyes/night_vision/ashwalker
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/lizard/ashwalker,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/lizard/ashwalker,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/lizard/ashwalker,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/lizard/ashwalker,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/lizard/ashwalker,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/lizard/ashwalker,
	)

/datum/species/lizard/ashwalker/on_species_gain(mob/living/carbon/carbon_target, datum/species/old_species)
	. = ..()
	RegisterSignal(carbon_target, COMSIG_MOB_ITEM_ATTACK, PROC_REF(mob_attack))
	carbon_target.AddComponent(/datum/component/ash_age)
	carbon_target.faction |= FACTION_ASHWALKER

/datum/species/lizard/ashwalker/on_species_loss(mob/living/carbon/carbon_target)
	. = ..()
	UnregisterSignal(carbon_target, COMSIG_MOB_ITEM_ATTACK)
	carbon_target.faction &= FACTION_ASHWALKER

/datum/species/lizard/ashwalker/proc/mob_attack(datum/source, mob/mob_target, mob/user)
	SIGNAL_HANDLER

	if(!isliving(mob_target))
		return
	var/mob/living/living_target = mob_target
	var/datum/status_effect/ashwalker_damage/ashie_damage = living_target.has_status_effect(/datum/status_effect/ashwalker_damage)
	if(!ashie_damage)
		ashie_damage = living_target.apply_status_effect(/datum/status_effect/ashwalker_damage)
	ashie_damage.register_mob_damage(living_target)

/**
 * 20 minutes = ash storm immunity
 * 40 minutes = armor
 * 60 minutes = base punch
 * 80 minutes = lavaproof
 * 100 minutes = firebreath
 */

/datum/component/ash_age
	/// the amount of minutes after each upgrade
	var/stage_time = 20 MINUTES
	/// the current stage of the ash
	var/current_stage = 0
	/// the time when upgraded/attached
	var/evo_time = 0
	/// the human target the element is attached to
	var/mob/living/carbon/human/human_target

/datum/component/ash_age/Initialize()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	// set the target for the element so we can reference in other parts
	human_target = parent
	// set the time that it was attached then we will compare current world time versus the evo_time plus stage_time
	evo_time = world.time
	// when the rune successfully completes the age ritual, it will send the signal... do the proc when we receive the signal
	RegisterSignal(human_target, COMSIG_RUNE_EVOLUTION, PROC_REF(check_evolution))
	RegisterSignal(human_target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/component/ash_age/proc/check_evolution()
	SIGNAL_HANDLER
	// if the world time hasn't yet passed the time required for evolution
	if(world.time < (evo_time + stage_time))
		to_chat(human_target, span_warning("More time is necessary to evolve-- twenty minutes between each evolution..."))
		return
	// since it was time, go up a stage and now we check what to add
	current_stage++
	// since we went up a stage, we need to update the evo_time for the next comparison
	evo_time = world.time
	var/datum/species/species_target = human_target.dna.species
	switch(current_stage)
		if(1)
			ADD_TRAIT(human_target, TRAIT_ASHSTORM_IMMUNE, REF(src))
			to_chat(human_target, span_notice("The biting wind seems to sting less..."))
		if(2)
			species_target.damage_modifier += 10
			to_chat(human_target, span_notice("Your body seems to be sturdier..."))
		if(3)
			var/obj/item/bodypart/arm/left/left_arm = human_target.get_bodypart(BODY_ZONE_L_ARM)
			if(left_arm)
				left_arm.unarmed_damage_low += 5
				left_arm.unarmed_damage_high += 5

			var/obj/item/bodypart/arm/right/right_arm = human_target.get_bodypart(BODY_ZONE_R_ARM)
			if(right_arm)
				right_arm.unarmed_damage_low += 5
				right_arm.unarmed_damage_high += 5

			to_chat(human_target, span_notice("Your arms seem denser..."))
		if(4)
			ADD_TRAIT(human_target, TRAIT_LAVA_IMMUNE, REF(src))
			to_chat(human_target, span_notice("Your body feels hotter..."))
		if(5)
			var/datum/action/cooldown/mob_cooldown/fire_breath/granted_action
			granted_action = new()
			granted_action.Grant(human_target)
			to_chat(human_target, span_notice("Your throat feels larger..."))
		if(6 to INFINITY)
			to_chat(human_target, span_warning("You have already reached the pinnacle of your current body!"))


/datum/component/ash_age/proc/on_examine(atom/target_atom, mob/user, list/examine_list)
	SIGNAL_HANDLER
	if(world.time < (evo_time + stage_time))
		examine_list += span_notice("[human_target] has not yet reached the age for evolving.")
		return
	examine_list += span_warning("[human_target] has reached the age for evolving!")
