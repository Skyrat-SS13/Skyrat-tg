/*
	This file has all the code for the necromorph and corruption spawning interface, AKA necroshop.

	The marker player uses this shop to spend their stored biomass to create new units and corruption nodes
*/

/atom/proc/get_necroshop()
	return null

/obj/machinery/marker/get_necroshop()
	return shop


/datum/necroshop
	var/obj/machinery/marker/host	//Where do we draw our biomass from?
	var/datum/necroshop_item/current	//What do we currently have selected for spawning or more detailed viewing?
	var/list/spawnable_necromorphs = list()
	var/list/spawnable_structures = list()
	var/datum/necrospawn/selected_spawn = null
	var/list/possible_spawnpoints = list()
	var/list/content_data	=	list()	//No need to regenerate this every second
	var/necroqueue_fill	 = TRUE//Shop-level toggle for using necroqueue to fill new spawns

/datum/necroshop/New(var/newhost)
	host = newhost

	//Lets construct the shop inventory
	build_shop_list()

	selected_spawn = new(host, host.name)
	possible_spawnpoints += selected_spawn




/datum/necroshop/proc/build_shop_list()
	QDEL_ASSOC_LIST(spawnable_necromorphs)
	QDEL_ASSOC_LIST(spawnable_structures)

	//First up, necromorph species
	for (var/spath in subtypesof(/datum/species/necromorph))
		var/datum/species/necromorph/N = spath	//This lets us use initial
		N = all_species[initial(N.name)]
		if (!initial(N.marker_spawnable))
			continue	//Check this one is spawnable

		//Ok lets create a shop datum for them
		var/datum/necroshop_item/I = new N.necroshop_item_type()
		I.name = initial(N.name)
		I.desc = N.get_long_description()
		I.price = initial(N.biomass)
		I.spawn_method = initial(N.spawn_method)
		I.spawn_path = N.mob_type
		I.queue_fill = N.major_vessel
		I.require_total_biomass = N.use_total_biomass
		I.global_limit = N.global_limit

		//Check if its allowed, based on global limits
		if (!I.can_ever_spawn(src))
			//Not allowed
			qdel(I)
			continue

		//And add it to the list
		spawnable_necromorphs[I.name] = I

	sortTim(spawnable_necromorphs, /proc/cmp_necroshop_item, TRUE)

	//Corruption nodes next
	for (var/spath in subtypesof(/obj/structure/corruption_node))
		var/obj/structure/corruption_node/N = new spath()
		if (!initial(N.marker_spawnable))
			continue	//Check this one is spawnable

		//Ok lets create a shop datum for them
		var/datum/necroshop_item/I = new()
		I.name = initial(N.name)
		I.desc = N.get_long_description()
		I.price = initial(N.biomass)
		I.spawn_method = SPAWN_PLACE
		I.spawn_path = spath
		I.queue_fill = FALSE
		I.placement_type = N.placement_type

		//And add it to the list
		spawnable_structures[I.name] = I
		qdel(N)

	sortTim(spawnable_structures, /proc/cmp_necroshop_item, TRUE)

	//Now cache the display data for the above
	generate_content_data()

//Datums for spawnpoints
/datum/necrospawn
	var/id
	var/atom/spawnpoint				//Where are we spawning things?
	var/name = "Marker"				//What do we call this spawn location?
	//TODO: Support for a preview image of the area

/datum/necrospawn/New(var/atom/origin, var/_name)
	spawnpoint = origin
	name = _name
	id = "\ref[spawnpoint]"




//Datum to hold the spawnpoint selection menu, one is created for each user
/datum/necrospawn_selector
	var/datum/necroshop/host

/datum/necrospawn_selector/New(var/datum/necroshop/_host)
	host = _host

/datum/necrospawn_selector/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/list/data = list()
	for (var/datum/necrospawn/N in host.possible_spawnpoints)
		data["spawnpoints"] += list(list("name" = "[N.name]	[jumplink_public(user, N.spawnpoint)]", "id" = N.id))

	data["selected_id"] = host.selected_spawn.id



	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "necrospawn_selector.tmpl", "Spawning Menu", 800, 700, state = GLOB.interactive_state)
		ui.set_initial_data(data)
		ui.set_auto_update(0)
		ui.open()

