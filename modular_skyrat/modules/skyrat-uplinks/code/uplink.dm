////
// Uplinks starting TC
/datum/component/uplink/Initialize(
	owner,
	lockable = TRUE,
	enabled = FALSE,
	uplink_flag = UPLINK_TRAITORS,
	starting_tc = TELECRYSTALS_DEFAULT,
	has_progression = FALSE,
	datum/uplink_handler/uplink_handler_override,
)
	starting_tc = TELECRYSTALS_SKYRAT
	return ..()

/obj/item/implant/uplink/implant(mob/living/carbon/target, mob/user, silent, force)
	. = ..()

	var/datum/component/uplink/uplink = GetComponent(/datum/component/uplink)
	uplink.set_telecrystals(TELECRYSTALS_SKYRAT - UPLINK_IMPLANT_TELECRYSTAL_COST)

////
// Objectives rewards

// hack_comm_console.dm
/datum/traitor_objective/hack_comm_console/generate_objective(datum/mind/generating_for, list/possible_duplicates)
	. = ..()

	progression_reward = 20 MINUTES
	telecrystal_reward = 3

// destroy_item.dm
/datum/traitor_objective/destroy_item/generate_objective(datum/mind/generating_for, list/possible_duplicates)
	. = ..()

	if(istype(target_item, /datum/objective_item/steal/blackbox))
		telecrystal_reward = 2

// steal.dm
/datum/traitor_objective/steal_item/generate_objective(datum/mind/generating_for, list/possible_duplicates)

	minutes_per_telecrystal = 30 // Every 30 minutes the reward raises by 1 TC

	. = ..()

	if(istype(target_item, /datum/objective_item/steal/hoslaser))
		telecrystal_reward = 3
	else if(istype(target_item, /datum/objective_item/steal/caplaser))
		telecrystal_reward = 2

	if(!telecrystal_reward)	// No reward is unfun
		telecrystal_reward = 1
