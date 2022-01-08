#define PLACEMENT_SAFETY	if (!user || !user.client){stop_placement();return;}

GLOBAL_LIST_EMPTY(placement_previews)
/*
	Placement handler is used to designate a specific place for an object.

	When activated, the user gets a silhouette of the object attached to their mouse cursor.
	Lots of specific functionality may be needed to pull this off, so subclasses are vital.
*/
/datum/click_handler/placement
	var/atom/preview
	var/dir = SOUTH		//What direction are we using? This is assigned to the preview, and will be applied to the resulting placement item too
	var/result_path		//The atom we'll spawn when placement is successful
	var/snap_to_grid	//If true, the preview will snap to the centre of whatever tile the user hovers over
	var/stopped = FALSE	//Used to prevent running stop code twice
	var/vector2/pixel_offset	//Is our preview image offset from the mouse cursor?
	var/turf/last_location
	var/rotate_angle = 90
	flags = CLICK_HANDLER_REMOVE_ON_MOB_LOGOUT
	var/message = ""
	var/last_move_params	//Cached params from last mousemove event
	var/datum/callback/call_on_place
	var/placement_location = PLACEMENT_FLOOR


	has_mousemove = TRUE

/datum/click_handler/placement/New(var/mob/user, var/datum/callback/C)
	if (C)
		call_on_place = C
	pixel_offset = get_new_vector(0,0)
	.=..()


/datum/click_handler/placement/Destroy()
	release_vector(pixel_offset)
	.=..()

//Starting and finishing
//---------------------------------------
/datum/click_handler/placement/proc/start_placement()
	PLACEMENT_SAFETY
	user.client.show_popup_menus = FALSE	//We need to turn this off in order to recieve rightclicks
	user.client.screen |= preview
	add_verb(user, /mob/verb/placement_rotate)
	winset(user, "rotate_placement", "parent=macro;name=R;command=rotate_placement")
	//winset(user, "rotate_placement", "parent=hotkeymode;name=R;command=rotate_placement")


//This proc stops everything, and makes the handler remove+delete itself. Call this to end things
/datum/click_handler/placement/proc/stop_placement()
	if (!stopped)
		stopped = TRUE
		if (user && user.client)
			winset(user, "macro.rotate_placement", "parent=")
			//winset(user, "hotkeymode.rotate_placement", "parent=")
			remove_verb(user, /mob/verb/placement_rotate)
			user.client.show_popup_menus = TRUE
			user.client.screen -= preview

			qdel(preview)

		if (!QDELETED(src))
			user.RemoveClickHandler(src)


//If we'ere removed by some other means, make sure we stop
/datum/click_handler/placement/Destroy()
	stop_placement()
	.=..()



//Control interfaces:
//----------------------------------
//Leftclick: Spawn the item and finish placement
/datum/click_handler/placement/OnLeftClick(var/atom/A, var/params)
	PLACEMENT_SAFETY
	//Check if we're allowed to place where we've clicked
	var/turf/site = get_turf_at_mouse(params, user.client)
	var/message = placement_blocked(site)
	if (!message)
		spawn_result(site)
		stop_placement()
	else
		to_chat(user, SPAN_DANGER(message))
	return FALSE


//Rightclick: Cancel placement without spawning anything
/datum/click_handler/placement/OnRightClick(var/atom/A, var/params)
	PLACEMENT_SAFETY
	stop_placement()


//Shiftclick: Spawn the item, but don't finish placement, so the user can keep placing more copies
/datum/click_handler/placement/OnShiftClick(var/atom/A, var/params)
	PLACEMENT_SAFETY
	//Check if we're allowed to place where we've clicked
	var/turf/site = get_turf_at_mouse(params, user.client)
	var/message = placement_blocked(site)
	if (!message)
		spawn_result(site)
	else
		to_chat(user, SPAN_DANGER(message))
	return FALSE


//Mousemove: Update whether or not we can place things, move the preview to the cursor
/datum/click_handler/placement/MouseMove(object,location,control,params)

	PLACEMENT_SAFETY
	if (!isturf(location))
		return
	last_location = location
	message = placement_blocked(location)
	update_pixel_offset()
	last_move_params = params
	sync_screen_loc_to_mouse(preview, params, snap_to_grid, pixel_offset)


	set_preview_color((message ? FALSE : TRUE))



//Called by pressing R
/datum/click_handler/placement/proc/rotate()
	dir = turn(dir, rotate_angle)	//Possible todo: Future support for 8-directional sprites here
	if (preview)
		preview.dir = dir
		if (last_location)
			message = placement_blocked(last_location)
			set_preview_color((message ? FALSE : TRUE))
			update_pixel_offset()
			sync_screen_loc_to_mouse(preview, last_move_params, snap_to_grid, pixel_offset)


//Safety checking
//------------------------

//Is anything stopping us from placing the item on this turf?
//Return false if we're clear to proceed
//Otherwise, return a text string explaining why it fails, this will be displayed to the user
/datum/click_handler/placement/proc/placement_blocked(var/turf/candidate)
	PLACEMENT_SAFETY
	if (!turf_clear(candidate, ignore_mobs=TRUE))
		return "Tile obstructed"

	return FALSE





