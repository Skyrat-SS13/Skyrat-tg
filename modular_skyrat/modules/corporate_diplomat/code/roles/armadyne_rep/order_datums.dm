#define ONE_MINUTE 30

/datum/armadyne_order
	/// Name of the order
	var/name = ""
	/// A small description on what the order does
	var/desc = ""
	/// How much the order costs
	var/cost = 0
	/// What the order contains
	var/list/order_contents
	/// Stringified set of contents
	var/list/string_order_contents = list()


/datum/armadyne_order/New()
	. = ..()
	if(!length(string_order_contents))
		for(var/atom/entry as anything in order_contents)
			string_order_contents += "[order_contents[entry]]x [initial(entry.name)]"


/datum/armadyne_order/peacekeeper
	name = "PDH-6B 'Peacekeeper'"
	desc = "A 9mm handgun primarily used by law enforcement, notable for its fairly large magazine size."
	cost = ONE_MINUTE * 18
	order_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/pdh/peacekeeper/nomag = 1,
		/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper = 3,
	)


/datum/armadyne_order/peacekeeper_ammunition
	name = "2x PDH-6B 'Peacekeeper' magazine"
	desc = "A pair of FMJ 9mm magazines for the PDH-6B."
	cost = ONE_MINUTE * 6
	order_contents = list(
		/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper = 2,
	)


/datum/armadyne_order/ladon
	name = "Ladon pistol"
	desc = "A modern handgun chambered in 10mm based on the PDH series, it's guaranteed to pack a punch."
	cost = ONE_MINUTE * 24
	order_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/ladon/nomag = 1,
		/obj/item/ammo_box/magazine/multi_sprite/ladon = 3,
	)


/datum/armadyne_order/ladon_ammunition
	name = "2x Ladon magazine"
	desc = "A pair of FMJ 10mm magazines for the Ladon."
	cost = ONE_MINUTE * 8
	order_contents = list(
		/obj/item/ammo_box/magazine/multi_sprite/ladon = 2,
	)

/datum/armadyne_order/firefly
	name = "P-92 'Firefly'"
	desc = "A small 9mm pistol fit for those not well-accustomed to shooting firearms."
	cost = ONE_MINUTE * 12
	order_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/firefly/nomag = 1,
		/obj/item/ammo_box/magazine/multi_sprite/firefly = 3,
	)


/datum/armadyne_order/firefly_ammunition
	name = "2x P-92 'Firefly' magazine"
	desc = "A pair of FMJ 9mm magazines for the P-92."
	cost = ONE_MINUTE * 4
	order_contents = list(
		/obj/item/ammo_box/magazine/multi_sprite/firefly = 2,
	)

/datum/armadyne_order/mk58
	name = "MK-58 pistol"
	desc = "A 9mm firearm nearing the end of its production run, it's certainly capable of getting the user out of a jam."
	cost = ONE_MINUTE * 12
	order_contents = list(
		/obj/item/gun/ballistic/automatic/pistol/mk58/nomag = 1,
		/obj/item/ammo_box/magazine/multi_sprite/mk58 = 3,
	)


/datum/armadyne_order/mk58_ammunition
	name = "2x MK-58 magazine"
	desc = "A pair of FMJ 9mm magazines for the MK-58."
	cost = ONE_MINUTE * 4
	order_contents = list(
		/obj/item/ammo_box/magazine/multi_sprite/mk58 = 2,
	)


/datum/armadyne_order/zeta
	name = "Zeta-6 'Spurchamber'"
	desc = "A 10mm revolver with a focus on reliability above all else."
	cost = ONE_MINUTE * 14
	order_contents = list(
		/obj/item/gun/ballistic/revolver/zeta = 1,
		/obj/item/ammo_box/revolver/zeta = 2, // Spawns with one less because the zeta starts with a full cylinder
	)


/datum/armadyne_order/mk_58
	name = "2x Zeta-6 'Spurchamber' speedloader"
	desc = "A pair of 10mm speedloaders for the Zeta-6."
	cost = ONE_MINUTE * 5
	order_contents = list(
		/obj/item/ammo_box/revolver/zeta/full = 2,
	)

#undef ONE_MINUTE
