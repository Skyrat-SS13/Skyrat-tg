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
HOLOMAP_SPAWN(dorms, /area/station/commons/dorms, 1)
HOLOMAP_SPAWN(cryo, /area/station/common/cryopods, 1)
HOLOMAP_SPAWN(sec, /area/station/security/office, 2)

HOLOMAP_SPAWN_ENGI(engineering, /area/station/engineering/main, 2)
HOLOMAP_SPAWN_ENGI(ce, /area/station/command/heads_quarters/ce, 1)
HOLOMAP_SPAWN_ENGI(atmos, /area/station/engineering/atmos, 1)
HOLOMAP_SPAWN_ENGI(ai, /area/station/ai_monitored/turret_protected/ai, 1)
HOLOMAP_SPAWN_ENGI(bridge, /area/station/command/bridge, 1)

/obj/machinery/firealarm/Initialize(mapload, dir, building)
	. = ..()
	if(z in SSmapping.z_trait_levels[ZTRAIT_STATION])
		LAZYADD(GLOB.station_fire_alarms["[z]"], src)

/obj/machinery/firealarm/Destroy()
	LAZYREMOVE(GLOB.station_fire_alarms["[z]"], src)
	. = ..()

#undef HOLOMAP_SPAWN
