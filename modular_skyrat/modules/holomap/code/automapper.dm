// Doing it via macros is far more readable than doing an entry per.
#define HOLOMAP_SPAWN(name, ar, amt) /datum/area_spawn/holomap_##name {\
	target_areas = list(##ar); \
	desired_atom = /obj/machinery/station_map; \
	mode = AREA_SPAWN_MODE_MOUNT_WALL; \
	amount_to_spawn = amt; }

#define HOLOMAP_SPAWN_ENGI(name, ar, amt) /datum/area_spawn/holomap_##name {\
	target_areas = list(##ar); \
	desired_atom = /obj/machinery/station_map/engineering; \
	mode = AREA_SPAWN_MODE_MOUNT_WALL; \
	amount_to_spawn = amt; }

HOLOMAP_SPAWN(arrivals, /area/station/hallway/primary/fore, 2)
HOLOMAP_SPAWN(medbay, /area/station/medical/medbay/lobby, 1)
HOLOMAP_SPAWN(medbay, /area/station/medical/medbay/lobby, 1)

HOLOMAP_SPAWN_ENGI(engineering, /area/station/engineering/main, 2)
HOLOMAP_SPAWN_ENGI(atmos, /area/station/engineering/atmos, 1)
HOLOMAP_SPAWN_ENGI(ai, /area/station/ai_monitored/turret_protected/ai, 1)
HOLOMAP_SPAWN_ENGI(bridge, /area/station/command/bridge, 1)

#undef HOLOMAP_SPAWN
