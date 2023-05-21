/obj/structure/mold
	anchored = TRUE

	/// The controller controlling the mold's expansion
	var/datum/mold_controller/our_controller
	/// The type of mold
	var/datum/mold/mold_type

/obj/structure/mold/Destroy()
	our_controller = null
	mold_type = null
	playsound(src.loc, 'sound/effects/splat.ogg', 30, TRUE)
	return ..()

/obj/structure/mold/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			playsound(loc, 'sound/effects/attackblob.ogg', 100, TRUE)
		if(BURN)
			playsound(loc, 'sound/items/welder.ogg', 100, TRUE)

/obj/structure/mold/Initialize(mapload)
	. = ..()
	color = mold_type.color
	resistance_flags = mold_type.resistance_flags

/obj/structure/mold/structure
	density = TRUE

/datum/looping_sound/core_heartbeat
	mid_length = 3 SECONDS
	mid_sounds = list('modular_skyrat/master_files/sound/effects/heart_beat_loop3.ogg' = 1)
	volume = 20

#define CORE_RETALIATION_COOLDOWN (5 SECONDS)

/obj/structure/mold/structure/core
	name = "glowing core"
	icon = 'modular_skyrat/modules/mold/icons/blob_core.dmi'
	icon_state = "blob_core"
	layer = TABLE_LAYER
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LAVA
	max_integrity = 1200

	/// The soundloop played by the core
	var/datum/looping_sound/core_heartbeat/soundloop
	/// The time to the next attack
	var/next_retaliation = 0

/obj/structure/mold/structure/core/fungal
	mold_type = /datum/mold/fungal

/obj/structure/mold/structure/core/fire
	mold_type = /datum/mold/fire

/obj/structure/mold/structure/core/emp
	mold_type = /datum/mold/emp

/obj/structure/mold/structure/core/toxic
	mold_type = /datum/mold/toxic

/obj/structure/mold/structure/core/radioactive
	mold_type = /datum/mold/radioactive

/obj/structure/mold/structure/core/Initialize(mapload)
	if(!mold_type)
		mold_type = pick(subtypesof(/datum/mold))
	. = ..()
	new /datum/mold_controller(src, mold_type)
	soundloop = new(list(src), TRUE)
	update_overlays()

/obj/structure/mold/structure/core/Destroy()
	if(our_controller)
		our_controller.our_core = null
	soundloop.stop()
	QDEL_NULL(soundloop)
	return ..()

/obj/structure/mold/structure/core/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	if(!(damage_amount > 10) || !(world.time > next_retaliation) || !prob(40))
		return ..()

	our_controller?.core_retaliated()
	next_retaliation = world.time + CORE_RETALIATION_COOLDOWN

	mold_type.core_defense(src)

/obj/structure/mold/structure/core/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	SSvis_overlays.add_vis_overlay(src, icon, "blob_core_overlay", layer, plane, dir, alpha)
	SSvis_overlays.add_vis_overlay(src, icon, "blob_core_overlay", 0, EMISSIVE_PLANE, dir, alpha)
	var/obj/effect/overlay/vis/overlay1 = managed_vis_overlays[1]
	var/obj/effect/overlay/vis/overlay2 = managed_vis_overlays[2]
	overlay1.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR
	overlay2.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR

#undef CORE_RETALIATION_COOLDOWN

/obj/structure/mold/resin
	name = "mold"
	desc = "It looks like mold, but it seems alive."
	icon = 'modular_skyrat/modules/mold/icons/blob_resin.dmi'
	icon_state = "blob_floor"
	density = FALSE
	plane = FLOOR_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	max_integrity = 50
	var/blooming = FALSE
	//Are we a floor resin? If not then we're a wall resin
	var/floor = TRUE

/obj/structure/mold/resin/examine(mob/user)
	. = ..()
	. += mold_type.examine_text

/obj/structure/mold/resin/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(blooming)
		SSvis_overlays.add_vis_overlay(src, icon, "[icon_state]_overlay", layer, plane, dir, alpha)
		SSvis_overlays.add_vis_overlay(src, icon, "[icon_state]_overlay", 0, EMISSIVE_PLANE, dir, alpha)
		var/obj/effect/overlay/vis/overlay1 = managed_vis_overlays[1]
		var/obj/effect/overlay/vis/overlay2 = managed_vis_overlays[2]
		overlay1.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR
		overlay2.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR

/obj/structure/mold/resin/proc/calculate_direction()
	var/direction = 16
	var/turf/location = loc
	for(var/wallDir in GLOB.cardinals)
		var/turf/newTurf = get_step(location,wallDir)
		if(newTurf && newTurf.density)
			direction |= wallDir

	for(var/obj/structure/mold/resin/tomato in location)
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

/obj/structure/mold/resin/Destroy()
	if(our_controller)
		our_controller.activate_adjacent_resin(get_turf(src))
		our_controller.all_resin -= src
		our_controller.active_resin -= src
	return ..()

#define BLOB_BULB_ALPHA 100

/obj/structure/mold/structure/bulb
	name = "empty bulb"
	icon = 'modular_skyrat/modules/mold/icons/blob_bulb.dmi'
	icon_state = "blob_bulb_empty"
	density = FALSE
	layer = TABLE_LAYER
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_LAVA
	var/is_full = FALSE
	var/list/registered_turfs = list()
	max_integrity = 100

/obj/structure/mold/structure/bulb/Initialize(mapload)
	. = ..()
	make_full()
	for(var/adjacent_turf in get_adjacent_open_turfs(src))
		registered_turfs += adjacent_turf
		RegisterSignal(adjacent_turf, COMSIG_ATOM_ENTERED, PROC_REF(proximity_trigger))

