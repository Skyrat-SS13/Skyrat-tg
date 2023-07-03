/datum/market_item/weapon
	category = "Weapons"

/datum/market_item/weapon/bolt_rifle
	name = "Worn Sportiv Rifle"
	desc = "A bunch of corrupt imperial law officials have marked a shipment of those as 'defunct' and sold them to us. They do jam like a bitch though."
	item = /obj/item/gun/ballistic/rifle/boltaction/surplus

	price_min = CARGO_CRATE_VALUE * 4
	price_max = CARGO_CRATE_VALUE * 6
	stock_max = 3
	availability_prob = 30

/datum/market_item/weapon/bolt_ammo
	name = "Sportiv Stripper Clip"
	desc = "This came with the rifles and is -probably- some sportsmanship-grade ammunition, so surely it must be something good. Warranty void if used against people."
	item = /obj/item/ammo_box/a762/surplus

	price_min = CARGO_CRATE_VALUE * 1.5
	price_max = CARGO_CRATE_VALUE * 2.75
	stock_max = 9
	availability_prob = 60

/datum/market_item/weapon/shit_revolver
	name = ".38 Revolver"
	desc = "There was this roving band of psycholunatics mugging people for shit. But you can't mug if you can't see, so they were dying wave after wave. \
	That's where the guns are from."
	item = /obj/item/gun/ballistic/revolver/c38

	price_min = CARGO_CRATE_VALUE * 6
	price_max = CARGO_CRATE_VALUE * 8
	stock_max = 4
	availability_prob = 30

/datum/market_item/weapon/revolver_ammo
	name = ".38 Speedloader"
	desc = "There was this roving band of psycholunatics mugging people for shit. But you can't mug if you can't see, so they were dying wave after wave. \
	That's where the guns are from. And the ammo."
	item = /obj/item/ammo_box/c38

	price_min = CARGO_CRATE_VALUE * 1
	price_max = CARGO_CRATE_VALUE * 2
	stock_max = 7
	availability_prob = 60

/datum/market_item/weapon/croon
	name = "Croon SMG"
	desc = "This piece of junk was probably welded together in some garage. I mean it's literally a bunch of metal squares welded together. And it can barely hit anyone\
	at a range of three meters. Fantastic gun if you ask me."
	item = /obj/item/gun/ballistic/automatic/croon

	price_min = CARGO_CRATE_VALUE * 4.5
	price_max = CARGO_CRATE_VALUE * 7
	stock_max = 3
	availability_prob = 30

/datum/market_item/weapon/croon_ammo
	name = "Croon Magazine"
	desc = "Whoever designed this might be a real crackhead because not only did they weld together the gun but they also made this proprietary ammo. Crazy right?"
	item = /obj/item/ammo_box/magazine/multi_sprite/croon

	price_min = CARGO_CRATE_VALUE
	price_max = CARGO_CRATE_VALUE * 1.5
	stock_max = 3
	availability_prob = 60

/datum/market_item/weapon/rc_makarov
	name = "Authentic Makarov Pistol"
	desc = "I bet you've always wanted to have this 10mm beauty yourself right? So here's the perfect opportunity to grab one. No refunds."
	item = /obj/item/gun/ballistic/automatic/pistol/makarov

	price_min = CARGO_CRATE_VALUE * 5
	price_max = CARGO_CRATE_VALUE * 7.5
	stock_max = 2
	availability_prob = 30

/datum/market_item/weapon/makarov_ammo
	name = "Authentic Makarov Ammo"
	desc = "You'd think this'd come with a gun, but you see, we're not called black market for nothing."
	item = /obj/item/ammo_box/magazine/multi_sprite/makarov

	price_min = CARGO_CRATE_VALUE * 1.75
	price_max = CARGO_CRATE_VALUE * 3
	stock_max = 3
	availability_prob = 60

/datum/market_item/weapon/surplus_rifle
	name = "Surplus Rifle"
	desc = "This gun was used by the frontier varminting groups before it got phased out with that slavic civilian rifle. So, we took the batches for ourselves."
	item = /obj/item/gun/ballistic/automatic/surplus
	price_min = CARGO_CRATE_VALUE * 5
	price_max = CARGO_CRATE_VALUE * 7
	stock_max = 3
	availability_prob = 30

/datum/market_item/weapon/surplus_ammo
	name = "Surplus Rifle Ammo"
	desc = "This gun was used by the frontier varminting groups before it got phased out with that slavic civilian rifle. So, we took the batches for ourselves."
	item = /obj/item/ammo_box/magazine/m10mm/rifle
	price_min = CARGO_CRATE_VALUE * 3
	price_max = CARGO_CRATE_VALUE * 4
	stock_max = 5
	availability_prob = 60
