/**
 * Corrupt Structures
 *
 * Contains all of the structures that the corrupted flesh can use.
 */
/obj/structure/corrupted_flesh/structure
	name = "this shouldn't be here"
	desc = "report me to coders"
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/hivemind_structures.dmi'
	icon_state = "error"

/**
 * Wireweed Wall
 *
 * A simple wall made of wireweed.
 */
/obj/structure/corrupted_flesh/structure/wireweed_wall
	name = "wireweed wall"
	desc = "A wall made of wireweed."
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/hivemind_structures.dmi'
	icon_state = "wireweed_wall"
	density = TRUE
	opacity = TRUE
	can_atmos_pass = ATMOS_PASS_DENSITY
	max_integrity = 150

/obj/structure/corrupted_flesh/structure/wireweed_wall/Initialize()
	. = ..()
	var/turf/my_turf = get_turf(src)
	my_turf.immediate_calculate_adjacent_turfs()

/**
 * The CORE
 *
 * This is the central nervous system of this AI, the CPU if you will.
 *
 * This is simply the holder for the controller datum, however, has some cool interactions.
 *
 * There can be more than one core in the flesh.
 */
/obj/structure/corrupted_flesh/structure/core
	name = "strange core"
	desc = "This monsterous machine is definitely watching you."
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/hivemind_machines.dmi'
	icon_state = "core"
	density = TRUE
	max_integrity = 800
	/// The controller we create when we are created.
	var/controller_type = /datum/corrupted_flesh_controller
	/// Whether the core can attack nearby hostiles as its processing.
	var/can_attack = TRUE
	/// How much damage do we do on attacking
	var/attack_damage = 12
	/// What damage do we inflict on attacking
	var/attack_damage_type = BRUTE
	/// How quickly we can attack
	var/attack_cooldown = 6 SECONDS
	COOLDOWN_DECLARE(attack_move)
	/// Whether we do a retaliate effect
	var/does_retaliate_effect = TRUE
	/// Cooldown for retaliate effect
	var/retaliate_effect_cooldown = 40 SECONDS
	COOLDOWN_DECLARE(retaliate_effect)

/obj/structure/corrupted_flesh/structure/core/Initialize(mapload, spawn_controller = TRUE)
	. = ..()
	update_appearance()
	if(spawn_controller)
		our_controller = new controller_type(src)
	START_PROCESSING(SSobj, src)

/obj/structure/corrupted_flesh/structure/core/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/corrupted_flesh/structure/core/process(delta_time)
	var/mob/living/carbon/human/target = locate() in view(5, src)
	if(target)
		if(get_dist(src, target) <= 1)
			icon_state = "core-fear"
		else
			icon_state = "core-see"
			dir = get_dir(src, target)
	else
		icon_state = initial(icon_state)

	if(COOLDOWN_FINISHED(src, attack_move))
		return
	var/has_attacked = FALSE
	for(var/turf/range_turf as anything in RANGE_TURFS(1, loc))
		for(var/thing in range_turf)
			has_attacked = core_attack_atom(thing)
			if(has_attacked)
				break
		if(has_attacked)
			break

/obj/structure/corrupted_flesh/structure/core/update_overlays()
	. = ..()
	. += "core-smirk"

/obj/structure/corrupted_flesh/structure/core/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	our_controller?.core_damaged(src)
	COOLDOWN_START(src, attack_move, attack_cooldown)
	if(does_retaliate_effect && COOLDOWN_FINISHED(src, retaliate_effect))
		COOLDOWN_START(src, retaliate_effect, retaliate_effect_cooldown)
		retaliate_effect()
	return ..()

/obj/structure/corrupted_flesh/structure/core/proc/core_attack_atom(atom/thing)
	. = FALSE
	var/has_attacked
	if(istype(thing, /mob/living))
		var/mob/living/living_thing = thing
		if(!(faction_types in living_thing.faction))
			switch(attack_damage_type)
				if(BRUTE)
					living_thing.take_bodypart_damage(brute = attack_damage, check_armor = TRUE)
				if(BURN)
					living_thing.take_bodypart_damage(burn = attack_damage, check_armor = TRUE)
			has_attacked = TRUE
	else if(istype(thing, /obj/vehicle/sealed/mecha))
		var/obj/vehicle/sealed/mecha/mecha_thing = thing
		mecha_thing.take_damage(attack_damage, attack_damage_type, MELEE, 0, get_dir(mecha_thing, src))
		has_attacked = TRUE
	if(has_attacked)
		thing.visible_message(span_warning("\The [src] strikes [thing]!"), span_userdanger("\The [src] strikes you!"))
		playsound(loc, 'sound/effects/attackblob.ogg', 100, TRUE)
		do_attack_animation(thing, ATTACK_EFFECT_PUNCH)
		return TRUE


/obj/structure/corrupted_flesh/structure/core/proc/retaliate_effect()
	return



/obj/structure/mob_spawner/corrupted_flesh
	name = "Assembler"
	desc = "This cylindrical machine whirrs and whispers, it has a small opening in the middle."
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/hivemind_machines.dmi'
	icon_state = "spawner"
	passive_spawning = TRUE
	spawn_delay = 20 SECONDS
	monster_types = list(
		/mob/living/simple_animal/hostile/corrupted_flesh/floater,
		/mob/living/simple_animal/hostile/corrupted_flesh/globber,
		/mob/living/simple_animal/hostile/corrupted_flesh/hiborg,
		/mob/living/simple_animal/hostile/corrupted_flesh/slicer,
		/mob/living/simple_animal/hostile/corrupted_flesh/stunner,
	)

