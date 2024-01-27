/datum/techweb_node/adv_engi
	id = "adv_engi"
	display_name = "Advanced Engineering"
	description = "Pushing the boundaries of physics, one chainsaw-fist at a time."
	prereq_ids = list("engineering", "emp_basic")
	design_ids = list(
		"HFR_core",
		"HFR_corner",
		"HFR_fuel_input",
		"HFR_interface",
		"HFR_moderator_input",
		"HFR_waste_output",
		"engine_goggles",
		"forcefield_projector",
		"magboots",
		"rcd_loaded",
		"rcd_ammo",
		"rpd_loaded",
		"rtd_loaded",
		"sheetifier",
		"weldingmask",
		"bolter_wrench",
		"teg",  // Added Teg and its circulator, overwrites the tgstation engineering tech nodes
		"circulator",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 15000)
	discount_experiments = list(
		/datum/experiment/scanning/random/material/medium/one = 4000,
		/datum/experiment/ordnance/gaseous/bz = 10000,
	)
