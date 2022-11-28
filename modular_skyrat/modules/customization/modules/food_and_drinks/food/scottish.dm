/obj/item/food/snacks/store/bread/haggis
	name = "haggis"
	desc = "A savoury pudding containing intestines."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "haggis"
	food_reagents = list(/datum/reagent/consumable/nutriment = 50, /datum/reagent/consumable/nutriment/vitamin = 25)
	foodtypes = MEAT | GRAIN

/obj/item/food/snacks/store/bread/haggis/MakeProcessable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/snacks/breadslice/haggis, 5, 30, screentip_verb = "Slice")

/obj/item/food/snacks/breadslice/haggis
	name = "haggis chunk"
	desc = "A chunk of delicious haggis."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "haggis_chunk"
	food_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 5)
	foodtypes = MEAT | GRAIN


/obj/item/food/snacks/neep_tatty_haggis
	name = "haggis neeps and tatties "
	desc = "Oi mate! No neeps, but double beets! SCAM!!!"
	icon_state = "neep_tatty_haggis"
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	food_reagents = list(/datum/reagent/consumable/nutriment = 20, /datum/reagent/consumable/nutriment/vitamin = 10, /datum/reagent/iron = 10)
	foodtypes = GRAIN | VEGETABLES | MEAT


/obj/item/food/sausage/battered
	name = "battered sausage"
	desc = "A sausage coated in thick beer batter, best served with a portion of chips wrapped in a newspaper, it however, is pure cholesterol, Scottish people eat it. Few of them make 60."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "batteredsausage"


/obj/item/food/cookie/shortbread
	name = "shortbread"
	desc = "A rectangular piece of cooked flour. Said to control the sun during Hogmanay."
	icon = 'modular_skyrat/master_files/icons/obj/food/irnbru.dmi'
	icon_state = "shortbread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6, /datum/reagent/consumable/sugar = 6)
	tastes = list("sugary dough" = 1)
	foodtypes = GRAIN | JUNKFOOD | SUGAR
