/obj/item/circuitboard/computer/order_console/mining/interdyne
	name = "Interdyne Mining Equipment Vendor Console"
	build_path = /obj/machinery/computer/order_console/mining/interdyne

// Interdyne/DS-2 mining equipment vendor that doesn't need a cargo shuttle to work

/obj/machinery/computer/order_console/mining/interdyne
	name = "interdyne mining equipment vendor"
	circuit = /obj/item/circuitboard/computer/order_console/mining/interdyne
	forced_express = TRUE
	express_cost_multiplier = 1
	order_categories = list(
		CATEGORY_MINING,
		CATEGORY_CONSUMABLES,
		CATEGORY_TOYS_DRONE,
		CATEGORY_PKA,
	)

// This is honestly quite terrible but, replaces voucher spawned mining drones with the interdyne subtype at this console

/obj/machinery/computer/order_console/mining/interdyne/redeem_voucher(obj/item/mining_voucher/voucher, mob/redeemer)
	. = ..()
	for(var/mob/living/basic/mining_drone/drone in drop_location())
		// There could already be an interdyne drone there
		if(!istype(drone, /mob/living/basic/mining_drone/interdyne))
			qdel(drone)
			new /mob/living/basic/mining_drone/interdyne(drop_location())

// Interdyne minebot

/mob/living/basic/mining_drone/interdyne
	name = "\improper Interdyne minebot"
	faction = list(FACTION_NEUTRAL, ROLE_SYNDICATE)
