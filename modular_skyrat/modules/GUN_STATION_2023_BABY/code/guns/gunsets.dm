/*
*	GUNSET BOXES
*/

/obj/item/storage/box/gunset/roundstart_guns
	icon_state = "guncase_s"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/box/gunset/roundstart_guns/cargo

/obj/item/storage/box/gunset/roundstart_guns/cargo/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/revolver/cargovolver(src)
	new /obj/item/ammo_box/advanced/s12gauge(src)

/obj/item/storage/box/gunset/roundstart_guns/engineering

/obj/item/storage/box/gunset/roundstart_guns/engineering/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/laser_cutter(src)
	new /obj/item/ammo_box/magazine/recharge/engilaser(src)
	new /obj/item/ammo_box/magazine/recharge/engilaser(src)

/obj/item/storage/box/gunset/roundstart_guns/medical

/obj/item/storage/box/gunset/roundstart_guns/medical/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/revolver/harmacist(src)
	new /obj/item/ammo_casing/bloodvial(src)
	new /obj/item/ammo_casing/bloodvial(src)
	new /obj/item/ammo_casing/bloodvial(src)

/obj/item/storage/box/gunset/roundstart_guns/science

/obj/item/storage/box/gunset/roundstart_guns/science/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/plasma_thrower(src)
	new /obj/item/ammo_box/magazine/recharge/plasmasci(src)
	new /obj/item/ammo_box/magazine/recharge/plasmasci(src)

/obj/item/storage/box/gunset/roundstart_guns/sec

/obj/item/storage/box/gunset/roundstart_guns/sec/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/pdh/peacekeeper(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper(src)
	new /obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper(src)

/obj/item/storage/box/gunset/roundstart_guns/serv

/obj/item/storage/box/gunset/roundstart_guns/serv/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/g17(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g17(src)
	new /obj/item/ammo_box/magazine/multi_sprite/g17(src)

/obj/item/storage/box/gunset/roundstart_guns/assistant

/obj/item/storage/box/gunset/roundstart_guns/assistant/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/revolver/c38(src)
	new /obj/item/ammo_box/c38(src)
	new /obj/item/ammo_box/c38/match(src)
