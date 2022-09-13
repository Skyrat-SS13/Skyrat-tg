/obj/item/trash/empty_food_tray
	name = "empty plastic food tray"
	desc = "The condensation and what you can only hope are the leftovers of food make this a bit hard to reuse."
	icon = 'modular_skyrat/modules/importedvendors/icons/imported_quick_foods.dmi'
	icon_state = "foodtray_empty"
	custom_materials = list(/datum/material/plastic=1000)

/obj/item/trash/empty_side_pack
	name = "empty side wrapper"
	desc = "Unfortunately, this no longer holds any sides to distract you from the other 'food'."
	icon = 'modular_skyrat/modules/importedvendors/icons/imported_quick_foods.dmi'
	icon_state = "foodpack_generic_trash"
	custom_materials = list(/datum/material/plastic=1000)

/obj/item/trash/empty_side_pack/nt
	icon_state = "foodpack_nt_trash"

/obj/item/trash/empty_side_pack/panslav
	icon_state = "foodpack_panslav_trash"

/obj/item/trash/empty_side_pack/yangyu
	icon_state = "foodpack_yangyu_trash"

/obj/item/trash/empty_side_pack/moth
	icon_state = "foodpack_moth_trash"

/obj/item/trash/empty_side_pack/tiziria
	icon_state = "foodpack_tiziria_trash"

/obj/item/food/vendor_tray_meal
	name = "\improper NT-Meal: Steak and Macaroni"
	desc = "A 'salisbury steak' drowning in something similar to a gravy, with a macaroni and cheese substitute mix sitting right beside it."
	icon = 'modular_skyrat/modules/importedvendors/icons/imported_quick_foods.dmi'
	icon_state = "foodtray_sadsteak"
	trash_type = /obj/item/trash/empty_food_tray
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("meat?" = 2, "cheese?" = 2, "laziness" = 1)
	foodtypes = MEAT | GRAIN | DAIRY | JUNKFOOD
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	///Does this food have the steam effect on it when initialized
	var/hot_and_steamy = TRUE

/obj/item/food/vendor_tray_meal/Initialize(mapload)
	. = ..()
	if(hot_and_steamy)
		overlays += mutable_appearance('icons/effects/steam.dmi', "steam_triple", ABOVE_OBJ_LAYER)

/obj/item/food/vendor_tray_meal/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>You browse the back of the box...</i>")
	. += "\t[span_warning("Warning: Packaged in a factory where every allergen known is present.")]"
	. += "\t[span_warning("Warning: Contents might be hot.")]"
	. += "\t[span_info("Per 200g serving contains: 8g Sodium; 25g Fat, of which 22g are saturated; 2g Sugar.")]"
	return .

/obj/item/food/vendor_tray_meal/burger
	name = "\improper NT-Meal: Cheeseburger"
	desc = "A pretty sad looking burger with a kinda soggy bottom bun and highlighter yellow cheese."
	icon_state = "foodtray_burg"
	tastes = list("bread" = 2, "meat?" = 2, "cheese?" = 2, "laziness" = 1)
	foodtypes = MEAT | GRAIN | DAIRY | JUNKFOOD

/obj/item/food/vendor_tray_meal/chicken_sandwich
	name = "\improper NT-Meal: Spicy Chicken Sandwich"
	desc = "A pretty sad looking chicken sandwich, the 'meat' itself covered in so many manufactured spices that it has become an eerie red color."
	icon_state = "foodtray_chickiesandwich"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/capsaicin = 10)
	tastes = list("bread" = 2, "chicken?" = 2, "overwhelming spice" = 2, "laziness" = 1)
	foodtypes = MEAT | GRAIN | DAIRY | JUNKFOOD

/obj/item/food/vendor_tray_meal/meat_pie
	name = "\improper Main Course: Meat Pastry"
	desc = "A relatively rectangular pastry stuffed with what you can only hope is a ground meat."
	icon_state = "foodtray_meatpie"
	tastes = list("meat?" = 2, "pastry" = 2, "laziness" = 1)
	foodtypes = MEAT | GRAIN | JUNKFOOD

