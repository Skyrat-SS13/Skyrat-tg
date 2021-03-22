/obj/machinery/vending/engivend
	name = "\improper Engi-Vend"
	desc = "Spare tool vending. What? Did you expect some witty description?"
	icon_state = "engivend"
	icon_deny = "engivend-deny"
	req_access = list(ACCESS_ENGINE_EQUIP)
	products = list(/obj/item/clothing/glasses/meson/engine = 5, 	// Skyrat edit - 5 goggles
					/obj/item/construction/rcd/loaded = 3,			// Skyrat edit - 3 RCDs
					/obj/item/clothing/glasses/welding = 3,
					/obj/item/multitool = 4,
					/obj/item/grenade/chem_grenade/smart_metal_foam = 10,
					/obj/item/geiger_counter = 5,
					/obj/item/stock_parts/cell/high = 10,
					/obj/item/electronics/airlock = 10,
					/obj/item/electronics/apc = 10,
					/obj/item/electronics/airalarm = 10,
					/obj/item/electronics/firealarm = 10,
					/obj/item/electronics/firelock = 10,
					/obj/item/storage/bag/material = 3) 			// Skyrat edit - ported ammo pouches
	contraband = list(/obj/item/stock_parts/cell/potato = 3)
	premium = list(/obj/item/storage/belt/utility = 3,
					// /obj/item/construction/rcd/loaded = 2, -- Skyrat edit - moved back to regular product price
					/obj/item/storage/box/smart_metal_foam = 1)
	refill_canister = /obj/item/vending_refill/engivend
	default_price = PAYCHECK_EASY
	extra_price = PAYCHECK_COMMAND * 1.5
	payment_department = ACCOUNT_ENG
	light_mask = "engivend-light-mask"

/obj/item/vending_refill/engivend
	machine_name = "Engi-Vend"
	icon_state = "refill_engi"
