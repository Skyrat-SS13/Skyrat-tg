/obj/structure/closet/secure_closet/blueshield
	name = "\the blueshield's locker"
	icon_state = "bs"
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	req_access = list(ACCESS_CAPTAIN)

/obj/structure/closet/secure_closet/blueshield/New()
	..()
	new /obj/item/storage/secure/briefcase(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/clothing/glasses/hud/security/sunglasses(src)
	new /obj/item/clothing/suit/hooded/wintercoat/skyrat/blueshield(src)
	new /obj/item/storage/medkit/tactical/blueshield(src)