/obj/item/food/vendor_tray_meal/potato_pancakes
	name = "\improper Main Course: Flattened Potato Cakes"
	desc = "A pair of flat potato pancakes, pretty much just shredded potato in a flat, 'pan fried' form in this case."
	icon_state = "foodtray_potatocake"
	tastes = list("potato" = 2, "laziness" = 1)
	foodtypes = BREAKFAST | JUNKFOOD

/obj/item/food/vendor_tray_meal/beet_soup
	name = "\improper Main Course: Red Beet Soup"
	desc = "A worryingly desaturated soup supposedly made from red beets, at least its warm."
	icon_state = "foodtray_redsoup"
	tastes = list("beets?" = 2, "laziness" = 1)
	foodtypes = VEGETABLES | JUNKFOOD

/obj/item/food/vendor_tray_meal/ramen
	name = "\improper メインコース: Homestyle Noodles"
	desc = "A brick of the finest factory made ramen, with a small amount of rehydrated vegetables and herbs floating around."
	icon_state = "foodtray_noodle"
	tastes = list("cheap noodles" = 2, "laziness" = 1)
	foodtypes = GRAIN | VEGETABLES | JUNKFOOD

/obj/item/food/vendor_tray_meal/sushi
	name = "\improper メインコース: Fresh Carp Rolls"
	desc = "A pair of sushi rolls, the appearance of which would suggest that the label is lying to you."
	icon_state = "foodtray_gasstationsushi"
	tastes = list("imitation space carp" = 2, "stale rice" = 2, "laziness" = 1)
	foodtypes = GRAIN | SEAFOOD | JUNKFOOD

/obj/item/food/vendor_tray_meal/beef_rice
	name = "\improper メインコース: Beef and Fried Rice"
	desc = "A few slices of seemingly grilled beef, paired with far too much rice for how much meat there is."
	icon_state = "foodtray_beefnrice"
	tastes = list("cheap beef" = 1, "rice" = 3, "laziness" = 1)
	foodtypes = GRAIN | MEAT | JUNKFOOD

/obj/item/food/vendor_tray_meal/pesto_pizza
	name = "\improper Main Course - Type M: Pesto Pizza"
	desc = "A rectangular pizza with a suspiciously bright green pesto in place of the standard tomato sauce."
	icon_state = "foodtray_pestopizza"
	tastes = list("tomato?" = 2, "cheese?" = 2, "herbs" = 1, "laziness" = 1)
	foodtypes = GRAIN | DAIRY | VEGETABLES | JUNKFOOD

/obj/item/food/vendor_tray_meal/baked_rice
	name = "\improper Main Course - Type M: Baked Rice and Grilled Cheese"
	desc = "Some sub-par looking fleet style rice, with a generous hunk of quite literally grilled cheese."
	icon_state = "foodtray_ricengrilledcheese"
	tastes = list("rice" = 2, "peppers" = 2, "charred cheese" = 2, "laziness" = 1)
	foodtypes = GRAIN | DAIRY | VEGETABLES | JUNKFOOD

/obj/item/food/vendor_tray_meal/fueljack
	name = "\improper Main Course - Type M: Fueljack's Tray"
	desc = "A flat chunk of fueljack's lunch, seemingly missing most of the usual variety in ingredients."
	icon_state = "foodtray_fueljacksmeal"
	tastes = list("potato" = 2, "cabbage" = 2, "cheese?" = 2, "laziness" = 1)
	foodtypes = DAIRY | VEGETABLES | JUNKFOOD

/obj/item/food/vendor_tray_meal/moonfish_nizaya
	name = "\improper Tiziria Imports: Moonfish and Nizaya"
	desc = "An almost synthetic looking cut of moonfish, paired with an equal helping of nizaya pasta."
	icon_state = "foodtray_moonfishnizaya"
	tastes = list("fish?" = 2, "cheap noodles" = 2, "laziness" = 1)
	foodtypes = VEGETABLES | NUTS | SEAFOOD | JUNKFOOD

