/datum/shuttle_freeform_docker
	var/mob/camera/ai_eye/remote/shuttle_freeform/eyeobj
	var/datum/overmap_shuttle_controller/my_controller
	var/datum/action/innate/freeform_docker_abort/abort_action
	var/datum/action/innate/freeform_docker_jump_view/jump_action
	var/datum/action/innate/freeform_docker_rotate/rotate_action
	var/datum/action/innate/freeform_docker_place/place_action
	var/view_range = 0
	var/x_offset = 0
	var/y_offset = 0
	var/list/whitelist_turfs = list(/turf/open/space, /turf/open/floor/plating, /turf/open/lava, /turf/open/floor/planetary)
	var/see_hidden = FALSE
	var/turf/designating_target_loc
	var/jammed = FALSE
	var/obj/docking_port/stationary/my_port //the custom docking port placed by this console
	var/obj/docking_port/mobile/shuttle_port //the mobile docking port of the connected shuttle
	var/shuttleId = ""
	var/shuttlePortId = ""
	var/shuttlePortName = "custom location"
	var/z_level

	var/mob/current_user

	var/direction = NORTH

	var/should_supress_view_changes = FALSE

	var/list/placement_images = list()

/datum/shuttle_freeform_docker/Destroy()
	abort_action.target = null
	qdel(abort_action)
	jump_action.target = null
	qdel(jump_action)
	rotate_action.target = null
	qdel(rotate_action)
	place_action.target = null
	qdel(place_action)
	my_controller.freeform_docker = null
	my_controller = null
	QDEL_LIST(placement_images)
	qdel(eyeobj)
	return ..()

/datum/shuttle_freeform_docker/New(datum/overmap_shuttle_controller/passed_controller, mob/user, z)
	abort_action = new
	abort_action.target = src
	jump_action = new
	jump_action.target = src
	rotate_action = new
	rotate_action.target = src
	place_action = new
	place_action.target = src
	my_controller = passed_controller
	z_level = z
	current_user = user
	whitelist_turfs = typecacheof(whitelist_turfs)
	StartCameraView()

/datum/shuttle_freeform_docker/proc/CreateEye()
	eyeobj = new()
	eyeobj.origin = src
	var/obj/docking_port/mobile/my_shuttle = my_controller.overmap_obj.my_shuttle
	direction = my_shuttle.dir
	eyeobj.setDir(direction)
	var/turf/origin = locate(my_shuttle.x + x_offset, my_shuttle.y + y_offset, my_shuttle.z)
	for(var/V in my_shuttle.shuttle_areas)
		var/area/A = V
		for(var/turf/T in A)
			if(T.z != origin.z)
				continue
			var/image/I = image('icons/effects/alphacolors.dmi', origin, "red")
			var/x_off = T.x - origin.x
			var/y_off = T.y - origin.y
			I.loc = locate(origin.x + x_off, origin.y + y_off, origin.z) //we have to set this after creating the image because it might be null, and images created in nullspace are immutable.
			I.layer = ABOVE_NORMAL_TURF_LAYER
			I.plane = 0
			I.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
			placement_images[I] = list(x_off, y_off)

/datum/shuttle_freeform_docker/proc/checkLandingSpot()
	var/turf/eyeturf = get_turf(eyeobj)
	if(!eyeturf)
		return SHUTTLE_DOCKER_BLOCKED
	/*
	if(!eyeturf.z || SSmapping.level_has_any_trait(eyeturf.z, locked_traits))
		return SHUTTLE_DOCKER_BLOCKED
	*/

	. = SHUTTLE_DOCKER_LANDING_CLEAR
	var/list/bounds = my_controller.overmap_obj.my_shuttle.return_coords(eyeobj.x - x_offset, eyeobj.y - y_offset, eyeobj.dir)
	var/list/overlappers = SSshuttle.get_dock_overlap(bounds[1], bounds[2], bounds[3], bounds[4], eyeobj.z)
	var/list/image_cache = placement_images
	for(var/i in 1 to image_cache.len)
		var/image/I = image_cache[i]
		var/list/coords = image_cache[I]
		var/turf/T = locate(eyeturf.x + coords[1], eyeturf.y + coords[2], eyeturf.z)
		I.loc = T
		switch(checkLandingTurf(T, overlappers))
			if(SHUTTLE_DOCKER_LANDING_CLEAR)
				I.icon_state = "green"
			if(SHUTTLE_DOCKER_BLOCKED_BY_HIDDEN_PORT)
				I.icon_state = "green"
				if(. == SHUTTLE_DOCKER_LANDING_CLEAR)
					. = SHUTTLE_DOCKER_BLOCKED_BY_HIDDEN_PORT
			else
				I.icon_state = "red"
				. = SHUTTLE_DOCKER_BLOCKED

