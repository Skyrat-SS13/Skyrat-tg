/mob/living/simple_animal/hostile/auto_scrapper
	name = "drone"
	desc = "An autonomous scrapping drone, carrying out its programming to the letter."
	icon = 'icons/mob/drone.dmi'
	icon_state = "drone_maint_grey"
	icon_living = "drone_maint_grey"
	icon_dead = "drone_maint_dead"
	icon_gib = null
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES | ENVIRONMENT_SMASH_WALLS
	mob_biotypes = list(MOB_ROBOTIC)
	speak_chance = 1
	speak_emote = list("buzzes")
	speed = 1
	emote_taunt = list("beeps", "buzzes", "boops")
	ranged_message = "jumps"
	taunt_chance = 5
	turns_per_move = 5
	maxHealth = 50
	health = 50
	speed = 3
	dodging = TRUE
	harm_intent_damage = 15
	melee_damage_lower = 5
	melee_damage_upper = 5
	loot = list(/obj/item/stack/circuit_stack)
	faction = list("hostile", "scrapper")
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_plas" = 0, "max_plas" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	/// Current system target, leaves once dead
	var/static/obj/machinery/system_to_attack
	// To my knowledge, `wanted_objects` won't work with what I want here
	/// If the system has been destroyed
	var/system_destroyed = FALSE

/mob/living/simple_animal/hostile/auto_scrapper/Initialize(mapload)
	. = ..()
	OUTBOUND_CONTROLLER
	ADD_TRAIT(src, TRAIT_SPACEWALK, INNATE_TRAIT)
	/* //debugging method
	for(var/obj/machinery/machine as anything in outbound_controller.machine_datums)
		if(outbound_controller.machine_datums[machine] != outbound_controller.ship_systems["Sensors"])
			continue
		system_to_attack = machine
		RegisterSignal(system_to_attack, COMSIG_AWAY_SYSTEM_FAIL, .proc/on_destruction)*/
	while(!system_to_attack)
		if(!length(outbound_controller.machine_datums))
			break
		var/obj/machinery/picked_machine = pick(outbound_controller.machine_datums)
		var/datum/outbound_ship_system/ship_sys = outbound_controller.machine_datums[picked_machine]
		if(!outbound_controller.is_system_dead(ship_sys))
			system_to_attack = picked_machine
			RegisterSignal(system_to_attack, COMSIG_AWAY_SYSTEM_FAIL, .proc/on_destruction)

/mob/living/simple_animal/hostile/auto_scrapper/ListTargets()
	. = ..()
	. += system_to_attack
	return .

/mob/living/simple_animal/hostile/auto_scrapper/PickTarget(list/targets)
	if(system_destroyed)
		for(var/obj/effect/landmark/outbound/scrapper_evac_point/drone_fuck_off in GLOB.landmarks_list)
			return drone_fuck_off
	if(!isnull(target)) // If we already have a target, but are told to pick again, calculate the lowest distance between all possible, and pick from the lowest distance targets
		var/atom/target_from = GET_TARGETS_FROM(src)
		for(var/pos_targ in targets)
			var/atom/atom_target = pos_targ
			var/target_dist = get_dist(target_from, target)
			var/possible_target_distance = get_dist(target_from, atom_target)
			if(target_dist < possible_target_distance)
				targets -= atom_target
	if(!length(targets)) // Found nothing, proceed to attack the system regardless of distance
		return system_to_attack
	return pick(targets) //Pick the remaining targets (if any) at random

/mob/living/simple_animal/hostile/auto_scrapper/CanAttack(atom/the_target)
	. = ..()
	if(iswallturf(the_target)) //these fuckers will bore through walls to get to you
		return TRUE
	if((istype(the_target, /obj/machinery/outbound_expedition) || istype(the_target, /obj/machinery/power/smes/vanguard)) && !system_destroyed)
		return TRUE

/mob/living/simple_animal/hostile/auto_scrapper/Aggro()
	. = ..()
	Goto(target, 3, 0)

/mob/living/simple_animal/hostile/auto_scrapper/proc/on_destruction()
	SIGNAL_HANDLER

	system_destroyed = TRUE
