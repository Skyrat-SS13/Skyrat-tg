//Note for this file: All the raw pastries should not have microwave results, use baking instead. All cooked products can use baking, but should also support a microwave.

/obj/item/food/dough
	name = "面团"
	desc = "一团面."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "dough"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("生面团" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_0

/obj/item/food/dough/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/bread/plain, rand(30 SECONDS, 45 SECONDS), TRUE, TRUE)

// Dough + rolling pin = flat dough
/obj/item/food/dough/make_processable()
	AddElement(/datum/element/processable, TOOL_ROLLINGPIN, /obj/item/food/flatdough, 1, 3 SECONDS, table_required = TRUE, screentip_verb = "Flatten")

/obj/item/food/flatdough
	name = "生面饼"
	desc = "擀平的面团."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "flat dough"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("生面团" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_0

/obj/item/food/flatdough/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizzabread, rand(30 SECONDS, 45 SECONDS), TRUE, TRUE)

// sliceable into 3xdoughslices
/obj/item/food/flatdough/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/doughslice, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Slice")

/obj/item/food/pizzabread
	name = "披萨饼坯"
	desc = "加入配料制作披萨."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "pizzabread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 7)
	tastes = list("烤饼" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/pizzabread/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, /obj/item/food/pizza/margherita, CUSTOM_INGREDIENT_ICON_SCATTER, max_ingredients = 12)

/obj/item/food/doughslice
	name = "切块面团"
	desc = "一小块生面团,能做成圆面包."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "doughslice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("dough" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_0

/obj/item/food/doughslice/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/bun, rand(20 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/doughslice/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/bait/doughball, 5, 3 SECONDS, screentip_verb = "Slice")

/obj/item/food/bun
	name = "圆面包"
	desc = "每个汉堡的自尊基础."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "bun"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("圆面包" = 1) // the bun tastes of bun.
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/bun/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, /obj/item/food/burger/empty, CUSTOM_INGREDIENT_ICON_STACKPLUSTOP)

/obj/item/food/cakebatter
	name = "蛋糕糊"
	desc = "把它烤一下做成蛋糕."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "cakebatter"
	food_reagents = list(/datum/reagent/consumable/nutriment = 9)
	tastes = list("生面糊" = 1)
	foodtypes = GRAIN | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/cakebatter/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/cake/plain, rand(70 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/cakebatter/make_processable()
	AddElement(/datum/element/processable, TOOL_ROLLINGPIN, /obj/item/food/piedough, 1, 3 SECONDS, table_required = TRUE, screentip_verb = "Flatten")

/obj/item/food/piedough
	name = "馅饼糊"
	desc = "把它烤一下做成派."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "piedough"
	food_reagents = list(/datum/reagent/consumable/nutriment = 9)
	tastes = list("生面糊" = 1)
	foodtypes = GRAIN | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/piedough/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pie/plain, rand(30 SECONDS, 45 SECONDS), TRUE, TRUE)

/obj/item/food/piedough/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/rawpastrybase, 6, 3 SECONDS, table_required = TRUE, screentip_verb = "Slice")

/obj/item/food/rawpastrybase
	name = "生糕点酥皮"
	desc = "使用前一定要弄熟."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "rawpastrybase"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("生酥皮" = 1)
	foodtypes = GRAIN | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/rawpastrybase/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pastrybase, rand(20 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pastrybase
	name = "糕点酥皮"
	desc = "是任何糕点的基础."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "pastrybase"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("糕点" = 1)
	foodtypes = GRAIN | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_2
