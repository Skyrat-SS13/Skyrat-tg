/obj/item/food/mre_course
	name = "undefined MRE course"
	desc = "Something you shouldn't see. But it's edible."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/courses.dmi'
	icon_state = "main_course"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("crayon powder" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/mre_course/main
	name = "MRE main course"
	desc = "Main course of the ancient military ration designed for ground troops. This one is NOTHING."
	tastes = list("strawberry" = 1, "vanilla" = 1, "chocolate" = 1)

/obj/item/food/mre_course/main/beans
	name = "MRE main course - Pork and Beans"
	desc = "Main course of the ancient military ration designed for ground troops. This one is pork and beans covered in some tomato sauce."
	tastes = list("beans" = 1, "pork" = 1, "tomato sauce" = 1)
	foodtypes = MEAT | VEGETABLES

/obj/item/food/mre_course/main/macaroni
	name = "MRE main course - Macaroni and Cheese"
	desc = "Main course of the ancient military ration designed for ground troops. This one is preboiled macaroni covered in some federal reserve cheese."
	tastes = list("cold macaroni" = 1, "bland cheese" = 1)
	foodtypes = DAIRY | GRAIN

/obj/item/food/mre_course/main/rice
	name = "MRE main course - Rice and Beef"
	desc = "Main course of the ancient military ration designed for ground troops. This one is rice with beef, covered in gravy."
	tastes = list("dense rice" = 1, "bits of beef" = 1, "gravy" = 1)
	foodtypes = GRAIN | MEAT

/obj/item/food/mre_course/side
	name = "MRE side course"
	desc = "Side course of the ancient military ration designed for ground troops. This one is NOTHING."
	icon_state = "side_dish"

/obj/item/food/mre_course/side/bread
	name = "MRE side course - Cornbread"
	desc = "Side course of the ancient military ration designed for ground troops. This one is cornbread."
	tastes = list("cornbread" = 1)
	foodtypes = GRAIN

/obj/item/food/mre_course/side/pie
	name = "MRE side course - Meat Pie"
	desc = "Side course of the ancient military ration designed for ground troops. This one is some meat pie."
	tastes = list("pie dough" = 1, "ground meat" = 1, "Texas" = 1)
	foodtypes = MEAT | GRAIN

/obj/item/food/mre_course/side/chicken
	name = "MRE side course - Sweet 'n Sour Chicken"
	desc = "Side course of the ancient military ration designed for ground troops. This one is some undefined chicken-looking meat covered in cheap reddish sauce."
	tastes = list("bits of chicken meat" = 1, "sweet and sour sauce" = 1, "salt" = 1)
	foodtypes = MEAT | FRIED

/obj/item/food/mre_course/dessert
	name = "MRE dessert"
	desc = "Dessert of the ancient military ration designed for ground troops. This one is NOTHING."
	icon_state = "dessert"

/obj/item/food/mre_course/dessert/cookie
	name = "MRE dessert - Cookie"
	desc = "Dessert of the ancient military ration designed for ground troops. This one is a big dry cookie."
	tastes = list("dryness" = 1, "hard cookie" = 1, "chocolate chip" = 1)
	foodtypes = GRAIN | SUGAR

/obj/item/food/mre_course/dessert/cake
	name = "MRE dessert - Apple Pie"
	desc = "Dessert of the ancient military ration designed for ground troops. This one is an amorphous apple pie."
	tastes = list("apple" = 1, "moist cake" = 1, "sugar" = 1)
	foodtypes = GRAIN | SUGAR | FRUIT

/obj/item/food/mre_course/dessert/chocolate
	name = "MRE dessert - Dark Chocolate"
	desc = "Dessert of the ancient military ration designed for ground troops. This one is a dark bar of chocolate."
	tastes = list("vanilla" = 1, "artificial chocolate" = 1, "chemicals" = 1)
	foodtypes = JUNKFOOD | SUGAR

/obj/item/storage/box/hecu_rations
	name = "Meal, Ready-to-Eat"
	desc = "A box containing a few rations and some chewing gum, for keeping a starving crayon-eater going."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/mre_hecu.dmi'
	icon_state = "mre_package"
	illustration = null

/obj/item/storage/box/hecu_rations/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5

/obj/item/storage/box/hecu_rations/PopulateContents()
	var/main_course = pick(/obj/item/food/mre_course/main/beans, /obj/item/food/mre_course/main/macaroni, /obj/item/food/mre_course/main/rice)
	var/side_dish = pick(/obj/item/food/mre_course/side/bread, /obj/item/food/mre_course/side/pie, /obj/item/food/mre_course/side/chicken)
	var/dessert = pick(/obj/item/food/mre_course/dessert/cookie, /obj/item/food/mre_course/dessert/cake, /obj/item/food/mre_course/dessert/chocolate)
	new main_course(src)
	new side_dish(src)
	new dessert(src)
	new /obj/item/storage/box/gum(src)
	new /obj/item/food/spacers_sidekick(src)