/obj/structure/mold/structure/bulb/proc/proximity_trigger(datum/source, atom/movable/nearby_atom)
	SIGNAL_HANDLER
	if(!isliving(nearby_atom))
		return
	var/mob/living/nearby_mob = nearby_atom
	if(!(FACTION_MOLD in nearby_mob.faction))
		INVOKE_ASYNC(src, PROC_REF(discharge))

/obj/structure/mold/structure/bulb/proc/make_full()
	//Called by a timer, check if we exist
	if(QDELETED(src))
		return
	is_full = TRUE
	name = "filled bulb"
	icon_state = "blob_bulb_full"
	set_light(2, 1, LIGHT_COLOR_LAVA)
	density = TRUE
	update_overlays()


/obj/structure/mold/structure/bulb/proc/discharge()
	if(!is_full)
		return

	mold_type.bulb_discharge(src)

	is_full = FALSE
	name = "empty bulb"
	icon_state = "blob_bulb_empty"
	playsound(src, 'sound/effects/bamf.ogg', 100, TRUE)
	set_light(0)
	update_overlays()
	density = FALSE
	addtimer(CALLBACK(src, PROC_REF(make_full)), 1 MINUTES, TIMER_UNIQUE|TIMER_NO_HASH_WAIT)



/obj/structure/mold/structure/bulb/attack_generic(mob/user, damage_amount, damage_type, damage_flag, sound_effect, armor_penetration)
	if(FACTION_MOLD in user.faction)
		return ..()
	discharge()
	. = ..()

/obj/structure/mold/structure/bulb/bullet_act(obj/projectile/P)
	if(istype(P, /obj/projectile/energy/nuclear_particle))
		return ..()
	discharge()
	. = ..()

/obj/structure/mold/structure/bulb/Destroy()
	if(our_controller)
		our_controller.other_structures -= src
	for(var/t in registered_turfs)
		UnregisterSignal(t, COMSIG_ATOM_ENTERED)
	registered_turfs = null
	return ..()

/obj/structure/mold/structure/bulb/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)
	if(is_full)
		SSvis_overlays.add_vis_overlay(src, icon, "blob_bulb_overlay", layer, plane, dir, BLOB_BULB_ALPHA)
		SSvis_overlays.add_vis_overlay(src, icon, "blob_bulb_overlay", 0, EMISSIVE_PLANE, dir, alpha)
		var/obj/effect/overlay/vis/overlay1 = managed_vis_overlays[1]
		var/obj/effect/overlay/vis/overlay2 = managed_vis_overlays[2]
		overlay1.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR
		overlay2.appearance_flags = PIXEL_SCALE | TILE_BOUND | RESET_COLOR

#undef BLOB_BULB_ALPHA


/obj/structure/mold/structure/wall
	name = "mold wall"
	desc = "Looks like some kind of thick resin."
	icon = 'icons/obj/smooth_structures/alien/resin_wall.dmi'
	icon_state = "resin_wall-0"
	base_icon_state = "resin_wall"
	opacity = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_ALIEN_RESIN
	canSmoothWith = SMOOTH_GROUP_ALIEN_RESIN
	max_integrity = 200
	can_atmos_pass = ATMOS_PASS_DENSITY

/obj/structure/mold/wall/Destroy()
	if(our_controller)
		our_controller.activate_adjacent_resin(get_turf(src))
		our_controller.other_structures -= src
	return ..()

/obj/structure/mold/structure/conditioner
	name = "pulsating vent"
	desc = "An unsightly vent, it appears to be puffing something out."
	density = FALSE
	icon = 'modular_skyrat/modules/mold/icons/blob_spawner.dmi'
	icon_state = "blob_vent"
	density = FALSE
	layer = LOW_OBJ_LAYER
	max_integrity = 150
	/// The mold atmosphere conditioner will spawn the molds preferred atmosphere every so often.
	var/happy_atmos = null
	/// The time between injections of that mold type's preferred atmos
	var/puff_cooldown = 15 SECONDS
	var/puff_delay = 0

/obj/structure/mold/structure/conditioner/Destroy()
	STOP_PROCESSING(SSobj, src)
	if(our_controller)
		our_controller.other_structures -= src
	return ..()

/obj/structure/mold/structure/conditioner/Initialize(mapload)
	. = ..()
	happy_atmos = mold_type.preferred_atmos_conditions
	START_PROCESSING(SSobj, src)

/obj/structure/mold/structure/conditioner/process(seconds_per_tick)
	if(!happy_atmos)
		return
	if(puff_delay > world.time)
		return
	puff_delay = world.time + puff_cooldown
	var/turf/holder_turf = get_turf(src)
	holder_turf.atmos_spawn_air(happy_atmos)
	if(mold_type == BIO_MOLD_TYPE_RADIOACTIVE)
		fire_nuclear_particle()

/obj/structure/mold/structure/spawner
	name = "hatchery"
	density = FALSE
	icon = 'modular_skyrat/modules/mold/icons/blob_spawner.dmi'
	icon_state = "blob_spawner"
	density = FALSE
	layer = LOW_OBJ_LAYER
	max_integrity = 150
	var/monster_types = list()
	var/max_spawns = 1
	var/spawn_cooldown = 1200 //In deciseconds

/obj/structure/mold/structure/spawner/Destroy()
	if(our_controller)
		our_controller.other_structures -= src
	return ..()

/obj/structure/mold/structure/spawner/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/spawner, monster_types, spawn_cooldown, max_spawns, list(FACTION_MOLD), "emerges from")
