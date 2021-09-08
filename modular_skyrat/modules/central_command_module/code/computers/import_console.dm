GLOBAL_LIST_EMPTY(cargo_control_consoles)

/obj/machinery/computer/cargo_control_console
	name = "NCV Titan Cargo Console"
	desc = "A console used for processing requests from the staton."
	icon_screen = "comm"
	icon_keyboard = "tech_key"
	req_access = list(ACCESS_CENT_CAPTAIN)
	circuit = /obj/item/circuitboard/computer/cargo_control_console
	light_color = LIGHT_COLOR_BLUE

	/// radio used by the console to send messages on supply channel
	var/obj/item/radio/headset/radio

	var/list/possible_floors = list()

/obj/machinery/computer/cargo_control_console/Initialize()
	. = ..()
	radio = new /obj/item/radio/headset/headset_cargo(src)
	GLOB.cargo_control_consoles += src
	for(var/area/centcom/ncvtitan/import_bay/iterating_import_bay in world)
		for(var/turf/open/floor/iterating_floor in iterating_import_bay)
			possible_floors += iterating_floor

/obj/machinery/computer/cargo_control_console/Destroy()
	if(radio)
		QDEL_NULL(radio)
	GLOB.cargo_control_consoles -= src
	possible_floors = null
	. = ..()


/obj/item/circuitboard/computer/cargo_control_console
	name = "Cargo Console (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/cargo_control_console

/obj/machinery/computer/cargo_control_console/ui_interact(mob/user)
	var/list/dat = list("<b>CARGOSYS 3000</b>")
	var/manual_operation = SSshuttle.supply.manual_operation
	if(manual_operation)
		dat += "REQUESTED ITEMS:"
		if(SSshuttle.requestlist.len)
			dat += "<select name='requested_items' size='number_of_options' multiple='multiple'>"
			for(var/datum/supply_order/SO in SSshuttle.requestlist)
				dat += "<option value='[SO.pack.id]'>[SO.pack.name] requested by [SO.orderer]</option>"
			dat += "</select>"
		else
			dat += " - NONE"
		dat += "PURCHASED ITEMS:"
		if(SSshuttle.shoppinglist.len)
			dat += "<select name='purchased_items' size='number_of_options' multiple='multiple'>"
			for(var/datum/supply_order/SO in SSshuttle.shoppinglist)
				dat += "<option value='[SO.pack.id]'>[SO.pack.name] purchased by [SO.orderer]</option>"
			dat += "</select>"
			dat += "<a href='byond://?src=[REF(src)];function=purchase'>PROCESS PURCHASE LIST</a>"
		else
			dat += " - NONE"
	else
		dat += "MANUAL SHUTTLE OPERATION IS REQUIRED TO USE THIS TERMINAL."


	var/datum/browser/popup = new(user, "cargo_console","Cargo Console", 600, 400, src)
	popup.set_content(dat.Join("<br>"))
	popup.open()
	onclose(user, "cargo_console")

/obj/machinery/computer/cargo_control_console/Topic(href, href_list)
	if(..())
		return

	if(machine_stat & (NOPOWER|BROKEN|MAINT))
		return

	usr.set_machine(src)

	var/function = href_list["function"]

	if(href_list["close"])
		usr << browse(null, "window=cargo_console")
		return

	switch(function)
		if("purchase")
			if(!SSshuttle.supply.manual_operation)
				say("Manual shuttle operation required.")
				return
			buy()
			create_mail()
			radio.talk_into(src, "NCV Titan has processed your purchase list, they will deliver it shortly.", RADIO_CHANNEL_SUPPLY)
	updateUsrDialog()

/obj/machinery/computer/cargo_control_console/proc/create_mail()
	//Early return if there's no mail waiting to prevent taking up a slot. We also don't send mails on sundays or holidays.
	if(!SSeconomy.mail_waiting || SSeconomy.mail_blocked)
		return

	//spawn crate
	var/list/empty_turfs = list()
	for(var/turf/open/floor/iterating_floor in possible_floors)
		if(iterating_floor.is_blocked_turf())
			continue
		empty_turfs += iterating_floor


	new /obj/structure/closet/crate/mail/economy(pick(empty_turfs))


