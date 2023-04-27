/obj/item/storage/belt/military/nri/captain/pirate_officer/PopulateContents()
	generate_items_inside(list(
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/flashbang = 1,
		),
		src,
	)

/obj/item/storage/belt/security/nri/PopulateContents()
	generate_items_inside(list(
		/obj/item/knife/combat = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/grenade/flashbang = 1,
		),
		src,
	)

/obj/item/storage/box/nri_survival_pack/raider
	desc = "A box filled with useful emergency items, supplied by the NRI. It feels particularily light."

/obj/item/storage/box/nri_survival_pack/raider/PopulateContents()
	new /obj/item/oxygen_candle(src)
	new /obj/item/tank/internals/emergency_oxygen(src)
	new /obj/item/stack/spacecash/c1000(src)
	new /obj/item/storage/pill_bottle/iron(src)
	new /obj/item/reagent_containers/hypospray/medipen(src)
	new /obj/item/flashlight/flare(src)
	new /obj/item/crowbar/red(src)
