/obj/item/food/tortilla
	name = "墨西哥薄饼"
	desc = "是一种薄的圆形无酵大饼,最初由玉米粥粉制成."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "tortilla"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("玉米薄饼" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/tortilla/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/hard_taco_shell, rand(15 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/burrito
	name = "墨西哥卷饼"
	desc = "最基本的墨西哥卷饼,即用一张较大的面饼卷上酱、肉、豆子还有菜等."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "burrito"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("玉米薄饼" = 2, "豆子" = 3)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cheesyburrito
	name = "墨西哥芝士卷饼"
	desc = "塞满了芝士的墨西哥卷饼."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "cheesyburrito"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("玉米薄饼" = 2, "豆子" = 3, "芝士" = 1)
	foodtypes = GRAIN | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/carneburrito
	name = "墨西哥牛肉卷饼"
	desc = "肉食者眼中最好的墨西哥卷饼."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "carneburrito"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("玉米薄饼" = 2, "肉" = 4)
	foodtypes = GRAIN | MEAT
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/fuegoburrito
	name = "墨西哥火山卷饼"
	desc = "超辣的卷饼."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "fuegoburrito"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/capsaicin = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("玉米薄饼" = 2, "豆子" = 3, "辣椒" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_LEGENDARY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/nachos
	name = "玉米片"
	desc = "也可以称为玉米脆饼,是墨西哥人的零食和开胃菜."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "nachos"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("玉米片" = 1)
	foodtypes = GRAIN | FRIED
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/cheesynachos
	name = "烤干酪玉米片"
	desc = "玉米片和融化的奶酪的美味组合."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "cheesynachos"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("玉米片" = 2, "芝士" = 1)
	foodtypes = GRAIN | FRIED | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cubannachos
	name = "古巴玉米片"
	desc = "那是危险的辣玉米片."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "cubannachos"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/consumable/capsaicin = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("玉米片" = 2, "辣椒" = 1)
	foodtypes = VEGETABLES | FRIED | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/taco
	name = "经典塔可"
	desc = "传统的塔可饼,有肉、奶酪和生菜."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "taco"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("塔可" = 4, "肉" = 2, "芝士" = 2, "生菜" = 1)
	foodtypes = MEAT | DAIRY | GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/taco/plain
	name = "普通塔可"
	desc = "传统的塔可饼加肉和奶酪,不加兔肉."
	icon_state = "taco_plain"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("塔可" = 4, "肉" = 2, "芝士" = 2)
	foodtypes = MEAT | DAIRY | GRAIN
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/taco/fish
	name = "鱼肉塔可"
	desc = "有鱼、奶酪和卷心菜的塔可饼."
	icon_state = "fishtaco"
	tastes = list("塔可" = 4, "鱼肉" = 2, "芝士" = 2, "卷心菜" = 1)
	foodtypes = SEAFOOD | DAIRY | GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/enchiladas
	name = "安琪拉达"
	desc = "安琪拉达是墨西哥十分常见的平民烤肉,制做者先用铁板炒肉，再把炒好的肉、奶酪用墨西哥玉米饼卷起."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "enchiladas"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/capsaicin = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("辣椒" = 1, "肉" = 3, "芝士" = 1, "酸奶" = 1)
	foodtypes = MEAT | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/stuffedlegion
	name = "塞军团"
	desc = "一个人类的头骨里面装满了歌利亚的肉,还有一个由番茄酱和辣酱制成的装饰熔岩池."
	icon_state = "stuffed_legion"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("死亡" = 2, "岩石" = 1, "肉" = 1, "辣" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_LEGENDARY
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/chipsandsalsa
	name = "玉米片和莎莎酱"
	desc = "来点玉米片,再来杯莎莎酱,很容易上瘾!"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "chipsandsalsa"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("辣椒" = 1, "莎莎酱" = 3, "玉米片" = 1, "洋葱" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/classic_chimichanga
	name = "经典墨西哥炸卷饼"
	desc = "一种油炸的卷饼,里面塞满了大量的肉和奶酪."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "classic_chimichanga"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("油炸玉米薄饼" = 1, "肉" = 3, "芝士" = 1, "洋葱" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | DAIRY | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/vegetarian_chimichanga
	name = "素墨西哥炸卷饼"
	desc = "为不吃肉的人准备的油炸卷饼,里面有大量的烤蔬菜."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "vegetarian_chimichanga"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("油炸玉米薄饼" = 1, "卷饼" = 3, "洋葱" = 1, "辣椒" = 1)
	foodtypes = GRAIN | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/hard_taco_shell
	name = "塔可脆饼"
	desc = "硬硬的塔可饼,可以添加你自己想要的食材进去!"
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "hard_taco_shell"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("塔可饼" = 1)
	foodtypes = GRAIN | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/hard_taco_shell/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, /obj/item/food/hard_taco_shell/empty, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 6)

// empty taco shell for custom tacos
/obj/item/food/hard_taco_shell/empty
	name = "塔可脆饼"
	foodtypes = NONE
	tastes = list()
	icon_state = "hard_taco_shell"
	desc = "一个定制的塔可."
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/classic_hard_shell_taco
	name = "经典塔可脆饼"
	desc = "经典的硬塔可饼,全银河系最令人满意的脆饼."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "classic_hard_shell_taco"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("塔可脆饼" = 1, "卷心菜" = 3, "番茄" = 1, "碎肉" = 1, "芝士" = 1)
	foodtypes = GRAIN | VEGETABLES | MEAT | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/plain_hard_shell_taco
	name = "普通塔可脆饼"
	desc = "一个塔可脆饼,只有肉,为挑食者和我们所有的孩子."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "plain_hard_shell_taco"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("塔可脆饼" = 1, "碎肉" = 1)
	foodtypes = GRAIN | MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/refried_beans
	name = "炸豆泥"
	desc = "一碗热气腾腾的美味煎豆,墨西哥菜中常见的主食."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "refried_beans"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("炸豆泥" = 1, "洋葱" = 3,)
	foodtypes = VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spanish_rice
	name = "西班牙米饭"
	desc = "一碗美味的西班牙米饭，用番茄酱煮熟,让它呈现出橙色."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "spanish_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("风味大米" = 1, "番茄酱" = 3,)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pineapple_salsa
	name = "菠萝莎莎"
	desc = "一种由菠萝、西红柿、洋葱和辣椒制成的不太液体的莎莎酱,形成令人愉悦的对比口味.莎莎酱是墨西哥料理中常见的一种酱汁."
	icon = 'icons/obj/food/mexican.dmi'
	icon_state = "pineapple_salsa"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("菠萝" = 4, "番茄" = 3, "洋葱" = 2, "红辣椒" = 2)
	foodtypes = VEGETABLES | FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