/obj/item/food/vendor_tray_meal/emperor_roll
	name = "\improper Tiziria Imports: Emperor Roll"
	desc = "A pretty sad looking emperor roll, if you can even call it that, it seems caviar wasn't in the budget."
	icon_state = "foodtray_emperorroll"
	tastes = list("bread" = 2, "cheese?" = 2, "liver?" = 2, "laziness" = 1)
	foodtypes = VEGETABLES | NUTS | DAIRY | MEAT | GORE | JUNKFOOD

/obj/item/food/vendor_tray_meal/mushroom_fry
	name = "\improper Tiziria Imports: Mushroom Stirfry"
	desc = "A mix of what was likely mushrooms too low quality to be used in making actual food, lightly fried and tossed in a plastic container together."
	icon_state = "foodtray_shroomfry"
	tastes = list("mushroom" = 4, "becoming rich" = 1, "laziness" = 1)
	foodtypes = VEGETABLES | JUNKFOOD

/obj/effect/spawner/random/vendor_meal_sides
	name = "random side spawner"
	desc = "I hope I get one that actually matches my meal."
	icon_state = "loot"

/obj/effect/spawner/random/vendor_meal_sides/nt
	name = "random nt side spawner"

/obj/effect/spawner/random/vendor_meal_sides/nt/Initialize(mapload)
	loot = list(
		/obj/item/food/vendor_tray_meal/side,
		/obj/item/food/vendor_tray_meal/side/crackers_and_jam,
		/obj/item/food/vendor_tray_meal/side/crackers_and_cheese,
	)
	. = ..()

/obj/item/food/vendor_tray_meal/side
	name = "\improper NT-Side: Flatbread and Peanut Butter"
	desc = "A small stack of tough flatbread, and a small spread of peanut butter for each."
	icon_state = "foodpack_nt"
	trash_type = /obj/item/trash/empty_side_pack/nt
	food_reagents = list(/datum/reagent/consumable/nutriment = 3)
	tastes = list("tough bread" = 2, "peanut butter" = 2)
	foodtypes = GRAIN | JUNKFOOD
	hot_and_steamy = FALSE
	custom_price = PAYCHECK_LOWER * 2.5

/obj/item/food/vendor_tray_meal/side/crackers_and_jam
	name = "\improper NT-Side: Flatbread and Berry Jelly"
	desc = "A small stack of tough flatbread, and a small spread of nondescript berry jelly for each."
	tastes = list("tough bread" = 2, "berries" = 2)
	foodtypes = GRAIN | FRUIT | JUNKFOOD

/obj/item/food/vendor_tray_meal/side/crackers_and_cheese
	name = "\improper NT-Side: Flatbread and Cheese Spread"
	desc = "A small stack of tough flatbread, and a small spread of cheese for each."
	tastes = list("tough bread" = 2, "cheese" = 2)
	foodtypes = GRAIN | DAIRY | JUNKFOOD

/obj/effect/spawner/random/vendor_meal_sides/panslav
	name = "random pan-slavic side spawner"

/obj/effect/spawner/random/vendor_meal_sides/panslav/Initialize(mapload)
	loot = list(
		/obj/item/food/vendor_tray_meal/side/rye,
		/obj/item/food/vendor_tray_meal/side/breadsticks,
		/obj/item/food/vendor_tray_meal/side/sunflower_seeds,
	)
	. = ..()

/obj/item/food/vendor_tray_meal/side/rye
	name = "\improper Side Course: Rye Bread Slices"
	desc = "A small stack of rye bread slices, a great pairing with beet soup if you've got any around."
	icon_state = "foodpack_panslav"
	trash_type = /obj/item/trash/empty_side_pack/panslav
	tastes = list("rye" = 2)

/obj/item/food/vendor_tray_meal/side/breadsticks
	name = "\improper Side Course: Breadsticks"
	desc = "A small assortment of distinctly pan-slavic breadsticks, these seem stale enough to double as a stabbing weapon in an emergency."
	icon_state = "foodpack_panslav"
	trash_type = /obj/item/trash/empty_side_pack/panslav
	tastes = list("hard bread" = 2)