/datum/shuttle_freeform_docker/proc/checkLandingTurf(turf/T, list/overlappers)
	// Too close to the map edge is never allowed
	if(!T || T.x <= 10 || T.y <= 10 || T.x >= world.maxx - 10 || T.y >= world.maxy - 10)
		return SHUTTLE_DOCKER_BLOCKED
	// If it's one of our shuttle areas assume it's ok to be there
	if(my_controller.overmap_obj.my_shuttle.shuttle_areas[T.loc])
		return SHUTTLE_DOCKER_LANDING_CLEAR
	. = SHUTTLE_DOCKER_LANDING_CLEAR
	// See if the turf is hidden from us
	var/list/hidden_turf_info
	if(!see_hidden)
		hidden_turf_info = SSshuttle.hidden_shuttle_turfs[T]
		if(hidden_turf_info)
			. = SHUTTLE_DOCKER_BLOCKED_BY_HIDDEN_PORT

	if(length(whitelist_turfs))
		var/turf_type = hidden_turf_info ? hidden_turf_info[2] : T.type
		if(!is_type_in_typecache(turf_type, whitelist_turfs))
			return SHUTTLE_DOCKER_BLOCKED

	// Checking for overlapping dock boundaries
	for(var/i in 1 to overlappers.len)
		var/obj/docking_port/port = overlappers[i]
		if(port == my_port)
			continue
		var/port_hidden = !see_hidden && port.hidden
		var/list/overlap = overlappers[port]
		var/list/xs = overlap[1]
		var/list/ys = overlap[2]
		if(xs["[T.x]"] && ys["[T.y]"])
			if(port_hidden)
				. = SHUTTLE_DOCKER_BLOCKED_BY_HIDDEN_PORT
			else
				return SHUTTLE_DOCKER_BLOCKED

/datum/shuttle_freeform_docker/proc/GrantActions()
	abort_action.Grant(current_user)
	jump_action.Grant(current_user)
	rotate_action.Grant(current_user)
	place_action.Grant(current_user)

/datum/shuttle_freeform_docker/proc/RemoveActions()
	abort_action.Remove(current_user)
	jump_action.Remove(current_user)
	rotate_action.Remove(current_user)
	place_action.Remove(current_user)

/datum/shuttle_freeform_docker/proc/RotateAction()
	direction = turn(direction, -90)
	eyeobj.setDir(direction)
	var/list/image_cache = placement_images
	for(var/i in 1 to image_cache.len)
		var/image/pic = image_cache[i]
		var/list/coords = image_cache[pic]
		var/Tmp = coords[1]
		coords[1] = coords[2]
		coords[2] = -Tmp
		pic.loc = locate(eyeobj.x + coords[1], eyeobj.y + coords[2], eyeobj.z)
	checkLandingSpot()

/datum/shuttle_freeform_docker/proc/StartCameraView()
	if(!eyeobj)
		CreateEye()
	if(!eyeobj.eye_initialized)
		var/camera_location
		var/turf/myturf = locate(round(world.maxx/2), round(world.maxy/2), z_level)
		camera_location = myturf
		eyeobj.eye_initialized = TRUE
		give_eye_control(current_user)
		eyeobj.setLoc(camera_location)

/datum/shuttle_freeform_docker/proc/give_eye_control()
	GrantActions()
	eyeobj.eye_user = current_user
	eyeobj.name = "Camera Eye ([current_user.name])"
	current_user.remote_control = eyeobj
	current_user.reset_perspective(eyeobj)
	eyeobj.setLoc(eyeobj.loc)
	if(current_user.client)
		if(should_supress_view_changes)
			current_user.client.view_size.supress()
		current_user.client.images += placement_images
	//current_user.client.view_size.setTo(view_range)

/datum/shuttle_freeform_docker/proc/remove_eye_control()
	RemoveActions()
	if(current_user.client)
		current_user.reset_perspective(null)
		if(eyeobj.visible_icon && current_user.client)
			current_user.client.images -= eyeobj.user_image
		current_user.client.view_size.unsupress()

	if(current_user.client)
		current_user.client.images -= placement_images
	//current_user.client.view_size.resetToDefault()

	eyeobj.eye_user = null
	current_user.remote_control = null
	current_user = null

