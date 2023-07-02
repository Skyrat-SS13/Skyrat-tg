/datum/market_item/clothing
	category = "Clothing"

/datum/market_item/clothing/old_helmet
	name = "Defunct Surplus Helmet"
	desc = "This thing has seen lots of battles a long time ago, and while its lenses might be a bit too dark for your eyes, it'll still hold your brain inside your skull, guaranteed."
	item = /obj/item/clothing/head/helmet/old

	price_min = CARGO_CRATE_VALUE
	price_max = CARGO_CRATE_VALUE * 2
	stock_max = 3
	availability_prob = 40

/datum/market_item/clothing/old_vest
	name = "Defunct Surplus Vest"
	desc = "We had to bribe a bunch of xenoarchaeologists for this thing. It -might- be a bit stiff to move in, though. Just chug some stimulants we sell on the side and you'll be fine."
	item = /obj/item/clothing/suit/armor/vest/old

	price_min = CARGO_CRATE_VALUE
	price_max = CARGO_CRATE_VALUE * 2.5
	stock_max = 4
	availability_prob = 50

/datum/market_item/clothing/cool_jumpsuit
	name = "Camouflaged Uniform"
	desc = "A pirate brigand shipped those to us after ransacking some LARPers. Made out of some durable thread so you might wanna get some of those if you're into acting tactically."
	item = /obj/item/clothing/under/syndicate/camo

	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE
	stock_max = 5
	availability_prob = 50

/datum/market_item/clothing/chameleon_kit
	name = "Disguise Kit"
	desc = "A single box of chameleon disguise kit for acting suspiciously fancy."
	item = /obj/item/storage/box/syndie_kit/chameleon

	price_min = CARGO_CRATE_VALUE * 7.5
	price_max = CARGO_CRATE_VALUE * 20
	stock_max = 3
	availability_prob = 30

/datum/market_item/clothing/tacklers
	name = "Tackling Gloves"
	desc = "Good if you like acting recklessly."
	item = /obj/item/clothing/gloves/tackler/offbrand

	price_min = CARGO_CRATE_VALUE * 0.5
	price_max = CARGO_CRATE_VALUE
	stock_max = 2
	availability_prob = 40