/obj/machinery/computer/cargo_control_console/proc/buy()
	var/list/obj/miscboxes = list() //miscboxes are combo boxes that contain all goody orders grouped
	var/list/misc_order_num = list() //list of strings of order numbers, so that the manifest can show all orders in a box
	var/list/misc_contents = list() //list of lists of items that each box will contain
	var/list/misc_costs = list() //list of overall costs sustained by each buyer.

	var/list/empty_turfs = list()
	for(var/turf/open/floor/iterating_floor in possible_floors)
		if(iterating_floor.is_blocked_turf())
			continue
		empty_turfs += iterating_floor

	//quickly and greedily handle chef's grocery runs first, there are a few reasons why this isn't attached to the rest of cargo...
	//but the biggest reason is that the chef requires produce to cook and do their job, and if they are using this system they
	//already got let down by the botanists. So to open a new chance for cargo to also screw them over any more than is necessary is bad.
	if(SSshuttle.chef_groceries.len)
		var/obj/structure/closet/crate/freezer/grocery_crate = new(pick_n_take(empty_turfs))
		grocery_crate.name = "kitchen produce freezer"
		investigate_log("Chef's [SSshuttle.chef_groceries.len] sized produce order arrived. Cost was deducted from orderer, not cargo.", INVESTIGATE_CARGO)
		for(var/datum/orderable_item/item as anything in SSshuttle.chef_groceries)//every order
			for(var/amt in 1 to SSshuttle.chef_groceries[item])//every order amount
				new item.item_instance.type(grocery_crate)
		SSshuttle.chef_groceries.Cut() //This lets the console know it can order another round.

	if(!SSshuttle.shoppinglist.len)
		return

	var/value = 0
	var/purchases = 0
	var/list/goodies_by_buyer = list() // if someone orders more than GOODY_FREE_SHIPPING_MAX goodies, we upcharge to a normal crate so they can't carry around 20 combat shotties

	for(var/datum/supply_order/SO in SSshuttle.shoppinglist)
		if(!empty_turfs.len)
			break
		var/price = SO.pack.get_cost()
		if(SO.applied_coupon)
			price *= (1 - SO.applied_coupon.discount_pct_off)

		var/datum/bank_account/D
		if(SO.paying_account) //Someone paid out of pocket
			D = SO.paying_account
			var/list/current_buyer_orders = goodies_by_buyer[SO.paying_account] // so we can access the length a few lines down
			if(!SO.pack.goody)
				price *= 1.1 //TODO make this customizable by the quartermaster

			// note this is before we increment, so this is the GOODY_FREE_SHIPPING_MAX + 1th goody to ship. also note we only increment off this step if they successfully pay the fee, so there's no way around it
			else if(LAZYLEN(current_buyer_orders) == 5)
				price += 700
				D.bank_card_talk("Goody order size exceeds free shipping limit: Assessing [700] credit S&H fee.")
		else
			D = SSeconomy.get_dep_account(ACCOUNT_CAR)
		if(D)
			if(!D.adjust_money(-price))
				if(SO.paying_account)
					D.bank_card_talk("Cargo order #[SO.id] rejected due to lack of funds. Credits required: [price]")
				continue

		if(SO.paying_account)
			if(SO.pack.goody)
				LAZYADD(goodies_by_buyer[SO.paying_account], SO)
			D.bank_card_talk("Cargo order #[SO.id] has shipped. [price] credits have been charged to your bank account.")
			var/datum/bank_account/department/cargo = SSeconomy.get_dep_account(ACCOUNT_CAR)
			cargo.adjust_money(price - SO.pack.get_cost()) //Cargo gets the handling fee
		value += SO.pack.get_cost()
		SSshuttle.shoppinglist -= SO
		SSshuttle.orderhistory += SO
		QDEL_NULL(SO.applied_coupon)

		if(!SO.pack.goody) //we handle goody crates below
			SO.generate(pick_n_take(empty_turfs))

		SSblackbox.record_feedback("nested tally", "cargo_imports", 1, list("[SO.pack.get_cost()]", "[SO.pack.name]"))
		investigate_log("Order #[SO.id] ([SO.pack.name], placed by [key_name(SO.orderer_ckey)]), paid by [D.account_holder] has shipped.", INVESTIGATE_CARGO)
		if(SO.pack.dangerous)
			message_admins("\A [SO.pack.name] ordered by [ADMIN_LOOKUPFLW(SO.orderer_ckey)], paid by [D.account_holder] has shipped.")
		purchases++

	// we handle packing all the goodies last, since the type of crate we use depends on how many goodies they ordered. If it's more than GOODY_FREE_SHIPPING_MAX
	// then we send it in a crate (including the CRATE_TAX cost), otherwise send it in a free shipping case
	for(var/D in goodies_by_buyer)
		var/list/buying_account_orders = goodies_by_buyer[D]
		var/datum/bank_account/buying_account = D
		var/buyer = buying_account.account_holder

		if(buying_account_orders.len > 5) // no free shipping, send a crate
			var/obj/structure/closet/crate/secure/owned/our_crate = new /obj/structure/closet/crate/secure/owned(pick_n_take(empty_turfs))
			our_crate.buyer_account = buying_account
			our_crate.name = "goody crate - purchased by [buyer]"
			miscboxes[buyer] = our_crate
		else //free shipping in a case
			miscboxes[buyer] = new /obj/item/storage/lockbox/order(pick_n_take(empty_turfs))
			var/obj/item/storage/lockbox/order/our_case = miscboxes[buyer]
			our_case.buyer_account = buying_account
			miscboxes[buyer].name = "goody case - purchased by [buyer]"
		misc_contents[buyer] = list()

		for(var/O in buying_account_orders)
			var/datum/supply_order/our_order = O
			for (var/item in our_order.pack.contains)
				misc_contents[buyer] += item
			misc_costs[buyer] += our_order.pack.cost
			misc_order_num[buyer] = "[misc_order_num[buyer]]#[our_order.id]  "

	for(var/I in miscboxes)
		var/datum/supply_order/SO = new/datum/supply_order()
		SO.id = misc_order_num[I]
		SO.generateCombo(miscboxes[I], I, misc_contents[I], misc_costs[I])
		qdel(SO)

	SSeconomy.import_total += value
	var/datum/bank_account/cargo_budget = SSeconomy.get_dep_account(ACCOUNT_CAR)
	investigate_log("[purchases] orders in this shipment, worth [value] credits. [cargo_budget.account_balance] credits left.", INVESTIGATE_CARGO)

/obj/machinery/computer/cargo_control_console/proc/notify_order(datum/supply_order/SO)
	say("New order recieved!")
	playsound(src, 'sound/machines/ping.ogg')
	SO.generateRequisition(get_turf(src))
