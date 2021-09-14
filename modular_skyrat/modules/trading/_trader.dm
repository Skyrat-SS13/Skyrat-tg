/datum/trader
	/// Name of the trader
	var/name = "unsuspicious trader"
	/// Place where he comes from, it'll be shown to the user
	var/origin = "some place"
	/// A list of possible places where he'll be from
	var/list/possible_origins
	/// A list of possible names he'll have
	var/list/possible_names
	/// Current disposition. The merchant may close communications if it's too low
	var/disposition = 0
	/// All the flags of the merchant, currently whether they trade money or barter or both
	var/trade_flags = TRADER_MONEY|TRADER_BARTER|TRADER_SELLS_GOODS|TRADER_BUYS_GOODS
	/// The hub they belong to
	var/datum/trade_hub/hub
	/// Associative list of sold goods datums, key is type, value is chance that the datum will apply
	var/list/possible_sold_goods
	/// Associative list of bought goods datums, key is type, value is chance that the datum will apply
	var/list/possible_bought_goods
	/// List of sold good datums. If you want all of them to be guaranteed, make sure `target_sold_goods_amount` is greater than the amount of items in here
	var/list/sold_goods = list()
	/// List of bought goods datums. If you want all of them to be guaranteed, make sure `target_bought_goods_amount` is greater than the amount of items in here
	var/list/bought_goods = list()
	/// Cash they hold, they won't be able to pay out if it gets too low
	var/current_credits = DEFAULT_TRADER_CREDIT_AMOUNT
	/// The present percentage the merchant will allow to haggle the people, it's randomized between 0 and haggle_percent each trade
	var/current_haggle = 0
	/// A list of connected trade consoles, in case the trader is destroyed we want to disconnect the consoles
	var/list/connected_consoles = list()

	/// Whether he refuses comms or not
	var/refuses_comms = FALSE

	/// Maximum percent that the merchant will be able to drop the price. Randomized between 0 and this
	var/haggle_percent = 15
	/// A percentage of the price variance on all sold and bought goods
	var/price_variance = 20
	/// How much more items are valuable to the merchant for purchasing (in %)
	var/buy_margin = 1
	/// How much more items are expensive for the users to purchase (in %)
	var/sell_margin = 1.15
	/// How much more, or less items will he have on stock. Minimum of 1 per datum
	var/quantity_multiplier = 1
	/// Amount of disposition gained per each trade
	var/disposition_per_trade = 3
	/// Amount of disposition lost per each rejection
	var/disposition_per_reject = 3

	/// The amount of individual purchase items the trader will try and have. If equal or more, he'll loose a sold datum, if less he'll try and get a new one
	var/target_sold_goods_amount = 7
	/// The amount of individual bought items the trader will try and have. If equal or more, he'll loose a bought datum, if less he'll try and get a new one
	var/target_bought_goods_amount = 4
	/// How much more or less the trader will initialize with in stock
	var/initial_goods_amount_randomness = 1

	/// Whether the trader rotates stock or not
	var/rotates_stock = TRUE
	/// What's the chance the vendor will rotate stock
	var/rotate_stock_chance = 100

	/// Current listed bounties
	var/list/bounties
	/// All possible bounties, associative to weight
	var/list/possible_bounties
	/// Chance to gain a bounty per stock rotation
	var/bounty_gain_chance = 15
	/// Chance to gain a bounty when the trader is spawned in
	var/initial_bounty_gain_chance = 50

	/// Current listed deliveries
	var/list/deliveries
	/// All possible deliveries, associative to weight
	var/list/possible_deliveries
	/// Chance to gain a delivery per stock rotation
	var/delivery_gain_chance = 15
	/// Chance to gain a delivery when the trader is spawned in
	var/initial_delivery_gain_chance = 50

	/// An associative list of unique responses
	var/list/speech
	var/id

// For the traders to override and do some special interactions after trading
/datum/trader/proc/AfterTrade(mob/user, obj/machinery/computer/trade_console/console)
	return

/datum/trader/proc/randomize_haggle()
	current_haggle = rand(0, haggle_percent)