/datum/necrospawn_selector/Topic(href, href_list)
	if(..())
		return

	if (href_list["select_spawn"])	//This will be an id of a spawnpoint. lets find it
		for (var/datum/necrospawn/N in host.possible_spawnpoints)
			if (N.id == href_list["select_spawn"])	//We found it!
				//Set it on the host
				host.selected_spawn = N

				//Close this window
				var/datum/nanoui/ui = SSnano.get_open_ui(usr, src, "main")
				ui.close()

				//And refresh the parent window
				SSnano.update_uis(host)
				return


/datum/necroshop/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	if (!authorised_to_view(user))
		return
	var/list/data = content_data.Copy()
	if (current)
		data["current"] = list("name" = current.name, "desc" = current.desc, "price" = current.price, "reqtotal" = current.require_total_biomass)
		if (current.spawn_method == SPAWN_PLACE)
			data["place"] = TRUE

		if (current.require_total_biomass)
			data["total"] = Floor(host.get_total_biomass())

	data["biomass"]	=	round(host.biomass, 0.1)
	data["income"] = round(host.biomass_tick, 0.01)

	data["spawn"] = list("name" = selected_spawn.name, "x" = selected_spawn.spawnpoint.x, "y" = selected_spawn.spawnpoint.y, "z" = selected_spawn.spawnpoint.z)
	if (authorised_to_spawn(user))
		data["authorised"] = TRUE


	if (necroqueue_fill)
		data["queue"]	=	"checked"	//Used in html


	data["waiting_num"] = 0
	if (SSnecromorph.necroqueue.len)
		data["waiting_num"] = SSnecromorph.necroqueue.len
		var/names = "Currently in necroqueue:"
		for (var/mob/observer/eye/signal/S in SSnecromorph.necroqueue)
			names += "\n[S.key]"
		data["waiting_names"] = names
	else
		data["waiting_names"] = "There are no players currently in the necroqueue."
	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "necroshop.tmpl", "Spawning Menu", 800, 700, state = GLOB.interactive_state)
		ui.set_initial_data(data)
		ui.set_auto_update(1)
		ui.open()

/datum/necroshop/Topic(href, href_list)
	if(..())
		return
	if (href_list["select"])
		current = spawnable_necromorphs[href_list["select"]]
		if (!current)
			current = spawnable_structures[href_list["select"]]


	if (href_list["spawn"])
		if (authorised_to_spawn(usr))
			start_spawn()
			return //Don't update the UIs

	if (href_list["toggle-queue"])
		necroqueue_fill = !necroqueue_fill

	if (href_list["select_spawn"])
		var/datum/necrospawn_selector/NS = new (src)
		NS.ui_interact(usr)

	SSnano.update_uis(src)



//Generate and cache the common data
/datum/necroshop/proc/generate_content_data()
	content_data = list()

	var/list/listed_necromorphs = list()
	for(var/a in spawnable_necromorphs)
		var/datum/necroshop_item/I = spawnable_necromorphs[a]

		listed_necromorphs.Add(list(list("name" = I.name,
			"price" = I.price)))
	content_data["necromorphs"] = listed_necromorphs


	var/list/listed_structures = list()
	for(var/a in spawnable_structures)
		var/datum/necroshop_item/I = spawnable_structures[a]

		listed_structures.Add(list(list("name" = I.name,
			"price" = I.price)))
	content_data["structures"] = listed_structures


//Safety Checks
//------------------
//Is this mob allowed to browse through the shop?
/datum/necroshop/proc/authorised_to_view(var/mob/M)
	//Anyone on the necro team is allowed
	if (M.is_necromorph())
		return TRUE

	//Admins are allowed
	if(M.client && check_rights(R_ADMIN|R_DEBUG, FALSE, M.client))
		return TRUE

	return FALSE


//Should the spawn button be enabled in the UI?
/datum/necroshop/proc/authorised_to_spawn(var/mob/M)
	//First of all
	//Do we even have anything selected for spawning yet?
	if (!current)
		return FALSE

	//Secondly
	//Is this mob allowed to spend biomass and spawn objects?
	var/authority = FALSE
	//Only the marker player is allowed
	if (istype(M, /mob/observer/eye/signal/master))
		authority = TRUE

	//Admins are allowed
	if(M.client && check_rights(R_ADMIN|R_DEBUG, FALSE,  M.client))
		authority = TRUE

	if (!authority)
		return FALSE

	//Third
	//Can it be spawned right now, based on available biomass, or total biomass where appropriate
	if (!current.can_spawn(src))
		return FALSE


	//All Clear
	return TRUE




