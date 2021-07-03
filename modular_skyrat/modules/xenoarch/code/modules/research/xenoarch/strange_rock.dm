/obj/item/xenoarch/strange_rock
	name = "strange rock"
	desc = "A mysterious, strange rock that has the potential to have a wonderful item. Also possible for it to have our disposed garbage."
	icon_state = "rock"

	var/max_depth //the max depth
	var/safe_depth //the depth away from the max depth
	var/item_depth //the depth between the max and the safe, containing the item
	var/dug_depth = 0 //the depth that has been currently dug

	var/hidden_item //the item that is held

	var/measured = FALSE //if the item has been tape-measured
	var/scanned = FALSE //if the item has been scanned

	var/scan_state = "rock_Strange"

/obj/item/xenoarch/strange_rock/Initialize()
	. = ..()
	create_item()
	create_depth()

/obj/item/xenoarch/strange_rock/examine(mob/user)
	. = ..()
	. += span_notice("[scanned ? "This item has been scanned. Max Depth: [max_depth] cm. Safe Depth: [safe_depth] cm." : "This item has not been scanned."]")
	. += span_notice("[measured ? "This item has been measured. Dug Depth: [dug_depth]." : "This item has not been measured."]")
	if(measured && dug_depth > item_depth)
		. += span_warning("The rock is crumbling, even just brushing it will destroy it!")

/obj/item/xenoarch/strange_rock/proc/create_item()
	var/choose_tier = rand(1,100)
	switch(choose_tier)
		if(1 to 70)
			hidden_item = pickweight(GLOB.tier1_reward)
		if(71 to 97)
			hidden_item = pickweight(GLOB.tier2_reward)
		if(98 to 100)
			hidden_item = pickweight(GLOB.tier3_reward)

/obj/item/xenoarch/strange_rock/proc/create_depth()
	max_depth = rand(21, 100)
	safe_depth = rand(1, 10)
	item_depth = rand((max_depth - safe_depth), max_depth)
	dug_depth = rand(0, 10)

/obj/item/xenoarch/strange_rock/proc/get_measured() //returns true if successful measure
	if(measured)
		return FALSE
	measured = TRUE
	return TRUE

/obj/item/xenoarch/strange_rock/proc/get_scanned() //returns true if successful scan
	if(scanned)
		return FALSE
	scanned = TRUE
	return TRUE

/obj/item/xenoarch/strange_rock/proc/try_dig(var/dig_amount) //1: no dig amount 2: above dig depth 3: successful dig
	if(!dig_amount)
		return 1
	dug_depth += dig_amount
	if(dug_depth > item_depth)
		qdel(src)
		return 2
	return 3

/obj/item/xenoarch/strange_rock/proc/try_uncover() //1: brush too above item 2: brush successful 3: brush unsuccesful but fine
	if(dug_depth > item_depth)
		qdel(src)
		return 1
	if(dug_depth == item_depth)
		new hidden_item(get_turf(src))
		qdel(src)
		return 2
	return 3

/obj/item/xenoarch/strange_rock/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/xenoarch/hammer))
		var/obj/item/xenoarch/hammer/xenoHammer = I
		to_chat(user, span_notice("You begin carefully using your hammer."))
		if(!do_after(user, xenoHammer.dig_speed, target = src))
			to_chat(user, span_warning("You interrupt your careful planning, damaging the rock in the process!"))
			dug_depth += rand(1,5)
			return
		switch(try_dig(xenoHammer.dig_amount))
			if(1)
				message_admins("Tell Jake something broke with hammers and dig amount.")
				return
			if(2)
				to_chat(user, span_warning("The rock crumbles, leaving nothing behind."))
				return
			if(3)
				to_chat(user, span_notice("You successfully dig around the item."))

	if(istype(I, /obj/item/xenoarch/brush))
		var/obj/item/xenoarch/brush/xenoBrush = I
		to_chat(user, span_notice("You begin carefully using your brush."))
		if(!do_after(user, xenoBrush.dig_speed, target = src))
			to_chat(user, span_warning("You interrupt your careful planning, damaging the rock in the process!"))
			dug_depth += rand(1,5)
			return
		switch(try_uncover())
			if(1)
				to_chat(user, span_warning("The rock crumbles, leaving nothing behind."))
				return
			if(2)
				to_chat(user, span_notice("You successfully brush around the item, fully revealing the item!"))
				return
			if(3)
				to_chat(user, span_notice("You brush around the item, but it wasn't revealed... hammer some more."))

	if(istype(I, /obj/item/xenoarch/tape_measure))
		to_chat(user, span_notice("You begin carefully using your measuring tape."))
		if(!do_after(user, 4 SECONDS, target = src))
			to_chat(user, span_warning("You interrupt your careful planning, damaging the rock in the process!"))
			dug_depth += rand(1,5)
			return
		if(get_measured())
			to_chat(user, span_notice("You successfully attach a holo measuring tape to the strange rock; the strange rock will now report its depth always!"))
			return
		to_chat(user, span_warning("The strange rock was already marked with a holo measuring tape."))


