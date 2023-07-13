//Lockers used in cargodiselost.dmm

/obj/structure/closet/freighterammo
	name = "Ammo Storage"

/obj/structure/closet/secure_closet/personal/cabinet/freighterboss
	name = "Personal Closet"

/obj/structure/closet/freighterammo/PopulateContents()
	. = ..()
	new /obj/item/ammo_box/magazine/akm(src)
	new /obj/item/ammo_box/magazine/akm(src)
	new /obj/item/ammo_box/magazine/akm(src)
	new /obj/item/ammo_box/magazine/akm(src)
	new /obj/item/ammo_box/magazine/multi_sprite/makarov(src)
	new /obj/item/ammo_box/magazine/multi_sprite/makarov(src)
	new /obj/item/ammo_box/a762(src)
	new /obj/item/ammo_box/a762(src)
	new /obj/item/ammo_box/a762(src)
	new /obj/item/ammo_box/a762(src)

/obj/structure/secure_closet/personal/cabinet/freighterboss/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/cfa_rifle(src)
	new /obj/item/storage/bag/ammo(src)
	new /obj/item/clothing/suit/armor/bulletproof(src)
	new /obj/storage/belt/utility/syndicate(src)
	new /obj/gps/mining(src)
	new /obj/item/clothing/gloves/combat(src)
	new /obj/storage/backpack/duffelbag/syndie(src)
	new /obj/item/radio(src)
	new /obj/item/ammo_box/magazine/cm68(src)
	new /obj/item/ammo_box/magazine/cm68(src)
	new /obj/item/ammo_box/magazine/cm68(src)


