
/datum/techweb_node/adv_vision
	id = "adv_vision"
	display_name = "Combat Cybernetic Eyes"
	description = "Military grade combat implants to improve vision."
	prereq_ids = list("combat_cyber_implants","alien_bio")
	design_ids = list(
		"ci-thermals",
		"ci-xray",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 4000)

/datum/techweb_node/industrial_mining
	id = "industrial_mining"
	display_name = "Industrial Mining Technology"
	description = "For when better than efficiency V isn't quite enough."
	prereq_ids = list("basic_mining")
	design_ids = list(
		"mining_drill",
		"mining_brace",
		"metal_density_scanner"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 2500)

/datum/techweb_node/adv_industrial_mining
	id = "adv_industrial_mining"
	display_name = "Advanced Industrial Mining Technology"
	description = "And even then, sometimes you just need a little more materials."
	prereq_ids = list("industrial_mining")
	design_ids = list(
		"adv_metal_density_scanner"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000) // Change this research cost if more things get added
