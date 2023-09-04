/obj/item/food/snacks/store/bread/haggis
	name = "haggis"
	desc = "A savoury pudding containing intestines."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "haggis"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 50,
		/datum/reagent/consumable/nutriment/vitamin = 25
	)
	foodtypes = MEAT | GRAIN
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/snacks/store/bread/haggis/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/snacks/breadslice/haggis, 5, 30, screentip_verb = "Slice")

/obj/item/food/snacks/breadslice/haggis
	name = "haggis chunk"
	desc = "A chunk of delicious haggis."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "haggis_chunk"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5
	)
	foodtypes = MEAT | GRAIN
	crafting_complexity = FOOD_COMPLEXITY_4


/obj/item/food/snacks/neep_tatty_haggis
	name = "haggis neeps and tatties "
	desc = "Oi mate! No neeps, but double beets! SCAM!!!"
	icon_state = "neep_tatty_haggis"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/iron = 10
	)
	foodtypes = GRAIN | VEGETABLES | MEAT
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_sausage/battered
	name = "raw battered sausage"
	desc = "A raw sausage coated in thick beer batter."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "batteredsausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/ethanol/beerbatter = 5
	)
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_sausage/battered/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/sausage/battered, rand(60 SECONDS, 75 SECONDS), TRUE)

/obj/item/food/sausage/battered
	name = "battered sausage"
	desc = "A sausage coated in thick beer batter, best served with a portion of chips wrapped in a newspaper, it however, is pure cholesterol, Scottish people eat it. Few of them make it to 60."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "grilled_batteredsausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/fat/oil = 2
	)
	foodtypes = MEAT | BREAKFAST | FRIED
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/sausage/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/salami, 6, 3 SECONDS, table_required = TRUE,  screentip_verb = "Slice")

/obj/item/food/cookie/shortbread
	name = "shortbread"
	desc = "A rectangular piece of cooked flour. Said to control the sun during Hogmanay."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "shortbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/sugar = 6
	)
	tastes = list("sugary dough" = 1)
	foodtypes = GRAIN | JUNKFOOD | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2