//turfs
/turf/closed/mineral/strange_rock
	mineralAmt = 1
	icon = 'icons/turf/mining.dmi'
	scan_state = "rock_Strange"
	mineralType = /obj/item/xenoarch/strange_rock

/turf/closed/mineral/strange_rock/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = TRUE

/turf/closed/mineral/random/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = TRUE

	mineralChance = 10
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 5, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 10, /obj/item/stack/ore/titanium = 11,
		/obj/item/stack/ore/silver = 12, /obj/item/stack/ore/plasma = 20, /obj/item/stack/ore/iron = 40, /turf/closed/mineral/strange_rock/volcanic = 10,
		/turf/closed/mineral/gibtonite/volcanic = 4, /obj/item/stack/ore/bluespace_crystal = 1)

/turf/closed/mineral/strange_rock/ice
	environment_type = "snow_cavern"
	icon_state = "icerock_strange"
	smooth_icon = 'icons/turf/walls/icerock_wall.dmi'
	base_icon_state = "icerock_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	turf_type = /turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE

/turf/closed/mineral/strange_rock/ice/icemoon
	turf_type = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice/icemoon
	initial_gas_mix = ICEMOON_DEFAULT_ATMOS

/turf/closed/mineral/random/snow
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 5, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 10, /obj/item/stack/ore/titanium = 11,
		/obj/item/stack/ore/silver = 12, /obj/item/stack/ore/plasma = 20, /obj/item/stack/ore/iron = 40, /turf/closed/mineral/strange_rock/ice/icemoon = 10,
		/turf/closed/mineral/gibtonite/ice/icemoon = 4, /obj/item/stack/ore/bluespace_crystal = 1)

/turf/closed/mineral/random/snow/underground
	baseturfs = /turf/open/floor/plating/asteroid/snow/icemoon
	// abundant ore
	mineralChance = 20
	mineralSpawnChanceList = list(
		/obj/item/stack/ore/uranium = 10, /obj/item/stack/ore/diamond = 4, /obj/item/stack/ore/gold = 20, /obj/item/stack/ore/titanium = 22,
		/obj/item/stack/ore/silver = 24, /obj/item/stack/ore/plasma = 20, /obj/item/stack/ore/iron = 20, /obj/item/stack/ore/bananium = 1,
		/turf/closed/mineral/gibtonite/ice/icemoon = 8, /turf/closed/mineral/strange_rock/ice/icemoon = 10, /obj/item/stack/ore/bluespace_crystal = 2)

//small gibonite fix
/turf/closed/mineral/gibtonite/asteroid
	environment_type = "asteroid"
	icon_state = "redrock_Gibonite"
	smooth_icon = 'icons/turf/walls/red_wall.dmi'
	base_icon_state = "red_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	turf_type = /turf/open/floor/plating/asteroid
	baseturfs = /turf/open/floor/plating/asteroid
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	defer_change = TRUE

/turf/closed/mineral/strange_rock/asteroid
	environment_type = "asteroid"
	icon_state = "redrock_strange"
	smooth_icon = 'icons/turf/walls/red_wall.dmi'
	base_icon_state = "red_wall"
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	turf_type = /turf/open/floor/plating/asteroid
	baseturfs = /turf/open/floor/plating/asteroid
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	defer_change = TRUE

/turf/closed/mineral/random/stationside/asteroid/rockplanet
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	turf_type = /turf/open/floor/plating/asteroid
	mineralSpawnChanceList = list(/obj/item/stack/ore/uranium = 5, /obj/item/stack/ore/diamond = 1, /obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/silver = 12, /obj/item/stack/ore/plasma = 20, /obj/item/stack/ore/iron = 40, /obj/item/stack/ore/titanium = 11,
		/turf/closed/mineral/gibtonite/asteroid = 4, /obj/item/stack/ore/bluespace_crystal = 1, /turf/closed/mineral/strange_rock/asteroid = 10)
	mineralChance = 30
