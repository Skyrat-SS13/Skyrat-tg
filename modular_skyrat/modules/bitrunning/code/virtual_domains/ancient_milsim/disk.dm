/obj/item/bitrunning_disk/item/ancient_milsim
	name = "bitrunning gear: ancient milsim"
	selectable_items = list(
		/obj/item/storage/box/armor_set/ancient_milsim,
		/obj/item/gun/ballistic/automatic/sol_rifle/machinegun,
		/obj/item/shield/riot/pointman/nri,
	)

/obj/item/storage/box/armor_set/ancient_milsim
	name = "VOSKHOD armor set"
	desc = "Box containing a damage-resistant regenerating armor suit and helmet."

/obj/item/storage/box/armor_set/ancient_milsim/PopulateContents()
	new /obj/item/clothing/suit/space/hev_suit/nri(src)
	new /obj/item/clothing/head/helmet/space/hev_suit/nri(src)
