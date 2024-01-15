/datum/component/carrier/soulcatcher
	/// Are ghosts currently able to join this soulcatcher?
	var/ghost_joinable = TRUE
	/// Is the soulcatcher removable from the parent object?
	var/removable = FALSE

/datum/component/carrier/soulcatcher/New()
	. = ..()
	GLOB.soulcatchers += src

/datum/component/carrier/soulcatcher/Destroy(force, ...)
	GLOB.soulcatchers -= src
	return ..()

/// Attempts to remove the carrier from the attached object
/datum/component/carrier/soulcatcher/proc/remove_self()
	if(!removable)
		return FALSE

	qdel(src)

/// Returns a list of all of the rooms that a soul can join/transfer into. `ghost_join` checks if the room is accessible to ghosts.
/datum/component/carrier/soulcatcher/get_open_rooms(ghost_join = FALSE)
	var/list/datum/carrier_room/room_list = list()
	for(var/datum/carrier_room/room as anything in carrier_rooms)
		if((ghost_join && !room.joinable) || !check_for_vacancy())
			continue

		room_list += room

	return room_list

