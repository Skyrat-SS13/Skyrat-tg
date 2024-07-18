//digitigrade research

/datum/techweb_node/digitigrade_cyber
	id = TECHWEB_NODE_CYBERNETICS_DIGITIGRADE
	display_name = "Digitigrade Cybernetics"
	description = "Specialized cybernetic limb designs. The shortening of the femur is surely the result of mechanical optimization."
	prereq_ids = list(TECHWEB_NODE_ROBOTICS)
	design_ids = list(
		"digitigrade_cyber_l_leg",
		"digitigrade_cyber_r_leg",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)


/datum/techweb_node/adv_digitigrade_cyber
	id = TECHWEB_NODE_CYBERNETICS_DIGITIGRADE_ADVANCED
	display_name = "Advanced Digitigrade Cybernetics"
	description = "A step above consumer-grade digitigrade models, these have self-sharpening claws for destroying your footwear much faster."
	prereq_ids = list(TECHWEB_NODE_AUGMENTATION)
	design_ids = list(
		"digitigrade_advanced_l_leg",
		"digitigrade_advanced_r_leg",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS)
