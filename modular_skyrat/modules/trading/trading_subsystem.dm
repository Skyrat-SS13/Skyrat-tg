SUBSYSTEM_DEF(trading)
	name = "Trading"
	init_order = INIT_ORDER_MAPPING - 1 //Always after mapping
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 5 MINUTES
	///List of all trade hubs
	var/list/trade_hubs = list()
	///List of all traders
	var/list/all_traders = list()
	///A dedicated global trade hub
	var/datum/trade_hub/global_trade_hub

	var/list/trader_types_spawned = list()

	var/next_trade_hub_id = 0

	var/next_trader_id = 0

	var/list/delivery_runs = list()

/datum/controller/subsystem/trading/proc/get_trade_hub_by_id(id)
	return trade_hubs["[id]"]

/datum/controller/subsystem/trading/proc/get_trader_by_id(id)
	return all_traders["[id]"]

/datum/controller/subsystem/trading/proc/get_next_trade_hub_id()
	next_trade_hub_id++
	return next_trade_hub_id

/datum/controller/subsystem/trading/proc/get_next_trader_id()
	next_trader_id++
	return next_trader_id

//Gets all available trade hubs from a turf position
/datum/controller/subsystem/trading/proc/get_available_trade_hubs(turf/position)
	var/list/passed_trade_hubs = list()
	if(global_trade_hub)
		passed_trade_hubs += global_trade_hub
	var/datum/overmap_object/overmap_object = GetHousingOvermapObject(position)
	if(overmap_object)
		var/list/overmap_objects = overmap_object.current_system.GetObjectsInRadius(overmap_object.x,overmap_object.y,0)
		for(var/i in overmap_objects)
			var/datum/overmap_object/iterated_object = i
			if(istype(iterated_object, /datum/overmap_object/trade_hub))
				var/datum/overmap_object/trade_hub/th_obj = iterated_object
				passed_trade_hubs += th_obj.hub
	return passed_trade_hubs

/datum/controller/subsystem/trading/Initialize(timeofday)
	var/datum/map_config/config = SSmapping.config
	// Create global trade hub
	if(config.global_trading_hub_type)
		global_trade_hub = new config.global_trading_hub_type()
	// Create the localized trade hubs
	if(config.localized_trading_hub_types)
		for(var/hub_type in config.localized_trading_hub_types)
			new /datum/overmap_object/trade_hub(SSovermap.main_system, rand(5,20), rand(5,20), hub_type)
	return ..()

/datum/controller/subsystem/trading/fire(resumed = FALSE)
	for(var/i in trade_hubs)
		var/datum/trade_hub/hub = trade_hubs[i]
		hub.Tick()
