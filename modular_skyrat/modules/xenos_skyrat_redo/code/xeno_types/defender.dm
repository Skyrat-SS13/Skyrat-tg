/mob/living/carbon/alien/humanoid/skyrat/defender
	name = "alien defender"
	caste = "defender"
	maxHealth = 300
	health = 300
	icon_state = "aliendefender"
	var/datum/action/cooldown/alien/skyrat/evade/evade_ability
	melee_damage_lower = 25
	melee_damage_upper = 30
	damage_coeff = 0.8
	var/datum/action/cooldown/mob_cooldown/charge/basic_charge/defender/charge
	var/datum/action/cooldown/spell/aoe/repulse/xeno/crushing/tail_sweep

/mob/living/carbon/alien/humanoid/skyrat/defender/Initialize(mapload)
	. = ..()
	tail_sweep = new /datum/action/cooldown/spell/aoe/repulse/xeno/crushing()
	tail_sweep.Grant(src)

	charge = new /datum/action/cooldown/mob_cooldown/charge/basic_charge/defender()
	charge.Grant(src)

/mob/living/carbon/alien/humanoid/skyrat/defender/Destroy()
	QDEL_NULL(charge)
	QDEL_NULL(tail_sweep)
	return ..()

/mob/living/carbon/alien/humanoid/skyrat/defender/create_internal_organs()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/small
	..()

/datum/action/cooldown/spell/aoe/repulse/xeno/crushing
	name = "Crushing Tail Sweep"
	desc = "Throw back attackers with a sweep of your tail, likely breaking some bones in the process."

	cooldown_time = 60 SECONDS

	aoe_radius = 1

/datum/action/cooldown/spell/aoe/repulse/xeno/crushing/cast_on_thing_in_aoe(atom/movable/victim, atom/caster)
	if(ismob(victim))
		var/mob/victim_mob = victim
		if(victim_mob.can_block_magic(antimagic_flags))
			return

	var/turf/throwtarget = get_edge_target_turf(caster, get_dir(caster, get_step_away(victim, caster)))
	var/dist_from_caster = get_dist(victim, caster)

	if(dist_from_caster == 0)
		if(isliving(victim))
			var/mob/living/victim_living = victim
			victim_living.Knockdown(10 SECONDS)
			var/obj/item/bodypart/chest/victim_chest = victim_living.get_bodypart(BODY_ZONE_CHEST)
			if(victim_chest)
				victim_chest.receive_damage(brute=30,wound_bonus=20)
			to_chat(victim, span_userdanger("You're slammed into the floor by [caster]'s tail!"))
	else
		if(sparkle_path)
			new sparkle_path(get_turf(victim), get_dir(caster, victim))

		if(isliving(victim))
			var/mob/living/victim_living = victim
			victim_living.Knockdown(4 SECONDS)
			var/obj/item/bodypart/chest/victim_chest = victim_living.get_bodypart(BODY_ZONE_CHEST)
			if(victim_chest)
				victim_chest.receive_damage(brute=30,wound_bonus=20)
			to_chat(victim, span_userdanger("[caster]'s tail slams into you, throwing you back!"))

		victim.safe_throw_at(throwtarget, ((clamp((max_throw - (clamp(dist_from_caster - 2, 0, dist_from_caster))), 3, max_throw))), 1, caster, force = repulse_force)

/datum/action/cooldown/mob_cooldown/charge/basic_charge/defender
	name = "Charge Attack"
	cooldown_time = 15 SECONDS
	charge_delay = 1 SECONDS
	charge_distance = 5
	destroy_objects = FALSE
	charge_damage = 50

/datum/action/cooldown/mob_cooldown/charge/basic_charge/defender/on_bump(atom/movable/source, atom/target)
	SIGNAL_HANDLER
	if(owner == target)
		return

	INVOKE_ASYNC(src, .proc/DestroySurroundings, source)
	hit_target(source, target, charge_damage)

/datum/action/cooldown/mob_cooldown/charge/basic_charge/defender/charge_sequence(atom/movable/charger, atom/target_atom, delay, past)
	. = ..()
	unset_click_ability()
