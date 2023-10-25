/obj/item/paper/paperslip/ration_ticket
	name = "ration ticket - standard"
	desc = "A little slip of paper that'll slot right into any cargo console and put your alotted food ration on the next shuttle to the station."
	icon = 'modular_skyrat/modules/paycheck_rations/icons/tickets.dmi'
	icon_state = "ticket_food"
	default_raw_text = "Redeem this ticket in the nearest supply console to recieve benefits."
	color = COLOR_OFF_WHITE
	show_written_words = FALSE
	/// The finalized list of items we send once the ticket is used, don't define here, the procs will do it
	var/list/items_we_deliver = list()

/obj/item/paper/paperslip/ration_ticket/attack_atom(obj/machinery/computer/cargo/object_we_attack, mob/living/user, params)
	if(!istype(object_we_attack))
		return ..()
	if(!object_we_attack.is_operational || !user.can_perform_action(object_we_attack))
		return ..()

	try_to_make_ration_order_list(object_we_attack, user)

/// Attempts to fill out the order list with items of the user's choosing, will stop in its tracks if it fails
/obj/item/paper/paperslip/ration_ticket/proc/try_to_make_ration_order_list(obj/machinery/computer/cargo/object_we_attack, mob/living/user)
	forceMove(object_we_attack)

	// List of meat options we get
	var/list/radial_meat_options = list(
		"Standard Meats" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "meats"),
		"Seafood Meats" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "meats_fish"),
		"Tizirian Meats" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "meats_lizard"),
	)

	var/meats_choice = show_radial_menu(user, object_we_attack, radial_meat_options, require_near = TRUE)

	if(!meats_choice)
		object_we_attack.balloon_alert(user, "no selection made")
		forceMove(drop_location(object_we_attack))
		return

	switch(meats_choice)
		if("Standard Meats")
			items_we_deliver += /obj/item/storage/box/spaceman_ration/meats
		if("Seafood Meats")
			items_we_deliver += /obj/item/storage/box/spaceman_ration/meats/fish
		if("Tizirian Meats")
			items_we_deliver += /obj/item/storage/box/spaceman_ration/meats/lizard

	// List of produce options we get
	var/list/radial_produce_options = list(
		"Standard Produce" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "plants"),
		"Alternative Produce" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "plants_alt"),
		"Mothic Produce" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "plants_moth"),
		"Tizirian Produce" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "plants_lizard"),
	)

	var/produce_choice = show_radial_menu(user, object_we_attack, radial_produce_options, require_near = TRUE)

	if(!produce_choice)
		object_we_attack.balloon_alert(user, "no selection made")
		// Reset the list if we fail
		items_we_deliver = list()
		forceMove(drop_location(object_we_attack))

	switch(produce_choice)
		if("Standard Produce")
			items_we_deliver += /obj/item/storage/box/spaceman_ration/plants
		if("Alternative Produce")
			items_we_deliver += /obj/item/storage/box/spaceman_ration/plants/alternate
		if("Mothic Produce")
			items_we_deliver += /obj/item/storage/box/spaceman_ration/plants/mothic
		if("Tizirian Produce")
			items_we_deliver += /obj/item/storage/box/spaceman_ration/plants/lizard

	items_we_deliver += /obj/item/storage/box/papersack/ration_bread_slice

	// List of flour options we get
	var/list/radial_flour_options = list(
		"Standard Flour" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "flour"),
		"Korta Flour" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "flour_korta"),
	)

	var/flour_choice = show_radial_menu(user, object_we_attack, radial_flour_options, require_near = TRUE)

	if(!flour_choice)
		object_we_attack.balloon_alert(user, "no selection made")
		// Reset the list if we fail
		items_we_deliver = list()
		forceMove(drop_location(object_we_attack))

	switch(flour_choice)
		if("Standard Flour")
			items_we_deliver += /obj/item/reagent_containers/condiment/flour/small_ration
		if("Korta Flour")
			items_we_deliver += /obj/item/reagent_containers/condiment/small_ration_korta_flour
			items_we_deliver += /obj/item/reagent_containers/condiment/soymilk/small_ration

	items_we_deliver += /obj/item/reagent_containers/condiment/rice/small_ration
	items_we_deliver += /obj/item/reagent_containers/condiment/sugar/small_ration
	items_we_deliver += /obj/item/reagent_containers/cup/glass/bottle/small/tiny/lime_juice
	items_we_deliver += /obj/item/reagent_containers/cup/glass/bottle/small/tiny/vinegar

	items_we_deliver += /obj/item/reagent_containers/cup/glass/waterbottle

	var/random_drink = pick( \
		/obj/item/reagent_containers/cup/glass/waterbottle/tea, \
		/obj/item/reagent_containers/cup/glass/waterbottle/tea/mushroom, \
		/obj/item/reagent_containers/cup/glass/waterbottle/tea/astra, \
		/obj/item/reagent_containers/cup/glass/coffee, \
	)
	items_we_deliver += random_drink

	make_the_actual_order(object_we_attack, user)