// TRUE to accept hail, FALSE to reject it. Speciest traders could reject hails from some species, or from cyborgs
// This will also be called every interaction, and may shut down the comms, last response will be the close reason
/datum/trader/proc/get_hailed(mob/user, obj/machinery/computer/trade_console/console)
	if(disposition <= TRADER_DISPOSITION_REJECT_HAILS)
		return FALSE
	return TRUE

/datum/trader/proc/get_matching_bought_datum(atom/movable/AM)
	for(var/b in bought_goods)
		var/datum/bought_goods/goodie = bought_goods[b]
		if(goodie.Validate(AM) && goodie.CheckAmount(AM))
			return goodie

/datum/trader/proc/requested_barter(mob/user, obj/machinery/computer/trade_console/console, datum/sold_goods/goodie)
	if(!goodie.current_stock)
		return get_response("out_of_stock", "I'm afraid I don't have any more of these!", user)
	if(!(trade_flags & TRADER_BARTER))
		return get_response("trade_no_buy", "I don't deal in goods!", user)
	//Now we need to figure out how much does the haggled items have in value
	var/list/items_on_pad = console.linked_pad.get_valid_items()
	if(!length(items_on_pad))
		return get_response("pad_empty", "There's nothing on the pad...", user)
	var/total_value = 0
	var/list/valid_items = list()

	var/bartered_items
	var/bartered_item_count = 0

	for(var/i in items_on_pad)
		var/atom/movable/AM = i
		var/datum/bought_goods/bought_goodie = get_matching_bought_datum(AM)
		if(bought_goodie)
			total_value += bought_goodie.GetCost(AM)
			valid_items += AM
			if(!bartered_items)
				bartered_items = "[bought_goodie.name]"
			else
				bartered_items += ", [bought_goodie.name]"
			bartered_item_count += bought_goodie.GetAmount(AM)

	total_value *= TRADE_BARTER_EXTRA_MARGIN
	//Always treat barter as if it's haggling
	var/haggle_percent = (100-current_haggle)/100
	if(total_value < goodie.cost*haggle_percent)
		//Not enough value
		disposition -= disposition_per_reject
		. = get_response("trade_not_enough", "It's definetly worth more than that", user)
	else
		//Successfully bartered
		for(var/i in valid_items)
			var/atom/movable/AM = i
			qdel(AM)

		//Hard bargain
		if(total_value < goodie.cost*(haggle_percent+TRADE_HARD_BARGAIN_MARGIN))
			. = get_response("hard_bargain", "You drive a hard bargain, but I'll accept", user)
		else
			. = get_response("trade_complete", "Thanks for your business!", user)
		goodie.current_stock--
		var/destination_turf = get_turf(console.linked_pad)
		goodie.spawn_item(destination_turf)
		disposition += disposition_per_trade
		console.linked_pad.do_teleport_effect()
		AfterTrade(user,console)
		randomize_haggle()
		console.write_manifest(bartered_items, "[bartered_item_count] total", total_value, TRUE, user.name)
		console.write_manifest(goodie.name, 1, total_value, FALSE, user.name)

