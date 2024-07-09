/datum/ai_controller/basic_controller/stillcap
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/allow_items,
		BB_PET_TARGETING_STRATEGY = /datum/targeting_strategy/basic/not_friends,
		BB_BASIC_MOB_FLEE_DISTANCE = 25,
		BB_AGGRO_RANGE = 5,
		BB_TARGET_MINIMUM_STAT = HARD_CRIT,
		BB_HIDING_HIDDEN = FALSE,
		BB_HIDING_AGGRO_RANGE = DEFAULT_HIDING_AGGRO_RANGE,
		BB_HIDING_COOLDOWN_MAXIMUM = 3 MINUTES,
		BB_HIDING_COOLDOWN_MINIMUM = 1 MINUTES,
		BB_HIDING_RANDOM_STOP_HIDING_CHANCE = 2,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk/hide

	planning_subtrees = list(
		/datum/ai_planning_subtree/pet_planning,
		/datum/ai_planning_subtree/stop_hiding_if_target,
		/datum/ai_planning_subtree/simple_find_nearest_target_to_flee,
		/datum/ai_planning_subtree/stop_hiding_if_target,
		/datum/ai_planning_subtree/flee_target,
		/datum/ai_planning_subtree/random_hiding,
		/datum/ai_planning_subtree/target_retaliate/check_faction/stop_hiding,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/stop_hiding_if_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)
