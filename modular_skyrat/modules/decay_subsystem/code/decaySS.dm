/*
This is the decay subsystem that is run once at startup.
These procs are incredibly expensive and should only really be run once. That's why the only run once.
*/


#define WALL_RUST_PERCENT_CHANCE 15

#define FLOOR_DIRT_PERCENT_CHANCE 15
#define FLOOR_BLOOD_PERCENT_CHANCE 1
#define FLOOR_VOMIT_PERCENT_CHANCE 1
#define FLOOR_OIL_PERCENT_CHANCE 5
#define FLOOR_TILE_MISSING_PERCENT_CHANCE 1
#define FLOOR_COBWEB_PERCENT_CHANCE 1

#define NEST_PERCENT_CHANCE 1

#define LIGHT_FLICKER_PERCENT_CHANCE 10

SUBSYSTEM_DEF(decay)
	name = "Decay System"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_DECAY

	var/list/possible_turfs = list()
	var/list/possible_areas = list()
	var/severity_modifier = 1

	var/list/possible_nests = list(
		/obj/structure/mob_spawner/spiders,
		/obj/structure/mob_spawner/bush,
		/obj/structure/mob_spawner/beehive,
		/obj/structure/mob_spawner/rats
		)

/datum/controller/subsystem/decay/Initialize()
	if(CONFIG_GET(flag/ssdecay_disabled))
		message_admins("SSDecay was disabled in config.")
		log_world("SSDecay was disabled in config.")
		return ..()
	// Putting this first so that it just doesn't waste time iterating through everything if it's not going to do anything anyway.
	if(prob(50))
		message_admins("SSDecay will not interact with this round.")
		log_world("SSDecay will not interact with this round.")
		return ..()
	for(var/turf/iterating_turf in world)
		if(!is_station_level(iterating_turf.z))
			continue
		if(!(iterating_turf.flags_1 & CAN_BE_DIRTY_1))
			continue
		possible_turfs += iterating_turf

	for(var/area/iterating_area in world)
		if(!is_station_level(iterating_area.z))
			continue
		possible_areas += iterating_area

	if(!possible_turfs)
		CRASH("SSDecay had no possible turfs to use!")

	severity_modifier = rand(1, 4)

	message_admins("SSDecay severity modifier set to [severity_modifier]")
	log_world("SSDecay severity modifier set to [severity_modifier]")

	do_common()

	do_maintenance()

	do_engineering()

	do_medical()

	return ..()

/datum/controller/subsystem/decay/proc/do_common()
	for(var/turf/open/floor/iterating_floor in possible_turfs)
		if(iterating_floor.turf_flags & CAN_DECAY_BREAK_1)
			if(prob(FLOOR_TILE_MISSING_PERCENT_CHANCE * severity_modifier) && prob(60))
				iterating_floor.break_tile_to_plating()

		if(prob(FLOOR_DIRT_PERCENT_CHANCE * severity_modifier))
			new /obj/effect/decal/cleanable/dirt(iterating_floor)

		if(prob(FLOOR_DIRT_PERCENT_CHANCE * severity_modifier))
			new /obj/effect/decal/cleanable/dirt(iterating_floor)

	for(var/turf/closed/iterating_wall in possible_turfs)
		if(HAS_TRAIT(iterating_wall, TRAIT_RUSTY))
			continue
		if(prob(WALL_RUST_PERCENT_CHANCE * severity_modifier))
			iterating_wall.AddElement(/datum/element/rust)

/datum/controller/subsystem/decay/proc/do_maintenance()
	for(var/area/station/maintenance/iterating_maintenance in possible_areas)
		for(var/turf/open/iterating_floor in iterating_maintenance)
			if(prob(FLOOR_BLOOD_PERCENT_CHANCE * severity_modifier))
				var/obj/effect/decal/cleanable/blood/spawned_blood = new (iterating_floor)
				spawned_blood.dry()
				if(!iterating_floor.Enter(spawned_blood))
					qdel(spawned_blood) //No blood under windows.

			if(prob(FLOOR_COBWEB_PERCENT_CHANCE * severity_modifier))
				var/obj/structure/spider/stickyweb/spawned_web = new (iterating_floor)
				if(!iterating_floor.Enter(spawned_web))
					qdel(spawned_web)

			if(!CONFIG_GET(flag/ssdecay_disable_nests) && prob(NEST_PERCENT_CHANCE * severity_modifier) && prob(50))
				var/spawner_to_spawn = pick(possible_nests)
				var/obj/structure/mob_spawner/spawned_spawner = new spawner_to_spawn(iterating_floor)
				if(!iterating_floor.Enter(spawned_spawner))
					qdel(spawned_spawner)

		for(var/obj/machinery/light/iterating_light in iterating_maintenance)
			if(prob(LIGHT_FLICKER_PERCENT_CHANCE))
				iterating_light.start_flickering()

/datum/controller/subsystem/decay/proc/do_engineering()
	for(var/area/station/engineering/iterating_engineering in possible_areas)
		for(var/turf/open/iterating_floor in iterating_engineering)
			if(prob(FLOOR_BLOOD_PERCENT_CHANCE * severity_modifier))
				var/obj/effect/decal/cleanable/blood/spawned_blood = new (iterating_floor)
				spawned_blood.dry()
				if(!iterating_floor.Enter(spawned_blood))
					qdel(spawned_blood)

			if(prob(FLOOR_OIL_PERCENT_CHANCE * severity_modifier))
				var/obj/effect/decal/cleanable/oil/spawned_oil = new (iterating_floor)
				if(!iterating_floor.Enter(spawned_oil))
					qdel(spawned_oil)

/datum/controller/subsystem/decay/proc/do_medical()
	for(var/area/station/medical/iterating_medical in possible_areas)
		for(var/turf/open/iterating_floor in iterating_medical)
			if(prob(FLOOR_BLOOD_PERCENT_CHANCE * severity_modifier))
				var/obj/effect/decal/cleanable/blood/spawned_blood = new (iterating_floor)
				spawned_blood.dry()
				if(!iterating_floor.Enter(spawned_blood))
					qdel(spawned_blood)

			if(prob(FLOOR_VOMIT_PERCENT_CHANCE * severity_modifier))
				var/obj/effect/decal/cleanable/vomit/spawned_vomit = new (iterating_floor)
				if(!iterating_floor.Enter(spawned_vomit))
					qdel(spawned_vomit)

		if(is_type_in_list(iterating_medical, list(/area/station/medical/coldroom, /area/station/medical/morgue, /area/station/medical/psychology)))
			for(var/obj/machinery/light/iterating_light in iterating_medical)
				if(prob(LIGHT_FLICKER_PERCENT_CHANCE))
					iterating_light.start_flickering()