/datum/trader/proc/requested_sell(mob/user, obj/machinery/computer/trade_console/console, datum/bought_goods/goodie, haggled_price)
	if(!(trade_flags & TRADER_MONEY))
		return get_response("only_deal_in_goods", "I only deal in goods, come and barter!", user)
	var/list/items_on_pad = console.linked_pad.get_valid_items()
	var/atom/movable/chosen_item
	var/item_value
	for(var/i in items_on_pad)
		var/atom/movable/AM = i
		if(goodie.Validate(AM) && goodie.CheckAmount(AM))
			chosen_item = AM
			item_value = goodie.GetCost(AM)
			break
	items_on_pad = null
	if(!chosen_item)
		return get_response("trade_found_unwanted", "I'm not interested in these kinds of items!", user)
	var/proposed_cost = haggled_price ? haggled_price : item_value
	if(current_credits < proposed_cost)
		return get_response("out_of_money", "Sorry, I've ran out of credits.", user)
	var/hard_bargain
	if(haggled_price)
		var/haggle_percent = (100+current_haggle)/100
		if(haggled_price > item_value*haggle_percent)
			//Too much, reject
			disposition -= disposition_per_reject
			return get_response("too_much_value", "No way I'm paying that much for this", user)
		else if (haggled_price > item_value*(haggle_percent-TRADE_HARD_BARGAIN_MARGIN))
			hard_bargain = TRUE
	goodie.SubtractAmount(chosen_item)
	qdel(chosen_item)
	console.linked_pad.do_teleport_effect()
	AfterTrade(user,console)
	console.credits_held += proposed_cost
	current_credits -= proposed_cost
	randomize_haggle()
	console.write_manifest(goodie.name, goodie.GetAmount(chosen_item), proposed_cost, TRUE, user.name)
	if(hard_bargain)
		return get_response("hard_bargain", "You drive a hard bargain, but I'll accept", user)
	else
		disposition += disposition_per_trade
		return get_response("trade_complete", "Thanks for your business!", user)

/datum/trader/proc/requested_buy(mob/user, obj/machinery/computer/trade_console/console, datum/sold_goods/goodie, haggled_price)
	var/proposed_cost = haggled_price ? haggled_price : goodie.cost
	if(!goodie.current_stock)
		return get_response("out_of_stock", "I'm afraid I don't have any more of these!", user)
	if(!(trade_flags & TRADER_MONEY))
		return get_response("doesnt_use_cash", "I have no need for cash. Offer me some goods!", user)
	if(console.credits_held < proposed_cost)
		return get_response("user_no_money", "You can't afford this", user)
	var/hard_bargain = FALSE
	if(haggled_price)
		var/haggle_percent = (100-current_haggle)/100
		if(haggled_price < goodie.cost*haggle_percent)
			//Too low of a haggle, reject
			disposition -= disposition_per_reject
			return get_response("trade_not_enough", "It's definetly worth more than that", user)
		else if(haggled_price < goodie.cost*(haggle_percent+TRADE_HARD_BARGAIN_MARGIN))
			hard_bargain = TRUE

	//We established there's stock and we have enough money for it, and the trader deals in cash
	console.credits_held -= proposed_cost
	current_credits += proposed_cost
	goodie.current_stock--
	var/destination_turf = get_turf(console.linked_pad)
	goodie.spawn_item(destination_turf)
	console.linked_pad.do_teleport_effect()
	AfterTrade(user,console)
	randomize_haggle()
	console.write_manifest(goodie.name, 1, proposed_cost, FALSE, user.name)
	if(hard_bargain)
		return get_response("hard_bargain", "You drive a hard bargain, but I'll accept", user)
	else
		disposition += disposition_per_trade
		return get_response("trade_complete", "Thanks for your business!", user)

/datum/trader/proc/get_appraisal(mob/user, obj/machinery/computer/trade_console/console)
	var/list/items_on_pad = console.linked_pad.get_valid_items()
	if(!length(items_on_pad))
		return get_response("pad_empty", "There's nothing on the pad...", user)
	var/last_item_name
	var/item_count = 0
	var/total_value = 0

	for(var/i in items_on_pad)
		var/atom/movable/AM = i
		var/datum/bought_goods/goodie = get_matching_bought_datum(AM)
		if(goodie)
			item_count++
			total_value += goodie.GetCost(AM)
			last_item_name = AM.name

	if(!item_count)
		return get_response("trade_found_unwanted", "I'm not interested in these kinds of items!", user)
	if(item_count == 1)
		. = get_response("how_much", "For this ITEM I'm willing to pay VALUE credits.", user)
		. = replacetext(., "ITEM", last_item_name)
	else
		. = get_response("how_much", "For those items I'm willing to pay VALUE credits.", user)
	. = replacetext(., "VALUE", "[total_value]")

