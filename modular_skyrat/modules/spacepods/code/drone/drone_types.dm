
// ASGARD DRONE
/obj/drone/asgard_guard
	name = "Ascension Guard Drone"
	desc = "Protector of worlds."
	icon_state = "drone_asgard"
	patrol_id = DRONE_PATROL_ID_ASGARD
	friendly_factions = list(FACTION_ASGARD)
	max_integrity = 300
	projectile_type = /obj/projectile/beam/emitter/hitscan


/obj/effect/abstract/drone_control_node/asgard
	patrol_id = DRONE_PATROL_ID_ASGARD

/obj/effect/abstract/drone_patrol_node/asgard
	patrol_id = DRONE_PATROL_ID_ASGARD

/obj/structure/launcher/target_lead/asgard
	name = "Ascension Anti-ship Launcher"
	friendly_factions = list(FACTION_ASGARD)

/obj/structure/launcher/missile/asgard
	name = "Ascension Missile Launcher"
	friendly_factions = list(FACTION_ASGARD)

/obj/drone/crap
	name = "ruined drone"
	desc = "An aincient drone that is not in good shape. It's targeting parameters are fried so it will attack anything."
	icon_state = "drone_unknown"
	patrol_id = DRONE_PATROL_ID_DEFAULT
	friendly_factions = list(FACTION_ROGUE_DRONE)
	max_integrity = 50
	projectile_type = /obj/projectile/beam/weak
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/laser.ogg'

/obj/drone/rogue
	name = "rogue protection drone"
	desc = "An old security drone that has clearly seen better days. It's still functional, but it's not exactly friendly."
	icon_state = "drone_rogue"
	patrol_id = DRONE_PATROL_ID_DEFAULT
	friendly_factions = list(FACTION_ROGUE_DRONE)
	max_integrity = 150
	projectile_type = /obj/projectile/beam/laser

/obj/drone/sentinel
	name = "sentinel drone"
	desc = "A drone dedicated to sector overwatch. It is, however, not aligned with Nanotrasen."
	icon_state = "drone_sentinel"
	patrol_id = DRONE_PATROL_ID_SENTINEL
	friendly_factions = list(FACTION_ROGUE_DRONE)
	max_integrity = 200
	projectile_type = /obj/projectile/bullet/c9mm
	fire_sound = 'modular_skyrat/modules/spacepods/sound/drone/drone_shot.ogg'
	reload_time = 0.5 SECONDS
