SUBSYSTEM_DEF(necromorph)
	name = "Necromorph"
	init_order = SS_INIT_NECROMORPH	//Initializes before atoms
	flags = SS_NO_FIRE

	//Necromorph Lists
	var/list/major_vessels = list()	//Necromorphs that need a player to control them. they are inert husks without one.
	var/list/minor_vessels	=	list()	//Necromorphs that have AI and don't need a player, but can be possessed anyway if someone wants to do manual control
	var/list/shards = list()	//Marker shards in the world
	var/list/spawned_necromorph_types = list() //Assoc list of typepath = quantity, tracks the number of necromorphs ever spawned this round

	//Signal Lists
	var/list/signals	=	list()	//List of all signal players
	var/list/necroqueue = list()	//This is a list of signal players who are waiting to be put into the first available major vessel

	//Marker
	var/obj/machinery/marker/marker
	var/list/marker_spawns_ishimura = list()	//Possible spawn locations aboard ishimura
	var/list/marker_spawns_aegis = list()	//Possible spawn locations on Aegis VII
	var/marker_activated_at = 0	//World time when the marker was activated

	//Players
	var/list/necromorph_players = list()	//This is a list of keys and mobs of players on the necromorph team

	//Sightings of prey. See  code/modules/necromorph/corruption/eye.dm
	var/list/sightings = list()

	//Misc
	var/list/massive_necroatoms = list()	//A list of all necromorphs which are worth biomass

	//Tiny bit of a hack. This shared global variable is used to cycle through the shards list.
	//Under the mostly likely assumption that two people generally won't be jumping to shards at the same time
	var/last_shard_jumped_to = 1

/datum/controller/subsystem/necromorph/stat_entry(msg)
	return ("Click to debug!")

/datum/controller/subsystem/necromorph/proc/join_necroqueue(mob/dead/observer/eye/signal/M)
	if (is_marker_master(M))
		//The master may not queue. They can still possess things if really needed though
		return FALSE
	necroqueue |= M
	remove_verb(M, /mob/dead/observer/eye/signal/proc/join_necroqueue)
	add_verb(M, /mob/dead/observer/eye/signal/proc/leave_necroqueue)
	to_chat(M, ("You are now in the necroqueue. When a necromorph vessel is available, you will be automatically placed in control of it. You can still manually posess necromorphs."))



/datum/controller/subsystem/necromorph/proc/remove_from_necroqueue(mob/dead/observer/eye/signal/M)
	add_verb(M, /mob/dead/observer/eye/signal/proc/join_necroqueue)
	remove_verb(M, /mob/dead/observer/eye/signal/proc/leave_necroqueue)
	necroqueue -= M




/datum/controller/subsystem/necromorph/proc/fill_vessel_from_queue(var/mob/vessel, var/vessel_id)
	for (var/mob/dead/observer/eye/signal/M in necroqueue)
		if (!M.client || !M.key)
			continue	//Gotta be connected


		//If we get here, they'll do.
		vessel.key = M.key	//Move into the mob and delete the old
		qdel(M)

		return TRUE
	return FALSE	//Return false if we failed to find anyone




/proc/add_massive_atom(var/atom/A)
	if ((A in SSnecromorph.massive_necroatoms))
		return

	SSnecromorph.massive_necroatoms += A
	var/obj/machinery/marker/M = get_marker()
	if (M)
		M.invested_biomass = NONSENSICAL_VALUE
		M.unavailable_biomass = NONSENSICAL_VALUE


/proc/remove_massive_atom(var/atom/A)
	if (!(A in SSnecromorph.massive_necroatoms))
		return

	SSnecromorph.massive_necroatoms -= A
	var/obj/machinery/marker/M = get_marker()
	if (M)
		M.invested_biomass = NONSENSICAL_VALUE
		M.unavailable_biomass = NONSENSICAL_VALUE


//Possible future todo: Allow this to take some kind of faction id in order to allow a necros vs necros gamemode
/proc/get_marker()
	if (SSnecromorph)
		return SSnecromorph.marker


//Shard handling
/datum/controller/subsystem/necromorph/proc/register_shard(var/obj/item/marker_shard/MS)
	var/shardsbefore = shards.len

	shards |= MS

	//When the number of shards in the world switches between zero and nonzero, we update ability lists
	if (shardsbefore == 0)



/datum/controller/subsystem/necromorph/proc/unregister_shard(var/obj/item/marker_shard/MS)
	var/shardsbefore = shards.len

	shards -= MS

	//When the number of shards in the world switches between zero and nonzero, we update ability lists
	if ((shardsbefore > 0) && (shards.len <= 0))

