GLOBAL_LIST_INIT(fishing_weights, list(
	/obj/item/stack/ore/diamond = 1,
	/obj/item/stack/ore/bluespace_crystal = 1,
	/obj/item/stack/ore/gold = 3,
	/obj/item/stack/ore/uranium = 3,
	/obj/item/stack/ore/titanium = 3,
	/obj/item/stack/ore/silver = 5,
	/obj/item/stack/ore/iron = 5,
	/obj/item/xenoarch/strange_rock = 5,
))

#define TRAIT_FISHING_MASTER "fishing_master"

/obj/item/skillchip/fishing_master
	name = "Fishing Master skillchip"
	desc = "A master of fishing, capable of wrangling the whole ocean if we must."
	auto_traits = list(TRAIT_FISHING_MASTER)
	skill_name = "Fishing Master"
	skill_description = "Master the ability to use fish."
	skill_icon = "certificate"
	activate_message = "<span class='notice'>The fish and junk become far more visible beneath the surface.</span>"
	deactivate_message = "<span class='notice'>The surface begins to cloud up, making it hard to see beneath.</span>"

/turf/open
	///If fishes are able to be fished from this open turf
	var/fishspawn_possible = FALSE

//water will have ores and fish
/turf/open/water
	fishspawn_possible = TRUE

/turf/open/water/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/water/lava_land_surface

/obj/item/fishing_rod
	name = "fishing rod"
	desc = "A rod that allows you to fish."
	icon = 'modular_skyrat/modules/fishing/icons/fishing.dmi'
	icon_state = "normal_rod"
	inhand_icon_state = "normal_rod"
	lefthand_file = 'modular_skyrat/modules/fishing/icons/fishing_left.dmi'
	righthand_file = 'modular_skyrat/modules/fishing/icons/fishing_right.dmi'
	//normal_rod and lava_rod
	///which turfs are allowed within that rod type
	var/list/allowed_fishing_turfs = list()
	///the current turf in which the fishing rod is after
	var/turf/open/fishing_spot
	///the time to allow fishing
	var/allowed_fishing
	///the mob that the rod is listening to signal wise
	var/mob/listening_to
	///the linked, spawned bobber
	var/obj/effect/fishing_bobber/spawned_bobber
	///whether its in a water basin, so it chooses fish only
	var/water_basined = FALSE
	w_class = WEIGHT_CLASS_SMALL

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

/datum/crafting_recipe/water_rod
	name = "Water Fishing Rod"
	result = /obj/item/fishing_rod/water_rod
	reqs = list(/obj/item/stack/rods = 2,
				/obj/item/stack/cable_coil = 2)
	category = CAT_MISC

/obj/item/fishing_rod/lava_rod
	icon_state = "lava_rod"
	inhand_icon_state = "lava_rod"
	allowed_fishing_turfs = list(/turf/open/lava)

/datum/crafting_recipe/lava_rod
	name = "Lava Fishing Rod"
	result = /obj/item/fishing_rod/lava_rod
	reqs = list(/obj/item/stack/sheet/animalhide/goliath_hide = 2,
				/obj/item/stack/sheet/sinew = 2)
	category = CAT_MISC

/obj/item/fishing_rod/admin_rod
	allowed_fishing_turfs = list(/turf/open/water, /turf/open/lava)

/obj/effect/fishing_bobber
	name = "fishing bobber"
	desc = "A tool that bobs in the water to help bait things."
	icon = 'modular_skyrat/modules/fishing/icons/fishing.dmi'
	icon_state = "bobber"
	var/timed_fishing
	var/obj/item/fishing_rod/connected_rod

/obj/effect/fishing_bobber/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/effect/fishing_bobber/Destroy(force)
	STOP_PROCESSING(SSobj, src)
	connected_rod = null
	. = ..()

/obj/effect/fishing_bobber/process(delta_time)
	if(world.time > timed_fishing && world.time < timed_fishing + 3 SECONDS)
		playsound(src, 'sound/machines/ping.ogg', 30, TRUE)
	if(world.time > timed_fishing + 4 SECONDS)
		timed_fishing = world.time + 4 SECONDS
		connected_rod.allowed_fishing = world.time + 4 SECONDS

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
		var/repeat_code = 1
		if(HAS_TRAIT(user, TRAIT_FISHING_MASTER))
			repeat_code = 2
		for(var/multiple_times in 1 to repeat_code)
			if(fishing_spot.fishspawn_possible || water_basined)
				var/pick_choose = rand(1, 3)
				switch(pick_choose)
					if(1 to 2)
						generate_fish(get_turf(user), random_fish_type())
					if(3)
						var/obj/spawn_objone = pickweight(GLOB.fishing_weights)
						new spawn_objone(get_turf(user))
			else
				var/obj/spawn_objtwo = pickweight(GLOB.fishing_weights)
				new spawn_objtwo(get_turf(user))
		water_basined = FALSE
		fishing_spot = null
		QDEL_NULL(spawned_bobber)
		return
	if(istype(target, /obj/structure/reagent_water_basin))
		var/obj/structure/reagent_water_basin/target_basin = target
		if(!target_basin.bluespaced)
			to_chat(user, span_warning("[target_basin] is not connected to another ocean... perhaps using a bluespace crystal will do so?"))
			return
		var/turf/open/basin_turf = get_turf(target_basin)
		if(get_dist(target, user) >= 4) //not using proximity because I want you to be able to cast the line
			return
		to_chat(user, span_notice("You throw out the line to [basin_turf]..."))
		var/choose_timer = (rand(3, 7)) SECONDS
		allowed_fishing = world.time + choose_timer
		fishing_spot = basin_turf
		spawned_bobber =  new /obj/effect/fishing_bobber(basin_turf)
		spawned_bobber.timed_fishing = allowed_fishing
		water_basined = TRUE
		return
	if(!is_type_in_list(target, allowed_fishing_turfs))
		return
	var/turf/open/open_turf = target
	if(get_dist(target, user) >= 4) //not using proximity because I want you to be able to cast the line
		return
	to_chat(user, span_notice("You throw out the line to [open_turf]..."))
	var/choose_timer = (rand(3, 7)) SECONDS
	allowed_fishing = world.time + choose_timer
	fishing_spot = open_turf
	spawned_bobber =  new /obj/effect/fishing_bobber(open_turf)
	spawned_bobber.timed_fishing = allowed_fishing
	spawned_bobber.connected_rod = src
