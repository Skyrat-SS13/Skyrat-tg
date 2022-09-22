
//	Shoe pockets
/datum/storage/pockets/shoes/New()
	. = ..()

	add_holdable(list(
	//	Adds pistol magazines from guncargo companies in their respective order
	/obj/item/ammo_box/magazine/multi_sprite/pdh,
	/obj/item/ammo_box/magazine/multi_sprite/ladon,
	/obj/item/ammo_box/magazine/multi_sprite/firefly,
	/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper,
	/obj/item/ammo_box/magazine/multi_sprite/mk58,
	/obj/item/ammo_box/magazine/m45,
	/obj/item/ammo_box/magazine/pepperball, //	boot pepper
	/obj/item/ammo_box/magazine/multi_sprite/g17,
	/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby,
	/obj/item/ammo_box/magazine/multi_sprite/cfa_snub,
	/obj/item/ammo_box/magazine/multi_sprite/makarov,
	/obj/item/ammo_box/magazine/m9mm_aps,
	/obj/item/ammo_box/magazine/toy/pistol/riot,
	))
