/datum/map_template/shuttle/personal_buyable/mining
	personal_shuttle_type = PERSONAL_SHIP_TYPE_MINING
	port_id = "mining"

// Mining ship, meant to be a hub for deep space mech mining

/datum/map_template/shuttle/personal_buyable/mining/mech_hub
	name = "SF Cigale"
	description = "A heavy mining vessel meant to be a hub for \
		deep space powered mining activities. Features several launch \
		and maintenance bays, as well as crew quarters."
	credit_cost = CARGO_CRATE_VALUE * 16
	suffix = "cigale"
	width = 29
	height = 16
	personal_shuttle_size = PERSONAL_SHIP_LARGE

/area/shuttle/personally_bought/mining_hub
	name = "SF Cigale"
