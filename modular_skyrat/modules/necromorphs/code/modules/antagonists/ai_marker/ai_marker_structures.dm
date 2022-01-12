/obj/structure/corruption
	anchored = TRUE
	var/datum/marker_corruption_controller/our_controller


/obj/structure/corruption/Destroy()
	our_controller = null
	playsound(src.loc, 'sound/effects/splat.ogg', 30, TRUE)
	return ..()

/obj/structure/corruption/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(loc, 'sound/effects/attackblob.ogg', 100, TRUE)
		if(BURN)
			playsound(loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/corruption/Initialize(mapload)
	. = ..()

	//calculate_growth()
	//___TraitAddupdate_neighbors()
	update_icon()


/obj/structure/corruption/structure
	density = TRUE

/datum/looping_sound/core_heartbeat
	mid_length = 3 SECONDS
	mid_sounds = list('modular_skyrat/master_files/sound/effects/heart_beat_loop3.ogg'=1)
	volume = 20

#define CORE_RETALIATION_COOLDOWN 5 SECONDS

/obj/structure/corruption/structure/core
	name = "glowing core"
	icon = 'modular_skyrat/modules/necromorphs/icons/obj/marker_normal.dmi'
	icon_state = "marker_normal_active"
	layer = TABLE_LAYER
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LAVA
	max_integrity = 1200
	var/datum/looping_sound/core_heartbeat/soundloop
	var/next_retaliation = 0

/obj/structure/corruption/structure/core/Initialize()
	. = ..()
	new /datum/marker_corruption_controller(src)
	soundloop = new(list(src),  TRUE)
	update_overlays()

/obj/structure/corruption/structure/core/Destroy()
	if(our_controller)
		our_controller.our_core = null
	soundloop.stop()
	QDEL_NULL(soundloop)
	return ..()

/obj/structure/corruption/structure/core/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	if(damage_amount > 10 && world.time > next_retaliation && prob(40))
		if(our_controller)
			our_controller.CoreRetaliated()
		next_retaliation = world.time + CORE_RETALIATION_COOLDOWN
		//The core should try and seal the room its in, to prevent ranged cheese?
		//Add maybe a melee attack too?
		//var/turf/my_turf = get_turf(src)
		visible_message(span_warning("The [src] emitts a cloud!"))
		var/datum/reagents/R = new/datum/reagents(300)
		R.my_atom = src
		R.add_reagent(/datum/reagent/cordycepsspores, 50)
		var/datum/effect_system/smoke_spread/chem/smoke = new()
		smoke.set_up(R, 5)
		smoke.attach(src)
		smoke.start()

	return ..()

/obj/structure/corruption/structure/core/update_overlays()
	. = ..()
	// var/mutable_appearance/corruption_overlay = mutable_appearance('icons/mob/blob.dmi', "blob")
	// . += corruption_overlay
	// . += mutable_appearance('icons/mob/blob.dmi', "blob_core_overlay")

	// SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	// SSvis_overlays.add_vis_overlay(src, icon, "blob_core_overlay", layer, plane, dir, alpha)
	// SSvis_overlays.add_vis_overlay(src, icon, "blob_core_overlay", 0, EMISSIVE_PLANE, dir, alpha)
	// var/obj/effect/overlay/vis/overlay1 = managed_vis_overlays[1]
	// var/obj/effect/overlay/vis/overlay2 = managed_vis_overlays[2]
	// overlay1.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR
	// overlay2.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR

#undef CORE_RETALIATION_COOLDOWN

/obj/structure/corruption/resin
	name = "Growth"
	desc = "It looks like mold, but it seems alive."
	icon = 'modular_skyrat/modules/necromorphs/icons/effects/corruption.dmi'
	icon_state = "corruption-1"
	density = FALSE
	plane = FLOOR_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	max_integrity = 50
	var/blooming = FALSE
	//Are we a floor resin? If not then we're a wall resin
	var/floor = TRUE
	var/use_edge = FALSE
	var/max_alpha = 215
	var/min_alpha = 20
	var/vine_scale = 1.1

/obj/structure/corruption/resin/Initialize(mapload)
	. = ..()
	desc += " It looks like it's rotting."
	update_icon()

/obj/structure/corruption/resin/update_icon()
	. = ..()
	icon_state = "corruption-[rand(1,3)]"

	var/matrix/M = matrix()
	M = M.Scale(vine_scale)	//We scale up the sprite so it slightly overlaps neighboring corruption tiles
	var/rotation = pick(list(0,90,180,270))	//Randomly rotate it
	transform = turn(M, rotation)


/*
/obj/structure/blob/normal/update_icon_state()
	icon_state = "blob[(atom_integrity <= 15) ? "_damaged" : null]"

	/// - [] TODO: Move this elsewhere
	if(atom_integrity <= 15)
		brute_resist = BLOB_BRUTE_RESIST
	else if (overmind)
		brute_resist = BLOB_BRUTE_RESIST * 0.5
	else
		brute_resist = BLOB_BRUTE_RESIST * 0.5
	return ..()
*/

/obj/structure/corruption/resin/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(blooming)
		SSvis_overlays.add_vis_overlay(src, icon, "minieye", layer, plane, dir, alpha)
		SSvis_overlays.add_vis_overlay(src, icon, "minigrowth", 0, EMISSIVE_PLANE, dir, alpha)
		var/obj/effect/overlay/vis/overlay1 = managed_vis_overlays[1]
		var/obj/effect/overlay/vis/overlay2 = managed_vis_overlays[2]
		overlay1.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR
		overlay2.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR
	if(use_edge)
		SSvis_overlays.add_vis_overlay(src, icon, "corruption-edge", layer, plane, dir, alpha)
		switch(dir) //offset to make it be on the wall rather than on the floor
			if(NORTH)
				pixel_y = 32
			if(SOUTH)
				pixel_y = -32
			if(EAST)
				pixel_x = 32
			if(WEST)
				pixel_x = -32
		var/obj/effect/overlay/vis/overlay3 = managed_vis_overlays[3]
		var/matrix/M = matrix()
		M = M.Scale(vine_scale)
		overlay3.icon_state = "corruption-edge"
		overlay3.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR | RESET_TRANSFORM
		overlay3.transform = M
		overlay3.pixel_x = pixel_x
		overlay3.pixel_y = pixel_y

	// if(floor)
	// 	overlays.Cut()
	// 	for(var/turf/ in GLOB.cardinals)
	// 		var/direction = get_dir(src, floor)
	// 		var/vector2/offset = newDir
	// 		offset.SelfMultiply(32 * vine_scale)
	// 		var/image/I = image(icon, src, "corruption-edge", layer+1, direction)
	// 		I.pixel_x = offset.x
	// 		I.pixel_y = offset.y
	// 		I.appearance_flags = RESET_TRANSFORM	//We use reset transform to not carry over the rotation

	// 		I.transform = I.transform.Scale(vine_scale)	//We must reapply the scale
	// 		overlays.Add(I)

/obj/structure/corruption/resin/proc/CalcDir()
	var/direction = 16
	var/turf/location = loc
	for(var/wallDir in GLOB.cardinals)
		var/turf/newTurf = get_step(location,wallDir)
		if(newTurf && newTurf.density)
			direction |= wallDir

	for(var/obj/structure/corruption/resin/tomato in location)
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
			use_edge = TRUE
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
			icon_state = "corruption-edge"
			plane = GAME_PLANE
			layer = ABOVE_NORMAL_TURF_LAYER

	if(prob(7))
		blooming = TRUE
		set_light(2, 1, LIGHT_COLOR_LAVA)
		update_overlays()

/obj/structure/corruption/resin/Destroy()
	if(our_controller)
		our_controller.ActivateAdjacentResin(get_turf(src))
		our_controller.all_corruption -= src
		our_controller.active_corruption -= src
	return ..()

#define BLOB_BULB_ALPHA 100

/obj/structure/corruption/structure/bulb
	name = "empty bulb"
	icon = 'modular_skyrat/modules/necromorphs/icons/effects/corruption.dmi'
	icon_state = "cyst-empty"
	density = FALSE
	layer = TABLE_LAYER
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LAVA
	var/is_full = FALSE
	var/list/registered_turfs = list()
	max_integrity = 100

/obj/structure/corruption/structure/bulb/Initialize()
	. = ..()
	make_full()
	for(var/t in get_adjacent_open_turfs(src))
		registered_turfs += t
		RegisterSignal(t, COMSIG_ATOM_ENTERED, .proc/proximity_trigger)

/obj/structure/corruption/structure/bulb/proc/proximity_trigger(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	if(!isliving(AM))
		return
	var/mob/living/L = AM
	if(!(MOLD_FACTION in L.faction))
		INVOKE_ASYNC(src, .proc/discharge)

/obj/structure/corruption/structure/bulb/proc/make_full()
	//Called by a timer, check if we exist
	if(QDELETED(src))
		return
	is_full = TRUE
	name = "filled bulb"
	icon_state = "cyst-full"
	set_light(2,1,LIGHT_COLOR_LAVA)
	density = TRUE
	update_overlays()

/obj/structure/corruption/structure/bulb/proc/discharge()
	if(!is_full)
		return
	//var/turf/T = get_turf(src)
	visible_message(span_warning("The [src] ruptures!"))
	var/datum/reagents/R = new/datum/reagents(300)
	R.my_atom = src
	R.add_reagent(/datum/reagent/cordycepsspores, 50)
	var/datum/effect_system/smoke_spread/chem/smoke = new()
	smoke.set_up(R, 5)
	smoke.attach(src)
	smoke.start()
	is_full = FALSE
	name = "empty bulb"
	icon_state = "cyst-empty"
	playsound(src, 'sound/effects/bamf.ogg', 100, TRUE)
	set_light(0)
	update_overlays()
	density = FALSE
	addtimer(CALLBACK(src, .proc/make_full), 1 MINUTES, TIMER_UNIQUE|TIMER_NO_HASH_WAIT)

/obj/structure/corruption/structure/bulb/attack_generic(mob/user, damage_amount, damage_type, damage_flag, sound_effect, armor_penetration)
	if(FACTION_NECROMORPH in user.faction)
		return ..()
	discharge()
	. = ..()

/obj/structure/corruption/structure/bulb/bullet_act(obj/projectile/P)
	if(istype(P, /obj/projectile/energy/nuclear_particle))
		return ..()
	discharge()
	. = ..()

/obj/structure/corruption/structure/bulb/Destroy()
	if(our_controller)
		our_controller.other_structures -= src
	for(var/t in registered_turfs)
		UnregisterSignal(t, COMSIG_ATOM_ENTERED)
	registered_turfs = null
	return ..()

/obj/structure/corruption/structure/bulb/update_overlays()
	. = ..()
	// SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	// if(is_full)
	// 	SSvis_overlays.add_vis_overlay(src, icon, "blob_bulb_overlay", layer, plane, dir, BLOB_BULB_ALPHA)
	// 	SSvis_overlays.add_vis_overlay(src, icon, "blob_bulb_overlay", 0, EMISSIVE_PLANE, dir, alpha)
	// 	var/obj/effect/overlay/vis/overlay1 = managed_vis_overlays[1]
	// 	var/obj/effect/overlay/vis/overlay2 = managed_vis_overlays[2]
	// 	overlay1.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR
	// 	overlay2.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR

#undef BLOB_BULB_ALPHA


/obj/structure/corruption/structure/wall
	name = "mold wall"
	desc = "Looks like some kind of thick resin."
	icon = 'icons/obj/smooth_structures/alien/resin_wall.dmi'
	icon_state = "resin_wall-0"
	base_icon_state = "resin_wall"
	opacity = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_ALIEN_RESIN)
	canSmoothWith = list(SMOOTH_GROUP_ALIEN_RESIN)
	max_integrity = 200
	can_atmos_pass = ATMOS_PASS_DENSITY

/obj/structure/corruption/wall/Destroy()
	if(our_controller)
		our_controller.ActivateAdjacentResin(get_turf(src))
		our_controller.other_structures -= src
	return ..()

/obj/structure/corruption/structure/conditioner
	name = "pulsating vent"
	desc = "An unsightly vent, it appears to be puffing something out."
	density = FALSE
	icon = 'modular_skyrat/modules/necromorphs/icons/effects/corruption.dmi'
	icon_state = "growth"
	density = FALSE
	layer = LOW_OBJ_LAYER
	max_integrity = 150
	///The mold atmosphere conditioner will spawn the molds preferred atmosphere every so often.
	var/happy_atmos = null
	var/puff_cooldown = 15 SECONDS
	var/puff_delay = 0

/obj/structure/corruption/structure/conditioner/Destroy()
	STOP_PROCESSING(SSobj, src)
	if(our_controller)
		our_controller.other_structures -= src
	return ..()

/obj/structure/corruption/structure/conditioner/Initialize()
	. = ..()
	happy_atmos = "miasma=50;TEMP=296"

	START_PROCESSING(SSobj, src)

/obj/structure/corruption/structure/conditioner/process(delta_time)
	if(!happy_atmos)
		return
	if(puff_delay > world.time)
		return
	puff_delay = world.time + puff_cooldown
	var/turf/holder_turf = get_turf(src)
	holder_turf.atmos_spawn_air(happy_atmos)

/obj/structure/corruption/structure/spawner
	name = "hatchery"
	density = FALSE
	icon = 'modular_skyrat/modules/necromorphs/icons/effects/corruption.dmi'
	icon_state = "maw"
	density = FALSE
	layer = LOW_OBJ_LAYER
	max_integrity = 150
	var/monster_types = list()
	var/max_spawns = 1
	var/spawn_cooldown = 1200 //In deciseconds.
	var/randpixel = 0
	var/random_rotation = TRUE


/obj/structure/corruption/structure/spawner/Destroy()
	if(our_controller)
		our_controller.other_structures -= src
	return ..()

/obj/structure/corruption/structure/spawner/Initialize()
	. = ..()
	monster_types = list(/mob/living/simple_animal/hostile/corruption/slasher)
	spawn_cooldown = 500
	AddComponent(/datum/component/spawner, monster_types, spawn_cooldown, list(FACTION_NECROMORPH), "emerges from", max_spawns)

	/datum/component/spawner

/obj/structure/corruption/structure/spawner/update_icon()
	.=..()
	var/matrix/M = matrix()
	M = M.Scale(default_scale)	//We scale up the sprite so it slightly overlaps neighboring corruption tiles
	M = turn(M, get_rotation())
	if (randpixel)
		pixel_x = base_pixel_x + rand_between(-randpixel, randpixel)
		pixel_y = base_pixel_y + rand_between(-randpixel, randpixel)
	transform = M


/obj/structure/corruption/structure/spawner/proc/get_rotation()
	if (!random_rotation)
		return 0
	default_rotation = pick(list(0,45,90,135,180,225,270,315))//Randomly rotate it

	return default_rotation
