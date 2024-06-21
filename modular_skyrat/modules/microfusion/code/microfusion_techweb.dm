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
		"energy_manipulation",
		"parts",
	)
	design_ids = list(
		"enhanced_microfusion_cell",
		"enhanced_microfusion_phase_emitter",
		"microfusion_gun_attachment_black_camo",
		"microfusion_gun_attachment_nt_camo",
		"microfusion_gun_attachment_heatsink",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 3500)

//Advanced microfusion
/datum/techweb_node/advanced_microfusion
	id = "advanced_microfusion"
	display_name = "Advanced Microfusion Technology"
	description = "Advanced microfusion technology allowing for advanced microfusion!"
	prereq_ids = list(
		"enhanced_microfusion",
		"parts_adv",
	)
	design_ids = list(
		"advanced_microfusion_cell",
		"microfusion_cell_attachment_overcapacity",
		"microfusion_cell_attachment_stabiliser",
		"microfusion_gun_attachment_scatter",
		"microfusion_gun_attachment_hellfire",
		"advanced_microfusion_phase_emitter",
		"microfusion_gun_attachment_lance",
		"microfusion_gun_attachment_grip",
		"microfusion_gun_attachment_rail",
		"microfusion_gun_attachment_scope",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)


// Bluespace microfusion
/datum/techweb_node/bluespace_microfusion
	id = "bluespace_microfusion"
	display_name = "Bluespace Microfusion Technology"
	description = "Bluespace tinkering plus microfusion technology!"
	prereq_ids = list(
		"advanced_microfusion",
		"parts_bluespace",
		"beam_weapons",
		"electric_weapons",
		"fusion",
	)
	design_ids = list(
		"bluespace_microfusion_cell",
		"microfusion_gun_attachment_repeater",
		"bluespace_microfusion_phase_emitter",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)

// Quantum microfusion
/datum/techweb_node/quantum_microfusion
	id = "quantum_microfusion"
	display_name = "Quantum Microfusion Technology"
	description = "Bleeding edge microfusion tech, making use of the latest in materials and components, bluespace or otherwise."
	prereq_ids = list(
		"bluespace_microfusion",
		"alientech",
	)
	design_ids = list(
		"microfusion_gun_attachment_xray",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 15000)

// Warcrime microfusion
/datum/techweb_node/illegal_microfusion
	id = "illegal_microfusion"
	display_name = "Illegal Microfusion Technology"
	description = "Microfusion tech that has previously been banned by SolFed. I love the smell of plasma in the mornings."
	prereq_ids = list(
		"advanced_microfusion",
		"syndicate_basic",
	)
	design_ids = list(
		"microfusion_gun_attachment_superheat",
		"microfusion_gun_attachment_scattermax",
		"microfusion_gun_attachment_penetrator",
		"microfusion_gun_attachment_syndi_camo",
		"microfusion_gun_attachment_suppressor",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 5000)

// clown microfusion. | This exists to not make this non modular
/datum/techweb_node/clown_microfusion
	id = "clown_microfusion"
	display_name = "Honkicron Clownery Systems Technology"
	description = "Microfusion tech that is proprietary tech of Honkicron Clownery Systems. HONK!!"
	prereq_ids = list(
		"basic_microfusion",
		"toys",
	)
	design_ids = list(
		"microfusion_gun_attachment_honk",
		"microfusion_gun_attachment_honk_camo",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 500) //Its normally supposed to be in clown tech so
