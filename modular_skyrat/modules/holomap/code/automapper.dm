#define HOLOMAP_SPAWN(name, ar, amt) /datum/area_spawn/holomap_##name {\
	target_areas = list(##ar); \
	desired_atom = /obj/machinery/station_map; \
	mode = AREA_SPAWN_MODE_MOUNT_WALL; \
	amount_to_spawn = amt; }

HOLOMAP_SPAWN(arrivals, /area/station/hallway/secondary/entry, 3)

/datum/area_spawn/holomap_engi
	target_areas = list(/area/station/engineering/main)
	desired_atom = /obj/machinery/station_map
	mode = AREA_SPAWN_MODE_MOUNT_WALL
	amount_to_spawn = 2

/datum/area_spawn/holomap_atmos
	target_areas = list(/area/station/engineering/atmos)
	desired_atom = /obj/machinery/station_map
	mode = AREA_SPAWN_MODE_MOUNT_WALL

/datum/area_spawn/holomap_ai
	target_areas = list(/area/station/ai_monitored/turret_protected/ai)
	desired_atom = /obj/machinery/station_map
	mode = AREA_SPAWN_MODE_MOUNT_WALL

/datum/area_spawn/holomap_bridge
	target_areas = list(/area/station/command/bridge)
	desired_atom = /obj/machinery/station_map
	mode = AREA_SPAWN_MODE_MOUNT_WALL
