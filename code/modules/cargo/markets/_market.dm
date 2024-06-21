/datum/market
	/// Name for the market.
	var/name = "huh?"

	/// Available shipping methods and prices, just leave the shipping method out that you don't want to have.
	var/list/shipping

	// Automatic vars, do not touch these.
	/// Items available from this market, populated by SSblackmarket on initialization. Automatically assigned, so don't manually adjust.
	var/list/available_items = list()
	/// Item categories available from this market, only items which are in these categories can be gotten from this market. Automatically assigned, so don't manually adjust.
	var/list/categories = list()

/// Adds item to the available items and add it's category if it is not in categories yet.
/datum/market/proc/add_item(datum/market_item/item)
	if(ispath(item, /datum/market_item))
		item = new item()

	if(!(item.category in categories))
		categories += item.category
		available_items[item.category] = list()

	available_items[item.category][item.identifier] = item
	RegisterSignal(item, COMSIG_QDELETING, PROC_REF(on_item_del))
	return TRUE

/datum/market/proc/on_item_del(datum/market_item/item)
	SIGNAL_HANDLER
	available_items[item.category] -= item.identifier
	if(!length(available_items[item.category]))
		available_items -= item.category

/// Handles buying the item, this is mainly for future use and moving the code away from the uplink.
/datum/market/proc/purchase(identifier, category, method, obj/item/market_uplink/uplink, user)
	var/datum/market_item/item = available_items[category][identifier]
	if(isnull(item))
		return FALSE

	if(!istype(uplink) || !((method in shipping) || (method in item.shipping_override)))
		return FALSE

	var/shipment_fee = item.shipping_override?[method]
	if(isnull(shipment_fee))
		shipment_fee = shipping[method]
	var/price = item.price + shipment_fee

	if(!uplink.current_user)///There is no ID card on the user, or the ID card has no account
		to_chat(user, span_warning("The uplink sparks, as it can't identify an ID card with a bank account on you."))
		return FALSE
	var/balance = uplink?.current_user.account_balance

	// I can't get the price of the item and shipping in a clean way to the UI, so I have to do this.
	if(balance < price)
		to_chat(user, span_warning("You don't have enough credits in [uplink] for [item] with [method] shipping."))
		return FALSE

	if(item.buy(uplink, user, method))
		uplink.current_user.adjust_money(-price, "Other: Third Party Transaction")
		if(ismob(user))
			var/mob/m_user = user
			m_user.playsound_local(get_turf(m_user), 'sound/machines/twobeep_high.ogg', 50, TRUE)
		return TRUE

	return FALSE

/datum/market/blackmarket
	name = "Black Market"
	shipping = list(
		SHIPPING_METHOD_LTSRBT = 40,
		SHIPPING_METHOD_LAUNCH = 10,
		SHIPPING_METHOD_TELEPORT= 75,
	)
