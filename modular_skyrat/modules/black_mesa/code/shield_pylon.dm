/mob/living/simple_animal/hostile/blackmesa/xen
	/// Can we be shielded by pylons?
	var/can_be_shielded = TRUE
	/// If we have support pylons, this is true.
	var/shielded = FALSE
	/// How many shields we have protecting us
	var/shield_count = 0

/mob/living/simple_animal/hostile/blackmesa/xen/update_overlays()
	. = ..()
	if(shielded)
		. += mutable_appearance('icons/effects/effects.dmi', "shield-yellow", MOB_SHIELD_LAYER)

/mob/living/simple_animal/hostile/blackmesa/xen/proc/lose_shield()
	shield_count--
	if(shield_count <= 0)
		shielded = FALSE
		update_appearance()

/mob/living/simple_animal/hostile/blackmesa/xen/apply_damage(damage, damagetype, def_zone, blocked, forced, spread_damage, wound_bonus, bare_wound_bonus, sharpness, attack_direction)
	if(shielded)
		balloon_alert_to_viewers("ineffective!")
		return FALSE
	return ..()

/obj/structure/xen_pylon
	name = "shield plant"
	desc = "It seems to be some kind of force field generator."
	icon = 'modular_skyrat/modules/black_mesa/icons/plants.dmi'
	icon_state = "crystal_pylon"
	max_integrity = 70
	density = TRUE
	anchored = TRUE
	/// The range at which we provide shield support to a mob.
	var/shield_range = 8
	/// A list of mobs we are currently shielding with attached beams.
	var/list/shielded_mobs = list()

/obj/structure/xen_pylon/Initialize(mapload)
	. = ..()
	for(var/mob/living/simple_animal/hostile/blackmesa/xen/iterating_mob in range(shield_range, src))
		if(!iterating_mob.can_be_shielded)
			continue
		register_mob(iterating_mob)
	for(var/turf/iterating_turf in RANGE_TURFS(shield_range, src))
		RegisterSignal(iterating_turf, COMSIG_ATOM_ENTERED, .proc/mob_entered_range)

/obj/structure/xen_pylon/proc/mob_entered_range(datum/source, atom/movable/entered_atom)
	SIGNAL_HANDLER
	if(!isxenmob(entered_atom))
		return
	var/mob/living/simple_animal/hostile/blackmesa/xen/entered_xen_mob = entered_atom
	if(!entered_xen_mob.can_be_shielded)
		return
	register_mob(entered_xen_mob)

/obj/structure/xen_pylon/proc/register_mob(mob/living/simple_animal/hostile/blackmesa/xen/mob_to_register)
	if(mob_to_register in shielded_mobs)
		return
	if(!istype(mob_to_register))
		return
	shielded_mobs += mob_to_register
	mob_to_register.shielded = TRUE
	mob_to_register.shield_count++
	mob_to_register.update_appearance()
	var/datum/beam/created_beam = Beam(mob_to_register, icon_state = "red_lightning", time = 10 MINUTES, maxdistance = (shield_range - 1))
	shielded_mobs[mob_to_register] = created_beam
	RegisterSignal(created_beam, COMSIG_PARENT_QDELETING, .proc/beam_died, override = TRUE)
	RegisterSignal(mob_to_register, COMSIG_PARENT_QDELETING, .proc/mob_died, override = TRUE)

/obj/structure/xen_pylon/proc/mob_died(atom/movable/source, force)
	SIGNAL_HANDLER
	var/datum/beam/beam = shielded_mobs[source]
	QDEL_NULL(beam)
	shielded_mobs[source] = null
	shielded_mobs -= source

/obj/structure/xen_pylon/proc/beam_died(datum/beam/beam_to_kill)
	SIGNAL_HANDLER
	for(var/mob/living/simple_animal/hostile/blackmesa/xen/iterating_mob as anything in shielded_mobs)
		if(shielded_mobs[iterating_mob] == beam_to_kill)
			iterating_mob.lose_shield()
			shielded_mobs[iterating_mob] = null
			shielded_mobs -= iterating_mob

/obj/structure/xen_pylon/Destroy()
	for(var/mob/living/simple_animal/hostile/blackmesa/xen/iterating_mob as anything in shielded_mobs)
		iterating_mob.lose_shield()
		var/datum/beam/beam = shielded_mobs[iterating_mob]
		QDEL_NULL(beam)
		shielded_mobs[iterating_mob] = null
		shielded_mobs -= iterating_mob
	shielded_mobs = null
	playsound(src, 'sound/magic/lightningbolt.ogg', 100, TRUE)
	new /obj/item/grenade/xen_crystal(get_turf(src))
	return ..()
