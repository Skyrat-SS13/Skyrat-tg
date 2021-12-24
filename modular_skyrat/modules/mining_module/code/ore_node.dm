/datum/ore_node
	var/list/ores_to_mine
	var/range
	var/scanner_range
	var/x_coord
	var/y_coord
	var/z_coord
	var/has_attracted_fauna = FALSE

/datum/ore_node/New(x, y, z, list/ores, _range)
	x_coord = x
	y_coord = y
	z_coord = z
	ores_to_mine = ores
	range = _range
	scanner_range = range * 3
	//Add to the level list
	var/datum/space_level/level = SSmapping.z_list[z_coord]
	level.ore_nodes += src

/datum/ore_node/Destroy()
	//Remove from the level list
	var/datum/space_level/level = SSmapping.z_list[z_coord]
	level.ore_nodes -= src
	return ..()

/datum/ore_node/proc/GetRemainingOreAmount()
	var/amount = 0
	for(var/path in ores_to_mine)
		amount += ores_to_mine[path]
	return amount

/datum/ore_node/proc/GetScannerReadout(turf/scanner_turf)
	//We read out ores based on the distance
	var/list/sorted_ores = ores_to_mine.Copy()
	var/turf/my_turf = locate(x_coord, y_coord, z_coord)
	var/dist = get_dist(my_turf,scanner_turf)
	if(dist <= 0)
		dist = 1
	var/percent = 1-(dist/scanner_range)
	var/precision = round(sorted_ores.len * percent) + 1
	precision = max(1,precision)
	var/is_full_scan = FALSE
	if(precision >= sorted_ores.len)
		precision = sorted_ores.len
		is_full_scan = TRUE
	var/full_string = ""
	for(var/i in 1 to precision)
		var/ore_type
		var/ore_weight = 0
		for(var/b in sorted_ores)
			if(sorted_ores[b] > ore_weight)
				ore_weight = sorted_ores[b]
				ore_type = b
		sorted_ores -= ore_type
		var/described_amount
		switch(ore_weight)
			if(-INFINITY to 5)
				described_amount = "Trace amounts"
			if(6 to 20)
				described_amount = "Small amounts"
			if(20 to 40)
				described_amount = "Notable amounts"
			if(40 to 70)
				described_amount = "Large amounts"
			if(70 to INFINITY)
				described_amount = "Plentiful amounts"
		var/described_ore
		switch(ore_type)
			if(/obj/item/stack/ore/uranium)
				described_ore = "uranium ore"
			if(/obj/item/stack/ore/diamond)
				described_ore = "diamonds"
			if(/obj/item/stack/ore/gold)
				described_ore = "gold ore"
			if(/obj/item/stack/ore/silver)
				described_ore = "silver ore"
			if(/obj/item/stack/ore/plasma)
				described_ore = "plasma ore"
			if(/obj/item/stack/ore/iron)
				described_ore = "iron ore"
			if(/obj/item/stack/ore/titanium)
				described_ore = "titanium ore"
			if(/obj/item/stack/ore/bluespace_crystal)
				described_ore = "bluespace crystals"
			else
				described_ore = "unidentified ore"
		full_string += "<BR>[described_amount] of [described_ore]."
	if(!is_full_scan)
		full_string += "<BR>..and traces of undetected ore."
	return full_string

/datum/ore_node/proc/GetScannerDensity(turf/scanner_turf)
	var/turf/my_turf = locate(x_coord, y_coord, z_coord)
	var/dist = get_dist(my_turf,scanner_turf)
	if(dist <= 0)
		dist = 1
	var/percent = 1-(dist/scanner_range)
	var/total_density = 0
	for(var/i in ores_to_mine)
		total_density += ores_to_mine[i]
	total_density *= percent
	switch(total_density)
		if(-INFINITY to 10)
			. = METAL_DENSITY_NONE
		if(10 to 70)
			. = METAL_DENSITY_LOW
		if(70 to 150)
			. = METAL_DENSITY_MEDIUM
		if(150 to INFINITY)
			. = METAL_DENSITY_HIGH

