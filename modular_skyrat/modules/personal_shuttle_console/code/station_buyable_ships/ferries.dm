/datum/map_template/shuttle/personal_buyable/ferries
	personal_shuttle_type = PERSONAL_SHIP_TYPE_FERRY

// Little people mover

/datum/map_template/shuttle/personal_buyable/ferries/people_mover
	name = "SF Hafila"
	description = "A common shuttle used for ferrying crew short distances. \
		Has seating for six plus the pilot, as well as basic ship supplies. \
		Powered by two large power cells, with an onboard SOFIE generator \
		as backup in case those cells run dry."
	credit_cost = CARGO_CRATE_VALUE * 8
	suffix = "ferry_hafila.dmm"
	width = 15
	height = 11

/area/shuttle/personally_bought/people_mover
	name = "SF Hafila"

// Personal ship with some commodities

/datum/map_template/shuttle/personal_buyable/ferries/house_boat
	name = "SF Manzil"
	description = "A common personal shuttle used often by solo spacers. \
		An upgraded version of the SF Hafila, sharing \
		its general shape and power plant. The bonus is that instead of \
		six seats for ferrying crew, there is a small suite and kitchen for life \
		in the void."
	credit_cost = CARGO_CRATE_VALUE * 10
	suffix = "ferry_manzil.dmm"
	width = 15
	height = 11

/area/shuttle/personally_bought/house_boat
	name = "SF Manzil"

// Basically, a private jet

/area/shuttle/personally_bought/private_liner
	name = "SF Khasun"
