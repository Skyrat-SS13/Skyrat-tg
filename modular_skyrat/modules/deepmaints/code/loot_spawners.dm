/obj/effect/spawner/random/deep_maintenance
	name = "deep maintenance loot spawner"
	desc = "Come on Lady Luck, spawn me a pair of shotguns."
	icon_state = "loot"
	spawn_random_offset = TRUE
	/// What type of closet type should we spawn to fill the place of a missing one?
	var/obj/structure/closet/replacement_closet = /obj/structure/closet

/obj/effect/spawner/random/deep_maintenance/spawn_loot(lootcount_override)
	. = ..()

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

	var/obj/structure/closet/new_closet = new replacement_closet(drop_location(src))
	new_closet.take_contents()
