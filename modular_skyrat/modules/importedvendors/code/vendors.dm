/obj/effect/spawner/random/vending/snackvend
	loot = list(
		/obj/machinery/vending/imported,
		/obj/machinery/vending/imported/yangyu,
		/obj/machinery/vending/imported/mothic,
		/obj/machinery/vending/imported/tizirian,
	)

/obj/machinery/vending/imported
	name = "NT Sustenance Supplier"
	desc = "A vending machine serving up only the finest of human college student food."
	icon = 'modular_skyrat/modules/importedvendors/icons/imported_vendors.dmi'
	icon_state = "ntfood"
	panel_type = "panel15"
	light_mask = "ntfood-light-mask"
	light_color = LIGHT_COLOR_LIGHT_CYAN
	product_slogans = "Caution, contents may be selling hot!;Look at these low prices!;Hungry? Me too, wait no you didn't hear that!"
	product_categories = list(
		list(
			"name" = "Snacks",
			"icon" = "cookie",
			"products" = list(
				/obj/item/food/peanuts/random = 6,
				/obj/item/food/cnds/random = 6,
				/obj/item/food/pistachios = 6,
				/obj/item/food/cornchips/random = 6,
				/obj/item/food/sosjerky = 6,
				/obj/item/reagent_containers/cup/soda_cans/cola = 6,
				/obj/item/reagent_containers/cup/soda_cans/lemon_lime = 6,
				/obj/item/reagent_containers/cup/soda_cans/starkist = 6,
				/obj/item/reagent_containers/cup/soda_cans/pwr_game = 6,
			),
		),
		list(
			"name" = "Meals",
			"icon" = "pizza-slice",
			"products" = list(
				/obj/item/storage/box/foodpack/nt = 6,
				/obj/item/storage/box/foodpack/nt/burger = 6,
				/obj/item/storage/box/foodpack/nt/chickensammy = 6,
				/obj/item/food/vendor_tray_meal/side = 6,
				/obj/item/food/vendor_tray_meal/side/crackers_and_jam = 6,
				/obj/item/food/vendor_tray_meal/side/crackers_and_cheese = 6,
			),
		),
	)

	refill_canister = /obj/item/vending_refill/snack
	default_price = PAYCHECK_CREW * 0.5
	extra_price = PAYCHECK_COMMAND
	payment_department = NO_FREEBIES

	/// What language should this vendor speak, for flavor reasons
	var/language_to_speak = /datum/language/common

/obj/machinery/vending/imported/Initialize(mapload)
	. = ..()
	var/datum/language_holder/vendor_languages = get_language_holder()
	grant_all_languages()
	vendor_languages.selected_language = language_to_speak

/obj/machinery/vending/imported/yangyu
	name = "質の高い食品ベンダー"
	desc = "A vendor selling traditionally sol eastern foods of dubious quality, 'don't trust the sushi' is written on the side in marker."
	icon_state = "yangyufood"
	light_mask = "yangyufood-light-mask"
	light_color = LIGHT_COLOR_FLARE
	product_slogans = "Fresh farmed space carp from local space!;Imitation lobstrocity sushi choices availible!;Made with traditional recipes and care!"
	product_categories = list(
		list(
			"name" = "Snacks",
			"icon" = "cookie",
			"products" = list(
				/obj/item/reagent_containers/cup/glass/dry_ramen/prepared = 6,
				/obj/item/reagent_containers/cup/glass/dry_ramen/prepared/hell = 6,
				/obj/item/food/vendor_snacks/ricecrackers = 6,
				/obj/item/food/vendor_snacks/mochi_icecream = 6,
				/obj/item/food/vendor_snacks/mochi_icecream/matcha = 6,
				/obj/item/reagent_containers/cup/glass/waterbottle/tea = 6,
				/obj/item/reagent_containers/cup/glass/waterbottle/tea/astra = 6,
				/obj/item/reagent_containers/cup/glass/waterbottle/tea/strawberry = 6,
				/obj/item/reagent_containers/cup/glass/waterbottle/tea/nip = 6,
			),
		),
		list(
			"name" = "Meals",
			"icon" = "pizza-slice",
			"products" = list(
				/obj/item/storage/box/foodpack/yangyu = 6,
				/obj/item/storage/box/foodpack/yangyu/sushi = 6,
				/obj/item/storage/box/foodpack/yangyu/beefrice = 6,
				/obj/item/food/vendor_tray_meal/side/miso = 6,
				/obj/item/food/vendor_tray_meal/side/rice = 6,
				/obj/item/food/vendor_tray_meal/side/pickled_vegetables = 6,
			),
		),
	)

	language_to_speak = /datum/language/yangyu

