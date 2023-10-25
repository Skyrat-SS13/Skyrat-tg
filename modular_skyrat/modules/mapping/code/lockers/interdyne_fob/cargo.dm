/obj/structure/closet/secure_closet/interdynefob/mining_locker
	icon_door = "mining"
	icon_state = "mining"
	name = "mining gear locker"

/obj/item/clothing/accessory/armband/cargo/syndicate
	name = "mining officer armband"
	desc = "An armband, worn by the FOB's operatives to display which department they're assigned to."

/obj/structure/closet/secure_closet/interdynefob/mining_locker/PopulateContents()
	..()

	new /obj/item/storage/bag/ore(src)
	new /obj/item/mining_scanner(src)
	new /obj/item/storage/belt/mining/alt(src)
	new /obj/item/clothing/under/syndicate/skyrat/overalls(src)
	new /obj/item/storage/backpack/satchel/explorer(src)
	new /obj/item/storage/backpack/explorer(src)
	new /obj/item/storage/backpack/messenger/explorer(src)
	new /obj/item/clothing/accessory/armband/cargo/syndicate(src)

/obj/structure/closet/secure_closet/interdynefob/mining_locker/populate_contents_immediate()
	. = ..()

	new /obj/item/gun/energy/recharge/kinetic_accelerator(src)
