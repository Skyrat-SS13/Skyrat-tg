/datum/overmap_object
	/// Unique integer ID, used for easy communication between the server and clients UI
	var/id
	/// The name of the overmpa object
	var/name = "Overmap object"
	/// It's x coordinate
	var/x = 0
	/// It's y coordinate
	var/y = 0
	var/partial_x = 0
	var/partial_y = 0
	/// The sunsystem it is stationed in
	var/datum/overmap_sun_system/current_system
	/// Whether it should make a visual dummy or not
	//var/make_visual = TRUE //Currently to save memory we piggyback on turf.contents for a 2d array. Just make your visual object invisible if you dont want this
	/// Reference to the visual dummy
	var/obj/effect/abstract/overmap/my_visual
	/// The type of the visual that will be spawned for this object
	var/visual_type = /obj/effect/abstract/overmap
	/// Related Z levels of this overmap object, for objects like the station, planets, ruin clusters
	var/list/related_levels = list()
	/// If true then the SSovermap will call process() on it every time it fires
	var/overmap_process = FALSE
	/// When this object is spawned it will clear all the hazards in its current position
	var/clears_hazards_on_spawn = FALSE
	var/overmap_flags = OV_SHOWS_ON_SENSORS|OV_CAN_BE_TARGETED|OV_CAN_BE_SCANNED
	/// Linked weather controller, expect this to apply to all related_levels
	var/datum/weather_controller/weather_controller
	/// Linked day and night controller, expect this to apply to all related_levels
	var/datum/day_night_controller/day_night_controller

/datum/overmap_object/proc/ProcessPartials()
	var/did_move = FALSE
	var/new_x
	var/new_y
	while(partial_y > 16)
		did_move = TRUE
		partial_y -= 32
		new_y = min(y+1,current_system.maxy)
	while(partial_y < -16)
		did_move = TRUE
		partial_y += 32
		new_y = max(y-1,1)
	while(partial_x > 16)
		did_move = TRUE
		partial_x -= 32
		new_x = min(x+1,current_system.maxx)
	while(partial_x < -16)
		did_move = TRUE
		partial_x += 32
		new_x = max(x-1,1)
	UpdateVisualOffsets()
	if(did_move)
		var/passed_x = new_x || x
		var/passed_y = new_y || y
		Move(passed_x, passed_y)
	return did_move

/datum/overmap_object/proc/DealtDamage(damage_type, damage_amount)
	return

/datum/overmap_object/proc/DoTransport(turf/destination)
	return

//Gets all alive client mobs in the contained overmap object
/datum/overmap_object/proc/GetAllAliveClientMobs()
	var/list/compiled_list = list()
	for(var/i in related_levels)
		var/datum/space_level/level = i 
		compiled_list += SSmobs.clients_by_zlevel[level.z_value]
	return compiled_list

//Gets all alive and dead(observers) client mobs in the contained overmap object
/datum/overmap_object/proc/GetAllClientMobs()
	var/list/compiled_list = GetAllAliveClientMobs()
	for(var/i in related_levels)
		var/datum/space_level/level = i 
		compiled_list += SSmobs.dead_players_by_zlevel[level.z_value]
	return compiled_list

//When something enters this object. Also called when the objects are created
/datum/overmap_object/proc/Entered(datum/overmap_object/entering, spawned = FALSE)
	return

//When something exits this object. Also called when the objects are deleted
/datum/overmap_object/proc/Exited(datum/overmap_object/exiting, deleted = FALSE )
	return

/datum/overmap_object/New(datum/overmap_sun_system/passed_system, x_coord, y_coord)
	. = ..()
	SSovermap.RegisterObject(src)
	current_system = passed_system
	current_system.overmap_objects += src
	x = x_coord
	y = y_coord

	my_visual = new visual_type(locate(x,y,current_system.z_level))
	my_visual.name = name
	my_visual.my_overmap_object = src
	update_visual_position()

	//As we are created we enter other objects
	for(var/other_obj in current_system.GetObjectsOnCoords(x, y))
		var/datum/overmap_object/other_overmap_obj = other_obj
		other_overmap_obj.Entered(src, TRUE)

	if(clears_hazards_on_spawn)
		current_system.CoordsClearHazard(x, y)

/datum/overmap_object/Destroy()
	if(weather_controller)
		weather_controller.UnlinkOvermapObject()
	//As we are destroyed we exit other objects
	for(var/other_obj in current_system.GetObjectsOnCoords(x, y))
		var/datum/overmap_object/other_overmap_obj = other_obj
		other_overmap_obj.Exited(src, TRUE)

	SSovermap.UnregisterObject(src)
	current_system.overmap_objects -= src
	if(my_visual)
		my_visual.my_overmap_object = null
		//So we can delete the objects within mapping processes
		if(SSatoms.initialized == INITIALIZATION_INSSATOMS)
			my_visual.qdel_init = TRUE
		else
			qdel(my_visual, TRUE)
		my_visual = null
	return ..()

/datum/overmap_object/proc/relaymove(mob/living/user, direction)
	return

/datum/overmap_object/proc/Move(new_x, new_y)
	if(x == new_x && y == new_y)
		return FALSE
	//Exit from things in the old position
	for(var/other_obj in current_system.GetObjectsOnCoords(x, y))
		var/datum/overmap_object/other_overmap_obj = other_obj
		other_overmap_obj.Exited(src)
	x = new_x
	y = new_y
	//Enter on things in the new position
	for(var/other_obj in current_system.GetObjectsOnCoords(x, y))
		var/datum/overmap_object/other_overmap_obj = other_obj
		other_overmap_obj.Entered(src)
	update_visual_position()
	. = TRUE

/datum/overmap_object/proc/UpdateVisualOffsets()
	if(my_visual)
		my_visual.pixel_x = FLOOR(partial_x,1)
		my_visual.pixel_y = FLOOR(partial_y,1)

/datum/overmap_object/proc/GetVisualOffsets()
	var/list/passed = list()
	passed += FLOOR(partial_x,1)
	passed += FLOOR(partial_y,1)
	return passed

/datum/overmap_object/proc/update_visual_position()
	if(my_visual)
		my_visual.x = current_system.GetVisualX(x)
		my_visual.y = current_system.GetVisualY(y)

/datum/overmap_object/process(delta_time)
	return

/datum/overmap_object/ruins
	name = "Cluster of Ruins"
	visual_type = /obj/effect/abstract/overmap/ruins
	clears_hazards_on_spawn = TRUE
