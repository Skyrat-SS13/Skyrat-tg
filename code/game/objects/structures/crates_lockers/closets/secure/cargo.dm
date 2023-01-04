/obj/structure/closet/secure_closet/quartermaster
	name = "\proper quartermaster's locker"
	req_access = list(ACCESS_QM)
	icon_state = "qm"

/obj/structure/closet/secure_closet/quartermaster/PopulateContents()
	..()
	new /obj/item/clothing/neck/cloak/qm(src)
	new /obj/item/storage/lockbox/medal/cargo(src)
	// SKYRAT EDIT REMOVAL BEGIN - MOVED TO COMMAND CLOTHING VENDOR
	/*
	new /obj/item/clothing/under/rank/cargo/qm(src)
	new /obj/item/clothing/under/rank/cargo/qm/skirt(src)
	new /obj/item/clothing/shoes/sneakers/brown(src)
	new /obj/item/clothing/gloves/fingerless(src) // Why does the QM spawn with generic gloves
	new /obj/item/clothing/mask/gas(src) // Why does the QM spawn with a generic gas mask
	new /obj/item/clothing/head/soft(src) // Why does the QM spawn with a generic soft cap
	*/
	new /obj/item/radio/headset/heads/qm(src)
	new /obj/item/clothing/suit/utility/fire/firefighter(src)
	new /obj/item/clothing/gloves/fingerless(src)
	new /obj/item/megaphone/cargo(src)
	new /obj/item/tank/internals/emergency_oxygen(src)
	new /obj/item/universal_scanner(src)
	new /obj/item/door_remote/quartermaster(src)
	new /obj/item/circuitboard/machine/techfab/department/cargo(src)
	new /obj/item/storage/photo_album/qm(src)
	new /obj/item/circuitboard/machine/ore_silo(src)
	new /obj/item/clothing/suit/hooded/wintercoat/cargo/qm(src)
	new /obj/item/gun/ballistic/rifle/boltaction/brand_new/quartermaster(src) // SKYRAT EDIT - The QM's 'special' head item. It spawns loaded, but you have to find more ammo if you run out and get ready to manually load rounds in!
	new /obj/item/cargo_teleporter(src) // SKYRAT EDIT - Adds a cargo teleporter to QM locker, so they can intice others to research it
	new /obj/item/clothing/glasses/hud/gun_permit/sunglasses(src) //SKYRAT EDIT - GUN CARGO

/obj/structure/closet/secure_closet/quartermaster/populate_contents_immediate()
	. = ..()

	// Traitor steal objective
	new /obj/item/card/id/departmental_budget/car(src)
