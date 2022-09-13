/obj/effect/spawner/random/vending/snackvend
	loot = list(
		/obj/machinery/vending/cultural,
		/obj/machinery/vending/cultural/panslav,
		/obj/machinery/vending/cultural/yangyu,
		/obj/machinery/vending/cultural/mothic,
		/obj/machinery/vending/cultural/tizirian,
	)

/obj/machinery/vending/cultural
	name = "NT Sustenance Supplier"
	desc = "A vending machine serving up only the finest of human college student food."
	icon = 'modular_skyrat/modules/culturalvendors/icons/cultural_vendors.dmi'
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
				/obj/item/food/vendor_tray_meal/side = 7,
				/obj/item/food/vendor_tray_meal/side/crackers_and_jam = 7,
				/obj/item/food/vendor_tray_meal/side/crackers_and_cheese = 7,
			),
		),

		list(
			"name" = "Meals",
			"icon" = "pizza-slice",
			"products" = list(
				/obj/item/storage/box/foodpack/nt = 5,
				/obj/item/storage/box/foodpack/nt/burger = 5,
				/obj/item/storage/box/foodpack/nt/chickensammy = 5,
			),
		),
	)

	refill_canister = /obj/item/vending_refill/snack
	default_price = PAYCHECK_CREW * 0.5
	extra_price = PAYCHECK_COMMAND
	payment_department = NO_FREEBIES

	/// What language should this vendor speak, for flavor reasons
	var/language_to_speak = /datum/language/common

/obj/machinery/vending/cultural/Initialize(mapload)
	. = ..()
	var/datum/language_holder/vendor_languages = get_language_holder()
	grant_all_languages()
	vendor_languages.selected_language = language_to_speak

/obj/machinery/vending/cultural/panslav
	name = "NRI Surplus Meal Pack Vendor"
	desc = "Sponsored by the NRI to feed station crews, the screen shows more propaganda than it does food, it'd seem."
	icon_state = "panslavfood"
	light_mask = "panslavfood-light-mask"
	light_color = LIGHT_COLOR_ELECTRIC_GREEN
	product_slogans = "Guaranteed fresh, even from the vacuum of space!;The same meals our loyal soldiers eat!;Ten percent of all proceeds go to funding the NRI!"
	product_categories = list(
		list(
			"name" = "Snacks",
			"icon" = "cookie",
			"products" = list(
				/obj/item/food/vendor_tray_meal/side/rye = 7,
				/obj/item/food/vendor_tray_meal/side/breadsticks = 7,
				/obj/item/food/vendor_tray_meal/side/sunflower_seeds = 7,
			),
		),

		list(
			"name" = "Meals",
			"icon" = "pizza-slice",
			"products" = list(
				/obj/item/storage/box/foodpack/panslav = 5,
				/obj/item/storage/box/foodpack/panslav/potatocakes = 5,
				/obj/item/storage/box/foodpack/panslav/beetsoup = 5,
			),
		),
	)

	language_to_speak = /datum/language/panslavic

/obj/machinery/vending/cultural/yangyu
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
				/obj/item/food/vendor_tray_meal/side/miso = 7,
				/obj/item/food/vendor_tray_meal/side/rice = 7,
				/obj/item/food/vendor_tray_meal/side/pickled_vegetables = 7,
			),
		),

		list(
			"name" = "Meals",
			"icon" = "pizza-slice",
			"products" = list(
				/obj/item/storage/box/foodpack/yangyu = 5,
				/obj/item/storage/box/foodpack/yangyu/sushi = 5,
				/obj/item/storage/box/foodpack/yangyu/beefrice = 5,
			),
		),
	)

	language_to_speak = /datum/language/yangyu

/obj/machinery/vending/cultural/mothic
	name = "Nomad Fleet Ration Chit Exchange"
	desc = "One of the nomad fleet's own ration vendors, converted to use credits instead of ration chits as the name would imply."
	icon_state = "mothfood"
	light_mask = "mothfood-light-mask"
	light_color = LIGHT_COLOR_HALOGEN
	product_slogans = "Support the fleet, conserve rations today!;Some options in reduced portion and cost!;Do your part to keep the fleet flying!"
	product_categories = list(
		list(
			"name" = "Snacks",
			"icon" = "cookie",
			"products" = list(
				/obj/item/food/vendor_tray_meal/side/moffin = 7,
				/obj/item/food/vendor_tray_meal/side/cornbread = 7,
				/obj/item/food/vendor_tray_meal/side/roasted_seeds = 7,
			),
		),

		list(
			"name" = "Meals",
			"icon" = "pizza-slice",
			"products" = list(
				/obj/item/storage/box/foodpack/moth = 5,
				/obj/item/storage/box/foodpack/moth/bakedrice = 5,
				/obj/item/storage/box/foodpack/moth/fueljack = 5,
			),
		),
	)

	language_to_speak = /datum/language/moffic

/obj/machinery/vending/cultural/tizirian
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
				/obj/item/food/vendor_tray_meal/side/root_crackers = 7,
				/obj/item/food/vendor_tray_meal/side/korta_brittle = 7,
				/obj/item/food/vendor_tray_meal/side/crispy_headcheese = 7,
			),
		),

		list(
			"name" = "Meals",
			"icon" = "pizza-slice",
			"products" = list(
				/obj/item/storage/box/foodpack/tiziria = 5,
				/obj/item/storage/box/foodpack/tiziria/roll = 5,
				/obj/item/storage/box/foodpack/tiziria/stirfry = 5,
			),
		),
	)

	language_to_speak = /datum/language/draconic

/* Pending part 2 of the cultural stuff
/obj/machinery/vending/cultural/tizirian/drinks
	name = "Tizirian Imported Drinks"
	desc = "A vendor serving a selection of Tizirian name brand drinks and alcohols."
	icon_state = "tiziriadrink"
	light_mask = "tiziriadrink-light-mask"
	product_slogans = "Ceremonial grade mushroom tea, hand ground!;Naturally spiced kortara, TFHSA certified!;A taste of a home far away, in convenient can form!"
	product_categories = list(
		list(
			"name" = "Drinks",
			"icon" = "mug-hot",
			"products" = list(
				/obj/ = 1,
			),
		),
	)

/obj/machinery/vending/cultural/synthdrinks
	name = "Mal F. Unction's Robotic Brews"
	desc = "A vendor of little known origin selling drinks that anything not made of silicon probably shouldn't consume."
	icon_state = "robodrink"
	light_mask = "robodrink-light-mask"
	light_color = LIGHT_COLOR_HALOGEN
	product_slogans = "Turrets to thirsty, crack a can open!;One-hundred percent pure, caffeinated oil!;Now that's a clean burning energy drink, I tell you h'what!"
	vend_reply = "Contents are likely flammable, you have been warned!"
	product_categories = list(
		list(
			"name" = "Drinks",
			"icon" = "mug-hot",
			"products" = list(
				/obj/ = 1,
			),
		),
	)

	language_to_speak = /datum/language/machine

/obj/machinery/vending/cultural/mothic/drinks
	name = "Nomad Fleet Beverage Chit Exchange"
	desc = "Second only to airlocks, the most used machine aboard Nomad Fleet ships, for some reason."
	icon_state = "mothdrink"
	light_mask = "mothdrink-light-mask"
	product_categories = list(
		list(
			"name" = "Drinks",
			"icon" = "mug-hot",
			"products" = list(
				/obj/ = 1,
			),
		),
	)
*/