/obj/item/food/vendor_tray_meal/side/sunflower_seeds
	name = "\improper Side Course: Sunflower Seeds"
	desc = "Certainly not a repackaged pack of Semki brand sunflower seeds."
	icon_state = "foodpack_panslav"
	trash_type = /obj/item/trash/empty_side_pack/panslav
	tastes = list("sunflower seeds" = 2)
	foodtypes = NUTS | JUNKFOOD

/obj/effect/spawner/random/vendor_meal_sides/yangyu
	name = "random yangyu side spawner"

/obj/effect/spawner/random/vendor_meal_sides/yangyu/Initialize(mapload)
	loot = list(
		/obj/item/food/vendor_tray_meal/side/miso,
		/obj/item/food/vendor_tray_meal/side/rice,
		/obj/item/food/vendor_tray_meal/side/pickled_vegetables,
	)
	. = ..()

/obj/item/food/vendor_tray_meal/side/miso
	name = "\improper 副菜: Miso Soup"
	desc = "This is quite literally just a plastic bag full of miso soup, remember to only open it on the side facing up."
	icon_state = "foodpack_yangyu"
	trash_type = /obj/item/trash/empty_side_pack/yangyu
	tastes = list("miso" = 2)
	foodtypes = VEGETABLES | BREAKFAST | JUNKFOOD

/obj/item/food/vendor_tray_meal/side/rice
	name = "\improper 副菜: White Rice"
	desc = "A bag stuffed full of white rice, in case your meal didn't come with enough to sate your needs."
	icon_state = "foodpack_yangyu"
	trash_type = /obj/item/trash/empty_side_pack/yangyu
	tastes = list("old rice" = 2)
	foodtypes = GRAIN | JUNKFOOD

/obj/item/food/vendor_tray_meal/side/pickled_vegetables
	name = "\improper 副菜: Pickled Vegetables"
	desc = "Contains a small assortment of vegetables picked in a vinegar-like solution."
	icon_state = "foodpack_yangyu"
	trash_type = /obj/item/trash/empty_side_pack/yangyu
	tastes = list("vinegar" = 4)
	foodtypes = VEGETABLES | JUNKFOOD

/obj/effect/spawner/random/vendor_meal_sides/moth
	name = "random mothic side spawner"

/obj/effect/spawner/random/vendor_meal_sides/moth/Initialize(mapload)
	loot = list(
		/obj/item/food/vendor_tray_meal/side/moffin,
		/obj/item/food/vendor_tray_meal/side/cornbread,
		/obj/item/food/vendor_tray_meal/side/roasted_seeds,
	)
	. = ..()

/obj/item/food/vendor_tray_meal/side/moffin
	name = "\improper Side Course - Type M: Moffin"
	desc = "The result of taking a perfectly fine moffin, and flattening it into a more wafer-like form."
	icon_state = "foodpack_moth"
	trash_type = /obj/item/trash/empty_side_pack/moth
	tastes = list("fabric?" = 2, "sugar" = 2)
	foodtypes = CLOTH | GRAIN | SUGAR | BREAKFAST | JUNKFOOD

/obj/item/food/vendor_tray_meal/side/cornbread
	name = "\improper Side Course - Type M: Cornbread"
	desc = "A flattened cut of sweetened cornbread, goes well with butter."
	icon_state = "foodpack_moth"
	trash_type = /obj/item/trash/empty_side_pack/moth
	tastes = list("cornbread" = 2, "sweetness" = 2)
	foodtypes = GRAIN | SUGAR | JUNKFOOD

/obj/item/food/vendor_tray_meal/side/roasted_seeds
	name = "\improper Side Course - Type M: Roasted Seeds"
	desc = "A packet full of various oven roasted seeds."
	icon_state = "foodpack_moth"
	trash_type = /obj/item/trash/empty_side_pack/moth
	tastes = list("seeds" = 2, "char" = 2)
	foodtypes = NUTS | JUNKFOOD

/obj/effect/spawner/random/vendor_meal_sides/tiziria
	name = "random tizirian side spawner"

