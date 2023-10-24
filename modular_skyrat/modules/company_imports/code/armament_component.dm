#define MAX_AMMO_AMOUNT 10
#define CARGO_CONSOLE 1
#define IRN_CONSOLE 2

/datum/component/armament/company_imports
	/// Selected amount of ammo to purchase
	var/ammo_purchase_num = 1
	/// Is this set to private order
	var/self_paid = FALSE
	/// Cooldown to announce a requested order
	COOLDOWN_DECLARE(radio_cooldown)
	/// To cut down on redundant istypes(), what this component is attached to
	var/console_state = null
	/// If this is a tablet, the parent budgetordering
	var/datum/computer_file/program/budgetorders/parent_prog

/datum/component/armament/company_imports/Initialize(list/required_products, list/needed_access)
	. = ..()
	if(istype(parent, /obj/machinery/computer/cargo))
		console_state = CARGO_CONSOLE
	else if(istype(parent, /obj/item/modular_computer))
		console_state = IRN_CONSOLE

/datum/component/armament/company_imports/Destroy(force, silent)
	parent_prog = null
	. = ..()

/datum/component/armament/company_imports/on_attack_hand(datum/source, mob/living/user)
	return

/datum/component/armament/company_imports/on_attackby(atom/target, obj/item, mob/user)
	return

/datum/component/armament/company_imports/ui_data(mob/user)
	var/list/data = list()

	var/mob/living/carbon/human/the_person = user
	var/obj/item/card/id/id_card
	var/datum/bank_account/buyer = SSeconomy.get_dep_account(ACCOUNT_CAR)

	if(console_state == IRN_CONSOLE)
		id_card = parent_prog.computer.computer_id_slot?.GetID()
	else
		if(istype(the_person))
			id_card = the_person.get_idcard(TRUE)

	var/budget_name = "Cargo Budget"

	if(id_card?.registered_account && (console_state == IRN_CONSOLE))
		if((ACCESS_COMMAND in id_card.access) || (ACCESS_QM in id_card.access))
			parent_prog.requestonly = FALSE
			buyer = SSeconomy.get_dep_account(id_card.registered_account?.account_job.paycheck_department)
			parent_prog.can_approve_requests = TRUE
		else
			parent_prog.requestonly = TRUE
			parent_prog.can_approve_requests = FALSE
	else
		parent_prog?.requestonly = TRUE

	if(id_card)
		budget_name = self_paid ? id_card.name : buyer.account_holder

	data["budget_name"] = budget_name

	var/cant_buy_restricted = TRUE

	if(console_state == CARGO_CONSOLE)
		var/obj/machinery/computer/cargo/console = parent
		if(!console.requestonly)
			cant_buy_restricted = FALSE

	else if((console_state == IRN_CONSOLE) && id_card?.registered_account)
		if((ACCESS_COMMAND in id_card.access) || (ACCESS_QM in id_card.access))
			if((buyer == SSeconomy.get_dep_account(id_card.registered_account.account_job.paycheck_department)) && !self_paid)
				cant_buy_restricted = FALSE

	data["cant_buy_restricted"] = !!cant_buy_restricted
	data["budget_points"] = self_paid ? id_card?.registered_account?.account_balance : buyer?.account_balance
	data["ammo_amount"] = ammo_purchase_num
	data["self_paid"] = !!self_paid
	data["armaments_list"] = list()

	for(var/armament_category as anything in SSarmaments.entries)

		var/list/armament_subcategories = list()

		for(var/subcategory as anything in SSarmaments.entries[armament_category][CATEGORY_ENTRY])
			var/list/subcategory_items = list()
			for(var/datum/armament_entry/armament_entry as anything in SSarmaments.entries[armament_category][CATEGORY_ENTRY][subcategory])
				if(products && !(armament_entry.type in products))
					continue

				var/datum/armament_entry/company_import/gun_entry = armament_entry

				if(gun_entry.contraband)
					if(!(console_state == CARGO_CONSOLE))
						continue
					var/obj/machinery/computer/cargo/parent_console = parent
					if(!parent_console.contraband)
						continue

				subcategory_items += list(list(
					"ref" = REF(armament_entry),
					"icon" = armament_entry.cached_base64,
					"name" = armament_entry.name,
					"cost" = armament_entry.cost,
					"buyable_ammo" = armament_entry.magazine ? TRUE : FALSE,
					"magazine_cost" = armament_entry.magazine_cost,
					"purchased" = purchased_items[armament_entry] ? purchased_items[armament_entry] : 0,
					"description" = armament_entry.description,
					"armament_category" = armament_entry.category,
					"equipment_subcategory" = armament_entry.subcategory,
					"restricted" = !!armament_entry.restricted,
				))

			if(!LAZYLEN(subcategory_items))
				continue

			armament_subcategories += list(list(
				"subcategory" = subcategory,
				"items" = subcategory_items,
			))

		if(!LAZYLEN(armament_subcategories))
			continue

		data["armaments_list"] += list(list(
			"category" = armament_category,
			"category_uses" = used_categories[armament_category],
			"subcategories" = armament_subcategories,
		))

	return data

/datum/component/armament/company_imports/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CargoImportConsole")
		ui.open()

