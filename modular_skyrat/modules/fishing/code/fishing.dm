/turf/open
	///If fishes are able to be fished from this open turf
	var/fishspawn_possible = FALSE
	///What are the weights of items that can be fished from this open turf.
	var/list/fishing_weights = list()

//lava will have ores
/turf/open/lava
	fishing_weights = list(
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/ore/gold = 3,
		/obj/item/stack/ore/uranium = 3,
		/obj/item/stack/ore/titanium = 3,
		/obj/item/stack/ore/silver = 5,
		/obj/item/stack/ore/iron = 5,
		/obj/item/xenoarch/strange_rock = 5,
	)

//water will have ores and fish
/turf/open/water
	fishspawn_possible = TRUE
	fishing_weights = list(
		/obj/item/stack/ore/diamond = 1,
		/obj/item/stack/ore/bluespace_crystal = 1,
		/obj/item/stack/ore/gold = 3,
		/obj/item/stack/ore/uranium = 3,
		/obj/item/stack/ore/titanium = 3,
		/obj/item/stack/ore/silver = 5,
		/obj/item/stack/ore/iron = 5,
		/obj/item/xenoarch/strange_rock = 5,
	)

/obj/item/fishing_rod
	name = "fishing rod"
	desc = "A rod that allows you to fish."
	icon = 'modular_skyrat/modules/fishing/icons/fishing.dmi'
	icon_state = "normal_rod"
	//normal_rod and lava_rod
	///which turfs are allowed within that rod type
	var/list/allowed_fishing_turfs = list()
	///the current turf in which the fishing rod is after
	var/turf/open/fishing_spot
	var/allowed_fishing
	var/mob/listening_to
	var/obj/effect/fishing_bobber/spawned_bobber

/obj/item/fishing_rod/Destroy()
	if(fishing_spot)
		fishing_spot = null
	if(spawned_bobber)
		QDEL_NULL(spawned_bobber)
	if(listening_to)
		UnregisterSignal(listening_to, COMSIG_MOVABLE_MOVED)
		listening_to = null
	. = ..()


/obj/item/fishing_rod/water_rod
	allowed_fishing_turfs = list(/turf/open/water)

/obj/item/fishing_rod/lava_rod
	icon_state = "lava_rod"
	allowed_fishing_turfs = list(/turf/open/lava)

/obj/item/fishing_rod/admin_rod
	allowed_fishing_turfs = list(/turf/open/water, /turf/open/lava)

/obj/effect/fishing_bobber
	name = "fishing bobber"
	desc = "A tool that bobs in the water to help bait things."
	icon = 'modular_skyrat/modules/fishing/icons/fishing.dmi'
	icon_state = "bobber"
	var/timed_fishing

/obj/effect/fishing_bobber/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/effect/fishing_bobber/Destroy(force)
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/effect/fishing_bobber/process(delta_time)
	if(world.time > timed_fishing && world.time < timed_fishing + 2 SECONDS)
		pixel_y = rand(-2, 2)

/obj/item/fishing_rod/equipped(mob/user, slot, initial)
	. = ..()
	if(listening_to == user)
		return
	if(listening_to)
		UnregisterSignal(listening_to, COMSIG_MOVABLE_MOVED)
		fishing_spot = null
		allowed_fishing = 0
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/check_movement)
	listening_to = user

/obj/item/fishing_rod/dropped(mob/user, silent)
	. = ..()
	if(listening_to)
		UnregisterSignal(listening_to, COMSIG_MOVABLE_MOVED)
		listening_to = null
	fishing_spot = null
	QDEL_NULL(spawned_bobber)
	allowed_fishing = 0

/obj/item/fishing_rod/proc/check_movement()
	if(!listening_to)
		return
	if(!fishing_spot)
		return
	if(get_dist(fishing_spot, listening_to) >= 4)
		fishing_spot = null
		QDEL_NULL(spawned_bobber)
		allowed_fishing = 0

/obj/item/fishing_rod/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(fishing_spot)
		if(world.time < allowed_fishing || world.time > allowed_fishing + 2 SECONDS)
			to_chat(user, span_warning("You feel back [src] to reveal nothing..."))
			fishing_spot = null
			QDEL_NULL(spawned_bobber)
			return
		to_chat(user, span_notice("You reel back [src], catching something..."))
		if(fishing_spot.fishspawn_possible)
			var/pick_choose = rand(1, 3)
			switch(pick_choose)
				if(1)
					generate_fish(get_turf(user), random_fish_type())
				if(2 to 3)
					var/obj/spawn_objone = pickweight(fishing_spot.fishing_weights)
					new spawn_objone(get_turf(user))
			fishing_spot = null
			QDEL_NULL(spawned_bobber)
			return
		var/obj/spawn_objtwo = pickweight(fishing_spot.fishing_weights)
		new spawn_objtwo(get_turf(user))
		fishing_spot = null
		QDEL_NULL(spawned_bobber)
		return
	if(!is_type_in_list(target, allowed_fishing_turfs))
		return
	var/turf/open/open_turf = target
	if(get_dist(target, user) >= 4) //not using proximity because I want you to be able to cast the line
		return
	to_chat(user, span_notice("You throw out the line to [open_turf]..."))
	var/choose_timer = (rand(5, 10)) SECONDS
	allowed_fishing = world.time + choose_timer
	fishing_spot = open_turf
	spawned_bobber =  new /obj/effect/fishing_bobber(open_turf)
	spawned_bobber.timed_fishing = allowed_fishing