//Preview Handling
//------------------------------------
/datum/click_handler/placement/proc/generate_preview_image(var/path)
	if (!preview)
		preview = new /atom/movable()
		var/atom/A = new path()
		if (!snap_to_grid)
			pixel_offset.x = -WORLD_ICON_SIZE/2
			pixel_offset.y = -WORLD_ICON_SIZE/2 //Offset should be at least -16,-16 to center the icon.

		pixel_offset.x += A.pixel_x
		pixel_offset.y += A.pixel_y
		preview.appearance = A.appearance
		user.client.screen |= preview
		qdel(A)

/datum/click_handler/placement/proc/set_preview_color(var/placeable = FALSE)
	preview.alpha = 128
	if (placeable)
		preview.color = "#88CC88"
	else
		preview.color = "#CC8888"


/datum/click_handler/placement/proc/update_pixel_offset()
	return


//Spawning
//----------------
/datum/click_handler/placement/proc/spawn_result(var/turf/site)
	//We should have done all necessary checks here, so we are clear to proceed
	var/atom/A = new result_path(site)
	A.dir = dir
	return A	//We are done!


//Entrypoints and debug
//---------------------------
//This proc creates a placement handler, the arguments are:
	//user: must be a cliented mob
	//Result: The path of the thing we will spawn
	//Type: The subtype of click handler we'll use. Optional.
	//Preview Image: Optional. If not supplied, one will be autogenerated from the result path
/proc/create_placement_handler(var/mob/_user, var/_result, var/_handler_type = /datum/click_handler/placement, var/snap = FALSE, var/datum/callback/C)
	if (!istype(_user))
		return

	_user.RemoveClickHandlersByType(/datum/click_handler/placement)	//Remove any old placement handlers first, a mob should never have more than one of these

	var/datum/click_handler/placement/P = _user.PushClickHandler(_handler_type, C)

	P.result_path = _result
	P.snap_to_grid = snap

	P.generate_preview_image(P.result_path)
	P.start_placement()

	winset(_user, "mapwindow.map", "focus=true")
	return P



/mob/verb/placement_rotate()
	set name = "rotate_placement"
	set hidden = TRUE
	set popup_menu = FALSE
	set category = null

	var/datum/stack/handlers = GetClickHandlers()
	while (handlers.Num())
		var/datum/click_handler/placement/CH = handlers.Pop()
		if (istype(CH))
			CH.rotate()
			return

/*
//Debugging verbs, kept for future use
/client/verb/debug_placement_snap()
	set category = "Commands"

	create_placement_handler(usr, /obj/machinery/power/emitter, snap = TRUE)


/client/verb/debug_placement_freeform()
	set category = "Commands"

	create_placement_handler(usr, /obj/machinery/power/emitter)
*/


//Variants
//--------------------

//Used for spawning necros, this one checks if a marker has enough biomass, and passes back to the marker to do the actual spawning
	//We won't actually take biomass from the marker, it handles the spending itself, and it will also double verify our spawn command
//In addition, it can optionally require the thing to be spawned only on corrupted tiles

/datum/click_handler/placement/necromorph
	var/spawn_name = "Spawn"
	var/obj/machinery/marker/biomass_source
	var/biomass_cost = 0
	var/require_corruption = TRUE
	var/LOS_block = TRUE


/datum/click_handler/placement/necromorph/placement_blocked(var/turf/candidate)
	.=..()
	if (!.)
		if (!biomass_source)
			return "No biomass source!"
		if (biomass_source.get_available_biomass() < biomass_cost)
			return "Insufficient biomass"


		if (require_corruption && !turf_corrupted(candidate))
			return "This can only be placed on corrupted tiles."

		for (var/obj/structure/corruption_node/CN in candidate)
			if (CN.placement_location == src.placement_location)
				return "Only one corruption node can be placed per tile."

		if (LOS_block)
			var/mob/M = candidate.is_seen_by_crew()
			if (M)
				return "Placement here is blocked, because [M] can see this tile. Must be placed out of sight"


//Here, we won't spawn the item ourselves. Instead we assemble a spawn params list and pass it to the marker's necroshop to finish
/datum/click_handler/placement/necromorph/spawn_result(var/turf/site)
	var/datum/necroshop/NS = biomass_source.get_necroshop()
	if (!istype(NS))
		//Fatal error, abort
		return

	var/list/params = list()
	params["name"] = spawn_name
	params["origin"] = biomass_source
	params["target"] = site	//The exact turf we will spawn into
	params["price"] = biomass_cost	//How much will it cost to do this spawn?
	params["dir"] = dir	//Direction we face on spawning, not important for point spawn
	params["path"] = result_path
	params["user"] = user	//Who is responsible for this ? Who shall we show error messages to
	if (ispath(result_path, /mob))
		params["queue"] = TRUE
	else
		params["queue"] = FALSE

	return NS.finalize_spawn(params)


/proc/create_necromorph_placement_handler(var/mob/_user, var/_result, var/_handler_type = /datum/click_handler/placement/necromorph, var/snap = TRUE, var/atom/biomass_source, var/name, var/biomass_cost, var/require_corruption)
	if (!istype(_user))
		return

	_user.RemoveClickHandlersByType(/datum/click_handler/placement)	//Remove any old placement handlers first, a mob should never have more than one of these

	var/datum/click_handler/placement/necromorph/P = _user.PushClickHandler(_handler_type)
	P.result_path = _result
	P.snap_to_grid = snap
	P.spawn_name = name
	P.biomass_cost = biomass_cost
	P.require_corruption = require_corruption
	P.biomass_source = biomass_source

	P.generate_preview_image(P.result_path)
	P.start_placement()

	winset(_user, "mapwindow.map", "focus=true")
	return P