/datum/ore_node/proc/AttractFauna()
	has_attracted_fauna = TRUE
	//TODO: do this
	return

/datum/ore_node/proc/TakeRandomOre()
	if(!length(ores_to_mine))
		return
	if(!has_attracted_fauna)
		AttractFauna()
	var/obj/item/ore_to_return
	var/type = pick_weight(ores_to_mine)
	ores_to_mine[type] = ores_to_mine[type] - 1
	if(ores_to_mine[type] == 0)
		ores_to_mine -= type
	ore_to_return = new type()

	if(!length(ores_to_mine))
		qdel(src)
	return ore_to_return

/proc/GetNearbyOreNode(turf/T)
	var/datum/space_level/level = SSmapping.z_list[T.z]
	if(!length(level.ore_nodes))
		return
	var/list/iterated = level.ore_nodes
	for(var/i in iterated)
		var/datum/ore_node/ON = i
		if(T.x < (ON.x_coord + ON.range) && T.x > (ON.x_coord - ON.range) && T.y < (ON.y_coord + ON.range) && T.y > (ON.y_coord - ON.range))
			return ON

/proc/GetOreNodeInScanRange(turf/T)
	var/datum/space_level/level = SSmapping.z_list[T.z]
	if(!length(level.ore_nodes))
		return
	var/list/iterated = level.ore_nodes
	for(var/i in iterated)
		var/datum/ore_node/ON = i
		if(T.x < (ON.x_coord + ON.scanner_range) && T.x > (ON.x_coord - ON.scanner_range) && T.y < (ON.y_coord + ON.scanner_range) && T.y > (ON.y_coord - ON.scanner_range))
			return ON

/obj/effect/ore_node_spawner
	var/list/possible_ore_weight = list(
		/obj/item/stack/ore/uranium = 5,
		/obj/item/stack/ore/diamond = 2,
		/obj/item/stack/ore/gold = 10,
		/obj/item/stack/ore/silver = 12,
		/obj/item/stack/ore/plasma = 20,
		/obj/item/stack/ore/iron = 40,
		/obj/item/stack/ore/titanium = 11,
		/obj/item/stack/ore/bluespace_crystal = 2,
	)
	var/ore_density = 4
	var/ore_variety = 5

/obj/effect/ore_node_spawner/generous
	ore_density = 6

/obj/effect/ore_node_spawner/scarce
	ore_density = 3

/obj/effect/ore_node_spawner/varied
	ore_variety = 8

/obj/effect/ore_node_spawner/proc/SeedVariables()
	return

/obj/effect/ore_node_spawner/proc/SeedDeviation()
	if(prob(50))
		ore_variety--
	else
		ore_variety++
	ore_variety = max(1, ore_variety)
	var/deviation = (rand(1,5)/10)
	if(prob(50))
		ore_density += deviation
	else
		ore_density -= deviation
	ore_density = max(1, ore_density)

/obj/effect/ore_node_spawner/Initialize()
	. = ..()
	SeedVariables()
	SeedDeviation()
	if(!length(possible_ore_weight))
		return INITIALIZE_HINT_QDEL
	var/compiled_list = list()
	for(var/i in 1 to ore_variety)
		if(!possible_ore_weight.len)
			break
		var/ore_type = pick(possible_ore_weight)
		var/ore_amount = possible_ore_weight[ore_type]
		possible_ore_weight -= ore_type
		compiled_list[ore_type] = round(ore_amount * ore_density)
	new /datum/ore_node(x, y, z, compiled_list, rand(5,8))
	return INITIALIZE_HINT_QDEL

/datum/ore_node_seeder
	var/list/spawners_weight = list(/obj/effect/ore_node_spawner = 100)
	var/spawners_amount = 6

/datum/ore_node_seeder/proc/SeedToLevel(z)
	for(var/i in 1 to spawners_amount)
		var/picked_type = pick_weight(spawners_weight)
		var/turf/loc_to_spawn = locate(rand(1,world.maxx), rand(1,world.maxy), z)
		new picked_type(loc_to_spawn)