/datum/action/innate/freeform_docker_abort
	name = "Abort Docking"
	icon_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_cycle_equip_off"

/datum/action/innate/freeform_docker_abort/Activate()
	var/datum/shuttle_freeform_docker/docker = target
	docker.my_controller.AbortFreeform()

/datum/action/innate/freeform_docker_jump_view
	name = "Jump View To Vista"
	icon_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_cycle_equip_off"

/datum/action/innate/freeform_docker_jump_view/Activate() //TODO
	return

/datum/action/innate/freeform_docker_rotate
	name = "Rotate"
	icon_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_cycle_equip_off"

/datum/action/innate/freeform_docker_rotate/Activate()
	var/datum/shuttle_freeform_docker/docker = target
	docker.RotateAction()

/datum/action/innate/freeform_docker_place
	name = "Engage Docking"
	icon_icon = 'icons/mob/actions/actions_mecha.dmi'
	button_icon_state = "mech_zoom_off"

/datum/action/innate/freeform_docker_place/Activate()
	var/datum/shuttle_freeform_docker/docker = target
	docker.PlaceLandingSpot()

/datum/shuttle_freeform_docker/proc/PlaceLandingSpot()
	var/landing_clear = checkLandingSpot()
	var/obj/docking_port/mobile/my_shuttle = my_controller.overmap_obj.my_shuttle
	if(landing_clear != SHUTTLE_DOCKER_LANDING_CLEAR)
		switch(landing_clear)
			if(SHUTTLE_DOCKER_BLOCKED)
				to_chat(current_user, SPAN_WARNING("Invalid transit location."))
			if(SHUTTLE_DOCKER_BLOCKED_BY_HIDDEN_PORT)
				to_chat(current_user, SPAN_WARNING("Unknown object detected in landing zone. Please designate another location."))
		return

	///Make one use port that deleted after fly off, to don't lose info that need on to properly fly off.
	if(my_shuttle.freeform_port?.get_docked())
		my_shuttle.freeform_port.unregister()
		my_shuttle.freeform_port.delete_after = TRUE
		my_shuttle.freeform_port.id = null
		my_shuttle.freeform_port = null

	if(!my_shuttle.freeform_port)
		my_shuttle.freeform_port = new()
		my_shuttle.freeform_port.unregister()
		my_shuttle.freeform_port.name = "[my_shuttle.name] Freeform Dock"
		my_shuttle.freeform_port.id = "[my_shuttle.id]_freeform"
		my_shuttle.freeform_port.height = my_shuttle.height
		my_shuttle.freeform_port.width = my_shuttle.width
		my_shuttle.freeform_port.dheight = my_shuttle.dheight
		my_shuttle.freeform_port.dwidth = my_shuttle.dwidth
		my_shuttle.freeform_port.hidden = my_shuttle.hidden
		my_shuttle.freeform_port.register(TRUE)
	my_shuttle.freeform_port.setDir(eyeobj.dir)
	my_shuttle.freeform_port.forceMove(locate(eyeobj.x - x_offset, eyeobj.y - y_offset, eyeobj.z))

	if(current_user.client)
		to_chat(current_user, SPAN_NOTICE("Transit location designated."))

	//my_shuttle.request(my_shuttle.freeform_port)

	switch(SSshuttle.moveShuttle(my_shuttle.id, my_shuttle.freeform_port.id, TRUE))
		if(0)
			my_controller.busy = TRUE
			my_controller.RemoveCurrentControl()
			return TRUE
		/*
		if(1)
			message_admins("we didnt do it")
		else
			message_admins("error")
		*/

	return TRUE

/mob/camera/ai_eye/remote/shuttle_freeform
	visible_icon = FALSE
	use_static = FALSE
	var/list/placement_images = list()

/mob/camera/ai_eye/remote/shuttle_freeform/setLoc(T)
	..()
	var/datum/shuttle_freeform_docker/docker = origin
	if(docker)
		docker.checkLandingSpot()

/mob/camera/ai_eye/remote/shuttle_freeform/update_remote_sight(mob/living/user)
	user.sight = BLIND|SEE_TURFS
	user.lighting_alpha = LIGHTING_PLANE_ALPHA_INVISIBLE
	user.sync_lighting_plane_alpha()
	return TRUE
