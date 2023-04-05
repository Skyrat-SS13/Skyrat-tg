/datum/armament_entry/company_import/donk
	category = DONK_CO_NAME
	company_bitflag = CARGO_COMPANY_DONK

// Donk Co foods, like donk pockets and ready donk

/datum/armament_entry/company_import/donk/food
	subcategory = "Microwave Foods"

/datum/armament_entry/company_import/donk/food/ready_donk
	item_type = /obj/item/food/ready_donk
	lower_cost = PAYCHECK_CREW * 0.75
	upper_cost = PAYCHECK_CREW
	stock_mult = 4

/datum/armament_entry/company_import/donk/food/ready_donkhiladas
	item_type = /obj/item/food/ready_donk/donkhiladas
	lower_cost = PAYCHECK_CREW * 0.75
	upper_cost = PAYCHECK_CREW
	stock_mult = 4

/datum/armament_entry/company_import/donk/food/ready_donk_n_cheese
	item_type = /obj/item/food/ready_donk/mac_n_cheese
	lower_cost = PAYCHECK_CREW * 0.75
	upper_cost = PAYCHECK_CREW
	stock_mult = 4

/datum/armament_entry/company_import/donk/food/pockets
	item_type = /obj/item/storage/box/donkpockets
	lower_cost = PAYCHECK_CREW * 1.5
	upper_cost = PAYCHECK_CREW * 2
	stock_mult = 2

/datum/armament_entry/company_import/donk/food/berry_pockets
	item_type = /obj/item/storage/box/donkpockets/donkpocketberry
	lower_cost = PAYCHECK_CREW * 1.5
	upper_cost = PAYCHECK_CREW * 2
	stock_mult = 2

/datum/armament_entry/company_import/donk/food/honk_pockets
	item_type = /obj/item/storage/box/donkpockets/donkpockethonk
	lower_cost = PAYCHECK_CREW * 1.5
	upper_cost = PAYCHECK_CREW * 2
	stock_mult = 2

/datum/armament_entry/company_import/donk/food/pizza_pockets
	item_type = /obj/item/storage/box/donkpockets/donkpocketpizza
	lower_cost = PAYCHECK_CREW * 1.5
	upper_cost = PAYCHECK_CREW * 2
	stock_mult = 2

/datum/armament_entry/company_import/donk/food/spicy_pockets
	item_type = /obj/item/storage/box/donkpockets/donkpocketspicy
	lower_cost = PAYCHECK_CREW * 1.5
	upper_cost = PAYCHECK_CREW * 2
	stock_mult = 2

/datum/armament_entry/company_import/donk/food/teriyaki_pockets
	item_type = /obj/item/storage/box/donkpockets/donkpocketteriyaki
	lower_cost = PAYCHECK_CREW * 1.5
	upper_cost = PAYCHECK_CREW * 2
	stock_mult = 2

// Random donk toy items, fake jumpsuits, balloons, so on

// Donk merch gives you more interest than other items, buy donk bling and get company interest faster!

/datum/armament_entry/company_import/donk/merch
	subcategory = "Donk Co. Merchandise"

/datum/armament_entry/company_import/donk/merch/donk_carpet
	item_type = /obj/item/stack/tile/carpet/donk/thirty
	lower_cost = PAYCHECK_CREW * 0.75
	upper_cost = PAYCHECK_CREW
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/donk/merch/donkfish
	item_type = /obj/item/storage/fish_case/donkfish
	lower_cost = PAYCHECK_CREW * 0.75
	upper_cost = PAYCHECK_CREW
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/donk/merch/tacticool_turtleneck
	item_type = /obj/item/clothing/under/syndicate/tacticool
	lower_cost = PAYCHECK_CREW * 0.75
	upper_cost = PAYCHECK_CREW
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/donk/merch/tacticool_turtleneck_skirt
	item_type = /obj/item/clothing/under/syndicate/tacticool/skirt
	lower_cost = PAYCHECK_CREW * 0.75
	upper_cost = PAYCHECK_CREW
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/donk/merch/fake_centcom_turtleneck
	item_type = /obj/item/clothing/under/rank/centcom/officer/replica
	lower_cost = PAYCHECK_CREW * 0.75
	upper_cost = PAYCHECK_CREW
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/donk/merch/fake_centcom_turtleneck_skirt
	item_type = /obj/item/clothing/under/rank/centcom/officer_skirt/replica
	lower_cost = PAYCHECK_CREW * 0.75
	upper_cost = PAYCHECK_CREW
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/donk/merch/snack_rig
	item_type = /obj/item/storage/belt/military/snack
	lower_cost = PAYCHECK_CREW * 1.5
	upper_cost = PAYCHECK_CREW * 2
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/donk/merch/fake_syndie_suit
	item_type = /obj/item/storage/box/fakesyndiesuit
	lower_cost = PAYCHECK_CREW * 1.5
	upper_cost = PAYCHECK_CREW * 2
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_SOME_INTEREST

/datum/armament_entry/company_import/donk/merch/valid_bloon
	item_type = /obj/item/toy/balloon/arrest
	lower_cost = PAYCHECK_CREW * 1.5
	upper_cost = PAYCHECK_CREW * 2
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE
	interest_required = COMPANY_SOME_INTEREST

// Donksoft weapons

/datum/armament_entry/company_import/donk/foamforce
	subcategory = "Foam Force (TM) Weapons"

/datum/armament_entry/company_import/donk/foamforce/darts
	item_type = /obj/item/ammo_box/foambox
	lower_cost = CARGO_CRATE_VALUE * 0.25
	upper_cost = CARGO_CRATE_VALUE

/datum/armament_entry/company_import/donk/foamforce/riot_darts
	item_type = /obj/item/ammo_box/foambox/riot
	lower_cost = CARGO_CRATE_VALUE * 0.5
	upper_cost = CARGO_CRATE_VALUE * 1.5
	interest_required = COMPANY_SOME_INTEREST
	contraband = TRUE

/datum/armament_entry/company_import/donk/foamforce/foam_pistol
	item_type = /obj/item/gun/ballistic/automatic/pistol/toy
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 3
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/donk/foamforce/foam_shotgun
	item_type = /obj/item/gun/ballistic/shotgun/toy/unrestricted
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 4
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/donk/foamforce/foam_smg
	item_type = /obj/item/gun/ballistic/automatic/toy/unrestricted
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_required = COMPANY_SOME_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/donk/foamforce/foam_c20
	item_type = /obj/item/gun/ballistic/automatic/c20r/toy/unrestricted
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 5
	interest_required = COMPANY_SOME_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_AVERAGE

/datum/armament_entry/company_import/donk/foamforce/foam_lmg
	item_type = /obj/item/gun/ballistic/automatic/l6_saw/toy/unrestricted
	lower_cost = CARGO_CRATE_VALUE * 2
	upper_cost = CARGO_CRATE_VALUE * 6
	interest_required = COMPANY_HIGH_INTEREST
	interest_addition = COMPANY_INTEREST_GAIN_BIG
