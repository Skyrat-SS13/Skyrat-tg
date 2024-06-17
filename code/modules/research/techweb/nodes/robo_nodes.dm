/datum/techweb_node/robotics
	id = "robotics"
	starting_node = TRUE
	display_name = "Robotics"
	description = "Programmable machines that make our lives lazier."
	design_ids = list(
		"mechfab",
		"botnavbeacon",
		"paicard",
	)

/datum/techweb_node/exodrone
	id = "exodrone"
	display_name = "Exploration Drones"
	description = "Adapted arcade machines to covertly harness gamers' skills in controlling real drones for practical purposes."
	prereq_ids = list("robotics")
	design_ids = list(
		"exoscanner_console",
		"exoscanner",
		"exodrone_console",
		"exodrone_launcher",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

// AI root node
/datum/techweb_node/ai
	id = "ai"
	display_name = "Artificial Intelligence"
	description = "Exploration of AI systems, more intelligent than the entire crew put together."
	prereq_ids = list("robotics")
	design_ids = list(
		"aiupload",
		"aifixer",
		"intellicard",
		"mecha_tracking_ai_control",
		"borg_ai_control",
		"aicore",
		"reset_module",
		"asimov_module",
		"default_module",
		"nutimov_module",
		"paladin_module",
		"robocop_module",
		"corporate_module",
		"drone_module",
		"oxygen_module",
		"safeguard_module",
		"protectstation_module",
		"quarantine_module",
		"freeform_module",
		"remove_module",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)

/datum/techweb_node/ai/New()
	. = ..()
	if(HAS_TRAIT(SSstation, STATION_TRAIT_HUMAN_AI))
		design_ids -= list(
			"aicore",
			"borg_ai_control",
			"intellicard",
			"mecha_tracking_ai_control",
			"aifixer",
			"aiupload",
		)
	else if(HAS_TRAIT(SSstation, STATION_TRAIT_UNIQUE_AI))
		research_costs[TECHWEB_POINT_TYPE_GENERIC] *= 3

/datum/techweb_node/ai_laws
	id = "ai_laws"
	display_name = "Advanced AI Laws"
	description = "Delving into sophisticated AI directives, with hopes that they won't lead to humanity's extinction."
	prereq_ids = list("ai")
	design_ids = list(
		"asimovpp_module",
		"paladin_devotion_module",
		"dungeon_master_module",
		"painter_module",
		"ten_commandments_module",
		"hippocratic_module",
		"maintain_module",
		"liveandletlive_module",
		"reporter_module",
		"yesman_module",
		"hulkamania_module",
		"peacekeeper_module",
		"overlord_module",
		"tyrant_module",
		"antimov_module",
		"balance_module",
		"thermurderdynamic_module",
		"damaged_module",
		"freeformcore_module",
		"onehuman_module",
		"purge_module",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)
