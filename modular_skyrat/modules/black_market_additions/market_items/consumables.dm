/datum/market_item/consumable
	category = "Consumables"

/datum/market_item/consumable/syndie_cigs
	name = "SnD's Brand Cigarettes"
	desc = "A pack of cigarettes imported from a nearby outpost. Placed looks shady and the pack is similarly weird, but the customers say it's good for your health, so you do you."
	item = /obj/item/storage/fancy/cigarettes/cigpack_syndicate
	stock_min = 3
	stock_max = 6

	price_min = CARGO_CRATE_VALUE * 2.6
	price_max = CARGO_CRATE_VALUE * 4
	availability_prob = 30

/datum/market_item/consumable/hash
	name = "Brick of Hash"
	desc = "We support locally produced goods you know? So here's some of the stuff grown by those cabbageheads from the lava planet."
	item = /obj/item/reagent_containers/hashbrick

	stock_min = 3
	stock_max = 9
	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 3.5
	availability_prob = 80

/datum/market_item/consumable/cocaine
	name = "Brick of Cocaine"
	desc = "Hey, remember the time your Cargo has been shipping nothing but cocaine? It's one of those batches, sold back to you. No refunds."
	item = /obj/item/reagent_containers/cocainebrick

	stock_min = 3
	stock_max = 9
	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 3.5
	availability_prob = 50

/datum/market_item/consumable/crack
	name = "Brick of Crack"
	desc = "This is crack. A brick of it presumably. Are you buying or not?"
	item = /obj/item/reagent_containers/crackbrick

	stock_min = 3
	stock_max = 9
	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 3.5
	availability_prob = 50

/datum/market_item/consumable/heroin
	name = "Brick of Heroin"
	desc = "Some programmers swear this stuff helps them. I personally believe they're just crackheads."
	item = /obj/item/reagent_containers/heroinbrick

	stock_min = 3
	stock_max = 9
	price_min = CARGO_CRATE_VALUE * 2
	price_max = CARGO_CRATE_VALUE * 3.5
	availability_prob = 50

/datum/market_item/consumable/medkit
	name = "Medkit"
	desc = "Super plain medkit you can always get wherever else."
	item = /obj/item/storage/medkit/regular

	stock_min = 2
	stock_max = 9
	price_min = CARGO_CRATE_VALUE * 0.8
	price_max = CARGO_CRATE_VALUE * 1.6
	availability_prob = 50

/datum/market_item/consumable/stimpills
	name = "Stimulant Pills"
	desc = "This thing sure does make you fast as fuck, boy."
	item = /obj/item/storage/pill_bottle/stimulant

	stock_max = 3
	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE * 1
	availability_prob = 80
