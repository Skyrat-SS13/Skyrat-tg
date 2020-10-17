/obj/structure/biohazard_blob
	var/datum/biohazard_blob_controller/our_controller
	color = "#A85"

/obj/structure/biohazard_blob/core
	name = "blob core"
	icon = 'modular_skyrat/modules/biohazard_blob/icons/blob_core.dmi'
	icon_state = "blob_core"
	density = TRUE
	anchored = TRUE
	layer = TABLE_LAYER
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LAVA
	max_integrity = 300

/obj/structure/biohazard_blob/core/Initialize()
	. = ..()
	new /datum/biohazard_blob_controller(src)
	update_overlays()

/obj/structure/biohazard_blob/core/Destroy()
	if(our_controller)
		our_controller.CoreDeath()
		our_controller.our_core = null
	return ..()

/obj/structure/biohazard_blob/core/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	SSvis_overlays.add_vis_overlay(src, icon, "blob_core_overlay", layer, plane, dir, alpha)
	SSvis_overlays.add_vis_overlay(src, icon, "blob_core_overlay", EMISSIVE_LAYER, EMISSIVE_PLANE, dir, alpha)
	managed_vis_overlays[1].appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR
	managed_vis_overlays[2].appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR

/obj/structure/biohazard_blob/resin
	name = "organic resin"
	icon = 'modular_skyrat/modules/biohazard_blob/icons/blob_resin.dmi'
	icon_state = "blob_floor"
	density = FALSE
	anchored = TRUE
	plane = FLOOR_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	max_integrity = 50
	var/blooming = FALSE
	//Are we a floor resin? If not then we're a wall resin
	var/floor = TRUE

/obj/structure/biohazard_blob/resin/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(blooming)
		SSvis_overlays.add_vis_overlay(src, icon, "[icon_state]_overlay", layer, plane, dir, alpha)
		SSvis_overlays.add_vis_overlay(src, icon, "[icon_state]_overlay", EMISSIVE_LAYER, EMISSIVE_PLANE, dir, alpha)
		managed_vis_overlays[1].appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR
		managed_vis_overlays[2].appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR

/obj/structure/biohazard_blob/resin/proc/CalcDir()
	var/direction = 16
	var/turf/location = loc
	for(var/wallDir in GLOB.cardinals)
		var/turf/newTurf = get_step(location,wallDir)
		if(newTurf.density)
			direction |= wallDir

	for(var/obj/structure/biohazard_blob/resin/tomato in location)
		if(tomato == src)
			continue
		if(tomato.floor) //special
			direction &= ~16
		else
			direction &= ~tomato.dir

	var/list/dirList = list()

	for(var/i=1,i<=16,i <<= 1)
		if(direction & i)
			dirList += i 

	if(dirList.len)
		var/newDir = pick(dirList)
		if(newDir == 16)
			setDir(pick(GLOB.cardinals))
		else
			floor = FALSE
			setDir(newDir)
			switch(dir) //offset to make it be on the wall rather than on the floor
				if(NORTH)
					pixel_y = 32
				if(SOUTH)
					pixel_y = -32
				if(EAST)
					pixel_x = 32
				if(WEST)
					pixel_x = -32
			icon_state = "blob_wall"
			plane = GAME_PLANE
			layer = ABOVE_NORMAL_TURF_LAYER

	if(prob(7))
		blooming = TRUE
		set_light(2, 1, LIGHT_COLOR_LAVA)
		update_overlays()

/obj/structure/biohazard_blob/resin/Destroy()
	if(our_controller)
		our_controller.ActivateAdjacentResin(src)
		our_controller.all_resin -= src
		our_controller.active_resin -= src
	return ..()
