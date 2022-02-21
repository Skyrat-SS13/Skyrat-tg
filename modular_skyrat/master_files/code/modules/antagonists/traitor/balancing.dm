// Uplinks
/obj/item/multitool/uplink/Initialize(mapload, owner, tc_amount)
	. = ..()
	tc_amount = 10

/obj/item/pen/uplink/Initialize(mapload, owner, tc_amount)
	. = ..()
	tc_amount = 10

/obj/item/uplink/Initialize(mapload, owner, tc_amount)
	. = ..()
	tc_amount = 10

/obj/item/implant/uplink/starting/Initialize(mapload, uplink_handler)
	. = ..()
	starting_tc = 10 - UPLINK_IMPLANT_TELECRYSTAL_COST

// Progression
/datum/traitor_objective
	// Determines how influential global progression will affect this objective. Set to 0 to disable.
	global_progression_influence_intensity = 0.2
	// Determines how great the deviance has to be before progression starts to get reduced.
	global_progression_deviance_required = 0.5

// Objectives
/datum/traitor_objective/hack_comm_console
	progression_reward = 20 MINUTES
	telecrystal_reward = 3

/datum/traitor_objective/destroy_item/very_risky
	telecrystal_reward = 2
