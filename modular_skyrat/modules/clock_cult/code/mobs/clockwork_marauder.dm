GLOBAL_LIST_EMPTY(clockwork_marauders)

/mob/living/basic/clockwork_marauder
	name = "clockwork marauder"
	desc = "A brass machine of destruction."
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_mobs.dmi'
	icon_state = "clockwork_marauder"
	icon_living = "clockwork_marauder"
	icon_dead = ""
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	sentience_type = SENTIENCE_HUMANOID
	maxHealth = 140
	health = 140
	basic_mob_flags = DEL_ON_DEATH
	speed = 1.1
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	melee_damage_lower = 24
	melee_damage_upper = 24
	attack_verb_continuous = "slices"
	attack_verb_simple = "slice"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	combat_mode = TRUE
	pass_flags = PASSTABLE
	mob_size = MOB_SIZE_LARGE
	move_resist = MOVE_FORCE_OVERPOWERING
	unsuitable_atmos_damage = 0
	minimum_survivable_temperature = 0
	obj_damage = 80
	faction = list(FACTION_CLOCK)
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	ai_controller = /datum/ai_controller/basic_controller/clockwork_marauder


	var/static/list/loot = list(
		/obj/structure/fluff/clockwork/alloy_shards/large = 1,
		/obj/structure/fluff/clockwork/alloy_shards/medium = 2,
		/obj/structure/fluff/clockwork/alloy_shards/small = 3,
	)


/mob/living/basic/clockwork_marauder/Initialize(mapload)
	. = ..()
	if(length(loot))
		AddElement(/datum/element/death_drops, loot)

	GLOB.clockwork_marauders += src


/mob/living/basic/clockwork_marauder/Destroy()
	GLOB.clockwork_marauders -= src
	return ..()


/datum/language_holder/clockmob
	understood_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
								/datum/language/ratvar = list(LANGUAGE_ATOM))
	spoken_languages = list(/datum/language/ratvar = list(LANGUAGE_ATOM))



/datum/ai_controller/basic_controller/clockwork_marauder
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic/clockwork_marauder()
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/clockwork_marauder,
	)

/datum/ai_planning_subtree/basic_melee_attack_subtree/clockwork_marauder
	melee_attack_behavior = /datum/ai_behavior/basic_melee_attack/clockwork_marauder

/datum/ai_behavior/basic_melee_attack/clockwork_marauder
	action_cooldown = 1.2 SECONDS

/datum/targetting_datum/basic/clockwork_marauder
	stat_attack = HARD_CRIT

