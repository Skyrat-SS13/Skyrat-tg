/obj/effect/bump_teleporter/Bumped(atom/movable/bumper)
	if(!validate_setup(bumper))
		return

	// Extend original bump_teleporter functionality to randomly pick one of the matching teleporters,
	// instead of the first one.
	var/list/compatable_teleporters = list()
	for(var/obj/effect/bump_teleporter/teleporter in AllTeleporters)
		if(teleporter.id == id_target)
			compatable_teleporters += teleporter

	if(!LAZYLEN(compatable_teleporters))
		stack_trace("Bump_teleporter [src] could not find a teleporter with id [id_target]!")
		return

	var/obj/picked_teleporter = pick(compatable_teleporters)
	teleport_action(bumper, get_turf(picked_teleporter)) //Teleport to location with correct id.
