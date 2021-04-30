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

/area/cruiser_dock/heads
	name = "Head Of Staff Office"

/area/cruiser_dock/heads/admiral
	name = "Station Admiral's Office"
	icon_state = "captain"
	sound_environment = SOUND_AREA_WOODFLOOR

/area/cruiser_dock/heads/cmo
	name = "DS-1 Chief Medical Officer's Office"
	icon_state = "cmo_office"

/area/cruiser_dock/heads/ceo
	name = "Chief Engineering Officer's Office"
	icon_state = "ce_office"

/area/cruiser_dock/heads/cl
	name = "Corporate Liaison's Office"
	icon_state = "hop_office"

/area/cruiser_dock/heads/cmaa
	name = "Chief Master At Arms' Office"
	icon_state = "hos_office"

/area/cruiser_dock/heads/cro
	name = "Chief Research Officer's Office"
	icon_state = "rd_office"

/area/cruiser_dock/security
	name = "DS-1 Security"
	icon_state = "security"
	ambience_index = AMBIENCE_DANGER

/area/cruiser_dock/security/armory
	name = "DS-1 Armory"

/area/cruiser_dock/service
	name = "DS-1 Service Halls"
	icon_state = "hall_service"

/area/cruiser_dock/research
	name = "DS-1 Research And Development"
	icon_state = "science"
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/cruiser_dock/cargo
	name = "DS-1 Cargo"
	icon_state = "cargo_bay"
	sound_environment = SOUND_AREA_LARGE_ENCLOSED

/area/cruiser_dock/cargo/hangar
	name = "DS-1 Hangar"

/area/cruiser_dock/vault
	name = "DS-1 Vault"
	icon_state = "nuke_storage"

/area/cruiser_dock/engineering
	name = "DS-1 Engineering"
	ambience_index = AMBIENCE_ENGI
	sound_environment = SOUND_AREA_LARGE_ENCLOSED
	icon_state = "engine"

/area/cruiser_dock/commons
	name = "DS-1 Commons"
	icon_state = "dorms"
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/cruiser_dock/commons/dorms
	name = "DS-1 Dormitories"

/area/cruiser_dock/maint
	name = "DS-1 Maintenance Tunnels"
	ambience_index = AMBIENCE_MAINT
	sound_environment = SOUND_AREA_TUNNEL_ENCLOSED
	icon_state = "maint_electrical"

/area/cruiser_dock/medical
	name = "DS-1 Medical"
	icon_state = "medbay1"
	ambience_index = AMBIENCE_MEDICAL
	sound_environment = SOUND_AREA_STANDARD_STATION
	min_ambience_cooldown = 90 SECONDS
	max_ambience_cooldown = 180 SECONDS

/area/cruiser_dock/medical/virology
	name = "DS-1 Virology"
	icon_state = "virology"

/area/cruiser_dock/bridge
	name = "DS-1 Bridge"
	icon_state = "bridge_hallway"
	ambientsounds = list('sound/ambience/signal.ogg')
	sound_environment = SOUND_AREA_STANDARD_STATION

/area/cruiser_dock/bridge/hallway
	name = "DS-1 Command Hallway"

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
