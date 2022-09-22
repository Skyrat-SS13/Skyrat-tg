// Pets
/datum/area_spawn/markus
	target_areas = list(/area/station/cargo/sorting,  /area/station/cargo/storage, /area/station/cargo/office, /area/station/command/heads_quarters/qm)
	desired_atom = /mob/living/simple_animal/pet/dog/markus

/datum/area_spawn/bumbles
	target_areas = list(/area/station/service/hydroponics, /area/station/service/hydroponics/upper)
	desired_atom = /mob/living/simple_animal/pet/bumbles

/datum/area_spawn/borgi
	target_areas = list(/area/station/science/robotics, /area/station/science/robotics/mechbay, /area/station/science/robotics/lab)
	desired_atom = /mob/living/simple_animal/pet/dog/corgi/borgi

/datum/area_spawn/poppy
	target_areas = list(/area/station/engineering/main, /area/station/engineering/break_room, /area/station/engineering/lobby, /area/station/engineering/supermatter/room)
	desired_atom = /mob/living/simple_animal/pet/poppy

// Structures
/datum/area_spawn/secmed_locker
	target_areas = list(/area/station/security/medical, /area/station/security/lockers)
	desired_atom = /obj/structure/closet/secure_closet/security_medic
	blacklisted_stations = list("Blueshift", "Void Raptor", "Runtime Station", "MultiZ Debug", "MetaStation")

/datum/area_spawn/blueshield_locker
	target_areas = list(/area/station/command/heads_quarters/captain, /area/station/command/bridge)
	desired_atom = /obj/structure/closet/secure_closet/blueshield
	mode = AREA_SPAWN_MODE_HUG_WALL

/datum/area_spawn/command_drobe
	target_areas = list(/area/station/command/meeting_room, /area/station/command/meeting_room/council, /area/station/command/bridge)
	desired_atom = /obj/machinery/vending/access/command
	mode = AREA_SPAWN_MODE_HUG_WALL

/datum/area_spawn/ammo_workbench
	target_areas = list(/area/station/security/lockers, /area/station/security/office)
	desired_atom = /obj/machinery/ammo_workbench
	mode = AREA_SPAWN_MODE_HUG_WALL

/datum/area_spawn/gun_vendor
	target_areas = list(/area/station/security/lockers, /area/station/security/office)
	desired_atom = /obj/machinery/gun_vendor
	mode = AREA_SPAWN_MODE_HUG_WALL

/datum/area_spawn/lustwish_public
	target_areas = list(/area/station/commons/locker, /area/station/commons/dorms/laundry, /area/station/commons/dorms)
	desired_atom = /obj/machinery/vending/dorms
	mode = AREA_SPAWN_MODE_HUG_WALL

/datum/area_spawn/lustwish_prison
	target_areas = list(/area/station/security/prison, /area/station/security/prison/shower)
	desired_atom = /obj/machinery/vending/dorms
	blacklisted_stations = list("Blueshift", "Void Raptor", "Runtime Station", "MultiZ Debug", "MetaStation")
	mode = AREA_SPAWN_MODE_HUG_WALL

// Wall mounts. Use sparingly as walls are prime real estate
/datum/area_spawn/posialert_robotics
	target_areas = list(/area/station/science/robotics, /area/station/science/robotics/lab)
	desired_atom = /obj/machinery/posialert
	mode = AREA_SPAWN_MODE_MOUNT_WALL

/datum/area_spawn/posialert_rd
	target_areas = list(/area/station/command/heads_quarters/rd, /area/station/science/lab)
	desired_atom = /obj/machinery/posialert
	mode = AREA_SPAWN_MODE_MOUNT_WALL

// Job spawners
/datum/area_spawn/secmed_landmark
	target_areas = list(/area/station/security/medical, /area/station/security/brig)
	desired_atom = /obj/effect/landmark/start/security_medic

/datum/area_spawn/barber_landmark
	target_areas = list(/area/station/service/salon, /area/station/hallway/secondary/service)
	desired_atom = /obj/effect/landmark/start/barber

/datum/area_spawn/blueshield_landmark
	target_areas = list(/area/station/command/heads_quarters/captain, /area/station/command/bridge)
	desired_atom = /obj/effect/landmark/start/blueshield

/datum/area_spawn/vanguard_landmark
	target_areas = list(/area/station/command/gateway, /area/station/science/lobby, /area/station/science/breakroom)
	desired_atom = /obj/effect/landmark/start/expeditionary_corps

/datum/area_spawn/bouncer_landmark
	desired_atom = /obj/effect/landmark/start/bouncer
	target_areas = list(/area/station/service/bar, /area/station/service/cafeteria, /area/station/service/kitchen/diner)

/datum/area_spawn/engineering_guard_landmark
	desired_atom = /obj/effect/landmark/start/engineering_guard
	target_areas = list(/area/station/security/checkpoint/engineering, /area/station/engineering/break_room, /area/station/engineering/lobby)

/datum/area_spawn/science_guard_landmark
	desired_atom = /obj/effect/landmark/start/science_guard
	target_areas = list(/area/station/security/checkpoint/science, /area/station/science/lobby, /area/station/science/lab)

/datum/area_spawn/orderly_landmark
	desired_atom = /obj/effect/landmark/start/orderly
	target_areas = list(/area/station/security/checkpoint/medical, /area/station/medical/medbay/lobby)

/datum/area_spawn/customs_agent_landmark
	desired_atom = /obj/effect/landmark/start/customs_agent
	target_areas = list(/area/station/security/checkpoint/supply, /area/station/cargo/storage)
