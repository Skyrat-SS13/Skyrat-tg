GLOBAL_LIST_EMPTY(assaultop_start)

/area/shuttle/syndicate/cruiser
	name = "Syndicate Cruiser"

/area/shuttle/syndicate/cruiser/bridge
	name = "Syndicate Cruiser Control"
	color = COLOR_BLUE

/area/shuttle/syndicate/cruiser/medical
	name = "Syndicate Cruiser Medbay"
	color = COLOR_LIGHT_PINK

/area/shuttle/syndicate/cruiser/armory
	name = "Syndicate Cruiser Armory"
	color = COLOR_ORANGE

/area/shuttle/syndicate/cruiser/eva
	name = "Syndicate Cruiser EVA"
	color = COLOR_GREEN

/area/shuttle/syndicate/cruiser/hallway

/area/shuttle/syndicate/cruiser/airlock
	name = "Syndicate Cruiser Airlock"
	color = COLOR_RED

/area/shuttle/syndicate/cruiser/brig
	name = "Syndicate Cruiser Brig"
	color = COLOR_BLACK

/area/shuttle/syndicate/cruiser/engineering
	name = "Syndicate Cruiser Engineering"
	color = COLOR_YELLOW

/area/shuttle/syndicate/frigate
	name = "Syndicate Frigate"

/area/cruiser_dock
	name = "Cruiser Holding Facility"
	icon_state = "syndie-ship"
	requires_power = TRUE
	has_gravity = STANDARD_GRAVITY
	area_flags = VALID_TERRITORY | UNIQUE_AREA | NOTELEPORT
	ambientsounds = AMBIENCE_GENERIC

/area/cruiser_dock/brig
	name = "Cruiser Dock Prison"
	color = COLOR_BLUE
	ambientsounds = AMBIENCE_CREEPY
/obj/machinery/door/poddoor/shutters
	smoothing_groups = list(SMOOTH_GROUP_SHUTTERS)

/turf/closed/wall/r_wall/syndicate/cruiser
	canSmoothWith = list(SMOOTH_GROUP_SYNDICATE_WALLS, SMOOTH_GROUP_PLASTITANIUM_WALLS, SMOOTH_GROUP_AIRLOCK, SMOOTH_GROUP_SHUTTLE_PARTS, SMOOTH_GROUP_SHUTTERS)

/obj/effect/landmark/start/assaultop
	name = "assaultop"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "snukeop_spawn"
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/assaultop/Initialize()
	. = ..()
	GLOB.assaultop_start += src

/obj/effect/spawner/lootdrop/gun/assaultops/ballistics
	name = "gun spawner"
	loot = list(
				/obj/item/gun/ballistic/automatic/assault_rifle/m16,
				/obj/item/gun/ballistic/automatic/pistol/deagle,
				/obj/item/gun/ballistic/automatic/sniper_rifle/modular/syndicate,
				/obj/item/gun/ballistic/automatic/submachine_gun/mp40,
				/obj/item/gun/ballistic/automatic/c20r,
				/obj/item/gun/ballistic/automatic/m90
				)
