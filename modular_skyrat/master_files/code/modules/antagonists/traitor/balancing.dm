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


// Objectives rewards
/datum/traitor_objective/hack_comm_console
	progression_reward = 20 MINUTES
	telecrystal_reward = 3

/datum/traitor_objective/destroy_item/very_risky
	telecrystal_reward = 2
