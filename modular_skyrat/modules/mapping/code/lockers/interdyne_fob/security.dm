/obj/structure/closet/secure_closet/interdynefob/prisoner_locker
	name = "prisoner item locker"
	req_access = list("syndicate_leader")

/obj/structure/closet/secure_closet/interdynefob/brig_officer_locker
	icon_door = "sec"
	icon_state = "sec"
	name = "brig officer gear locker"
	req_access = list("syndicate_leader")

/obj/item/clothing/suit/toggle/jacket/sec/old/syndicate
	name = "brig officer jacket"

/obj/item/clothing/accessory/armband/syndicate
	name = "brig officer armband"
	desc ="An armband, worn by the FOB's operatives to display which department they're assigned to."

/obj/item/storage/bag/garment/brig_officer
	name = "brig officer's garment bag"
	desc = "A bag for storing extra clothes and shoes. This one belongs to a brig officer."

/obj/item/storage/bag/garment/brig_officer/PopulateContents()
	new /obj/item/clothing/under/rank/security/skyrat/utility/redsec/syndicate(src)
	new /obj/item/clothing/head/beret/sec/syndicate(src)
	new /obj/item/clothing/accessory/armband(src)
	new /obj/item/clothing/mask/gas/syndicate(src)
	new /obj/item/clothing/suit/toggle/jacket/sec/old/syndicate(src)
	new /obj/item/clothing/mask/gas/sechailer/syndicate(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/eyepatch/redsec(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses/redsec(src)

/obj/structure/closet/secure_closet/interdynefob/brig_officer_locker/PopulateContents()
	..()

	new /obj/item/storage/belt/security/full(src)
	new /obj/item/gun/energy/disabler(src)
	new /obj/item/storage/bag/garment/brig_officer(src)
	new /obj/item/radio/headset/interdyne(src)

/obj/structure/closet/secure_closet/interdynefob/armory_gear_locker
	anchored = 1
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_door = "riot"
	icon_state = "riot"
	name = "armory gear locker"
	req_access = list("syndicate_leader")

/obj/structure/closet/secure_closet/interdynefob/armory_gear_locker/PopulateContents()
	..()

	new /obj/item/storage/belt/holster/nukie(src)
	new /obj/item/storage/belt/holster/nukie(src)
	new /obj/item/storage/belt/holster/nukie(src)
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/clothing/suit/armor/vest(src)
	new /obj/item/storage/belt/military(src)
	new /obj/item/storage/belt/military(src)
	new /obj/item/storage/belt/military(src)
	new /obj/item/clothing/head/helmet(src)
	new /obj/item/clothing/head/helmet(src)
	new /obj/item/clothing/head/helmet(src)

/obj/structure/closet/secure_closet/interdynefob/munitions_locker
	anchored = 1;
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	icon_door = "riot"
	icon_state = "riot"
	name = "armory munitions locker"

/obj/structure/closet/secure_closet/interdynefob/munitions_locker/PopulateContents()
	..()

	generate_items_inside(list(
		/obj/item/ammo_box/magazine/c35sol_pistol = 6,
		/obj/item/ammo_box/magazine/c35sol_pistol/stendo = 2,
		/obj/item/ammo_box/c35sol = 2,
		/obj/item/ammo_box/magazine/c40sol_rifle/standard = 2,
		/obj/item/ammo_box/c40sol = 2,
		/obj/item/ammo_box/advanced/s12gauge = 2,
		/obj/item/ammo_box/advanced/s12gauge/rubber = 2,
	),src)