//Spawns the currently selected thing at the currently selected spawnpoint.
//This is an entry that calls a few more procs
/datum/necroshop/proc/start_spawn()
	var/list/spawn_params = current.get_spawn_params(src)	//Attempt to get an exact place to spawn
	if (!spawn_params)
		//For manual placement spawns, this will return null and call finalize later, after the user clicks where to place it
		return

	if (!current.can_spawn(src))
		return

	finalize_spawn(spawn_params)


//This proc takes a list of spawn parameters, which is either constructed through get_spawn_params, or via a placement datum.
//It takes the biomass and creates the atom
//No other safety checks are done here, we will assume the params contain only correct info
/datum/necroshop/proc/finalize_spawn(var/list/params)

	//First, ensure that the host can pay the biomass
	//For total mass requirements, we check but don't pay
	if (params["reqtotal"])
		if (host.get_total_biomass() < params["price"])
			to_chat(params["user"], SPAN_DANGER("ERROR: Not enough biomass to spawn [params["name"]]"))
			return

	//This line actually takes the biomass in most cases
	else if (!host_pay_biomass(params["name"], params["price"]))
		to_chat(params["user"], SPAN_DANGER("ERROR: Not enough biomass to spawn [params["name"]]"))
		return



	var/spawnpath = params["path"]
	var/atom/targetloc = params["target"]
	var/atom/newthing = new spawnpath(targetloc)

	//Lets increment the spawned global total
	var/total = SSnecromorph.spawned_necromorph_types[params["path"]]
	if (total)
		total++
	else
		total = 1

	SSnecromorph.spawned_necromorph_types[params["path"]] = total

	//And rebuild the shop list if needed
	if (params["limited"])
		build_shop_list()


	var/mob/user = params["user"]
	if (!QDELETED(newthing))
		newthing.set_dir(params["dir"])
		to_chat(user, SPAN_NOTICE("Successfully spawned [newthing] at [jumplink_public(user, targetloc)]"))

		if (params["queue"] && necroqueue_fill)
			SSnecromorph.fill_vessel_from_queue(newthing, params["name"])

	return newthing	//Return the newthing to the caller so it can do stuff


//Attempts to subtract the relevant quantity of biomass from the host marker or whatever else
//Make sure this is the last step before spawning, it can't be allowed to fail after this
/datum/necroshop/proc/host_pay_biomass(var/purpose, var/amount)
	if (host.pay_biomass(purpose, amount))
		return TRUE




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

	if (require_total_biomass)
		if (caller.host.get_total_biomass() < price)
			return FALSE

	else if (caller.host.biomass < price)
		return FALSE

	return TRUE

//This function has two modes.
//For spawning at a point, it will find an exact location and return a list of parameters which will then be passed to finalise_spawn
//For manual placement spawning, it will immediately return null to terminate that process, and create a datum which will handle the placement and user input
	//That datum, once a spot is selected, will generate its own parameters and call finalize_spawn directly on its own
/datum/necroshop_item/proc/get_spawn_params(var/datum/necroshop/caller)
	.=null
	if (spawn_method == SPAWN_POINT)
		var/list/params = list()
		params["name"] = name
		params["origin"] = caller.selected_spawn.spawnpoint	//Where are we spawning from? This may be useful for visual effects
		var/list/turfs = params["origin"].clear_turfs_in_view(10)
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
		return params

	if (spawn_method == SPAWN_PLACE)
		create_necromorph_placement_handler(usr, spawn_path, placement_type, snap = TRUE, biomass_source = caller.host, name = name, biomass_cost = price, require_corruption = TRUE)




/*
	Debug:
	The necroshop unfortunately sometimes bugs out and refuses to open for anyone. The exact cause is unknown, and no reproduction exists either

	As a stopgap measure, this verb will fix it
*/
/client/proc/fix_necroshop()
	set name = "Spawning Menu Fix"
	set desc = "Use if the necromorph spawning menu stops responding"
	set category = "Debug"

	for (var/obj/machinery/marker/M in world)
		QDEL_NULL(M.shop)
		M.shop = new(M)

	message_admins("[src] fixed the necromorph spawning menu")
