/datum/round_event_control/wall_fungus
	name = "Wall Fungus Outbreak"
	typepath = /datum/round_event/wall_fungus
	category = EVENT_CATEGORY_ENGINEERING
	max_occurrences = 2
	earliest_start = 30 MINUTES
	description = "A wall fungus will infest a random wall on the station, eating away at it. If left unchecked, it will spread to other walls and eventually destroy the station."

/datum/round_event/wall_fungus/announce(fake)
	priority_announce("Harmful fungi detected on the station, station structures may be contaminated. Crew are advised to provide immediate response in [get_area(starting_wall)].", "Harmful Fungi", ANNOUNCER_FUNGI)

/datum/round_event/wall_fungus
	announce_when = 180 EVENT_SECONDS
	announce_chance = 100
	fakeable = FALSE
	var/turf/closed/wall/starting_wall

/datum/round_event/wall_fungus/start()
	var/list/possible_start_walls = list()
	var/starting_area = get_area(pick(GLOB.generic_maintenance_landmarks))

	for(var/turf/closed/wall/iterating_wall in starting_area)
		possible_start_walls += iterating_wall

	starting_wall = pick(possible_start_walls)

	starting_wall.AddComponent(/datum/component/wall_fungus)

	notify_ghosts("[starting_wall] has been infested with wall eating mushrooms!!", source = starting_wall, action = NOTIFY_JUMP, header = "Fungus Amongus!")
