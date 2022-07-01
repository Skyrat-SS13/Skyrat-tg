/**
 * Area spawn subsystem
 *
 * Used to spawn items in areas at roundstart.
 */

SUBSYSTEM_DEF(area_spawn)
	name = "Opposing Force"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_PERSISTENCE

/datum/controller/subsystem/area_spawn/Initialize(start_timeofday)
	. = ..()
	for(var/datum/area_spawn/iterating_area_spawn in subtypesof(/datum/area_spawn))
		iterating_area_spawn = new
		iterating_area_spawn.try_spawn()
