/*
	Necrovision is used by both the marker, and signal ghosts
*/

/datum/visualnet/necrovision
	valid_source_types = list(/mob/living/,
	/obj/machinery/marker,
	/obj/effect/vine/corruption,
	/obj/structure/corruption_node,
	/obj/effect/scry_eye,
	/obj/effect/psychic_tracer,
	/obj/item/marker_shard)
	chunk_type = /datum/chunk/necrovision

/datum/chunk/necrovision/acquire_visible_turfs(var/list/visible)
	for(var/datum/source as anything in sources)
		if (!istype(source))
			sources -= source
			continue


		var/list/visible_turfs = get_datum_visible_turfs(source)

		//Special return value to indicate that we are invalid and should be removed
		if (visible_turfs == PROCESS_KILL)
			sources -= source
			continue

		for(var/t in visible_turfs)//source.get_visualnet_tiles(visualnet))
			visible[t] = t


