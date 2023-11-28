/obj/machinery/vending/security
	name = "\improper Armadyne Peacekeeper Equipment Vendor"
	desc = "An Armadyne peacekeeper equipment vendor."
	product_ads = "Crack capitalist skulls!;Beat some heads in!;Don't forget - harm is good!;Your weapons are right here.;Handcuffs!;Freeze, scumbag!;Don't tase me bro!;Tase them, bro.;Why not have a donut?"
	icon = 'modular_skyrat/modules/sec_haul/icons/vending/vending.dmi'
	products = list(
		/obj/item/restraints/handcuffs = 8,
		/obj/item/restraints/handcuffs/cable/zipties = 12,
		/obj/item/grenade/flashbang = 6,
		/obj/item/assembly/flash/handheld = 8,
		/obj/item/food/donut/plain = 12,
		/obj/item/storage/box/evidence = 6,
		/obj/item/flashlight/seclite = 6,
		/obj/item/restraints/legcuffs/bola/energy = 10,
	)
	premium = list(
		/obj/item/storage/belt/security/webbing = 4,
		/obj/item/storage/belt/security/webbing/peacekeeper = 4,
		/obj/item/coin/antagtoken = 1,
		/obj/item/clothing/head/helmet/blueshirt = 3,
		/obj/item/clothing/suit/armor/vest/blueshirt = 3,
		/obj/item/clothing/gloves/tackler/security = 5,
		/obj/item/grenade/stingbang = 5,
		/obj/item/watertank/pepperspray = 2,
		/obj/item/storage/box/holobadge = 1,
	)
	refill_canister = /obj/item/vending_refill/security_peacekeeper

/obj/item/vending_refill/security_peacekeeper
	icon_state = "refill_sec"

/obj/machinery/vending/wardrobe/sec_wardrobe
	name = "\improper Peacekeeper Outfitting Station"
	desc = "A vending machine stocked with Lopland's \"Peacekeeper\" security package, including standardized uniforms and general equipment."
	icon = 'modular_skyrat/modules/sec_haul/icons/vending/vending.dmi'
	light_mask = "sec-light-mask"
	icon_state = "peace"
	product_ads = "Beat perps in style!;The stains wash right out!;You have the right to be fashionable!;Now you can be the fashion police you always wanted to be!"
	vend_reply = "Good luck, Peacekeeper!"
	products = list(/obj/item/clothing/suit/hooded/wintercoat/security = 5,
					/obj/item/clothing/suit/toggle/jacket/sec = 5,
					/obj/item/clothing/suit/armor/vest/peacekeeper/brit = 5,
					/obj/item/clothing/neck/security_cape = 5,
					/obj/item/clothing/neck/security_cape/armplate = 5,
					/obj/item/storage/backpack/security = 5,
					/obj/item/storage/backpack/satchel/sec = 5,
					/obj/item/storage/backpack/duffelbag/sec = 5,
					/obj/item/storage/backpack/duffelbag/sec = 5,
					/obj/item/clothing/under/rank/security/officer = 10,
					/obj/item/clothing/under/rank/security/officer/skirt = 10,
					/obj/item/clothing/under/rank/security/peacekeeper = 10,
					/obj/item/clothing/under/rank/security/skyrat/utility = 3,
					/obj/item/clothing/shoes/jackboots/sec = 10,
					/obj/item/clothing/head/security_garrison = 10,
					/obj/item/clothing/head/security_cap = 10,
					/obj/item/clothing/head/beret/sec/peacekeeper = 5,
					/obj/item/clothing/head/helmet/sec/sol = 5,
					/obj/item/clothing/head/hats/warden/police/patrol = 5,
					/obj/item/clothing/head/costume/ushanka/sec = 10,
					/obj/item/clothing/gloves/color/black/security = 10,
					)
	premium = list( /obj/item/clothing/under/rank/security/officer/formal = 3,
					/obj/item/clothing/suit/jacket/officer/blue = 3,
					/obj/item/clothing/head/beret/sec/navyofficer = 3)
	refill_canister = /obj/item/vending_refill/wardrobe/peacekeeper_wardrobe
	payment_department = ACCOUNT_SEC
	light_color = COLOR_MODERATE_BLUE

/obj/item/vending_refill/wardrobe/peacekeeper_wardrobe
	machine_name = "Peacekeeper outfitting station"

//List for the old one, for when its mapped in; curates it nicely, adds /redsec to the items, and also prevents some conflicts with the above vendor
/obj/machinery/vending/wardrobe/sec_wardrobe/red
	name = "\improper SecDrobe"
	desc = "A vending machine for security and security-related clothing!"
	product_ads = "Beat perps in style!;It's red so you can't see the blood!;You have the right to be fashionable!;Now you can be the fashion police you always wanted to be!"
	vend_reply = "Thank you for using the SecDrobe!"
	icon = 'icons/obj/machines/vending.dmi'
	icon_state = "secdrobe"
	products = list(/obj/item/clothing/suit/hooded/wintercoat/security/redsec = 3,
					/obj/item/storage/backpack/security/redsec = 3,
					/obj/item/storage/backpack/satchel/sec/redsec = 3,
					/obj/item/storage/backpack/duffelbag/sec/redsec = 3,
					/obj/item/clothing/under/rank/security/officer/redsec = 3,
					/obj/item/clothing/shoes/jackboots = 3,
					/obj/item/clothing/head/beret/sec = 3,
					/obj/item/clothing/head/soft/sec = 3,
					/obj/item/clothing/mask/bandana/red = 3,
					/obj/item/clothing/gloves/color/black = 3,
					/obj/item/clothing/under/rank/security/officer/skirt = 3,
					/obj/item/clothing/under/rank/security/skyrat/utility/redsec = 3,
					/obj/item/clothing/suit/toggle/jacket/sec/old = 3,
					)
	premium = list( /obj/item/clothing/under/rank/security/officer/formal = 5,
					/obj/item/clothing/suit/jacket/officer/tan = 5,
					/obj/item/clothing/head/beret/sec/navyofficer = 5)
