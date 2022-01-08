//Item and spawning
//------------------------------
//These datums are created at runtime
/datum/necroshop_item
	var/name = "Thing"	//User facing
	var/desc = "stuff"
	var/price	=	1	//price in biomass
	var/spawn_method	= SPAWN_POINT	//Do we spawn around a point or manual placement?
	var/placement_type = /datum/click_handler/placement/necromorph	//If manual placement, which subtype of placement handler will we use?
	var/spawn_path		=	null		//What atom will we actually spawn?
	var/queue_fill	=	FALSE	//Can this thing be populated by a ghost from the necroqueue?
	var/require_total_biomass = FALSE	//If true, this spawn requires reaching a target of total biomass and can be spawned for free when that target is reached
	var/global_limit = 0	//If nonzero, a maximum number of these which can ever be spawned from markers

	/*
		This is an associative list in the format: event_datum = quantity
	*/
	var/list/event_spawns

//Can this thing be spawned now, or at some point in the future if we wait long enough? IE, will it become spawnable without explicit action
/datum/necroshop_item/proc/can_ever_spawn(var/datum/necroshop/caller)
	if (global_limit)
		var/total = SSnecromorph.spawned_necromorph_types[spawn_path]
		if (isnum(total) >= global_limit)
			return FALSE

	return TRUE

//Can this thing be spawned right now?
/datum/necroshop_item/proc/can_spawn(var/datum/necroshop/caller)
	if (!can_ever_spawn(caller))
		return FALSE

	/*
		If we have event spawns, maybe we can do one for free
	*/
	if (event_spawns)
		if (caller?.selected_spawn?.event)
			var/num_available = event_spawns[caller.selected_spawn.event]
			if (isnum(num_available) && num_available > 0)
				return TRUE


	if (require_total_biomass)
		if (caller.host.get_total_biomass() < require_total_biomass)
			return FALSE

	if (caller.host.biomass < price)
		return FALSE

	return TRUE

//This function has two modes.
//For spawning at a point, it will find an exact location and return a list of parameters which will then be passed to finalise_spawn
//For manual placement spawning, it will immediately return null to terminate that process, and create a datum which will handle the placement and user input
	//That datum, once a spot is selected, will generate its own parameters and call finalize_spawn directly on its own
/datum/necroshop_item/proc/get_spawn_params(var/datum/necroshop/caller)
	.=null
	if (spawn_method == SPAWN_POINT)
		var/list/params = list("name" = null, "origin" = null, "target" = null, "price" = null, "dir" = null, "path" = null, "user" = null, "queue" = null, "limited" = null, "reqtotal" = null, "item" = null, "free" = null)
		params["name"] = name
		params["origin"] = caller.selected_spawn.spawnpoint	//Where are we spawning from? This may be useful for visual effects
		var/list/turfs = caller.selected_spawn.spawnpoint.clear_turfs_in_view(10)
		if (!turfs.len)
			return //Failed?

		params["target"] = pick(turfs)	//The exact turf we will spawn into
		params["price"] = price	//How much will it cost to do this spawn?
		params["dir"] = SOUTH	//Direction we face on spawning, not important for point spawn
		params["path"] = spawn_path
		params["user"] = usr	//Who is responsible for this ? Who shall we show error messages to
		params["queue"] = queue_fill
		params["limited"] = global_limit
		params["reqtotal"] = require_total_biomass
		params["item"] = src

		if (event_spawns)
			if (caller?.selected_spawn?.event)
				var/num_available = event_spawns[caller.selected_spawn.event]
				if (isnum(num_available) && num_available > 0)
					params["free"] = caller.selected_spawn.event

		return params

	if (spawn_method == SPAWN_PLACE)
		create_necromorph_placement_handler(usr, spawn_path, placement_type, snap = TRUE, biomass_source = caller.host, name = name, biomass_cost = price, require_corruption = TRUE)

