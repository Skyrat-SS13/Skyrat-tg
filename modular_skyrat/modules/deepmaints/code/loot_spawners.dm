/obj/effect/spawner/random/deep_maintenance
	name = "deep maintenance loot spawner"
	desc = "Come on Lady Luck, spawn me a pair of shotguns."
	icon_state = "loot"
	spawn_random_offset = TRUE
	spawn_loot_count = 2
	anchored = TRUE
	invisibility = 100
	/// What type of closet type should we spawn to fill the place of a missing one?
	var/obj/replacement_closet = /obj/structure/closet
	/// Do we randomize the loot count a bit?
	var/random_loot_count = TRUE

/obj/effect/spawner/random/deep_maintenance/Initialize(mapload)
	spawn_loot()

/obj/effect/spawner/random/deep_maintenance/spawn_loot(lootcount_override)
	if(random_loot_count)
		spawn_loot_count += (rand(-2, 1))

	. = ..()

	if(isnull(replacement_closet))
		return

	var/container_present = FALSE

	// In addition, closets that are closed will have the maintenance loot inserted inside.
	for(var/obj/structure/closet/closet in get_turf(src))
		if(closet.opened)
			if(!closet.close())
				addtimer(CALLBACK(src, PROC_REF(spawn_loot)), rand(10 MINUTES, 15 MINUTES))
				return
		closet.take_contents()
		container_present = TRUE

	for(var/obj/structure/filingcabinet/cabinet in get_turf(src))
		if(length(cabinet.contents) > 5)
			continue
		for(var/obj/item/loose_item in get_turf(src))
			if(loose_item.anchored)
				continue
			loose_item.forceMove(cabinet)
			container_present = TRUE

	if(container_present)
		addtimer(CALLBACK(src, PROC_REF(spawn_loot)), rand(10 MINUTES, 15 MINUTES))
		return

	if(istype(replacement_closet, /obj/structure/closet))
		var/obj/structure/closet/new_closet = new replacement_closet(drop_location(src))
		new_closet.take_contents()
	else
		var/obj/new_storage = new replacement_closet(drop_location(src))
		for(var/obj/item/loose_item in get_turf(src))
			if(loose_item.anchored)
				continue
			loose_item.forceMove(new_storage)

	addtimer(CALLBACK(src, PROC_REF(spawn_loot)), rand(10 MINUTES, 15 MINUTES))

/obj/effect/spawner/random/deep_maintenance_single_item
	name = "deep maintenance loot item spawner"
	icon_state = "loot"
	spawn_random_offset = TRUE
	spawn_loot_count = 1

/obj/effect/spawner/random/deep_maintenance_single_item/Initialize(mapload)
	spawn_loot()

/obj/effect/spawner/random/deep_maintenance_single_item/spawn_loot(lootcount_override)
	// If one of the things we can spawn is on the tile, fuggetabout it
	for(var/thing in get_turf(src))
		if(thing in loot)
			addtimer(CALLBACK(src, PROC_REF(spawn_loot)), rand(10 MINUTES, 15 MINUTES))
			return

	. = ..()