/obj/machinery/vending/imported/mothic
	name = "Nomad Fleet Ration Chit Exchange"
	desc = "One of the nomad fleet's own ration vendors, don't mind the name engraving, this machine just takes credits."
	icon_state = "mothfood"
	light_mask = "mothfood-light-mask"
	light_color = LIGHT_COLOR_HALOGEN
	product_slogans = "Support the fleet, conserve rations today!;Some options in reduced portion and cost!;Do your part to keep the fleet flying!"
	product_categories = list(
		list(
			"name" = "Snacks",
			"icon" = "cookie",
			"products" = list(
				/obj/item/food/vendor_snacks/mothmallow = 6,
				/obj/item/food/vendor_snacks/moth_bagged = 6,
				/obj/item/food/vendor_snacks/moth_bagged/fueljack = 6,
				/obj/item/food/vendor_snacks/moth_bagged/cheesecake = 6,
				/obj/item/food/vendor_snacks/moth_bagged/cheesecake/honey = 6,
				/obj/item/reagent_containers/cup/soda_cans/skyrat/lemonade = 6,
				/obj/item/reagent_containers/cup/soda_cans/skyrat/navyrum = 6,
				/obj/item/reagent_containers/cup/soda_cans/skyrat/sodawater_moth = 6,
				/obj/item/reagent_containers/cup/soda_cans/skyrat/ginger_beer = 6,
			),
		),
		list(
			"name" = "Meals",
			"icon" = "pizza-slice",
			"products" = list(
				/obj/item/storage/box/foodpack/moth = 6,
				/obj/item/storage/box/foodpack/moth/bakedrice = 6,
				/obj/item/storage/box/foodpack/moth/fueljack = 6,
				/obj/item/food/vendor_tray_meal/side/moffin = 6,
				/obj/item/food/vendor_tray_meal/side/cornbread = 6,
				/obj/item/food/vendor_tray_meal/side/roasted_seeds = 6,
			),
		),
	)

	language_to_speak = /datum/language/moffic

/obj/machinery/vending/imported/tizirian
	name = "Tizirian Imported Delicacies"
	desc = "A vendor serving a fine collection of what is very likely knock-offs of popular Tizirian brands."
	icon_state = "tiziriafood"
	light_mask = "tiziriafood-light-mask"
	light_color = LIGHT_COLOR_FIRE
	product_slogans = "Real imports from the capital itself, we promise!;Rare selections of salt water catch!;Moonfish glaze included with all meat options!"
	product_categories = list(
		list(
			"name" = "Snacks",
			"icon" = "cookie",
			"products" = list(
				/obj/item/food/chips/shrimp = 6,
				/obj/item/food/vendor_snacks/lizard_bagged = 6,
				/obj/item/food/vendor_snacks/lizard_bagged/moonjerky = 6,
				/obj/item/food/vendor_snacks/lizard_boxed = 6,
				/obj/item/food/vendor_snacks/lizard_boxed/sweetroll = 6,
				/obj/item/reagent_containers/cup/glass/bottle/mushi_kombucha = 6,
				/obj/item/reagent_containers/cup/glass/waterbottle/tea/mushroom = 6,
				/obj/item/reagent_containers/cup/soda_cans/skyrat/kortara = 6,
			),
		),
		list(
			"name" = "Meals",
			"icon" = "pizza-slice",
			"products" = list(
				/obj/item/storage/box/foodpack/tiziria = 6,
				/obj/item/storage/box/foodpack/tiziria/roll = 6,
				/obj/item/storage/box/foodpack/tiziria/stirfry = 6,
				/obj/item/food/vendor_tray_meal/side/root_crackers = 6,
				/obj/item/food/vendor_tray_meal/side/korta_brittle = 6,
				/obj/item/food/vendor_tray_meal/side/crispy_headcheese = 6,
			),
		),
	)

	language_to_speak = /datum/language/draconic
