/obj/item/storage/box/foodpack
	name = "wrapped meal container"
	desc = "A generic brown paper food package, you aren't quite sure where this comes from."
	icon = 'modular_skyrat/modules/culturalvendors/icons/cultural_quick_foods.dmi'
	icon_state = "foodpack_generic_big"
	illustration = null
	custom_price = PAYCHECK_LOWER * 5
	///What the main course of this package is
	var/main_course
	///What the side of this package should be
	var/side_item
	///What kind of condiment pack should we give the package
	var/condiment_pack

/obj/item/storage/box/foodpack/PopulateContents()
	. = ..()
	new main_course(src)
	new side_item(src)
	new condiment_pack(src)

/obj/item/storage/box/foodpack/nt
	name = "\improper NT-Combo Meal - Salisbury Steak"
	desc = "A relatively bland package made of reflective metal foil, it has a blue sprite and the letters 'NT' printed on the top."
	icon_state = "foodpack_nt_big"
	main_course = /obj/item/food/vendor_tray_meal
	side_item = /obj/effect/spawner/random/vendor_meal_sides/nt
	condiment_pack = /obj/item/reagent_containers/condiment/pack/ketchup

/obj/item/storage/box/foodpack/nt/burger
	name = "\improper NT-Combo Meal - Cheeseburger"
	main_course = /obj/item/food/vendor_tray_meal/burger

/obj/item/storage/box/foodpack/nt/chickensammy
	name = "\improper NT-Combo Meal - Spicy Chicken Sandwich"
	main_course = /obj/item/food/vendor_tray_meal/chicken_sandwich

/obj/item/storage/box/foodpack/panslav
	name = "\improper Готова страва - Meat Pastry"
	desc = "A relatively bland package made of reflective metal foil, the symbol of the NRI, as well as some instructions in pan-slavic are printed on the top."
	icon_state = "foodpack_panslav_big"
	main_course = /obj/item/food/vendor_tray_meal/meat_pie
	side_item = /obj/effect/spawner/random/vendor_meal_sides/panslav
	condiment_pack = /obj/item/reagent_containers/condiment/pack/sugar

/obj/item/storage/box/foodpack/panslav/potatocakes
	name = "\improper Готова страва - Potato Pancakes"
	main_course = /obj/item/food/vendor_tray_meal/potato_pancakes

/obj/item/storage/box/foodpack/panslav/beetsoup
	name = "\improper Готова страва - Red Beet Soup"
	main_course = /obj/item/food/vendor_tray_meal/beet_soup

/obj/item/storage/box/foodpack/yangyu
	name = "\improper 温かい食事 - Homestyle Noodles"
	desc = "A well decorated red and white plastic package, covered in nearly incomprehensible yangyu text."
	icon_state = "foodpack_yangyu_big"
	main_course = /obj/item/food/vendor_tray_meal/ramen
	side_item = /obj/effect/spawner/random/vendor_meal_sides/yangyu
	condiment_pack = /obj/item/reagent_containers/condiment/pack/hotsauce

/obj/item/storage/box/foodpack/yangyu/sushi
	name = "\improper 温かい食事 - Carp Sushi Rolls"
	main_course = /obj/item/food/vendor_tray_meal/sushi

/obj/item/storage/box/foodpack/yangyu/beefrice
	name = "\improper 温かい食事 - Beef and Rice"
	main_course = /obj/item/food/vendor_tray_meal/beef_rice

/obj/item/storage/box/foodpack/moth
	name = "\improper Ration Type M - Pesto Pizza"
	desc = "A cardboard-colored paper package with the symbol of the nomad fleet stamped upon it."
	icon_state = "foodpack_moth_big"
	main_course = /obj/item/food/vendor_tray_meal/pesto_pizza
	side_item = /obj/effect/spawner/random/vendor_meal_sides/moth
	condiment_pack = /obj/item/reagent_containers/condiment/pack/astrotame

/obj/item/storage/box/foodpack/moth/bakedrice
	name = "\improper Ration Type M - Baked Rice and Grilled Cheese"
	main_course = /obj/item/food/vendor_tray_meal/baked_rice

/obj/item/storage/box/foodpack/moth/fueljack
	name = "\improper Ration Type M - Fueljack's Feast"
	main_course = /obj/item/food/vendor_tray_meal/fueljack

/obj/item/storage/box/foodpack/tiziria
	name = "\improper Tiziria Imports Pack - Moonfish Nizaya"
	desc = "A dull, metal foil package with the colors of the tizirian flag striped across it, as well as a stamp of legitimate origin from the Tizirian exports office."
	icon_state = "foodpack_tizira_big"
	main_course = /obj/item/food/vendor_tray_meal/moonfish_nizaya
	side_item = /obj/effect/spawner/random/vendor_meal_sides/tiziria
	condiment_pack = /obj/item/reagent_containers/condiment/pack/bbqsauce

/obj/item/storage/box/foodpack/tiziria/examine_more(mob/user)
	. = ..()
	. += span_notice("<b>Now that you look at it, the origin stamp appears to be a poor imitation of the real thing!</b>")
	return .

/obj/item/storage/box/foodpack/tiziria/roll
	name = "\improper Tiziria Imports Pack - Emperor Roll"
	main_course = /obj/item/food/vendor_tray_meal/emperor_roll

/obj/item/storage/box/foodpack/tiziria/stirfry
	name = "\improper Tiziria Imports Pack - Mushroom Stirfry"
	main_course = /obj/item/food/vendor_tray_meal/mushroom_fry
