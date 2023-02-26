#define POINTS_PER_DOLLAR 0.5

/datum/computer_file/program/armadyne_purchase
	filename = "ArmadyneCatalogue"
	filedesc = "Armadyne Catalogue"
	category = PROGRAM_CATEGORY_MISC
	program_icon_state = "assign"
	extended_desc = "An orderable catalogue usable by authorized personnel to purchase Armadyne-brand weaponry."
	size = 8
	available_on_ntnet = FALSE
	undeletable = TRUE
	tgui_id = "NtosArmadyneCatalogue"
	program_icon = "check"
	/// A dict of order datums that the catalogue draws from, name:datum
	var/static/list/order_datums = list()
	/// How many points this currently has (inputting money gains points, but they also passively increase over time)
	var/point_count = 0
	/// How many points this gains per tick (2s)
	var/point_gain = 1
	/// How much money this can take in at once
	var/max_money = 500
	/// How much money the rep's inserted that hasn't decayed yet
	var/money = 0
	/// How much the inputted money decays by per tick (one tick is 2s)
	var/money_decay = 2
	/// Ref to the radio the catalogue uses to yell at cargo
	var/obj/item/radio/headset/headset_cargo/radio

/datum/computer_file/program/armadyne_purchase/New()
	. = ..()
	radio = new(computer)
	radio.set_frequency(FREQ_SUPPLY)
	radio.subspace_transmission = TRUE
	radio.canhear_range = 0
	radio.recalculateChannels()

	START_PROCESSING(SSobj, src)

	if(!length(order_datums))
		for(var/type in subtypesof(/datum/armadyne_order))
			var/datum/armadyne_order/order_datum = new type
			order_datums[order_datum.name] = order_datum


/datum/computer_file/program/armadyne_purchase/Destroy(force)
	QDEL_NULL(radio)
	return ..()


/datum/computer_file/program/armadyne_purchase/process(delta_time)
	point_count += (point_gain * delta_time)
	if(money)
		money = clamp(money - money_decay, 0, max_money)


/datum/computer_file/program/armadyne_purchase/on_start(mob/living/user)
	. = ..(user)


/datum/computer_file/program/armadyne_purchase/ui_act(action, params)
	. = ..()
	if(.)
		return

	switch(action)
		if("loadcash")
			if(!computer?.computer_id_slot?.registered_account)
				return

			var/money_can_take = round(clamp(max_money - money, 0, computer.computer_id_slot.registered_account.account_balance))
			if(money_can_take <= 0)
				return

			money += money_can_take
			point_count += round(money_can_take * POINTS_PER_DOLLAR)

			computer.computer_id_slot.registered_account.adjust_money(-money_can_take, "Armadyne credit-to-point transfer")
			computer.say("$[money_can_take] has been removed from the account of [computer.computer_id_slot.registered_account.account_holder] in exchange for [round(money_can_take * POINTS_PER_DOLLAR)] points.")

		if("purchase")
			var/order_name = params["orderName"]

			if(!(order_name in order_datums))
				return

			var/datum/armadyne_order/order = order_datums[order_name]

			if(point_count < order.cost)
				return

			order_object(order, usr)



/datum/computer_file/program/armadyne_purchase/ui_data(mob/user)
	var/list/data = get_header_data()
	update_computer_icon()

	data["points"] = point_count
	data["money"] = money
	data["money_max"] = max_money
	data["card_inserted"] = !!computer.computer_id_slot

	return data


/datum/computer_file/program/armadyne_purchase/ui_static_data(mob/user)
	var/list/data = list()

	var/list/order_list = list()

	for(var/order_name in order_datums)
		var/datum/armadyne_order/armadyne_order = order_datums[order_name]
		order_list += list(list(
			"name" = armadyne_order.name,
			"desc" = armadyne_order.desc,
			"cost" = armadyne_order.cost,
			"string_contents" = armadyne_order.string_order_contents,
		))

	data["orders"] = order_list

	return data


/// Creates a new supply pack from an order datum
/datum/computer_file/program/armadyne_purchase/proc/order_object(datum/armadyne_order/order, mob/user)
	var/datum/supply_pack/custom/object_pack = new(
		purchaser = user,
		cost = 0,
		contains = order.order_contents,
	)
	object_pack.name = "[user]'s Armadyne supply crate"
	object_pack.crate_type = /obj/structure/closet/crate/secure/armadyne
	object_pack.crate_name = "\improper Armadyne supply crate"
	object_pack.access = ACCESS_ARMADYNE

	var/datum/supply_order/new_order = new(
		pack = object_pack,
		orderer = user,
		orderer_rank = "Armadyne Catalogue",
		orderer_ckey = user.ckey,
		reason = "",
		department_destination = null,
		coupon = null,
		charge_on_purchase = FALSE,
		manifest_can_fail = FALSE,
		cost_type = "cr",
		can_be_cancelled = FALSE,
	)

	computer.say("The purchase will arrive under Armadyne access-lock on the next cargo shuttle.")
	radio.talk_into(computer, "A secure order will be arriving with the next cargo shuttle, ensure it reaches the Armadyne Representative.", RADIO_CHANNEL_SUPPLY)
	SSshuttle.shopping_list += new_order

	point_count -= order.cost



/obj/structure/closet/crate/secure/armadyne
	name = "\improper Armadyne supply crate"
	desc = "A crate stamped with the logo of the Armadyne corporation."
	icon_state = "weaponcrate"
	req_access = list(ACCESS_ARMADYNE)

#undef POINTS_PER_DOLLAR
