/area/deepmaints
	name = "Abandoned Maintenance"
	icon_state = "bit_ruin"
	icon = 'icons/area/areas_station.dmi'
	area_flags = UNIQUE_AREA | NOTELEPORT | ABDUCTOR_PROOF | EVENT_PROTECTED | HIDDEN_AREA
	has_gravity = STANDARD_GRAVITY
	requires_power = FALSE
	power_equip = FALSE

/obj/modular_map_root/deepmaints
	config_file = "strings/modular_maps/skyrat/deepmaints.toml"
