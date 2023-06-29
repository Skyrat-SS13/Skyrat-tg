/datum/market_item/tool
	category = "Tools"

/datum/market_item/tool/syndie_toolbox
	name = "Black Toolbox"
	desc = "Psst, man... We got a toolbox full of that high-grade stuff red spacesuit guns are using."
	item = /obj/item/storage/toolbox/syndicate
	stock_min = 1
	stock_max = 3

	price_min = CARGO_CRATE_VALUE * 3
	price_max = CARGO_CRATE_VALUE * 6
	availability_prob = 20
