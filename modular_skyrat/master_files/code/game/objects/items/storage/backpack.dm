/obj/item/storage/backpack/satchel/flat/PopulateContents()
	var/contraband_list = list(
		/obj/item/storage/belt/utility/syndicate = 1,
		/obj/item/storage/toolbox/syndicate = 7,
		/obj/item/card/id/advanced/chameleon = 6,
		/obj/item/stack/spacecash/c5000 = 3,
		/obj/item/stack/telecrystal = 2,
		/obj/item/storage/belt/military = 12,
		/obj/item/storage/fancy/cigarettes/cigpack_syndicate = 8,
		/obj/item/storage/box/fireworks/dangerous = 11,
		/obj/item/clothing/mask/gas/syndicate = 10,
		/obj/item/vending_refill/donksoft = 13,
		/obj/item/ammo_box/foambox/riot = 11,
		/obj/item/soap/syndie = 7,
		/obj/item/reagent_containers/crackbrick = 5,
		/obj/item/reagent_containers/crack = 10,
		/obj/item/reagent_containers/cocaine = 9,
		/obj/item/reagent_containers/cocainebrick = 4,
		/obj/item/reagent_containers/hashbrick = 13, //not contraband, but it'll be good padding, and there'll still be a black market for bulk goods
		/obj/item/reagent_containers/heroin = 8,
		/obj/item/reagent_containers/heroinbrick = 3,
		/obj/item/reagent_containers/blacktar = 12,
		/obj/item/storage/pill_bottle/stimulant = 9, //ephedrine and coffee. Can actually change whether someone gets out of a runaway situation
		/obj/item/clothing/mask/cigarette/pipe/crackpipe = 15,
		/obj/item/toy/cards/deck/syndicate = 10, //1tc, not balance breaking, small but premium commodity
		/obj/item/reagent_containers/cup/bottle/morphine = 8,
		/obj/item/reagent_containers/syringe/contraband/methamphetamine = 12,
		/obj/item/clothing/glasses/sunglasses = 5, //can already be achieved in an arguably better form with just some hacking
	)

	for(var/i in 1 to 3)
		var/contraband_type = pick_weight(contraband_list)
		contraband_list -= contraband_type
		new contraband_type(src)

/obj/item/storage/backpack/satchel/flat/with_tools/PopulateContents()
	new /obj/item/stack/tile/iron/base(src)
	new /obj/item/crowbar(src)