/obj/effect/spawner/random/vendor_meal_sides/tiziria/Initialize(mapload)
	loot = list(
		/obj/item/food/vendor_tray_meal/side/root_crackers,
		/obj/item/food/vendor_tray_meal/side/korta_brittle,
		/obj/item/food/vendor_tray_meal/side/crispy_headcheese,
	)
	. = ..()

/obj/item/food/vendor_tray_meal/side/root_crackers
	name = "\improper Tiziria Imports: Rootbread Crackers and Pate"
	desc = "A small stack of rootbread crackers, with a small spread of meat pate for each."
	icon_state = "foodpack_tiziria"
	trash_type = /obj/item/trash/empty_side_pack/tiziria
	tastes = list("tough rootbread" = 2, "pate" = 2)
	foodtypes = VEGETABLES | NUTS | MEAT | JUNKFOOD

/obj/item/food/vendor_tray_meal/side/korta_brittle
	name = "\improper Tiziria Imports: Korta Brittle"
	desc = "A perfectly rectangular portion of unsweetened korta brittle."
	icon_state = "foodpack_tiziria"
	trash_type = /obj/item/trash/empty_side_pack/tiziria
	tastes = list("peppery heat" = 2)
	foodtypes = NUTS | JUNKFOOD

/obj/item/food/vendor_tray_meal/side/crispy_headcheese
	name = "\improper Tiziria Imports: Crisped Headcheese"
	desc = "A processed looking block of breaded headcheese."
	icon_state = "foodpack_tiziria"
	trash_type = /obj/item/trash/empty_side_pack/tiziria
	tastes = list("cheese" = 1, "oil" = 1)
	foodtypes = MEAT | VEGETABLES | NUTS | GORE | JUNKFOOD

// Moving away from the packaged stuff now

/obj/item/reagent_containers/cup/glass/dry_ramen/prepared
	name = "cup ramen"
	desc = "This one even comes with water, amazing!"
	list_reagents = list(/datum/reagent/consumable/hot_ramen = 15, /datum/reagent/consumable/salt = 3)

/obj/item/reagent_containers/cup/glass/dry_ramen/prepared/hell
	name = "spicy cup ramen"
	desc = "This one comes with water, AND a security checkpoint's worth of capsaicin!"
	list_reagents = list(/datum/reagent/consumable/hell_ramen = 15, /datum/reagent/consumable/salt = 3)

/obj/item/reagent_containers/cup/glass/waterbottle/tea
	name = "bottle of tea"
	desc = "A bottle of tea brought to you in a convenient plastic bottle."
	icon = 'modular_skyrat/modules/importedvendors/icons/imported_quick_foods.dmi'
	icon_state = "teabottle"
	inhand_icon_state = "bottle"
	list_reagents = list(/datum/reagent/consumable/tea = 40)
	cap_icon_state = "bottle_cap_tea"
	flip_chance = 5 //I fucking dare you
	custom_price = PAYCHECK_LOWER * 1.5
	fill_icon_state = null

/obj/item/reagent_containers/cup/glass/waterbottle/tea/astra
	name = "bottle of tea astra"
	desc = "A bottle of tea astra, known for the rather unusual tastes the leaf is known to give when brewed."
	icon_state = "teabottle_astra"
	list_reagents = list(
		/datum/reagent/consumable/tea = 25,
		/datum/reagent/medicine/salglu_solution = 10, // I know this looks strange but this is what tea astra grinds into, tea in the year 25whatever baby
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	custom_price = PAYCHECK_LOWER * 3

/obj/item/reagent_containers/cup/glass/waterbottle/tea/nip
	name = "bottle of catnip tea"
	desc = "A bottle of catnip tea, required to be at or under a 50% concentration by the SFDA for safety purposes."
	icon_state = "teabottle_nip"
	list_reagents = list(
		/datum/reagent/consumable/catnip_tea = 20,
		/datum/reagent/consumable/tea = 20, // I can't believe they would cut my catnip tea with regular tea
	)
	custom_price = PAYCHECK_LOWER * 4
