/obj/structure/closet/secure_closet/brigoff
	icon = 'modular_skyrat/modules/brigoff/icons/lockers/closet.dmi'
	name = "brig officer riot gear"
	icon_state = "riot"

/obj/structure/closet/secure_closet/warden/brigoff/PopulateContents()
	. = ..()
	new /obj/item/clothing/suit/armor/riot(src)
	new /obj/item/storage/belt/security/full(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/clothing/shoes/combat/peacekeeper(src)
	new /obj/item/clothing/head/helmet/riot(src)
	new /obj/item/shield/riot(src)
	new /obj/item/clothing/under/rank/security/brigguard(src)
