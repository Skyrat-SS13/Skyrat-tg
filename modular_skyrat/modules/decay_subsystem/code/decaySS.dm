/*
This is the decay subsystem that is run once at startup.
These procs are incredibly expensive and should only really be run once. That's why the only run once.
*/


#define WALL_RUST_PERCENT_CHANCE 15
#define FLOOR_DIRT_PERCENT_CHANCE 15
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
	var/severity_modifier = 1

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

	severity_modifier = rand(1, 4)

	message_admins("SSDecay severity modifier set to [severity_modifier]")

	do_common()

	do_maintenance()

	do_engineering()

	do_medical()

/datum/controller/subsystem/decay/proc/do_common()
	for(var/turf/open/iterating_floor in possible_turfs)
		if(prob(FLOOR_DIRT_PERCENT_CHANCE * severity_modifier))
			new /obj/effect/decal/cleanable/dirt(iterating_floor)

	for(var/turf/closed/iterating_wall in possible_turfs)
		if(prob(WALL_RUST_PERCENT_CHANCE))
			var/mutable_appearance/rust = mutable_appearance(iterating_wall.icon, "rust")
			iterating_wall.add_overlay(rust)

/datum/controller/subsystem/decay/proc/do_maintenance()
	for(var/area/maintenance/iterating_maintenance in possible_areas)
		for(var/turf/open/iterating_floor in iterating_maintenance)
			if(prob(FLOOR_BLOOD_PERCENT_CHANCE * severity_modifier))
				new /obj/effect/decal/cleanable/blood(iterating_floor)
		for(var/obj/machinery/light/iterating_light in iterating_maintenance)
			if(prob(LIGHT_FLICKER_PERCENT_CHANCE * severity_modifier))
				iterating_light.start_flickering()

/datum/controller/subsystem/decay/proc/do_engineering()
	for(var/area/engineering/iterating_engineering in possible_areas)
		for(var/turf/open/iterating_floor in iterating_engineering)
			if(prob(FLOOR_BLOOD_PERCENT_CHANCE * severity_modifier))
				new /obj/effect/decal/cleanable/blood(iterating_floor)
			if(prob(FLOOR_OIL_PERCENT_CHANCE * severity_modifier))
				new /obj/effect/decal/cleanable/oil(iterating_floor)

/datum/controller/subsystem/decay/proc/do_medical()
	for(var/area/medical/iterating_medical in possible_areas)
		for(var/turf/open/iterating_floor in iterating_medical)
			if(prob(FLOOR_BLOOD_PERCENT_CHANCE * severity_modifier))
				new /obj/effect/decal/cleanable/blood(iterating_floor)
			if(prob(FLOOR_VOMIT_PERCENT_CHANCE * severity_modifier))
				new /obj/effect/decal/cleanable/vomit(iterating_floor)
		if(is_type_in_list(iterating_medical, list(/area/medical/coldroom, /area/medical/morgue, /area/medical/psychology)))
			for(var/obj/machinery/light/iterating_light in iterating_medical)
				if(prob(LIGHT_FLICKER_PERCENT_CHANCE * severity_modifier))
					iterating_light.start_flickering()
