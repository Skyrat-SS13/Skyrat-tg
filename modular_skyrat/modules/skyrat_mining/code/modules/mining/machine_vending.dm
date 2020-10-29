/obj/item/suit_voucher
	name = "suit voucher"
	desc = "A token to redeem a new suit. Use it on a mining equipment vendor."
	icon = 'icons/obj/mining.dmi'
	icon_state = "mining_voucher"
	w_class = WEIGHT_CLASS_TINY

/obj/machinery/mineral/equipment_vendor/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/suit_voucher))
		RedeemSVoucher(I, user)
		return
	. = ..()

/obj/machinery/mineral/equipment_vendor/RedeemVoucher(obj/item/mining_voucher/voucher, mob/redeemer)
	var/items = list(	"Survival Capsule and Explorer's Webbing" = image(icon = 'icons/obj/storage.dmi', icon_state = "explorerpack"),
						"Resonator Kit" = image(icon = 'icons/obj/mining.dmi', icon_state = "resonator"),
						"Minebot Kit" = image(icon = 'icons/mob/aibots.dmi', icon_state = "mining_drone"),
						"Extraction and Rescue Kit" = image(icon = 'icons/obj/fulton.dmi', icon_state = "extraction_pack"),
						"Crusher Kit" = image(icon = 'icons/obj/mining.dmi', icon_state = "crusher"),
						"Mining Conscription Kit" = image(icon = 'icons/obj/storage.dmi', icon_state = "duffel"))

	var/selection = show_radial_menu(redeemer, src, items, require_near = TRUE, tooltips = TRUE)
	if(!selection || !Adjacent(redeemer) || QDELETED(voucher) || voucher.loc != redeemer)
		return
	var/drop_location = drop_location()
	switch(selection)
		if("Survival Capsule and Explorer's Webbing")
			new /obj/item/storage/belt/mining/vendor(drop_location)
		if("Resonator Kit")
			new /obj/item/extinguisher/mini(drop_location)
			new /obj/item/resonator(drop_location)
		if("Minebot Kit")
			new /mob/living/simple_animal/hostile/mining_drone(drop_location)
			new /obj/item/weldingtool/hugetank(drop_location)
			new /obj/item/clothing/head/welding(drop_location)
			new /obj/item/borg/upgrade/modkit/minebot_passthrough(drop_location)
		if("Extraction and Rescue Kit")
			new /obj/item/extraction_pack(drop_location)
			new /obj/item/fulton_core(drop_location)
			new /obj/item/stack/marker_beacon/thirty(drop_location)
		if("Crusher Kit")
			new /obj/item/extinguisher/mini(drop_location)
			new /obj/item/kinetic_crusher(drop_location)
		if("Mining Conscription Kit")
			new /obj/item/storage/backpack/duffelbag/mining_conscript(drop_location)

	SSblackbox.record_feedback("tally", "mining_voucher_redeemed", 1, selection)
	qdel(voucher)

