/datum/sold_goods
	/// Name of the item, if not set it'll draw a name from the path
	var/name
	/// Path of the sold goodie
	var/path
	/// Cost of the sold goodie, modified by margin and variance of the trader
	var/cost = 100
	/// Highest stock possible
	var/stock_high = 3
	/// Lowest stock possible
	var/stock_low = 1
	/// Current stock, initial stock will be modified by the vendors quantity
	var/current_stock
	/// If you want this rule to pick from a list of types use this
	var/list/trading_types

/datum/sold_goods/New(trader_cost_multiplier, trader_quantity_multiplier)
	current_stock = max(round(rand(stock_low,stock_high)*trader_cost_multiplier),1)
	cost *= trader_cost_multiplier
	cost = round(cost)
	if(trading_types)
		var/list/candidates = compile_typelist_for_trading(trading_types)
		path = pick(candidates)
		trading_types = null
	if(!name)
		var/atom/movable/thing = path
		name = initial(thing.name)

/datum/sold_goods/proc/spawn_item(turf/destination)
	new path(destination)

/datum/sold_goods/stack
	var/amount = 1

/datum/sold_goods/stack/New()
	. = ..()
	name = "[amount]x [name]"

/datum/sold_goods/stack/spawn_item(turf/destination)
	var/obj/item/stack/new_stack_path = path
	new new_stack_path(destination, amount)
