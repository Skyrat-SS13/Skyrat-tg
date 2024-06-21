/*
*	MELEE
*/

/mob/living/basic/abductor
	name = "abductor scientist"
	desc = "From the depths of space."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/abductors.dmi'
	icon_state = "abductor_scientist"
	icon_living = "abductor_scientist"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	faction = list(ROLE_ABDUCTOR)

	maxHealth = 120
	health = 120
	unsuitable_atmos_damage = 7.5
	basic_mob_flags = DEL_ON_DEATH

	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'

	combat_mode = TRUE
	status_flags = CANPUSH
	speed = 2

	ai_controller = /datum/ai_controller/basic_controller/abductor

	/// What this mob drops on death
	var/list/loot = list(/obj/effect/gibspawner/generic, /obj/effect/spawner/random/astrum/sci_loot)

/mob/living/basic/abductor/Initialize(mapload)
	. = ..()
	if(LAZYLEN(loot))
		loot = string_list(loot)
		AddElement(/datum/element/death_drops, loot)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_SHOE)


// More damaging variant
/mob/living/basic/abductor/melee
	icon_state = "abductor_scientist_melee"
	icon_living = "abductor_scientist_melee"
	status_flags = null

	melee_damage_lower = 10
	melee_damage_upper = 20
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	attack_vis_effect = ATTACK_EFFECT_SLASH


// Tankier, more damaging variant
/mob/living/basic/abductor/agent
	name = "abductor agent"
	icon_state = "abductor_agent"
	icon_living = "abductor_agent"

	health = 160
	maxHealth = 160
	loot = list(/obj/effect/gibspawner/generic, /obj/effect/spawner/random/astrum/agent_loot)

	melee_damage_lower = 15
	melee_damage_upper = 22


/*
*	RANGED
*/

/mob/living/basic/abductor/ranged
	name = "abductor scientist"
	icon_state = "abductor_scientist_gun"
	icon_living = "abductor_scientist_gun"

	maxHealth = 120
	health = 120
	loot = list(/obj/effect/gibspawner/generic, /obj/effect/spawner/random/astrum/sci_loot)

	ai_controller = /datum/ai_controller/basic_controller/abductor/ranged

/mob/living/basic/abductor/ranged/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/ranged_attacks, projectile_sound = 'sound/weapons/laser.ogg', projectile_type = /obj/projectile/beam/laser)


// Tankier variant
/mob/living/basic/abductor/ranged/agent
	name = "abductor combat specialist"
	icon_state = "abductor_agent_combat_gun"
	icon_living = "abductor_agent_combat_gun"

	maxHealth = 140
	health = 140
	loot = list(/obj/effect/gibspawner/generic, /obj/effect/spawner/random/astrum/agent_loot)


/**
 * BOSS
 */

/mob/living/simple_animal/hostile/megafauna/hierophant/astrum
	name = "abductor captain"
	desc = "The one you've come here for. Finish this."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/abductors.dmi'
	icon_state = "abductor_agent_combat"
	icon_living = "abductor_agent_combat"
	icon_gib = "syndicate_gib"
	gps_name = "Captain's Signal"
	mouse_opacity = MOUSE_OPACITY_ICON

	health = 1750
	maxHealth = 1750
	health_doll_icon = "pandora"
	death_message = "falls to their knees before exploding into a ball of gore."

	attack_verb_continuous = "attacks"
	attack_verb_simple = "attack"

/mob/living/simple_animal/hostile/megafauna/hierophant/astrum/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	. = ..()
	if(. != BULLET_ACT_HIT)
		return

	if(!hitting_projectile.is_hostile_projectile())
		return

	apply_damage(hitting_projectile.damage, hitting_projectile.damage_type) // no damage reduction

/mob/living/simple_animal/hostile/megafauna/hierophant/astrum/death(gibbed)
	spawn_gibs()
	spawn_gibs()
	new /obj/item/key/gateway(get_turf(src))
	new /obj/item/gun/energy/alien/zeta(get_turf(src))
	qdel(src)
