/datum/round_event_control/marker
	name = "Marker"
	typepath = /datum/round_event/ghost_role/marker
	weight = 10
	max_occurrences = 0 //SKYRAT EDIT CHANGE

	min_players = 20

	dynamic_should_hijack = TRUE

/datum/round_event_control/marker/canSpawnEvent(players)
	if(EMERGENCY_PAST_POINT_OF_NO_RETURN) // no markers if the shuttle is past the point of no return
		return FALSE

	return ..()

/datum/round_event/ghost_role/marker
	announceChance = 0
	role_name = "marker overmind"
	fakeable = TRUE

/datum/round_event/ghost_role/marker/announce(fake)
	priority_announce("Confirmed outbreak of level 5 biohazard aboard [station_name()]. All personnel must contain the outbreak.", "Biohazard Alert", ANNOUNCER_OUTBREAK5)

/datum/round_event/ghost_role/marker/spawn_role()
	if(!GLOB.markerstart.len)
		return MAP_ERROR
	var/list/candidates = get_candidates(ROLE_NECROMORPH, ROLE_NECROMORPH)
	if(!candidates.len)
		return NOT_ENOUGH_PLAYERS
	var/mob/dead/observer/new_marker = pick(candidates)
	var/mob/camera/marker/BC = new_marker.become_overmind()
	spawned_mobs += BC
	message_admins("[ADMIN_LOOKUPFLW(BC)] has been made into a marker overmind by an event.")
	log_game("[key_name(BC)] was spawned as a marker overmind by an event.")
	return SUCCESSFUL_SPAWN



/datum/round_event/necromorph_infestation/announce(fake)
	alert_sound_to_playing(sound('modular_skyrat/modules/alerts/sound/alert1.ogg'))
	priority_announce("Automated air filtration screeing systems have flagged an unknown pathogen in the ventilation systems, quarantine is in effect.", "Level-1 Viral Biohazard Alert", ANNOUNCER_MUTANTS)
