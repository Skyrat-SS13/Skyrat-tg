//teshari_ robolimb research node

/datum/techweb_node/teshari_cyber
	id = TECHWEB_NODE_CYBERNETICS_TESHARI
	display_name = "Raptoral Cybernetics"
	description = "Specialized civilian-grade cybernetic limb designs."
	prereq_ids = list(TECHWEB_NODE_ROBOTICS)
	design_ids = list(
		"teshari_cyber_chest",
		"teshari_cyber_l_arm",
		"teshari_cyber_r_arm",
		"teshari_cyber_l_leg",
		"teshari_cyber_r_leg",
		"teshari_cyber_head",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)


/datum/techweb_node/adv_teshari_cyber
	id = TECHWEB_NODE_CYBERNETICS_TESHARI_ADVANCED
	display_name = "Advanced Raptoral Cybernetics"
	description = "Specialized industrial-grade cybernetic limb designs."
	prereq_ids = list(TECHWEB_NODE_CYBERNETICS, TECHWEB_NODE_CYBERNETICS_TESHARI)
	design_ids = list(
		"teshari_advanced_l_arm",
		"teshari_advanced_r_arm",
		"teshari_advanced_l_leg",
		"teshari_advanced_r_leg",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
