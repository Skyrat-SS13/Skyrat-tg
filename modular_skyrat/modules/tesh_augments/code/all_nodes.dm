//teshari_ robolimb research node

/datum/techweb_node/teshari_cyber
	id = "teshari_cyber"
	display_name = "Raptoral Cybernetics"
	description = "Specialized civilian-grade cybernetic limb designs."
	prereq_ids = list("robotics")
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
	id = "adv_teshari_cyber"
	display_name = "Advanced Raptoral Cybernetics"
	description = "Specialized industrial-grade cybernetic limb designs."
	prereq_ids = list("cybernetics", "teshari_cyber")
	design_ids = list(
		"teshari_advanced_l_arm",
		"teshari_advanced_r_arm",
		"teshari_advanced_l_leg",
		"teshari_advanced_r_leg",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
