
// ASGARD DRONE
/obj/drone/asgard_guard
	name = "Ascension Guard Drone"
	desc = "Protector of worlds."
	icon_state = "asgard_drone"
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
