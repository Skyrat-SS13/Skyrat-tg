/obj/effect/spawner/random/deep_maintenance
	name = "deep maintenance loot spawner"
	desc = "Come on Lady Luck, spawn me a pair of shotguns."
	icon_state = "loot"
	spawn_random_offset = TRUE
	spawn_loot_count = 5
	/// What type of closet type should we spawn to fill the place of a missing one?
	var/obj/replacement_closet = /obj/structure/closet
	/// Do we randomize the loot count a bit?
	var/random_loot_count = TRUE

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
				return
		closet.take_contents()
		container_present = TRUE

	for(var/obj/structure/filingcabinet/cabinet in get_turf(src))
		for(var/obj/item/loose_item in get_turf(src))
			if(loose_item.anchored)
				continue
			loose_item.forceMove(cabinet)
			container_present = TRUE

	if(container_present)
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
