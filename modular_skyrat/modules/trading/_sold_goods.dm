/datum/sold_goods
	/// Name of the item, if not set it'll draw a name from the path
	var/name
	/// Path of the sold goodie. Supports lists with multiple paths.
	var/path
	/// If path is a list, and this is defined, then only a number of the paths will be chosen from the list.
	var/num_contained
	/// If defined, the goodie will be inside a labeled container of this type.
	var/container_path
	/// Cost of the sold goodie, modified by margin and variance of the trader
	var/cost = 100
	/// Stock amount of this sold goodie
	var/stock = 3
	/// Current stock, initial stock will be modified by the vendors quantity
	var/current_stock

/datum/sold_goods/New(trader_cost_multiplier)
	current_stock = stock
	cost *= trader_cost_multiplier
	cost = CEILING(cost, TRADER_PRICE_ROUNDING)
	if(!name)
		var/atom/movable/thing
		if(islist(path))
			thing = path[1]
		else
			thing = path
		name = initial(thing.name)

/datum/sold_goods/proc/spawn_item(turf/destination)
	var/atom/absolute_destination
	if(container_path)
		absolute_destination = new container_path(destination)
		absolute_destination.name += " ([name])"
	else
		absolute_destination = destination
	if(islist(path))
		if(num_contained)
			var/list/path_cast = path
			var/list/list_to_take_from = path_cast.Copy()
			for(var/i in 1 to num_contained)
				var/picked_type = pick_n_take(list_to_take_from)
				new picked_type(absolute_destination)
				if(!list_to_take_from.len)
					break
		else
			for(var/listed_path in path)
				new listed_path(absolute_destination)
	else
		new path(absolute_destination)

/datum/sold_goods/stack
	var/amount = 1

/datum/sold_goods/stack/New()
	. = ..()
	name = "[amount]x [name]"

/datum/sold_goods/stack/spawn_item(turf/destination)
	var/obj/item/stack/new_stack_path = path
	new new_stack_path(destination, amount)
