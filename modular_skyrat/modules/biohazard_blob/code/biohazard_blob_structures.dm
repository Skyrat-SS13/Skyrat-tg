/obj/structure/biohazard_blob
	anchored = TRUE
	var/datum/biohazard_blob_controller/our_controller
	var/blob_type

/obj/structure/biohazard_blob/Destroy()
	our_controller = null
	return ..()

/obj/structure/biohazard_blob/Initialize(mapload, passed_blob_type)
	. = ..()
	if(passed_blob_type)
		blob_type = passed_blob_type
	switch(blob_type)
		if(BIO_BLOB_TYPE_FUNGUS)
			color = "#A85"
		if(BIO_BLOB_TYPE_FIRE)
			color = "#C50"
			resistance_flags = FIRE_PROOF
		if(BIO_BLOB_TYPE_EMP)
			color = "#0B9"
		if(BIO_BLOB_TYPE_TOXIC)
			color = "#480"
			resistance_flags = UNACIDABLE | ACID_PROOF

/datum/looping_sound/core_heartbeat
	mid_length = 51
	mid_sounds = list('sound/effects/heart_beat.ogg'=1)
	volume = 20

/obj/structure/biohazard_blob/core
	name = "glowing core"
	icon = 'modular_skyrat/modules/biohazard_blob/icons/blob_core.dmi'
	icon_state = "blob_core"
	density = TRUE
	layer = TABLE_LAYER
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LAVA
	max_integrity = 400
	var/datum/looping_sound/core_heartbeat/soundloop

/obj/structure/biohazard_blob/core/fungus
	blob_type = BIO_BLOB_TYPE_FUNGUS

/obj/structure/biohazard_blob/core/fire
	blob_type = BIO_BLOB_TYPE_FIRE

/obj/structure/biohazard_blob/core/emp
	blob_type = BIO_BLOB_TYPE_EMP

/obj/structure/biohazard_blob/core/toxic
	blob_type = BIO_BLOB_TYPE_TOXIC

/obj/structure/biohazard_blob/core/Initialize()
	if(!blob_type)
		blob_type = pick(ALL_BIO_BLOB_TYPES)
	. = ..()
	new /datum/biohazard_blob_controller(src, blob_type)
	soundloop = new(list(src),  TRUE)
	update_overlays()

/obj/structure/biohazard_blob/core/Destroy()
	if(our_controller)
		our_controller.CoreDeath()
		our_controller.our_core = null
	soundloop.stop()
	QDEL_NULL(soundloop)
	return ..()

/obj/structure/biohazard_blob/core/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	SSvis_overlays.add_vis_overlay(src, icon, "blob_core_overlay", layer, plane, dir, alpha)
	SSvis_overlays.add_vis_overlay(src, icon, "blob_core_overlay", EMISSIVE_LAYER, EMISSIVE_PLANE, dir, alpha)
	managed_vis_overlays[1].appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR
	managed_vis_overlays[2].appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR

/obj/structure/biohazard_blob/resin
	name = "mold"
	desc = "It looks like mold, but it seems alive."
	icon = 'modular_skyrat/modules/biohazard_blob/icons/blob_resin.dmi'
	icon_state = "blob_floor"
	density = FALSE
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
		if(newTurf && newTurf.density)
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

#define BLOB_BULB_ALPHA 160

/obj/structure/biohazard_blob/bulb
	name = "empty bulb"
	density = TRUE
	icon = 'modular_skyrat/modules/biohazard_blob/icons/blob_bulb.dmi'
	icon_state = "blob_bulb_empty"
	density = TRUE
	layer = TABLE_LAYER
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LAVA
	var/is_full = FALSE
	var/list/registered_turfs = list()
	max_integrity = 100

/obj/structure/biohazard_blob/bulb/Initialize()
	. = ..()
	make_full()
	for(var/t in get_adjacent_open_turfs(src))
		registered_turfs += t
		RegisterSignal(t, COMSIG_ATOM_ENTERED, .proc/proximity_trigger)

/obj/structure/biohazard_blob/bulb/proc/proximity_trigger(datum/source, atom/movable/AM)
	if(!isliving(AM))
		return
	var/mob/living/L = AM
	if(!(MOLD_FACTION in L.faction))
		discharge()

/obj/structure/biohazard_blob/bulb/proc/make_full()
	//Called by a timer, check if we exist
	if(QDELETED(src))
		return
	is_full = TRUE
	name = "filled bulb"
	icon_state = "blob_bulb_full"
	set_light(2,1,LIGHT_COLOR_LAVA)
	update_overlays()

/obj/structure/biohazard_blob/bulb/proc/discharge()
	if(!is_full)
		return
	is_full = FALSE
	name = "empty bulb"
	icon_state = "blob_bulb_empty"
	playsound(src, 'sound/effects/bamf.ogg', 100, TRUE)
	set_light(0)
	update_overlays()
	addtimer(CALLBACK(src, .proc/make_full), 120 SECONDS, TIMER_UNIQUE|TIMER_NO_HASH_WAIT)

/obj/structure/biohazard_blob/bulb/run_obj_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	discharge()
	. = ..()

/obj/structure/biohazard_blob/bulb/Destroy()
	for(var/t in registered_turfs)
		UnregisterSignal(t, COMSIG_ATOM_ENTERED)
	registered_turfs = null
	return ..()

/obj/structure/biohazard_blob/bulb/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(is_full)
		SSvis_overlays.add_vis_overlay(src, icon, "blob_bulb_overlay", layer, plane, dir, BLOB_BULB_ALPHA)
		SSvis_overlays.add_vis_overlay(src, icon, "blob_bulb_overlay", EMISSIVE_LAYER, EMISSIVE_PLANE, dir, BLOB_BULB_ALPHA)
		managed_vis_overlays[1].appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR
		managed_vis_overlays[2].appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR

#undef BLOB_BULB_ALPHA


/obj/structure/biohazard_blob/wall
	name = "mold wall"
	desc = "Looks like some kind of thick resin."
	icon = 'icons/obj/smooth_structures/alien/resin_wall.dmi'
	icon_state = "resin_wall-0"
	base_icon_state = "resin_wall"
	density = TRUE
	opacity = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_ALIEN_RESIN)
	canSmoothWith = list(SMOOTH_GROUP_ALIEN_RESIN)
	max_integrity = 200
	CanAtmosPass = ATMOS_PASS_DENSITY

/obj/structure/biohazard_blob/wall/Destroy()
	if(our_controller)
		our_controller.other_structures -= src
	return ..()