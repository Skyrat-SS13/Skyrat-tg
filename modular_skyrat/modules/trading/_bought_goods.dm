/datum/bought_goods
	///Name of the goods that will be displayed that the trader is interested in
	var/name = "goods"
	/// Whether we check the types of the bought goodie. If not, make sure the datum handles verification by itself
	var/check_types = TRUE
	var/list/trading_types = list()
	var/list/compiled_typecache
	///The price label, if null then it'll initialize as correct price + variance
	var/cost_label
	var/cost = 100
	var/trader_price_multiplier = 1

	/// Stock amount of this purchasable goodie
	var/stock
	/// Remaining amount of how many of those the trader will yet buy. Infinite if null
	var/amount
	/// The decimal the stock will be rounded up to
	var/stock_ceiling = 1

/datum/bought_goods/New(price_multiplier)
	. = ..()
	trader_price_multiplier = price_multiplier
	cost *= price_multiplier
	cost = CEILING(cost, TRADER_PRICE_ROUNDING)
	if(!cost_label)
		cost_label = "[cost]"

	if(check_types)
		compiled_typecache = compile_typelist_for_trading(trading_types)
	trading_types = null

	if(stock)
		amount = stock

/datum/bought_goods/Destroy()
	compiled_typecache = null
	return ..()

/datum/bought_goods/proc/Validate(atom/movable/movable_atom_to_validate)
	if((!check_types || compiled_typecache[movable_atom_to_validate.type]) && IsValid(movable_atom_to_validate) && !length(movable_atom_to_validate.client_mobs_in_contents))
		return TRUE
	return FALSE

/// Whether the trader is interested in purchasing this amount of the item (matters for all stack related datums)
/datum/bought_goods/proc/CheckAmount(atom/movable/movable_atom_to_validate)
	if(isnull(amount))
		return TRUE
	if(amount < GetAmount(movable_atom_to_validate))
		return FALSE
	return TRUE

/datum/bought_goods/proc/GetAmount(atom/movable/movable_atom_to_validate)
	return 1

/// Subtract the stock by amount of items sold. Matters for stack datums
/datum/bought_goods/proc/SubtractAmount(atom/movable/movable_atom_to_subtract_from)
	if(isnull(amount))
		return
	amount -= GetAmount(movable_atom_to_subtract_from)

/// This proc is used to verify items past their typecheck verification
/datum/bought_goods/proc/IsValid(atom/movable/movable_atom_to_verify)
	return TRUE

/// This proc is used to dynamically appraise the items, changing their price based off variables, make sure the price label reflects such a possibility if used
/datum/bought_goods/proc/GetCost(atom/movable/movable_atom_to_appraise)
	return cost * GetAmount(movable_atom_to_appraise)

/datum/bought_goods/stack
	name = "a stack"

/datum/bought_goods/stack/New(price_multiplier)
	. = ..()
	cost_label += " each"

/datum/bought_goods/stack/GetAmount(atom/movable/movable_atom_to_validate)
	var/obj/item/stack/our_stack = movable_atom_to_validate
	return our_stack.amount

/datum/bought_goods/reagent
	name = null
	cost = 10
	check_types = FALSE
	stock_ceiling = 10
	var/reagent_type
	var/list/possible_reagent_types

/datum/bought_goods/reagent/New(price_multiplier)
	. = ..()
	if(possible_reagent_types)
		reagent_type = pick(possible_reagent_types)
		possible_reagent_types = null
	if(!name)
		var/datum/reagent/reagent_cast = reagent_type
		name = "[initial(reagent_cast.name)]"
	cost_label += " /u"

/datum/bought_goods/reagent/IsValid(atom/movable/movable_atom_to_verify)
	if(!istype(movable_atom_to_verify, /obj/item/reagent_containers))
		return FALSE
	var/datum/reagents/holder = movable_atom_to_verify.reagents
	if(!holder)
		return FALSE
	if(!holder.has_reagent(reagent_type))
		return FALSE
	return TRUE

/datum/bought_goods/reagent/GetAmount(atom/movable/movable_atom_to_validate)
	var/datum/reagents/holder = movable_atom_to_validate.reagents
	var/datum/reagent/reagent = holder.get_reagent(reagent_type)
	return reagent.volume
