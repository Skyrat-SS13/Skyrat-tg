#define TECHWEB_NODE_BASIC_MICROFUSION "basic_microfusion"
#define TECHWEB_NODE_ENHANCED_MICROFUSION "enhanced_microfusion"
#define TECHWEB_NODE_ADVANCED_MICROFUSION "advanced_microfusion"
#define TECHWEB_NODE_BLUESPACE_MICROFUSION "bluespace_microfusion"
#define TECHWEB_NODE_QUANTUM_MICROFUSION "quantum_microfusion"
#define TECHWEB_NODE_ILLEGAL_MICROFUSION "illegal_microfusion"
#define TECHWEB_NODE_CLOWN_MICROFUSION "clown_microfusion"


/datum/techweb_node/basic_microfusion
	id = TECHWEB_NODE_BASIC_MICROFUSION
	starting_node = TRUE
	display_name = "Basic Microfusion Technology"
	description = "Basic microfusion technology allowing for basic microfusion designs."
	design_ids = list(
		"basic_microfusion_cell",
	)

//Enhanced microfusion
/datum/techweb_node/enhanced_microfusion
	id = TECHWEB_NODE_ENHANCED_MICROFUSION
	display_name = "Enhanced Microfusion Technology"
	description = "Enhanced microfusion technology allowing for upgraded basic microfusion!"
	prereq_ids = list(
		TECHWEB_NODE_BASIC_MICROFUSION,
		TECHWEB_NODE_ENERGY_MANIPULATION,
		TECHWEB_NODE_PARTS,
	)
	design_ids = list(
		"enhanced_microfusion_cell",
		"enhanced_microfusion_phase_emitter",
		"microfusion_gun_attachment_black_camo",
		"microfusion_gun_attachment_nt_camo",
		"microfusion_gun_attachment_heatsink",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_2_POINTS)

//Advanced microfusion
/datum/techweb_node/advanced_microfusion
	id = TECHWEB_NODE_ADVANCED_MICROFUSION
	display_name = "Advanced Microfusion Technology"
	description = "Advanced microfusion technology allowing for advanced microfusion!"
	prereq_ids = list(
		TECHWEB_NODE_ENHANCED_MICROFUSION,
		TECHWEB_NODE_PARTS_ADV,
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
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_3_POINTS)


// Bluespace microfusion
/datum/techweb_node/bluespace_microfusion
	id = TECHWEB_NODE_BLUESPACE_MICROFUSION
	display_name = "Bluespace Microfusion Technology"
	description = "Bluespace tinkering plus microfusion technology!"
	prereq_ids = list(
		TECHWEB_NODE_ADVANCED_MICROFUSION,
		TECHWEB_NODE_PARTS_BLUESPACE,
		TECHWEB_NODE_BEAM_WEAPONS,
		TECHWEB_NODE_ELECTRIC_WEAPONS,
		TECHWEB_NODE_FUSION,
	)
	design_ids = list(
		"bluespace_microfusion_cell",
		"microfusion_gun_attachment_repeater",
		"bluespace_microfusion_phase_emitter",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)

// Quantum microfusion
/datum/techweb_node/quantum_microfusion
	id = TECHWEB_NODE_QUANTUM_MICROFUSION
	display_name = "Quantum Microfusion Technology"
	description = "Bleeding edge microfusion tech, making use of the latest in materials and components, bluespace or otherwise."
	prereq_ids = list(
		TECHWEB_NODE_BLUESPACE_MICROFUSION,
		TECHWEB_NODE_ALIENTECH,
	)
	design_ids = list(
		"microfusion_gun_attachment_xray",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)

// Warcrime microfusion
/datum/techweb_node/illegal_microfusion
	id = TECHWEB_NODE_ILLEGAL_MICROFUSION
	display_name = "Illegal Microfusion Technology"
	description = "Microfusion tech that has previously been banned by SolFed. I love the smell of plasma in the mornings."
	prereq_ids = list(
		TECHWEB_NODE_ADVANCED_MICROFUSION,
		TECHWEB_NODE_SYNDICATE_BASIC,
	)
	design_ids = list(
		"microfusion_gun_attachment_superheat",
		"microfusion_gun_attachment_scattermax",
		"microfusion_gun_attachment_penetrator",
		"microfusion_gun_attachment_syndi_camo",
		"microfusion_gun_attachment_suppressor",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_4_POINTS)

// clown microfusion. | This exists to not make this non modular
/datum/techweb_node/clown_microfusion
	id = TECHWEB_NODE_CLOWN_MICROFUSION
	display_name = "Honkicron Clownery Systems Technology"
	description = "Microfusion tech that is proprietary tech of Honkicron Clownery Systems. HONK!!"
	prereq_ids = list(
		TECHWEB_NODE_BASIC_MICROFUSION,
		TECHWEB_NODE_TOYS,
	)
	design_ids = list(
		"microfusion_gun_attachment_honk",
		"microfusion_gun_attachment_honk_camo",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_1_POINTS) //Its normally supposed to be in clown tech so
