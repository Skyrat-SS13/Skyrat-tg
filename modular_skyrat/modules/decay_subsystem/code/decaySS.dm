/*
This is the decay subsystem that is run once at startup.
These procs are incredibly expensive and should only really be run once. That's why the only run once.
*/


#define WALL_RUST_PERCENT_CHANCE 10
#define FLOOR_DIRT_PERCENT_CHANCE 10
#define FLOOR_BLOOD_PERCENT_CHANCE 2
#define FLOOR_VOMIT_PERCENT_CHANCE 2
#define FLOOR_OIL_PERCENT_CHANCE 5
#define LIGHT_FLICKER_PERCENT_CHANCE 50

SUBSYSTEM_DEF(decay)
	name = "Decay System"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_DECAY

	var/list/possible_turfs = list()
	var/list/possible_areas = list()

/datum/controller/subsystem/decay/Initialize()
	for(var/turf/iterating_turf in world)
		if(!is_station_level(iterating_turf.z))
			continue
		possible_turfs += iterating_turf

	for(var/area/iterating_area in world)
		if(!is_station_level(iterating_area.z))
			continue
		possible_areas += iterating_area

	if(!possible_turfs)
		CRASH("SSDECAY had no possible turfs to use!")

	do_common()

	do_maintenance()

	do_engineering()

	do_medical()

/datum/controller/subsystem/decay/proc/do_common()
	for(var/turf/open/iteraing_floor in possible_turfs)
		if(prob(FLOOR_DIRT_PERCENT_CHANCE))
			new /obj/effect/decal/cleanable/dirt(iteraing_floor)

	for(var/turf/closed/iteraing_wall in possible_turfs)
		if(prob(WALL_RUST_PERCENT_CHANCE))
			var/mutable_appearance/rust = mutable_appearance(iteraing_wall.icon, "rust")
			iteraing_wall.add_overlay(rust)


/datum/controller/subsystem/decay/proc/do_maintenance()
	for(var/area/maintenance/iterating_maintenance in possible_areas)
		for(var/turf/open/iteraing_floor in iterating_maintenance)
			if(prob(FLOOR_BLOOD_PERCENT_CHANCE))
				new /obj/effect/decal/cleanable/blood(iteraing_floor)
		for(var/obj/machinery/light/iterating_light in iterating_maintenance)
			if(prob(LIGHT_FLICKER_PERCENT_CHANCE))
				iterating_light.start_flickering()


/datum/controller/subsystem/decay/proc/do_engineering()
	for(var/area/engineering/iterating_engineering in possible_areas)
		for(var/turf/open/iteraing_floor in iterating_engineering)
			if(prob(FLOOR_BLOOD_PERCENT_CHANCE))
				new /obj/effect/decal/cleanable/blood(iteraing_floor)
			if(prob(FLOOR_OIL_PERCENT_CHANCE))
				new /obj/effect/decal/cleanable/oil(iteraing_floor)

/datum/controller/subsystem/decay/proc/do_medical()
	for(var/area/medical/iterating_medical in possible_areas)
		for(var/turf/open/iteraing_floor in iterating_medical)
			if(prob(FLOOR_BLOOD_PERCENT_CHANCE))
				new /obj/effect/decal/cleanable/blood(iteraing_floor)
			if(prob(FLOOR_VOMIT_PERCENT_CHANCE))
				new /obj/effect/decal/cleanable/vomit(iteraing_floor)
		if(is_type_in_list(iterating_medical, list(/area/medical/coldroom, /area/medical/morgue, /area/medical/psychology)))
			for(var/obj/machinery/light/iterating_light in iterating_medical)
				if(prob(LIGHT_FLICKER_PERCENT_CHANCE))
					iterating_light.start_flickering()