/datum/trader/proc/sell_all_on_pad(mob/user, obj/machinery/computer/trade_console/console)
	var/list/items_on_pad = console.linked_pad.get_valid_items()
	if(!length(items_on_pad))
		return get_response("pad_empty", "There's nothing on the pad...", user)
	var/item_count = 0
	var/total_value = 0
	var/conjoined_amount = 0
	var/conjoined_string
	var/list/valid_items = list()
	for(var/i in items_on_pad)
		var/atom/movable/AM = i
		var/datum/bought_goods/goodie = get_matching_bought_datum(AM)
		if(goodie)
			item_count++
			total_value += goodie.GetCost(AM)
			goodie.SubtractAmount(AM)
			valid_items += AM
			if(!conjoined_string)
				conjoined_string = "[goodie.name]"
			else
				conjoined_string += ", [goodie.name]"
			conjoined_amount += goodie.GetAmount(AM)

	if(!item_count)
		return get_response("trade_found_unwanted", "I'm not interested in these kinds of items!", user)
	if(current_credits < total_value)
		return get_response("out_of_money", "I'm afraid I don't have enough cash!", user)
	for(var/i in valid_items)
		var/atom/movable/AM = i
		qdel(AM)
	valid_items = null
	current_credits -= total_value
	console.credits_held += total_value
	disposition += disposition_per_trade*item_count
	console.linked_pad.do_teleport_effect()
	AfterTrade(user,console)
	randomize_haggle()
	console.write_manifest(conjoined_string, "[conjoined_amount] total", total_value, TRUE, user.name)
	return get_response("trade_complete", "Thanks for your business!", user)

/datum/trader/proc/requested_bounty_claim(mob/user, obj/machinery/computer/trade_console/console, datum/trader_bounty/bounty)
	var/list/items_on_pad = console.linked_pad.get_valid_items()
	var/list/valid_items = list()
	var/counted_amount = 0
	var/bounty_completed = FALSE
	for(var/i in items_on_pad)
		var/atom/movable/AM = i
		var/amount_in_this_item = bounty.Validate(AM)
		if(!amount_in_this_item)
			continue
		counted_amount += amount_in_this_item
		valid_items += AM
		if(counted_amount >= bounty.amount)
			bounty_completed = TRUE
			break
	if(!bounty_completed)
		return get_response("bounty_fail_claim", "I'm afraid you're a bit short of what I need!", user)
	for(var/i in valid_items)
		var/atom/movable/AM = i
		qdel(AM)
	console.credits_held += bounty.reward_cash
	if(bounty.reward_item_path)
		console.write_manifest(bounty.reward_item_name, 1, 0, FALSE, user.name)
		new bounty.reward_item_path(get_turf(console.linked_pad))
	console.linked_pad.do_teleport_effect()
	AfterTrade(user,console)
	randomize_haggle()
	console.write_manifest(bounty.name, counted_amount, bounty.reward_cash, TRUE, user.name)
	. = bounty.bounty_complete_text
	bounties -= bounty
	qdel(bounty)
	if(!bounties.len)
		bounties = null
		console.trader_screen_state = TRADER_SCREEN_NOTHING

/datum/trader/proc/hail_msg(is_success, mob/user)
	var/key = is_success ? "hail" : "hail_deny"
	var/default = is_success ? "Greetings, MOB!" : "We're closed!"
	. = get_response(key, default, user)

/datum/trader/proc/requested_delivery_take(mob/user, obj/machinery/computer/trade_console/console, datum/delivery_run/delivery)
	delivery.Accept(user, console)
	deliveries -= delivery
	qdel(delivery)
	if(!deliveries.len)
		deliveries = null
		console.trader_screen_state = TRADER_SCREEN_NOTHING
	return get_response("delivery_take", "Don't take too long!", user)

/datum/trader/proc/get_user_suffix(mob/user)
	if(!isliving(user))
		return
	if(isAI(user))
		return TRADE_USER_SUFFIX_AI
	if(iscyborg(user))
		return TRADE_USER_SUFFIX_CYBORG
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		if(isgolem(human_user))
			return TRADE_USER_SUFFIX_GOLEM
		if(is_species(human_user, /datum/species/robotic/ipc) || is_species(human_user, /datum/species/robotic/synthliz))
			return TRADE_USER_SUFFIX_ROBOT_PERSON
		return human_user.dna.species.id

