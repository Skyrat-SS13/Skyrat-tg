/obj/item/circuitboard/computer/order_console/mining/interdyne
	name = "Interdyne Mining Equipment Vendor Console"
	build_path = /obj/machinery/computer/order_console/mining/golem

// Interdyne/DS-2 mining equipment vendor that doesn't need a cargo shuttle to work

/obj/machinery/computer/order_console/mining/interdyne
	name = "interdyne mining equipment console"
	circuit = /obj/item/circuitboard/computer/order_console/mining/interdyne
	forced_express = TRUE
	express_cost_multiplier = 1
	uses_ltsrbt = FALSE
	order_categories = list(
		CATEGORY_MINING,
		CATEGORY_CONSUMABLES,
		CATEGORY_TOYS_DRONE_INTERDYNE,
		CATEGORY_PKA,
	)

// This is honestly quite terrible but, replaces voucher spawned mining drones with the interdyne subtype at this console

/obj/machinery/computer/order_console/mining/interdyne/redeem_voucher(obj/item/mining_voucher/voucher, mob/redeemer)
	. = ..()
	for(var/mob/living/simple_animal/hostile/mining_drone/drone in drop_location())
		// There could already be an interdyne drone there
		if(!istype(drone, /mob/living/simple_animal/hostile/mining_drone/interdyne))
			qdel(drone)
			new /mob/living/simple_animal/hostile/mining_drone/interdyne(drop_location())

// Interdyne minebot

/mob/living/simple_animal/hostile/mining_drone/interdyne
	name = "\improper Interdyne minebot"
	faction = list("neutral", "Syndicate")

// Category for interdyne drones/toys that gives them their special minebot and changes nothing else

/datum/orderable_item/toys_drones_interdyne
	category_index = CATEGORY_TOYS_DRONE_INTERDYNE

/datum/orderable_item/toys_drones_interdyne/soap
	item_path = /obj/item/soap/nanotrasen
	cost_per_order = 200

/datum/orderable_item/toys_drones_interdyne/laser_pointer
	item_path = /obj/item/laser_pointer
	cost_per_order = 300

/datum/orderable_item/toys_drones_interdyne/facehugger
	item_path = /obj/item/clothing/mask/facehugger/toy
	cost_per_order = 300

/datum/orderable_item/toys_drones_interdyne/mining_drone
	item_path = /mob/living/simple_animal/hostile/mining_drone/interdyne
	cost_per_order = 800

/datum/orderable_item/toys_drones_interdyne/drone_health
	item_path = /obj/item/mine_bot_upgrade/health
	cost_per_order = 400

/datum/orderable_item/toys_drones_interdyne/drone_pka
	item_path = /obj/item/borg/upgrade/modkit/cooldown/minebot
	cost_per_order = 600

/datum/orderable_item/toys_drones_interdyne/drone_sentience
	item_path = /obj/item/slimepotion/slime/sentience/mining
	cost_per_order = 1000
