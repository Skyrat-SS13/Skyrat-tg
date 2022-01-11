/proc/get_line_between(var/turf/source, var/turf/target, var/allow_diagonal = FALSE, var/include_source = TRUE)

	var/dist_remaining = hypot(world.maxx, world.maxy)	//The longest possible line across the map, as a safety
	//Must be on same zlevel
	if (source.z != target.z)
		target = locate(target.x, target.y, source.z)

	if (source == target)
		return list(source)

	var/list/line = list()
	if (include_source)
		line += source

	var/turf/current = source
	var/turf/next

	if (allow_diagonal)
		next = get_step_towards(current, target)
	else
		next = get_cardinal_step_towards(current, target)


	while (next != target && dist_remaining)
		line += next
		current = next
		//Possible Todo: This can return diagonals, break them into two steps
		if (allow_diagonal)
			next = get_step_towards(current, target)
		else
			next = get_cardinal_step_towards(current, target)

		dist_remaining--

	line += target

	return line