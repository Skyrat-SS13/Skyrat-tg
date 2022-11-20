/obj/item/storage/backpack/satchel/flat/PopulateContents()
	var/contraband_list = list(
		/obj/item/storage/bag/ammo = 4,
		/obj/item/storage/belt/utility/syndicate = 1,
		/obj/item/storage/toolbox/syndicate = 7,
		/obj/item/card/id/advanced/chameleon = 6,
		/obj/item/stack/spacecash/c5000 = 3,
		/obj/item/stack/telecrystal = 2,
		/obj/item/storage/belt/military = 12,
		/obj/item/storage/pill_bottle/aranesp = 11,
		/obj/item/storage/pill_bottle/happy = 12,
		/obj/item/storage/pill_bottle/stimulant = 9,
		/obj/item/storage/pill_bottle/lsd = 10,
		/obj/item/storage/fancy/cigarettes/cigpack_syndicate = 8,
		/obj/item/storage/fancy/cigarettes/cigpack_shadyjims = 10,
		/obj/item/reagent_containers/cup/glass/bottle/absinthe = 12,
		/obj/item/storage/box/fireworks/dangerous = 11,
		/obj/item/food/grown/cannabis/white = 9,
		/obj/item/food/grown/cannabis = 13,
		/obj/item/food/grown/cannabis/rainbow = 8,
		/obj/item/food/grown/mushroom/libertycap = 11,
		/obj/item/clothing/mask/gas/syndicate = 10,
		/obj/item/vending_refill/donksoft = 13,
		/obj/item/ammo_box/foambox/riot = 11,
		/obj/item/soap/syndie = 7,
	)
	for(var/i in 1 to 3)
		var/contraband_type = pick_weight(contraband_list)
		contraband_list -= contraband_type
		new contraband_type(src)
