/obj/structure/closet/secure_closet/brigoff
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	name = "corrections officer riot gear"
	icon_state = "riot"
	door_anim_time = 0 //CONVERT THESE DOORS YOU LAZY ASSHATS

/obj/structure/closet/secure_closet/brigoff/PopulateContents()
	..()
	new /obj/item/clothing/suit/armor/riot(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/clothing/shoes/combat/peacekeeper(src)
	new /obj/item/clothing/head/helmet/riot(src)
	new /obj/item/shield/riot(src)
	new /obj/item/clothing/under/rank/security/brigguard(src)