/datum/trader/proc/get_response(key, default, mob/user)
	var/suffix = get_user_suffix(user)
	if(speech)
		if(speech["[key]_[suffix]"])
			. = speech["[key]_[suffix]"]
		else if (speech[key])
			. = speech[key]
	if(!.)
		. = default
	. = replacetext(., "MERCHANT", name)
	. = replacetext(., "ORIGIN", origin)
	. = replacetext(., "MOB", user.name)

/datum/trader/New(datum/trade_hub/our_hub)
	. = ..()
	randomize_haggle()
	id = SStrading.get_next_trader_id()
	hub = our_hub
	hub.traders += src
	SStrading.all_traders["[id]"] = src
	if(possible_origins)
		origin = pick(possible_origins)
		possible_origins = null
	if(possible_names)
		name = pick(possible_names)
		possible_names = null

	InitializeStock()

/datum/trader/proc/Tick()
	if(current_credits < (initial(current_credits)*(TRADER_LOW_CASH_THRESHOLD/100)))
		current_credits += rand(TRADER_PAYCHECK_LOW, TRADER_PAYCHECK_HIGH)
	if(rotates_stock && prob(rotate_stock_chance))
		RotateStock()

/datum/trader/proc/InitializeStock()
	if(prob(initial_bounty_gain_chance))
		GainBounty()
	if(prob(initial_delivery_gain_chance))
		GainDelivery()
	if(possible_bought_goods)
		var/list/candidates = possible_bought_goods.Copy()
		var/amount_of_iterations = rand(target_bought_goods_amount-initial_goods_amount_randomness,target_bought_goods_amount+initial_goods_amount_randomness)
		if(amount_of_iterations > 0)
			for(var/i in 1 to amount_of_iterations)
				if(!length(candidates))
					break
				var/picked_type = pickweight(candidates)
				candidates -= picked_type
				//Safety check
				if(!bought_goods[picked_type])
					CreateBoughtGoodieType(picked_type)
		candidates = null
	if(possible_sold_goods)
		var/list/candidates = possible_sold_goods.Copy()
		var/amount_of_iterations = rand(target_sold_goods_amount-initial_goods_amount_randomness,target_sold_goods_amount+initial_goods_amount_randomness)
		if(amount_of_iterations > 0)
			for(var/i in 1 to amount_of_iterations)
				if(!length(candidates))
					break
				var/picked_type = pickweight(candidates)
				candidates -= picked_type
				//Safety check
				if(!sold_goods[picked_type])
					CreateSoldGoodieType(picked_type)
		candidates = null

/datum/trader/proc/GainBounty()
	if(bounties || !possible_bounties)
		return
	LAZYINITLIST(bounties)
	var/bounty_type = pickweight(possible_bounties)
	bounties += new bounty_type()

/datum/trader/proc/GainDelivery()
	if(deliveries || !possible_deliveries)
		return
	LAZYINITLIST(deliveries)
	var/delivery_type = pickweight(possible_deliveries)
	deliveries += new delivery_type(src)

