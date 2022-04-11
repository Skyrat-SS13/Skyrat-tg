/datum/techweb_node/ipc_parts
	id = "ipc_parts"
	display_name = "IPC Organs"
	description = "Allows Exosuit Fabricators to build IPC organs."
	prereq_ids = list("adv_robotics")
	design_ids = list(
		"ipc_stomach_design",
		"ipc_ears_design",
		"ipc_tongue_design",
		"ipc_eyes_design",
		"ipc_lungs_design",
		"ipc_heart_design",
		"ipc_liver_design",
		"ipc_power_cord_design",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 1000)
