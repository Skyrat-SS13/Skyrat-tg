/*
*	GUNSET BOXES
*/

/obj/item/storage/box/gunset/roundstart_guns
	icon_state = "guncase_s" //Currently only comes as a generic gray, though there's sprites for Armadyne branded ones in the icon file. There's also sprites for smaller ones!

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
