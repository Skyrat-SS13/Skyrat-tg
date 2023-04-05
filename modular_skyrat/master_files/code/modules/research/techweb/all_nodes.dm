
/datum/techweb_node/adv_vision
	id = "adv_vision"
	display_name = "Combat Cybernetic Eyes"
	description = "Military grade combat implants to improve vision."
	prereq_ids = list("combat_cyber_implants", "alien_bio")
	design_ids = list(
		"ci-thermals",
		"ci-xray",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 4000)
