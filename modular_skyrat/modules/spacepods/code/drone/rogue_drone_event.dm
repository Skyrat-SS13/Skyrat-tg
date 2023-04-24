/datum/round_event_control/rogue_drone
	name = "Rogue Drone"
	typepath = /datum/round_event/rogue_drone
	category = EVENT_CATEGORY_SPACE
	max_occurrences = 2
	earliest_start = 40 MINUTES

/datum/round_event/rogue_drone/announce(fake)
	priority_announce("A rogue drone has been detected nearby the station, proceed with caution, it is definitely hostile.", "Rogue Drone")

/datum/round_event/rogue_drone
	announce_when = 1
	announce_chance = 100
	var/static/list/pod_types = list(
		/obj/drone = 4,
		/obj/drone/crap = 3,
		/obj/drone/rogue = 2,
		/obj/drone/sentinel = 1,
	)

/datum/round_event/rogue_drone/start()
	var/drones_to_spawn = rand(1,3)

	var/list/possible_spawn_points = list()

	for(var/obj/effect/landmark/carpspawn/spawn_point in GLOB.landmarks_list)
		possible_spawn_points += spawn_point

	for(var/i in 1 to drones_to_spawn)
		var/obj/effect/landmark/carpspawn/spawn_point = pick_n_take(possible_spawn_points)
		var/obj/drone/drone_to_spawn = pick_weight(pod_types)
		new drone_to_spawn(get_turf(spawn_point))
		announce_to_ghosts(drone_to_spawn)