/// Takes the list of things to deliver and puts it into a cargo order
/obj/item/paper/paperslip/ration_ticket/proc/make_the_actual_order(obj/machinery/computer/cargo/object_we_attack, mob/user)
	var/datum/supply_pack/custom/ration_pack/ration_pack = new(
		purchaser = user, \
		cost = 0, \
		contains = items_we_deliver,
	)
	var/datum/supply_order/new_order = new(
		pack = ration_pack,
		orderer = user,
		orderer_rank = "Ration Ticket",
		orderer_ckey = user.ckey,
		reason = "",
		paying_account = null,
		department_destination = null,
		coupon = null,
		charge_on_purchase = FALSE,
		manifest_can_fail = FALSE,
		can_be_cancelled = FALSE,
	)
	object_we_attack.say("Ration order placed! It will arrive on the next cargo shuttle!")
	SSshuttle.shopping_list += new_order

/datum/supply_pack/custom/ration_pack
	name = "rations order"
	crate_name = "ration delivery crate"
	access = list()
	crate_type = /obj/structure/closet/crate/cardboard

/datum/supply_pack/custom/ration_pack/New(purchaser, cost, list/contains)
	. = ..()
	name = "[purchaser]'s Rations Order"
	crate_name = "[purchaser]'s ration delivery crate"
	src.cost = cost
	src.contains = contains

// Ticket for some luxury items, which you get every second paycheck

/obj/item/paper/paperslip/ration_ticket/luxury
	name = "ration ticket - luxury"
	desc = "A little slip of paper that'll slot right into any cargo console and put your alotted ration of luxury goods on the next cargo shuttle to the station."
	icon_state = "ticket_luxury"

/// Attempts to fill out the order list with items of the user's choosing, will stop in its tracks if it fails
/obj/item/paper/paperslip/ration_ticket/luxury/try_to_make_ration_order_list(obj/machinery/computer/cargo/object_we_attack, mob/living/user)
	forceMove(object_we_attack)

	// List of meat options we get
	var/list/radial_meat_options = list(
		"Standard Meats" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "meats"),
		"Seafood Meats" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "meats_fish"),
		"Tizirian Meats" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "meats_lizard"),
	)

	var/meats_choice = show_radial_menu(user, object_we_attack, radial_meat_options, require_near = TRUE)

	if(!meats_choice)
		object_we_attack.balloon_alert(user, "no selection made")
		forceMove(drop_location(object_we_attack))
		return

	switch(meats_choice)
		if("Standard Meats")
			items_we_deliver += /obj/item/storage/box/spaceman_ration/meats
		if("Seafood Meats")
			items_we_deliver += /obj/item/storage/box/spaceman_ration/meats/fish
		if("Tizirian Meats")
			items_we_deliver += /obj/item/storage/box/spaceman_ration/meats/lizard

	// List of produce options we get
	var/list/radial_produce_options = list(
		"Standard Produce" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "plants"),
		"Alternative Produce" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "plants_alt"),
		"Mothic Produce" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "plants_moth"),
		"Tizirian Produce" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "plants_lizard"),
	)

	var/produce_choice = show_radial_menu(user, object_we_attack, radial_produce_options, require_near = TRUE)

	if(!produce_choice)
		object_we_attack.balloon_alert(user, "no selection made")
		// Reset the list if we fail
		items_we_deliver = list()
		forceMove(drop_location(object_we_attack))

	switch(produce_choice)
		if("Standard Produce")
			items_we_deliver += /obj/item/storage/box/spaceman_ration/plants
		if("Alternative Produce")
			items_we_deliver += /obj/item/storage/box/spaceman_ration/plants/alternate
		if("Mothic Produce")
			items_we_deliver += /obj/item/storage/box/spaceman_ration/plants/mothic
		if("Tizirian Produce")
			items_we_deliver += /obj/item/storage/box/spaceman_ration/plants/lizard

	items_we_deliver += /obj/item/storage/box/papersack/ration_bread_slice

	// List of flour options we get
	var/list/radial_flour_options = list(
		"Standard Flour" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "flour"),
		"Korta Flour" = image(icon = 'modular_skyrat/modules/paycheck_rations/icons/food_containers.dmi', icon_state = "flour_korta"),
	)

	var/flour_choice = show_radial_menu(user, object_we_attack, radial_flour_options, require_near = TRUE)

	if(!flour_choice)
		object_we_attack.balloon_alert(user, "no selection made")
		// Reset the list if we fail
		items_we_deliver = list()
		forceMove(drop_location(object_we_attack))

	switch(flour_choice)
		if("Standard Flour")
			items_we_deliver += /obj/item/reagent_containers/condiment/flour/small_ration
		if("Korta Flour")
			items_we_deliver += /obj/item/reagent_containers/condiment/small_ration_korta_flour
			items_we_deliver += /obj/item/reagent_containers/condiment/soymilk/small_ration

	items_we_deliver += /obj/item/reagent_containers/condiment/rice/small_ration
	items_we_deliver += /obj/item/reagent_containers/condiment/sugar/small_ration
	items_we_deliver += /obj/item/reagent_containers/cup/glass/bottle/small/tiny/lime_juice
	items_we_deliver += /obj/item/reagent_containers/cup/glass/bottle/small/tiny/vinegar

	items_we_deliver += /obj/item/reagent_containers/cup/glass/waterbottle

	var/random_drink = pick( \
		/obj/item/reagent_containers/cup/glass/waterbottle/tea, \
		/obj/item/reagent_containers/cup/glass/waterbottle/tea/mushroom, \
		/obj/item/reagent_containers/cup/glass/waterbottle/tea/astra, \
		/obj/item/reagent_containers/cup/glass/coffee, \
	)
	items_we_deliver += random_drink

	make_the_actual_order(object_we_attack, user)
