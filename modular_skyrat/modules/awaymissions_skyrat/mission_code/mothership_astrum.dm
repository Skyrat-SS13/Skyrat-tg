///// AREAS, None of these should need power or lighting. I'd sooner die than hand-light this entire map

/area/awaymission/mothership_astrum/halls
	name = "Mothership Astrum Hallways"
	icon_state = "away1"
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck1
	name = "Mothership Astrum Combat Holodeck"
	icon_state = "away2"
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck2
	name = "Mothership Astrum Recreation Holodeck"
	icon_state = "away3"
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck3
	name = "Mothership Astrum Frozen Holodeck"
	icon_state = "away4"
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck4
	name = "Mothership Astrum Xeno Studies Holodeck"
	icon_state = "away4"
	requires_power = FALSE

/area/awaymission/mothership_astrum/deck5
	name = "Mothership Astrum Beach Holodeck"
	icon_state = "away5"
	requires_power = FALSE

//Fluff Notes

//Simplemobs

/mob/living/simple_animal/hostile/abductor
	name = "Abductor Scientist"
	desc = "From the depths of space."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons'
	icon_state = "abductor_scientist"
	icon_living = "syndicate"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	speak_chance = 0
	turns_per_move = 5
	speed = 0
	stat_attack = HARD_CRIT
	robust_searching = 1
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	combat_mode = TRUE
	loot = list(/obj/effect/gibspawner/human)
	atmos_requirements = list("min_oxy" = 5, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 1, "min_co2" = 0, "max_co2" = 5, "min_n2" = 0, "max_n2" = 0)
	unsuitable_atmos_damage = 7.5
	faction = list(ROLE_ABDUCTOR)
	check_friendly_fire = 1
	status_flags = CANPUSH
	del_on_death = 1
	dodging = TRUE
	rapid_melee = 2
	footstep_type = FOOTSTEP_MOB_SHOE