/obj/machinery/mineral/equipment_vendor/proc/RedeemSVoucher(obj/item/suit_voucher/voucher, mob/redeemer)
	var/items = list(	"Exo-suit" = image(icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/clothing/suits.dmi', icon_state = "exo"),
						"SEVA suit" = image(icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/clothing/suits.dmi', icon_state = "seva"))

	var/selection = show_radial_menu(redeemer, src, items, require_near = TRUE, tooltips = TRUE)
	if(!selection || !Adjacent(redeemer) || QDELETED(voucher) || voucher.loc != redeemer)
		return
	var/drop_location = drop_location()
	switch(selection)
		if("Exo-suit")
			new /obj/item/clothing/suit/hooded/explorer/exo(drop_location)
			new /obj/item/clothing/mask/gas/exo(drop_location)
		if("SEVA suit")
			new /obj/item/clothing/suit/hooded/explorer/seva(drop_location)
			new /obj/item/clothing/mask/gas/seva(drop_location)

	SSblackbox.record_feedback("tally", "suit_voucher_redeemed", 1, selection)
	qdel(voucher)

/obj/machinery/mineral/equipment_vendor
	prize_list = list( //if you add something to this, please, for the love of god, sort it by price/type. use tabs and not spaces.
		new /datum/data/mining_equipment("1 Marker Beacon",				/obj/item/stack/marker_beacon,										10),
		new /datum/data/mining_equipment("50 Point Transfer Card",		/obj/item/card/mining_point_card,									50),
		new /datum/data/mining_equipment("10 Marker Beacons",			/obj/item/stack/marker_beacon/ten,									100),
		new /datum/data/mining_equipment("30 Marker Beacons",			/obj/item/stack/marker_beacon/thirty,								300),
		new /datum/data/mining_equipment("Whiskey",						/obj/item/reagent_containers/food/drinks/bottle/whiskey,			100),
		new /datum/data/mining_equipment("Absinthe",					/obj/item/reagent_containers/food/drinks/bottle/absinthe/premium,	100),
		new /datum/data/mining_equipment("Cigar",						/obj/item/clothing/mask/cigarette/cigar/havana,						150),
		new /datum/data/mining_equipment("Miner's Salve Patch",			/obj/item/reagent_containers/pill/patch/salve,						150),
		new /datum/data/mining_equipment("Soap",						/obj/item/soap/nanotrasen,											200),
		new /datum/data/mining_equipment("Laser Pointer",				/obj/item/laser_pointer,											300),
		new /datum/data/mining_equipment("Alien Toy",					/obj/item/clothing/mask/facehugger/toy,								300),
		new /datum/data/mining_equipment("Stabilizing Serum",			/obj/item/hivelordstabilizer,										400),
		new /datum/data/mining_equipment("Fulton Beacon",				/obj/item/fulton_core,												400),
		new /datum/data/mining_equipment("Shelter Capsule",				/obj/item/survivalcapsule,											400),
		new /datum/data/mining_equipment("Survival Knife",				/obj/item/kitchen/knife/combat/survival,							450),
		new /datum/data/mining_equipment("GAR Meson Scanners",			/obj/item/clothing/glasses/meson/gar,								500),
		new /datum/data/mining_equipment("Explorer's Webbing",			/obj/item/storage/belt/mining,										500),
		new /datum/data/mining_equipment("Larger Ore Bag",				/obj/item/storage/bag/ore/large,									500),
		new /datum/data/mining_equipment("500 Point Transfer Card",		/obj/item/card/mining_point_card/mp500,								500),
		new /datum/data/mining_equipment("Tracking Implant Kit", 		/obj/item/storage/box/minertracker,									600),
		new /datum/data/mining_equipment("Jaunter",						/obj/item/wormhole_jaunter,											750),
		new /datum/data/mining_equipment("Kinetic Crusher",				/obj/item/kinetic_crusher,											750),
		new /datum/data/mining_equipment("Kinetic Accelerator",			/obj/item/gun/energy/kinetic_accelerator,							750),
		new /datum/data/mining_equipment("Survival Medipen",			/obj/item/reagent_containers/hypospray/medipen/survival,			750),
		new /datum/data/mining_equipment("Brute First-Aid Kit",			/obj/item/storage/firstaid/brute,									800),
		new /datum/data/mining_equipment("Burn First-Aid Kit",			/obj/item/storage/firstaid/fire,									800),
		new /datum/data/mining_equipment("First-Aid Kit",				/obj/item/storage/firstaid/regular,									800),
		new /datum/data/mining_equipment("Advanced Scanner",			/obj/item/t_scanner/adv_mining_scanner,								800),
		new /datum/data/mining_equipment("Resonator",					/obj/item/resonator,												800),
		new /datum/data/mining_equipment("Mini Extinguisher",			/obj/item/extinguisher/mini,										1000),
		new /datum/data/mining_equipment("Fulton Pack",					/obj/item/extraction_pack,											1000),
		new /datum/data/mining_equipment("Lazarus Injector",			/obj/item/lazarus_injector,											1000),
		new /datum/data/mining_equipment("Silver Pickaxe",				/obj/item/pickaxe/silver,											1000),
		new /datum/data/mining_equipment("Mining Conscription Kit",		/obj/item/storage/backpack/duffelbag/mining_conscript,				1000),
		new /datum/data/mining_equipment("1000 Point Transfer Card",	/obj/item/card/mining_point_card/mp1000,							1000),
		new /datum/data/mining_equipment("1500 Point Transfer Card",	/obj/item/card/mining_point_card/mp1500,							1500),
		new /datum/data/mining_equipment("2000 Point Transfer Card",	/obj/item/card/mining_point_card/mp2000,							2000),
		new /datum/data/mining_equipment("Jetpack Upgrade",				/obj/item/tank/jetpack/suit,										2000),
		new /datum/data/mining_equipment("Space Cash",					/obj/item/stack/spacecash/c1000,									2000),
		new /datum/data/mining_equipment("Mining Hardsuit",				/obj/item/clothing/suit/space/hardsuit/mining,						2000),
		new /datum/data/mining_equipment("Diamond Pickaxe",				/obj/item/pickaxe/diamond,											2000),
		new /datum/data/mining_equipment("Spare Suit Voucher",			/obj/item/suit_voucher,												2000),
		new /datum/data/mining_equipment("Super Resonator",				/obj/item/resonator/upgraded,										2500),
		new /datum/data/mining_equipment("Jump Boots",					/obj/item/clothing/shoes/bhop,										2500),
		new /datum/data/mining_equipment("Luxury Shelter Capsule",		/obj/item/survivalcapsule/luxury,									3000),
		new /datum/data/mining_equipment("Luxury Bar Capsule",			/obj/item/survivalcapsule/luxuryelite,								10000),
		new /datum/data/mining_equipment("Nanotrasen Minebot",			/mob/living/simple_animal/hostile/mining_drone,						800),
		new /datum/data/mining_equipment("Minebot Melee Upgrade",		/obj/item/mine_bot_upgrade,											400),
		new /datum/data/mining_equipment("Minebot Armor Upgrade",		/obj/item/mine_bot_upgrade/health,									400),
		new /datum/data/mining_equipment("Minebot Cooldown Upgrade",	/obj/item/borg/upgrade/modkit/cooldown/minebot,						600),
		new /datum/data/mining_equipment("Minebot AI Upgrade",			/obj/item/slimepotion/slime/sentience/mining,						1000),
		new /datum/data/mining_equipment("KA Minebot Passthrough",		/obj/item/borg/upgrade/modkit/minebot_passthrough,					100),
		new /datum/data/mining_equipment("KA White Tracer Rounds",		/obj/item/borg/upgrade/modkit/tracer,								100),
		new /datum/data/mining_equipment("KA Adjustable Tracer Rounds",	/obj/item/borg/upgrade/modkit/tracer/adjustable,					150),
		new /datum/data/mining_equipment("KA Super Chassis",			/obj/item/borg/upgrade/modkit/chassis_mod,							250),
		new /datum/data/mining_equipment("KA Hyper Chassis",			/obj/item/borg/upgrade/modkit/chassis_mod/orange,					300),
		new /datum/data/mining_equipment("KA Range Increase",			/obj/item/borg/upgrade/modkit/range,								1000),
		new /datum/data/mining_equipment("KA Damage Increase",			/obj/item/borg/upgrade/modkit/damage,								1000),
		new /datum/data/mining_equipment("KA Cooldown Decrease",		/obj/item/borg/upgrade/modkit/cooldown,								1000),
		new /datum/data/mining_equipment("KA AoE Damage",				/obj/item/borg/upgrade/modkit/aoe/mobs,								2000),
		new /datum/data/mining_equipment("Miner Full Replacement",		/obj/item/storage/backpack/duffelbag/mining_cloned,					3000),
		new /datum/data/mining_equipment("Premium Accelerator",			/obj/item/gun/energy/kinetic_accelerator/premiumka,					8000),
		new /datum/data/mining_equipment("Precise Accelerator",			/obj/item/gun/energy/kinetic_accelerator/premiumka/precise,			10000),
		new /datum/data/mining_equipment("Rapid Accelerator",			/obj/item/gun/energy/kinetic_accelerator/premiumka/rapid,			10000),
		new /datum/data/mining_equipment("Heavy Accelerator",			/obj/item/gun/energy/kinetic_accelerator/premiumka/heavy,			10000),
		new /datum/data/mining_equipment("Modular Accelerator",			/obj/item/gun/energy/kinetic_accelerator/premiumka/modular,			15000),
		new /datum/data/mining_equipment("Build-your-own-KA kit",		/obj/item/gun/energy/kinetic_accelerator/premiumka/byoka,			30000),
		new /datum/data/mining_equipment("Kinetic Destroyer",			/obj/item/kinetic_crusher/premiumcrusher,					12000)
		)

/obj/item/card/mining_point_card/mp500
	desc = "A small card preloaded with 500 mining points. Swipe your ID card over it to transfer the points, then discard."
	points = 500

/obj/item/card/mining_point_card/mp1000
	desc = "A small card preloaded with 1000 mining points. Swipe your ID card over it to transfer the points, then discard."
	points = 1000

/obj/item/card/mining_point_card/mp1500
	desc = "A small card preloaded with 1500 mining points. Swipe your ID card over it to transfer the points, then discard."
	points = 1500

/obj/item/card/mining_point_card/mp2000
	desc = "A small card preloaded with 2000 mining points. Swipe your ID card over it to transfer the points, then discard."
	points = 2000

/obj/item/storage/backpack/duffelbag/mining_cloned
	name = "mining replacement kit"
	desc = "A large bag that has advance tools and a spare jumpsuit, boots, and gloves for a newly cloned miner to get back in the field. Even has a new ID!"

/obj/item/storage/backpack/duffelbag/mining_cloned/PopulateContents()
	new /obj/item/pickaxe/mini(src)
	new /obj/item/clothing/under/rank/cargo/miner/lavaland(src)
	new /obj/item/clothing/shoes/workboots/mining(src)
	new /obj/item/clothing/gloves/color/black(src)
	new /obj/item/implanter/tracking/gps(src)
	new /obj/item/gun/energy/kinetic_accelerator(src)
	new /obj/item/kitchen/knife/combat/survival(src)
	new /obj/item/storage/firstaid/regular(src)
	new /obj/item/reagent_containers/hypospray/medipen/survival(src)
	new /obj/item/t_scanner/adv_mining_scanner(src)
	new /obj/item/clothing/suit/hooded/explorer(src)
	new /obj/item/encryptionkey/headset_cargo(src)
	new /obj/item/clothing/mask/gas/explorer(src)
	new /obj/item/card/id/mining(src)
	new /obj/item/storage/bag/ore(src)
	new /obj/item/clothing/glasses/meson(src)
