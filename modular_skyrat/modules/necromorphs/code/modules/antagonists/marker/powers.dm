#define MARKER_REROLL_RADIUS 60

/mob/camera/marker/proc/can_buy(cost = 15)
	if(marker_points < cost)
		to_chat(src, span_warning("You cannot afford this, you need at least [cost] resources!"))
		return FALSE
	add_points(-cost)
	return TRUE

/mob/camera/marker/proc/place_marker_core(placement_override, pop_override = FALSE)
	if(placed && placement_override != -1)
		return TRUE
	if(!placement_override)
		if(!pop_override)
			for(var/mob/living/M in range(7, src))
				if(ROLE_NECROMORPH in M.faction)
					continue
				if(M.client)
					to_chat(src, span_warning("There is someone too close to place your marker core!"))
					return FALSE
			for(var/mob/living/M in view(13, src))
				if(ROLE_NECROMORPH in M.faction)
					continue
				if(M.client)
					to_chat(src, span_warning("Someone could see your marker core from here!"))
					return FALSE
		var/turf/T = get_turf(src)
		if(T.density)
			to_chat(src, span_warning("This spot is too dense to place a marker core on!"))
			return FALSE
		var/area/A = get_area(T)
		if(isspaceturf(T) || A && !(A.area_flags & BLOBS_ALLOWED))
			to_chat(src, span_warning("You cannot place your core here!"))
			return FALSE
		for(var/obj/O in T)
			if(istype(O, /obj/structure/marker))
				if(istype(O, /obj/structure/marker/normal))
					qdel(O)
				else
					to_chat(src, span_warning("There is already a marker here!"))
					return FALSE
			else if(O.density)
				to_chat(src, span_warning("This spot is too dense to place a marker core on!"))
				return FALSE
		if(!pop_override && world.time <= manualplace_min_time && world.time <= autoplace_max_time)
			to_chat(src, span_warning("It is too early to place your marker core!"))
			return FALSE
	else if(placement_override == 1)
		var/turf/T = pick(GLOB.blobstart)
		forceMove(T) //got overrided? you're somewhere random, motherfucker
	if(placed && marker_core)
		marker_core.forceMove(loc)
	else
		var/obj/structure/marker/special/core/core = new(get_turf(src), src, 1)
		core.overmind = src
		markers_legit += src
		marker_core = core
		core.update_appearance()
	placed = TRUE
	announcement_time = world.time + OVERMIND_ANNOUNCEMENT_MAX_TIME
	return TRUE

/mob/camera/marker/proc/transport_core()
	if(marker_core)
		forceMove(marker_core.drop_location())

/mob/camera/marker/proc/jump_to_node()
	if(GLOB.marker_nodes.len)
		var/list/nodes = list()
		for(var/i in 1 to GLOB.marker_nodes.len)
			var/obj/structure/marker/special/node/B = GLOB.marker_nodes[i]
			nodes["Marker Node #[i] ([get_area_name(B)])"] = B
		var/node_name = input(src, "Choose a node to jump to.", "Node Jump") in nodes
		var/obj/structure/marker/special/node/chosen_node = nodes[node_name]
		if(chosen_node)
			forceMove(chosen_node.loc)

/mob/camera/marker/proc/createSpecial(price, minSeparation, needsNode, turf/T)
	if(!T)
		T = get_turf(src)
	var/obj/structure/marker/B = (locate(/obj/structure/marker) in T)
	if(!B)
		to_chat(src, span_warning("There is no marker here!"))
		return
	if(!istype(B, /obj/structure/marker/normal))
		to_chat(src, span_warning("Unable to use this marker, find a normal one."))
		return
	if(needsNode)
		var/area/A = get_area(src)
		if(!(A.area_flags & BLOBS_ALLOWED)) //factory and resource markers must be legit
			to_chat(src, span_warning("This type of marker must be placed on the station!"))
			return
		if(nodes_required && !(locate(/obj/structure/marker/special/node) in orange(MARKER_NODE_PULSE_RANGE, T)) && !(locate(/obj/structure/marker/special/core) in orange(MARKER_CORE_PULSE_RANGE, T)))
			to_chat(src, span_warning("You need to place this marker closer to a node or core!"))
			return //handholdotron 2000
	if(minSeparation)
		for(var/obj/structure/marker/L in orange(minSeparation, T))
			if(L.type == marker_core)
				to_chat(src, span_warning("There is a similar marker nearby, move more than [minSeparation] tiles away from it!"))
				return
	if(!can_buy(price))
		return
	var/obj/structure/marker/N = B.change_to(src)
	return N


/mob/camera/marker/proc/toggle_node_req()
	nodes_required = !nodes_required
	if(nodes_required)
		to_chat(src, span_warning("You now require a nearby node or core to place factory and resource markers."))
	else
		to_chat(src, span_warning("You no longer require a nearby node or core to place factory and resource markers."))

/mob/camera/marker/proc/expand_marker(turf/T)
	if(world.time < last_attack)
		return
	var/list/possiblemarkers = list()
	for(var/obj/structure/marker/AB in range(T, 1))
		possiblemarkers += AB
	if(!possiblemarkers.len)
		to_chat(src, span_warning("There is no marker adjacent to the target tile!"))
		return
	if(can_buy(MARKER_EXPAND_COST))
		var/attacksuccess = FALSE
		for(var/mob/living/L in T)
			if(ROLE_NECROMORPH in L.faction) //no friendly/dead fire
				continue
			if(L.stat != DEAD)
				attacksuccess = TRUE
		var/obj/structure/marker/B = locate() in T
		if(B)
			if(attacksuccess) //if we successfully attacked a turf with a marker on it, only give an attack refund
				add_points(MARKER_ATTACK_REFUND)
			else
				to_chat(src, span_warning("There is a marker there!"))
				add_points(MARKER_EXPAND_COST) //otherwise, refund all of the cost
		else
			var/list/cardinalmarkers = list()
			var/list/diagonalmarkers = list()
			for(var/I in possiblemarkers)
				var/obj/structure/marker/IB = I
				if(get_dir(IB, T) in GLOB.cardinals)
					cardinalmarkers += IB
				else
					diagonalmarkers += IB
			var/obj/structure/marker/OB
			if(cardinalmarkers.len)
				OB = pick(cardinalmarkers)
				if(!OB.expand(T, src))
					add_points(MARKER_ATTACK_REFUND) //assume it's attacked SOMETHING, possibly a structure
			else
				OB = pick(diagonalmarkers)
				if(attacksuccess)
					add_points(MARKER_EXPAND_COST) //if we're attacking diagonally and didn't hit anything, refund
		if(attacksuccess)
			last_attack = world.time + CLICK_CD_MELEE
		else
			last_attack = world.time + CLICK_CD_RAPID

/mob/camera/marker/proc/remove_marker(turf/T)
	var/obj/structure/marker/B = locate() in T
	if(!B)
		to_chat(src, span_warning("There is no marker there!"))
		return
	if(B.point_return < 0)
		to_chat(src, span_warning("Unable to remove this marker."))
		return
	if(max_marker_points < B.point_return + marker_points)
		to_chat(src, span_warning("You have too many resources to remove this marker!"))
		return
	if(B.point_return)
		add_points(B.point_return)
		to_chat(src, span_notice("Gained [B.point_return] resources from removing \the [B]."))
	qdel(B)
