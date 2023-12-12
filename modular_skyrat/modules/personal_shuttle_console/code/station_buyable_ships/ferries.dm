/datum/map_template/shuttle/personal_buyable/ferries

// Little people mover

/datum/map_template/shuttle/personal_buyable/ferries/people_mover
	name = "SF Hafila"
	description = "A common shuttle used for ferrying crew short distances. \
		Seen often around mining sites where shuttles can't do the mining themselves, \
		transporting the workers from a station to an asteroid or other mining site. \
		Has seating for six plus the pilot, as well as basic ship supplies. \
		The ship is powered by two large power cells, with an onboard SOFIE generator \
		as backup in case those cells run dry."
	credit_cost = CARGO_CRATE_VALUE * 8
	suffix = "ferry_hafila.dmm"

/area/shuttle/personally_bought/people_mover
	name = "SF Hafila"

// Personal ship with some commodities

/datum/map_template/shuttle/personal_buyable/ferries/house_boat
	name = "SF Manzil"
	description = "A common personal shuttle used often by solo spacers. \
		This ship is, in reality, an upgraded version of the SF Hafila, sharing \
		its general shape and power plant. The bonus, however, is that instead of \
		six seats for ferrying crew, there is a small suite and kitchen for life \
		in the void."
	credit_cost = CARGO_CRATE_VALUE * 10
	suffix = "ferry_manzil.dmm"

/area/shuttle/personally_bought/house_boat
	name = "SF Manzil"

// Basically, a private jet

/area/shuttle/personally_bought/private_liner
	name = "SF Khasun"
