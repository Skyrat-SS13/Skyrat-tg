/obj/structure/shuttle/engine
	var/extension_type = /datum/shuttle_extension/engine/burst
	var/datum/shuttle_extension/engine/extension

/obj/structure/shuttle/engine/Initialize()
	. = ..()
	if(extension_type)
		//Late initialize does not seem to work for this (doesnt get caled at all), so a timer
		addtimer(CALLBACK(src, .proc/CreateExtension))

/obj/structure/shuttle/engine/proc/CreateExtension()
	extension = new extension_type()
	if(state == ENGINE_WELDED)
		ApplyExtension()

/obj/structure/shuttle/engine/proc/ApplyExtension()
	if(!extension)
		return
	if(SSshuttle.is_in_shuttle_bounds(src))
		var/obj/docking_port/mobile/M = SSshuttle.get_containing_shuttle(src)
		if(M)
			extension.AddToShuttle(M)
	else
		var/datum/space_level/level = SSmapping.z_list[z]
		if(level && level.related_overmap_object && level.is_overmap_controllable)
			extension.AddToZLevel(level)

/obj/structure/shuttle/engine/proc/RemoveExtension()
	if(!extension)
		return
	extension.RemoveExtension()
