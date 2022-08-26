/// SKYRAT MODULE SKYRAT_XENO_REDO

/mob/living/carbon/alien/humanoid/skyrat/praetorian
	name = "alien praetorian"
	caste = "prae"
	maxHealth = 400
	health = 400
	icon_state = "alienprae"
	var/datum/action/cooldown/alien/skyrat/heal_aura/juiced/heal_aura_ability
	var/datum/action/cooldown/spell/aoe/repulse/xeno/hard_throwing/tail_sweep
	melee_damage_lower = 25
	melee_damage_upper = 30
	next_evolution = /mob/living/carbon/alien/humanoid/skyrat/queen

/mob/living/carbon/alien/humanoid/skyrat/praetorian/Initialize(mapload)
	. = ..()
	heal_aura_ability = new /datum/action/cooldown/alien/skyrat/heal_aura/juiced()
	heal_aura_ability.Grant(src)

	tail_sweep = new /datum/action/cooldown/spell/aoe/repulse/xeno/hard_throwing()
	tail_sweep.Grant(src)

	REMOVE_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT)

/mob/living/carbon/alien/humanoid/skyrat/praetorian/Destroy()
	QDEL_NULL(heal_aura_ability)
	return ..()

/mob/living/carbon/alien/humanoid/skyrat/praetorian/create_internal_organs()
	internal_organs += new /obj/item/organ/internal/alien/plasmavessel/large
	internal_organs += new /obj/item/organ/internal/alien/neurotoxin/spitter
	internal_organs += new /obj/item/organ/internal/alien/resinspinner
	..()

/datum/action/cooldown/alien/skyrat/heal_aura/juiced
	name = "Strong Healing Aura"
	desc = "Friendly xenomorphs in a longer range around yourself will receive passive healing."
	button_icon_state = "healaura_juiced"
	plasma_cost = 100
	cooldown_time = 90 SECONDS
	aura_range = 7
	aura_healing_amount = 10
	aura_healing_color = COLOR_RED_LIGHT

/datum/action/cooldown/spell/aoe/repulse/xeno/hard_throwing
	name = "Tail Sweep"

	cooldown_time = 60 SECONDS

	aoe_radius = 3

	icon_icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
	button_icon_state = "throw_tail"

	sparkle_path = /obj/effect/temp_visual/dir_setting/tailsweep/praetorian

	sound = 'modular_skyrat/modules/xenos_skyrat_redo/sound/alien_tail_swipe.ogg' //The defender's tail sound isn't changed because its big and heavy, this isn't

/datum/action/cooldown/spell/aoe/repulse/xeno/hard_throwing/cast_on_thing_in_aoe(atom/movable/victim, atom/caster)
	if(isalien(victim))
		return
	var/turf/throwtarget = get_edge_target_turf(caster, get_dir(caster, get_step_away(victim, caster)))
	var/dist_from_caster = get_dist(victim, caster)

	if(dist_from_caster == 0)
		if(isliving(victim))
			var/mob/living/victim_living = victim
			victim_living.Knockdown(10 SECONDS)
			victim_living.apply_damage(20,BRUTE,BODY_ZONE_CHEST,wound_bonus=10) //It doesn't hurt as hard as other xenos because praetorians aren't meant to be frontlining
			shake_camera(victim, 4, 3)
			playsound(victim, 'sound/weapons/slap.ogg', 50, TRUE) //Ayo HOS this xeno ain't shi- SMACK
			to_chat(victim, span_userdanger("You're slapped into the floor by [caster]'s tail!"))
	else
		if(sparkle_path)
			new sparkle_path(get_turf(victim), get_dir(caster, victim))

		if(isliving(victim))
			var/mob/living/victim_living = victim
			victim_living.Knockdown(4 SECONDS)
			victim_living.apply_damage(20,BRUTE,BODY_ZONE_CHEST,wound_bonus=10)
			shake_camera(victim, 4, 3)
			playsound(victim, 'sound/weapons/slap.ogg', 25, TRUE)
			to_chat(victim, span_userdanger("[caster]'s tail crashes into you, throwing you back!"))

		victim.safe_throw_at(throwtarget, ((clamp((max_throw - (clamp(dist_from_caster - 2, 0, dist_from_caster))), 3, max_throw))), 1, caster, force = repulse_force)

/obj/effect/temp_visual/dir_setting/tailsweep/praetorian
	icon = 'modular_skyrat/modules/xenos_skyrat_redo/icons/xeno_actions.dmi'
	icon_state = "throw_tail_anim"
