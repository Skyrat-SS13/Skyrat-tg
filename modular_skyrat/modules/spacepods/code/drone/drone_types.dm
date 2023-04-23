
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


/obj/drone/rogue
	name = "rogue protection drone"
	desc = "An old security drone that has clearly seen better days. It's still functional, but it's not exactly friendly."
	icon_state = "drone_rogue"
	patrol_id = DRONE_PATROL_ID_DEFAULT
	max_integrity = 150
	projectile_type = /obj/projectile/beam/laser

/obj/drone/sentinel
	name = "sentinel drone"
	desc = "A drone dedicated to sector overwatch. It is, however, not aligned with Nanotrasen."
	icon_state = "drone_sentinel"
	patrol_id = DRONE_PATROL_ID_SENTINEL
	max_integrity = 200
	projectile_type = /obj/projectile/beam/laser/heavylaser