/datum/component/armament/company_imports/select_armament(mob/user, datum/armament_entry/company_import/armament_entry)
	var/datum/bank_account/buyer = SSeconomy.get_dep_account(ACCOUNT_CAR)
	var/obj/item/modular_computer/possible_downloader
	var/obj/machinery/computer/cargo/possible_console

	if(console_state == CARGO_CONSOLE)
		possible_console = parent

	else if(console_state == IRN_CONSOLE)
		possible_downloader = parent

	if(!istype(armament_entry))
		return

	var/mob/living/carbon/human/the_person = user

	if(istype(the_person))

		var/obj/item/card/id/id_card

		if(console_state == IRN_CONSOLE)
			id_card = parent_prog.computer.computer_id_slot?.GetID()
		else
			id_card = the_person.get_idcard(TRUE)

		if(id_card?.registered_account && (console_state == IRN_CONSOLE))
			if((ACCESS_COMMAND in id_card.access) || (ACCESS_QM in id_card.access))
				parent_prog.requestonly = FALSE
				buyer = SSeconomy.get_dep_account(id_card.registered_account.account_job.paycheck_department)
				parent_prog.can_approve_requests = TRUE
			else
				parent_prog.requestonly = TRUE
				parent_prog.can_approve_requests = FALSE
		else
			parent_prog?.requestonly = TRUE

		if(self_paid)
			if(!istype(id_card))
				to_chat(user, span_warning("No ID card detected."))
				return

			if(istype(id_card, /obj/item/card/id/departmental_budget))
				to_chat(user, span_warning("[id_card] cannot be used to make purchases."))
				return

			var/datum/bank_account/account = id_card.registered_account

			if(!istype(account))
				to_chat(user, span_warning("Invalid bank account."))
				return

			buyer = account

	if(issilicon(user) && (console_state == IRN_CONSOLE))
		parent_prog.can_approve_requests = TRUE
		parent_prog.requestonly = FALSE

	if(!buyer)
		to_chat(user, span_warning("No budget found!"))
		return

	if(!ishuman(user) && !issilicon(user))
		return

	if(!buyer.has_money(armament_entry.cost))
		to_chat(user, span_warning("Not enough money!"))
		return

	var/name

	if(issilicon(user))
		name = user.real_name
	else
		the_person.get_authentification_name()

	var/reason = ""

	if(possible_console)
		if(possible_console.requestonly && !self_paid)
			reason = tgui_input_text(user, "Reason", name)
			if(isnull(reason))
				return

	else if(possible_downloader)
		var/datum/computer_file/program/budgetorders/parent_file = parent_prog
		if((parent_file.requestonly && !self_paid) || !(possible_downloader.computer_id_slot?.GetID()))
			reason = tgui_input_text(user, "Reason", name)
			if(isnull(reason))
				return

	used_categories[armament_entry.category]++

	purchased_items[armament_entry]++

	var/datum/supply_pack/armament/created_pack = new
	created_pack.name = initial(armament_entry.item_type.name)
	created_pack.cost = cost_calculate(armament_entry.cost) //Paid for seperately
	created_pack.contains = list(armament_entry.item_type)

	var/rank

	if(issilicon(user))
		rank = "Silicon"
	else
		rank = the_person.get_assignment(hand_first = TRUE)

	var/ckey = user.ckey

	var/datum/supply_order/company_import/created_order
	if(buyer != SSeconomy.get_dep_account(ACCOUNT_CAR))
		created_order = new(created_pack, name, rank, ckey, paying_account = buyer, reason = reason, can_be_cancelled = TRUE)
	else
		created_pack.goody = FALSE // Cargo ordered stuff should just show up in a box I think
		created_order = new(created_pack, name, rank, ckey, reason = reason, can_be_cancelled = TRUE)
	created_order.selected_entry = armament_entry
	created_order.used_component = src
	if(console_state == CARGO_CONSOLE)
		created_order.generateRequisition(get_turf(parent))
		if(possible_console.requestonly && !self_paid)
			SSshuttle.request_list += created_order
		else
			SSshuttle.shopping_list += created_order
	else if(console_state == IRN_CONSOLE)
		var/datum/computer_file/program/budgetorders/comp_file = parent_prog
		created_order.generateRequisition(get_turf(parent))
		if(comp_file.requestonly && !self_paid)
			SSshuttle.request_list += created_order
		else
			SSshuttle.shopping_list += created_order

/datum/component/armament/company_imports/proc/cost_calculate(cost)
	. = cost
	. *= SSeconomy.pack_price_modifier

/datum/component/armament/company_imports/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("toggleprivate")
			var/obj/item/card/id/id_card
			var/mob/living/carbon/human/the_person = usr

			if(!istype(the_person))
				if(issilicon(the_person))
					self_paid = FALSE
				return

			if(console_state == IRN_CONSOLE)
				id_card = parent_prog.computer.computer_id_slot?.GetID()
			else
				id_card = the_person.get_idcard(TRUE)

			if(!id_card)
				return

			self_paid = !self_paid

#undef MAX_AMMO_AMOUNT
#undef CARGO_CONSOLE
#undef IRN_CONSOLE
