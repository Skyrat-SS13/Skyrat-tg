/datum/techweb_node/basic_microfusion
	id = "basic_microfusion"
	starting_node = TRUE
	display_name = "Basic Microfusion Technology"
	description = "Basic microfusion technology allowing for basic microfusion designs."
	design_ids = list(
		"basic_microfusion_cell",
	)

//Enhanced microfusion
/datum/techweb_node/enhanced_microfusion
	id = "enhanced_microfusion"
	display_name = "Enhanced Microfusion Technology"
	description = "Enhanced microfusion technology allowing for upgraded basic microfusion!"
	prereq_ids = list(
		"basic_microfusion",
		"engineering",
		"weaponry",
		"high_efficiency",
	)
	design_ids = list(
		"enhanced_microfusion_cell",
		"microfusion_cell_attachment_overcapacity",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3500)

//Advanced microfusion
/datum/techweb_node/advanced_microfusion
	id = "advanced_microfusion"
	display_name = "Advanced Microfusion Technology"
	description = "Advanced microfusion technology allowing for advanced microfusion!"
	prereq_ids = list(
		"enhanced_microfusion",
		"adv_engi",
		"adv_weaponry",
		"adv_power",
		"adv_plasma",
	)
	design_ids = list(
		"advanced_microfusion_cell",
		"microfusion_cell_attachment_rechargable",
		"microfusion_cell_attachment_stabaliser",
		"microfusion_gun_attachment_scatter",

	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)


// Bluespace microfusion
/datum/techweb_node/bluespace_microfusion
	id = "bluespace_microfusion"
	display_name = "Bluespace Microfusion Technology"
	description = "Bluespace tinkering plus microfusion technology!"
	prereq_ids = list(
		"advanced_microfusion",
		"bluespace_power",
		"beam_weapons",
		"alientech",
		"explosive_weapons",
	)
	design_ids = list(
		"bluespace_power_cell",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

// Bluespace microfusion
/datum/techweb_node/alien_microfusion
	id = "alien_microfusion"
	display_name = "Alien Microfusion Technology"
	description = "Microfusion tech that is so advanced we don't quite understand how it's achieved."
	prereq_ids = list(
		"bluespace_power",
		"alientech",
	)
	design_ids = list(
		"microfusion_cell_attachment_selfcharging",
		"microfusion_gun_attachment_repeater",
		"microfusion_cell_attachment_selfcharging",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)
