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

	icon_icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
	button_icon_state = "crush_tail"

	sparkle_path = /obj/effect/temp_visual/dir_setting/tailsweep/defender

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
			playsound(victim, 'sound/effects/clang.ogg', 50, TRUE) //the defender's tail is literally just a small wrecking ball, CLANG
			to_chat(victim, span_userdanger("You're slammed into the floor by [caster]'s tail!"))
	else
		if(sparkle_path)
			new sparkle_path(get_turf(victim), get_dir(caster, victim))

		if(isliving(victim))
			var/mob/living/victim_living = victim
			victim_living.Knockdown(4 SECONDS)
			victim_living.apply_damage(30,BRUTE,BODY_ZONE_CHEST,wound_bonus=20)
			shake_camera(victim, 4, 3)
			playsound(victim, 'sound/effects/clang.ogg', 25, TRUE)
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
	playsound(charger, 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_roar1.ogg', 100, TRUE)
