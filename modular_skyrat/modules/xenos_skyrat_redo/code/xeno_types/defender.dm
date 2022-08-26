/// SKYRAT MODULE SKYRAT_XENO_REDO

/mob/living/carbon/alien/humanoid/skyrat/defender
	name = "alien defender"
	caste = "defender"
	maxHealth = 300
	health = 300
	icon_state = "aliendefender"
	melee_damage_lower = 25
	melee_damage_upper = 30
	var/datum/action/cooldown/mob_cooldown/charge/basic_charge/defender/charge
	var/datum/action/cooldown/spell/aoe/repulse/xeno/crushing/tail_sweep
	/// var/datum/action/cooldown/alien/skyrat/crest_defence/crest_defending
	next_evolution = /mob/living/carbon/alien/humanoid/skyrat/warrior

/mob/living/carbon/alien/humanoid/skyrat/defender/Initialize(mapload)
	. = ..()
	tail_sweep = new /datum/action/cooldown/spell/aoe/repulse/xeno/crushing()
	tail_sweep.Grant(src)

	charge = new /datum/action/cooldown/mob_cooldown/charge/basic_charge/defender()
	charge.Grant(src)

	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/*
	crest_defending = new /datum/action/cooldown/alien/skyrat/crest_defence()
	crest_defending.Grant(src)
*/

	add_movespeed_modifier(/datum/movespeed_modifier/alien_heavy)

/mob/living/carbon/alien/humanoid/skyrat/defender/Destroy()
	QDEL_NULL(charge)
	QDEL_NULL(tail_sweep)
	/// QDEL_NULL(crest_defending)
	return ..()

/mob/living/carbon/alien/humanoid/skyrat/defender/create_internal_organs()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/small
	..()

/datum/action/cooldown/spell/aoe/repulse/xeno/crushing
	name = "Crushing Tail Sweep"
	desc = "Throw back attackers with a sweep of your tail, likely breaking some bones in the process."

	cooldown_time = 60 SECONDS

	aoe_radius = 1

	icon_icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
	button_icon_state = "crush_tail"

	sparkle_path = /obj/effect/temp_visual/dir_setting/tailsweep/defender

/datum/action/cooldown/spell/aoe/repulse/xeno/crushing/IsAvailable()
	. = ..()
	if(!isalien(owner))
		return FALSE
	var/mob/living/carbon/alien/humanoid/skyrat/owner_alien = owner
	if(owner_alien.unable_to_use_abilities)
		return FALSE

/datum/action/cooldown/spell/aoe/repulse/xeno/crushing/cast_on_thing_in_aoe(atom/movable/victim, atom/caster)
	if(isalien(victim))
		return
	var/turf/throwtarget = get_edge_target_turf(caster, get_dir(caster, get_step_away(victim, caster)))
	var/dist_from_caster = get_dist(victim, caster)

	if(dist_from_caster == 0)
		if(isliving(victim))
			var/mob/living/victim_living = victim
			victim_living.Knockdown(10 SECONDS)
			victim_living.apply_damage(30,BRUTE,BODY_ZONE_CHEST,wound_bonus=20)
			shake_camera(victim, 4, 3)
			playsound(victim, 'sound/effects/clang.ogg', 100, TRUE, 8, 0.9) //the defender's tail is literally just a small wrecking ball, CLANG
			to_chat(victim, span_userdanger("You're slammed into the floor by [caster]'s tail!"))
	else
		if(sparkle_path)
			new sparkle_path(get_turf(victim), get_dir(caster, victim))

		if(isliving(victim))
			var/mob/living/victim_living = victim
			victim_living.Knockdown(4 SECONDS)
			victim_living.apply_damage(30,BRUTE,BODY_ZONE_CHEST,wound_bonus=20)
			shake_camera(victim, 4, 3)
			playsound(victim, 'sound/effects/clang.ogg', 100, TRUE, 8, 0.9)
			to_chat(victim, span_userdanger("[caster]'s tail slams into you, throwing you back!"))

		victim.safe_throw_at(throwtarget, ((clamp((max_throw - (clamp(dist_from_caster - 2, 0, dist_from_caster))), 3, max_throw))), 1, caster, force = repulse_force)

/obj/effect/temp_visual/dir_setting/tailsweep/defender
	icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
	icon_state = "crush_tail_anim"

/datum/action/cooldown/mob_cooldown/charge/basic_charge/defender
	name = "Charge Attack"
	desc = "Allows you to charge at a position, trampling any in your path."
	cooldown_time = 15 SECONDS
	charge_delay = 0.3 SECONDS
	charge_distance = 5
	destroy_objects = FALSE
	charge_damage = 50
	icon_icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
	button_icon_state = "defender_charge"
	unset_after_click = TRUE

/datum/action/cooldown/mob_cooldown/charge/basic_charge/defender/do_charge_indicator(atom/charger, atom/charge_target)
	. = ..()
	playsound(charger, 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_roar1.ogg', 100, TRUE, 8, 0.9)

/datum/action/cooldown/mob_cooldown/charge/basic_charge/defender/Activate(atom/target_atom)
	. = ..()
	return TRUE

/* I'm not quite sure how to give mobs like this armor yet
/datum/action/cooldown/alien/skyrat/crest_defence
	name = "Crest Defense"
	desc = "Trades speed for damage reduction, useful for getting into big fights where you don't need to run."
	button_icon_state = "fucking_invincible"
	cooldown_time = 1 SECONDS
	var/crest_defending = FALSE

/datum/action/cooldown/alien/skyrat/crest_defence/Activate()
	. = ..()
	var/mob/living/carbon/alien/humanoid/skyrat/defender = owner
	if(!crest_defending)
		defender.balloon_alert(defender, "crest defense active")
		to_chat(defender, span_danger("We drop into a defensive stance, using our large crest to protect ourselves from oncoming damage at the cost of being slower."))
		defender.alien_damage_multiplier = 0.4
		playsound(defender, 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_hiss.ogg', 100, TRUE)
		crest_defending = TRUE
		defender.icon_state = "alien[defender.caste]_crest"
		defender.add_movespeed_modifier(/datum/movespeed_modifier/defender_crest)
		return TRUE
	if(crest_defending)
		defender.balloon_alert(defender, "crest defense ended")
		defender.alien_damage_multiplier = 0.8
		crest_defending = FALSE
		defender.icon_state = "alien[defender.caste]"
		defender.remove_movespeed_modifier(/datum/movespeed_modifier/defender_crest)
		return TRUE

/datum/movespeed_modifier/defender_crest
	multiplicative_slowdown = 2
*/
