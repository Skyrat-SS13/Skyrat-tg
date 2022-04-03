/obj/effect/bump_teleporter/Bumped(atom/movable/movable_atom)
	var/list/compatable_teleporters = list()
	for(var/obj/effect/bump_teleporter/teleporter in AllTeleporters)
		if(teleporter.id == src.id_target)
			compatable_teleporters += teleporter
	if(!LAZYLEN(compatable_teleporters))
		return
	var/obj/picked_teleporter = pick(compatable_teleporters)
	movable_atom.forceMove(get_turf(picked_teleporter))
