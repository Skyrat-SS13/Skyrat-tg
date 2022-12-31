/datum/uplink_item/bundles_tc/bundle_tactical
	name = "Syndi-kit Tactical"
	desc = "Syndicate Bundles, also known as Syndi-Kits, are specialized groups of items that arrive in a plain box. \
			These items are collectively worth more than 20 telecrystals, but you do not know which specialization \
			you will receive. May contain discontinued and/or exotic items."
	item = /obj/item/storage/box/syndicate/bundle_a
	cost = 20
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/bundles_tc/bundle_special
	name = "Syndi-kit Special"
	desc = "Syndicate Bundles, also known as Syndi-Kits, are specialized groups of items that arrive in a plain box. \
			In Syndi-kit Special, you will receive items used by famous syndicate agents of the past. Collectively worth more than 20 telecrystals, the syndicate loves a good throwback."
	item = /obj/item/storage/box/syndicate/bundle_b
	cost = 20
	purchasable_from = ~(UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS)

/datum/uplink_item/bundles_tc/surplus_crate
	name = "Surplus Crate"
	desc = "A dusty crate from the back of the Syndicate warehouse. Rumored to contain a valuable assortment of items, \
			but you never know. Contents are sorted to always be worth 50 TC."
	item = /obj/effect/gibspawner/generic
	cost = 20
	/// The contents of the surplus crate will be equal to this var in TC
	var/telecrystal_count = 50

/datum/uplink_item/bundles_tc/surplus_crate/spawn_item(spawn_path, mob/user, datum/uplink_handler/uplink_handler, atom/movable/source)
	telecrystal_count = initial(telecrystal_count)
	var/list/uplink_items = list()
	var/obj/structure/closet/crate/holder_crate = new(get_turf(user))
	for(var/datum/uplink_item/item_path as anything in SStraitor.uplink_items_by_type)
		var/datum/uplink_item/item = SStraitor.uplink_items_by_type[item_path]
		if(item.purchasable_from & UPLINK_TRAITORS)
			uplink_items += item

	while(telecrystal_count)
		var/datum/uplink_item/uplink_item = pick(uplink_items)
		if(!uplink_item.surplus || prob(100 - uplink_item.surplus))
			continue
		if(telecrystal_count < uplink_item.cost)
			continue
		if(!uplink_item.item)
			continue
		telecrystal_count -= uplink_item.cost
		new uplink_item.item(holder_crate)

/datum/uplink_item/bundles_tc/surplus_crate/super
	name = "Super Surplus Crate"
	desc = "A dusty SUPER-SIZED crate from the back of the Syndicate warehouse. Rumored to contain a valuable assortment of items, \
			but you never know. Contents are sorted to always be worth 125 TC."
	telecrystal_count = 125
	cost = 40