/datum/trader/proc/RotateStock()
	if(prob(bounty_gain_chance))
		GainBounty()
	if(prob(delivery_gain_chance))
		GainDelivery()
	if(prob(TRADER_ABSOLUTE_STOCK_ROTATION_CHANCE))
		RemoveAllStock()
		InitializeStock()
		return
	//Remove up to 1 sold goodie that we've ran out of stock
	if(sold_goods.len && prob(TRADER_CHANCE_TO_REMOVE_EMPTY_STOCK))
		for(var/chosen_type in sold_goods)
			var/datum/sold_goods/goodie = sold_goods[chosen_type]
			if(!goodie.current_stock)
				RemoveSoldGoodieType(chosen_type)
				break

	//Remove up to 1 bought goodie that we've ran out of stock
	if(bought_goods.len && prob(TRADER_CHANCE_TO_REMOVE_EMPTY_STOCK))
		for(var/chosen_type in bought_goods)
			var/datum/bought_goods/goodie = bought_goods[chosen_type]
			if(!isnull(goodie.amount) && !goodie.amount)
				RemoveBoughtGoodieType(chosen_type)
				break

	//Simulate other people "purchasing" the stock items
	for(var/chosen_type in sold_goods)
		var/datum/sold_goods/goodie = sold_goods[chosen_type]
		if(goodie.current_stock && prob(TRADER_STRANGER_PURCHASE_ITEM_CHANCE))
			goodie.current_stock--

	if(possible_sold_goods)
		if(prob(TRADER_CHANCE_TO_DO_STOCK_FIXING))
			if(sold_goods.len < target_sold_goods_amount)
				//Too little items than what we're aiming for, try and add an item on a chance
				CreateSoldGoodieAtRandom()
			else
				//Too many items, remove one at random
				RemoveSoldGoodieAtRandom()

		//Randomness for the sake of randomeness
		if(prob(TRADER_WILDCARD_STOCK_ROTATE_CHANCE))
			if(prob(50))
				CreateSoldGoodieAtRandom()
			else
				RemoveSoldGoodieAtRandom()

	if(possible_bought_goods)
		if(prob(TRADER_CHANCE_TO_DO_STOCK_FIXING))
			if(bought_goods.len < target_bought_goods_amount)
				//Too little items than what we're aiming for, try and add an item on a chance
				CreateBoughtGoodieAtRandom()
			else
				//Too many items, remove one at random
				RemoveBoughtGoodieAtRandom()

		//Randomness for the sake of randomeness
		if(prob(TRADER_WILDCARD_STOCK_ROTATE_CHANCE))
			if(prob(50))
				CreateBoughtGoodieAtRandom()
			else
				RemoveBoughtGoodieAtRandom()

/datum/trader/proc/CreateSoldGoodieAtRandom()
	for(var/i in 1 to TRADER_ROTATE_STOCK_TRIES)
		var/picked_type = pick(possible_sold_goods)
		if(!sold_goods[picked_type])
			CreateSoldGoodieType(picked_type)
			break

/datum/trader/proc/RemoveSoldGoodieAtRandom()
	if(!sold_goods.len)
		return
	var/picked_type = pick(sold_goods)
	RemoveSoldGoodieType(picked_type)

/datum/trader/proc/CreateBoughtGoodieAtRandom()
	for(var/i in 1 to TRADER_ROTATE_STOCK_TRIES)
		var/picked_type = pick(possible_bought_goods)
		if(!bought_goods[picked_type])
			CreateBoughtGoodieType(picked_type)
			break

/datum/trader/proc/RemoveBoughtGoodieAtRandom()
	if(!bought_goods.len)
		return
	var/picked_type = pick(bought_goods)
	RemoveBoughtGoodieType(picked_type)

/datum/trader/proc/CreateSoldGoodieType(passed_type)
	sold_goods[passed_type] = new passed_type(TRADER_COST_MACRO(sell_margin,price_variance), quantity_multiplier)

/datum/trader/proc/CreateBoughtGoodieType(passed_type)
	bought_goods[passed_type] = new passed_type(TRADER_COST_MACRO(buy_margin,price_variance), quantity_multiplier)

/datum/trader/proc/RemoveSoldGoodieType(passed_type)
	qdel(sold_goods[passed_type])
	sold_goods -= passed_type

/datum/trader/proc/RemoveBoughtGoodieType(passed_type)
	qdel(bought_goods[passed_type])
	bought_goods -= passed_type

/datum/trader/proc/RemoveAllStock()
	for(var/goodie_type in sold_goods)
		RemoveSoldGoodieType(goodie_type)
	for(var/goodie_type in bought_goods)
		RemoveBoughtGoodieType(goodie_type)

/datum/trader/Destroy()
	RemoveAllStock()
	possible_sold_goods = null
	sold_goods = null
	possible_bought_goods = null
	bought_goods = null

	for(var/i in connected_consoles)
		var/obj/machinery/computer/trade_console/console = i
		console.disconnect_trader()
	connected_consoles = null

	hub.traders -= src
	hub = null

	SStrading.all_traders -= "[id]"
	return ..()
