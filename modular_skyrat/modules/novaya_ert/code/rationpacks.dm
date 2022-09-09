/obj/item/food/nri_course
	name = "undefined NRI course"
	desc = "Something you shouldn't see. But it's edible."
	icon = 'modular_skyrat/modules/novaya_ert/icons/rationpack.dmi'
	icon_state = "main_course"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("crayon powder" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/nri_course/entree
	name = "combat ration entree"
	desc = "A vacuum-sealed weather-resistant spaceproof package written in Pan-Slavic, labelled 'завтрак'. It supposedly contains protein-enriched wholewheat biscuits, liver pate and blueberry jam."
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/nutriment/vitamin = 4)
	tastes = list("wholewheat biscuits" = 5, "liver pate" = 5, "blueberry jam" = 5)
	foodtypes = FRUIT | GRAIN | MEAT | BREAKFAST

/obj/item/food/nri_course/main
	name = "combat ration main course"
	desc = "A vacuum-sealed weather-resistant spaceproof package written in Pan-Slavic, labelled 'обед'. It supposedly contains snap-to-heat buckwheat porridge and tushonka and snap-to-heat borscht."
	food_reagents = list(/datum/reagent/consumable/nutriment = 17, /datum/reagent/consumable/nutriment/vitamin = 8)
	icon_state = "side_dish"
	tastes = list("hot buckwheat porridge with canned beef" = 5, "hot imperial borscht" = 5)
	foodtypes = VEGETABLES | GRAIN | MEAT

/obj/item/food/nri_course/side
	name = "combat ration side-dish"
	desc = "A vacuum-sealed weather-resistant spaceproof package written in Pan-Slavic, labelled 'закуска'. It supposedly contains a large carnitine-enriched pryanik, breadsticks and apple sauce."
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	icon_state = "dessert"
	tastes = list("pryaniki" = 10, "breadsticks" = 5, "apple sauce" = 3)
	foodtypes = SUGAR | GRAIN | FRUIT

/obj/item/storage/box/nri_rations
	name = "NRI combat rations"
	desc = "A packaged military MRE for soldiers in extended deployments and people who can deal with the shits after finishing one. Everything on the back and front is written in Pan-Slavic, but you can make out 'Једите пре: Сентябрь 2603'."
	icon = 'modular_skyrat/modules/novaya_ert/icons/rationpack.dmi'
	icon_state = "mre_package"
	illustration = null

/obj/item/storage/box/nri_rations/Initialize(mapload)
	. = ..()
	atom_storage.max_slots = 7

/obj/item/storage/box/nri_rations/PopulateContents()
	new /obj/item/food/nri_course/entree(src)
	new /obj/item/food/nri_course/main(src)
	new /obj/item/food/nri_course/side(src)
	new /obj/item/storage/box/gum(src)
	new /obj/item/reagent_containers/cup/glass/waterbottle(src)
	new /obj/item/storage/fancy/cigarettes/cigpack_robust(src)
	new /obj/item/storage/box/matches(src)

/obj/item/storage/box/nri_rations/attack_self(mob/user, modifiers)
	icon_state = "mre_package_open"
