/datum/techweb_node/exp_tools/New()
	. = ..()
	// if this datum is ever instantiated twice, somehow, this is more efficient. i feel like an idiot writing this
	var/static/list/science_tools = list(
		SCIENCE_JAWS_OF_LIFE_DESIGN_ID,
		SCIENCE_DRILL_DESIGN_ID,
	)
	design_ids += science_tools

