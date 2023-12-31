//Moth Foods, the three C's: cheese, coleslaw, and cotton 芝士 凉拌卷心菜 棉花
//A large emphasis has been put on sharing and multiple portion dishes 重点放在了分享和多份菜肴上
//Additionally, where a mothic name is given, a short breakdown of what exactly it means is provided, for the curious on the internal workings of mothic: it's very onomatopoeic, and makes heavy use of combined words and accents
//此外，在给出蛾名的地方，提供了一个简短的分解，它的确切含义，为了好奇蛾的内部工作:它非常拟声，并且大量使用组合词和重音

//Base ingredients and miscellany, generally not served on their own 基础配料和杂项，一般不单独供应
/obj/item/food/herby_cheese
	name = "草酪"
	desc = "也可以叫它草药奶酪，作为蛾类菜肴的基础配料，奶酪经常被添加各种口味，以保持饮食的多样性。草药就是其中之一，尤其受人喜爱."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "herby_cheese"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 6)
	tastes = list("奶酪" = 1, "草药" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/grilled_cheese
	name = "烤奶酪"
	desc = "正如奥尔顿勋爵(Lord Alton,愿上帝保佑他的名字)所规定的那样,世界上99.997%的烤奶酪食谱都是这样的：奶酪从来都不是烤过的，它只是一个烤过的三明治，里面有融化的奶酪。另一方面，这是真正的烤奶酪。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "grilled_cheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("奶酪" = 1, "烧烤" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/mothic_salad
	name = "蛾类沙拉"
	desc = "卷心菜、红洋葱和番茄的基本沙拉。可以作为无数种不同沙拉的完美底料。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothic_salad"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("沙拉" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/toasted_seeds
	name = "烤种子"
	desc = "虽然它们远不能填饱肚子，但烤过的种子是蛾子们最喜欢的零食。盐，糖，甚至一些更奇特的口味可以添加一些额外的风味."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "toasted_seeds"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 5)
	tastes = list("种子" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/engine_fodder
	name = "引擎燃料"
	desc = "这是蛾子舰队的工程师们常见的零食，由种子、坚果、巧克力、爆米花和薯片制成，专为高热量设计。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "engine_fodder"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("种子" = 1, "坚果" = 1, "巧克力" = 1, "咸" = 1, "爆米花" = 1, "薯片" = 1)
	foodtypes = GRAIN | NUTS | VEGETABLES | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/mothic_pizza_dough
	name = "蛾类披萨饼"
	desc = "一种用玉米粉和面粉做成的结实的、有谷质的面团，用来承载起司和酱汁"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothic_pizza_面团"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 6)
	tastes = list("生面粉" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

//Entrees: categorising food that is 90% cheese and salad is not easy
/obj/item/food/squeaking_stir_fry
	name = "skeklitmischtpoppl" //skeklit = squeaking, mischt = stir, poppl = fry 原名skeklitmischtpoppl
	desc = "用奶酪凝乳和豆腐(以及其他东西)制成的蛾经典。从字面上翻译，这个名字的意思是“吱吱作响的炒菜”，这个名字是由于蛋白质独特的吱吱声而得名的。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "squeaking_stir_fry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("奶酪" = 1, "豆腐" = 1, "蔬菜" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/sweet_chili_cabbage_wrap
	name = "甜辣椒包菜"
	desc = "包着卷心菜的烤奶酪和沙拉，上面撒上美味的甜辣酱."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "sweet_chili_cabbage_wrap"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("奶酪" = 1, "沙拉" = 1, "甜椒" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/loaded_curds
	name = "ozlsettitæloskekllön ede pommes" //ozlsettit = overflowing (ozl = over, sett = flow, it = ing), ælo = cheese, skekllön = curds (skeklit = squeaking, llön = pieces/bits), ede = and, pommes = fries (hey, France!)
	desc = "还有什么比奶酪凝乳更好的呢?”油炸奶酪凝乳!还有什么比油炸奶酪凝乳更好的呢?油炸奶酪凝乳，上面放辣椒(和更多的奶酪)!还有什么比这更好的呢?把它放在薯条上!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "loaded_curds"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("奶酪" = 1, "油" = 1, "辣椒" = 1, "薯条" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/baked_cheese
	name = "烤奶酪轮"
	desc = "烤奶酪轮，融化而美味."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "baked_cheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/nutriment = 5,
	)
	tastes = list("cheese" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/baked_cheese_platter
	name = "stanntkraktælo" //stannt = oven, krakt = baked, ælo = cheese
	desc = "烤奶酪轮:蛾子最喜欢分享的食物，唯一比这更好的就是还能蘸着面包吃。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "baked_cheese_platter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("奶酪" = 1, "面包" = 1)
	foodtypes = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

//Baked Green Lasagna at the Whistlestop Cafe
/obj/item/food/raw_green_lasagne
	name = "生绿色美味千层面"
	desc = "用香蒜沙司和香草白酱做成的美味千层面，准备烘烤。适合多次食用."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_green_lasagne"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("奶酪" = 1, "意大利青酱" = 1, "千层面" = 1)
	foodtypes = VEGETABLES | GRAIN | NUTS | RAW
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_green_lasagne/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/green_lasagne, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/green_lasagne
	name = "绿色美味千层面"
	desc = "一种用香蒜沙司和香草白酱做成的美味千层面。适合多次食用。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "green_lasagne"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 24,
		/datum/reagent/consumable/nutriment/vitamin = 18,
	)
	tastes = list("奶酪" = 1, "意大利青酱" = 1, "千层面" = 1)
	foodtypes = VEGETABLES | GRAIN | NUTS
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/green_lasagne/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/green_lasagne_slice, 6, 3 SECONDS, table_required = TRUE,  screentip_verb = "Slice")

/obj/item/food/green_lasagne_slice
	name = "小块绿色美味千层面"
	desc = "一小块绿色美味千层面."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "green_lasagne_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("奶酪" = 1, "意大利青酱" = 1, "千层面" = 1)
	foodtypes = VEGETABLES | GRAIN | NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_baked_rice
	name = "未烹饪的大烤饭"
	desc = "一大锅土豆片，上面放着米饭和蔬菜高汤，准备烤成美味的共享餐."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_baked_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("米饭" = 1, "土豆" = 1, "蔬菜" = 1)
	foodtypes = VEGETABLES | GRAIN | RAW
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_baked_rice/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/big_baked_rice, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/big_baked_rice
	name = "大烤饭"
	desc = "这是蛾子的最爱，烤饭可以填上各种各样的蔬菜馅，做成美味的一餐。土豆也经常被放在烹饪容器的底部，以形成美味的外壳。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "big_baked_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 18,
		/datum/reagent/consumable/nutriment/vitamin = 42,
	)
	tastes = list("米饭" = 1, "土豆" = 1, "蔬菜" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/big_baked_rice/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/lil_baked_rice, 6, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/lil_baked_rice
	name = "小烤饭"
	desc = "一份烤米饭，完美的配菜，甚至可以当一顿正餐。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "lil_baked_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	tastes = list("米饭" = 1, "土豆" = 1, "蔬菜" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/oven_baked_corn
	name = "烘玉米"
	desc = "一根烤玉米棒，在烤箱的高温下烤到起泡变黑作为一种快速而又美味的食物，它是舰队中的常见菜肴"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "oven_baked_corn"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("玉米" = 1, "烘烤" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/buttered_baked_corn
	name = "黄油烘玉米"
	desc = "有什么比烘玉米还要好，黄油烘玉米!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "buttered_baked_corn"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("玉米" = 1, "烘烤" = 1)
	foodtypes = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/fiesta_corn_skillet
	name = "杂烩玉米锅"
	desc = "甜的，辣的，还有各种各样的."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fiesta_corn_skillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("玉米" = 1, "辣椒" = 1, "烘烤" = 1)
	foodtypes = VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/raw_ratatouille
	name = "生蔬菜杂烩" //rawtatouille?
	desc = "切好的蔬菜配上烤辣椒酱，是一种好吃的农家菜。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_ratatouille"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("蔬菜" = 1, "烤辣椒" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_ratatouille/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/ratatouille, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/ratatouille
	name = "蔬菜杂烩"
	desc = "这道菜可以把你的餐厅从挑剔的美食评论家手中拯救出来。如果你的厨师帽里有老鼠，那就更好了。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "ratatouille"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("蔬菜" = 1, "烤辣椒" = 1, "烘烤" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/mozzarella_sticks
	name = "马苏里拉奶酪条"
	desc = "小块的马苏里拉奶酪，涂上面包屑，油炸."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mozzarella_sticks"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("奶油芝士" = 1, "面包糠" = 1, "油" = 1)
	foodtypes = DAIRY | GRAIN | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/raw_stuffed_peppers
	name = "生voltölpaprik" //voltöl = stuffed (vol = full, töl = push), paprik (from German paprika) = bell pepper
	desc = "一个去掉顶部的甜椒，里面塞上草酪和洋葱，不应该生吃。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_stuffed_pepper"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("奶油芝士" = 1, "草药" = 1, "洋葱" = 1, "甜椒" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_stuffed_peppers/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/stuffed_peppers, rand(10 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/stuffed_peppers
	name = "voltölpaprik"
	desc = "软而脆的甜椒，里面有美妙的融化奶酪."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "stuffed_pepper"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("奶油芝士" = 1, "草药" = 1, "洋葱" = 1, "甜椒" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/fueljacks_lunch
	name = "\improper 加油工的午餐"
	desc = "这道菜是用油炸蔬菜做的，很受加油工的欢迎，加油工是指操纵撇油器维持舰队运转的勇敢蛾子。他们经常带着打包的食物，以节省跑到餐厅的时间。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fueljacks_lunch"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("cabbage" = 1, "potato" = 1, "onion" = 1, "chili" = 1, "cheese" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/mac_balls
	name = "macheronirölen"
	desc = "芝士通心粉蘸玉米面糊然后油炸，最后配上番茄酱。这是一种在整个银河系都很受欢迎的小吃，尤其是在蛾子舰队——他们倾向于用Ready-Donk作为基础."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mac_balls"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 10,
	)
	tastes = list("通心粉" = 1, "玉米面" = 1, "芝士" = 1)
	foodtypes = DAIRY | VEGETABLES | FRIED | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/sustenance_bar
	name = "PSB"
	desc = "PSB,或预包装营养棒,是舰队上一种食物短缺时的应急食品,由大豆和豌豆蛋白制成.有时也会因存货接近保质期而向市场清仓销售.这个的味道像大多数人工调味的蛾类食物一样，混合了草药的味道。."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "sustenance_bar"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("草药" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/sustenance_bar/neapolitan
	name = "PSB-那不勒斯味"
	desc = "PSB,或预包装营养棒,是舰队上一种食物短缺时的应急食品,由大豆和豌豆蛋白制成.有时也会因存货接近保质期而向市场清仓销售.这款是那不勒斯风味的，有草莓、香草和巧克力."
	tastes = list("草莓" = 1, "香草" = 1, "巧克力" = 1)

/obj/item/food/sustenance_bar/cheese
	name = "PSB-三奶酪味"
	desc = "PSB,或预包装营养棒,是舰队上一种食物短缺时的应急食品,由大豆和豌豆蛋白制成.有时也会因存货接近保质期而向市场清仓销售.这款包含了三种奶酪——帕尔马干酪、马苏里拉干酪和切达干酪."

/obj/item/food/sustenance_bar/mint
	name = "PSB-薄荷巧克力味"
	desc = "PSB,或预包装营养棒,是舰队上一种食物短缺时的应急食品,由大豆和豌豆蛋白制成.有时也会因存货接近保质期而向市场清仓销售.这款包含了薄荷,黑巧克力与薯片,但蛾子们好像搞错了薄荷巧克力的概念?"
	tastes = list("薄荷" = 1, "薯片(?)" = 1, "黑巧克力" = 1)

/obj/item/food/sustenance_bar/wonka
	name = "PSB- 经典晚餐味"
	desc = "PSB,或预包装营养棒,是舰队上一种食物短缺时的应急食品,由大豆和豌豆蛋白制成.有时也会因存货接近保质期而向市场清仓销售.这款的口味包含了番茄汤、烤南瓜和蓝莓派." //Thankfully not made by Willy Wonka
	tastes = list("番茄汤" = 1, "烤南瓜" = 1, "蓝莓派" = 1)

/obj/item/food/bowled/hua_mulan_congee
	name = "\improper 花木兰粥"
	desc = "没人知道为什么这碗带笑脸的鸡蛋和培根米粥是以中国历史典故人物的名字命名的——它只是一直被这么叫的."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "hua_mulan_congee"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("培根" = 1, "蛋" = 1)
	foodtypes = MEAT | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/bowled/fried_eggplant_polenta
	name = "炸茄子配燕麦粥"
	desc = "燕麦粥上有奶酪，配上几片炸茄子和一些番茄酱.Lække!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fried_eggplant_polenta"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 10,
	)
	tastes = list("麦片" = 1, "奶酪" = 1, "茄子" = 1, "番茄酱" = 1)
	foodtypes = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

//Salads: the bread and butter of mothic cuisine
/obj/item/food/caprese_salad
	name = "卡布里沙拉"
	desc = "虽然卡布里沙拉是意大利菜，但因简单美味它已成为舰队上的最爱,蛾子们称它为zaileskenknusksolt." //zail = two, esken = colour/tone, knuskolt = salad
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "caprese_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("马苏里拉奶酪" = 1, "番茄" = 1, "香油" = 1)
	foodtypes = DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/salad/fleet_salad
	name = "lörtonknusksolt" //lörton = fleet, knusksolt = salad (knusk = crisp, solt = bowl)
	desc = "Lörtonknusksolt,或称GalCom的舰队沙拉,在舰队上的小吃店和食堂很常见.烤奶酪使它特别有饱腹感,而面包丁则提供了一种松脆的感觉."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "fleet_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 12,
	)
	tastes = list("奶酪" = 1, "沙拉" = 1, "面包" = 1)
	foodtypes = DAIRY | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/salad/cotton_salad
	name = "flöfrölenknusksolt"
	desc = "加了棉花和基本调料的沙拉,不是附近有蛾子,就是南方又崛起了."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "cotton_salad"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 14,
	)
	tastes = list("芝士" = 1, "沙拉" = 1, "面包" = 1)
	foodtypes = VEGETABLES | CLOTH
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/salad/moth_kachumbari
	name = "\improper Kæniatknusksolt" //Kæniat = Kenyan, knusksolt = salad
	desc = "kachumbari(卡丘巴里)最初是肯尼亚的一种美食，后被蛾子所青睐然后加以本土化改造."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "moth_kachumbari"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 18,
	)
	tastes = list("洋葱" = 1, "番茄" = 1, "玉米" = 1, "辣椒" = 1, "香菜" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

//Pizza
/obj/item/food/raw_mothic_margherita
	name = "生蛾式玛格丽特披萨"
	desc = "蛾式披萨是一种被蛾子改造了的美食，其特点是使用新鲜的食材尤其是新鲜的马苏里拉奶酪，以及使用高筋面粉来制作面团."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_margherita_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("生面团" = 1, "番茄" = 1, "奶酪" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_margherita/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_margherita, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_margherita
	name = "蛾式玛格丽特披萨"
	desc = "蛾式披萨的一个关键特点是按重量出售——单片披萨可以获得discretionary credits,而餐券可以购买整个披萨."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "margherita_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("披萨" = 1, "番茄" = 1, "芝士" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mothic_margherita
	boxtag = "Margherita alla Moffuchi"
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_margherita
	name = "蛾式玛格丽特披萨片"
	desc = "一块蛾式玛格丽特披萨，最普通的披萨。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "margherita_slice"
	tastes = list("披萨" = 1, "番茄" = 1, "芝士" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_firecracker
	name = "生蛾式爆竹披萨"
	desc = "为最喜欢冒险的飞蛾,爆竹披萨HOT HOT HOT!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_firecracker_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/bbqsauce = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 10,
	)
	tastes = list("面团" = 1, "辣椒" = 1, "玉米" = 1, "芝士" = 1, "烧烤酱" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_firecracker/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_firecracker, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_firecracker
	name = "蛾式爆竹披萨"
	desc = "他们把这个叫做热披萨派不是在开玩笑的."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "firecracker_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/bbqsauce = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/capsaicin = 10,
	)
	tastes = list("披萨" = 1, "辣椒" = 1, "玉米" = 1, "芝士" = 1, "烧烤酱" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mothic_firecracker
	boxtag = "即将爆炸的爆竹" //Vesuvianfirecracker
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_firecracker
	name = "蛾式爆竹披萨片"
	desc = "一块很好吃的辣东西."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "firecracker_slice"
	tastes = list("披萨" = 1, "辣椒" = 1, "玉米" = 1, "芝士" = 1, "烧烤酱" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_five_cheese
	name = "生蛾式五奶酪披萨"
	desc = "几个世纪以来，学者们一直在问:多少奶酪算奶酪过多?"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_five_cheese_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("面团" = 1, "奶酪" = 1, "更多的奶酪" = 1, "过量的奶酪" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_five_cheese/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_five_cheese, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_five_cheese
	name = "蛾式五奶酪披萨"
	desc = "老鼠和英国发明家的最爱."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "five_cheese_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("披萨" = 1, "奶酪" = 1, "更多的奶酪" = 1, "过量的奶酪" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mothic_five_cheese
	boxtag = "奶酪爆破" // Cheeseplosion
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_five_cheese
	name = "蛾式五奶酪披萨片"
	desc = "这是银河系里最奶酪的一片!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "five_cheese_slice"
	tastes = list("披萨" = 1, "奶酪" = 1, "更多的奶酪" = 1, "过量的奶酪" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_white_pie
	name = "生蛾式白披萨"
	desc = "为讨厌番茄的人做的披萨."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_white_pie_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("面团" = 1, "奶酪" = 1, "草药" = 1, "大蒜" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_white_pie/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_white_pie, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_white_pie
	name = "蛾式白披萨"
	desc = "你说“to-may-to”,我说“to-mah-to”,这批萨上什么都不放."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "white_pie_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("披萨" = 1, "奶酪" = 1, "草药" = 1, "大蒜" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mothic_white_pie
	boxtag = "Pane Bianco"
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_white_pie
	name = "蛾式白披萨片"
	desc = "芝士味，蒜味，香草味，很好吃!"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "white_pie_slice"
	tastes = list("披萨" = 1, "奶酪" = 1, "草药" = 1, "大蒜" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_pesto
	name = "生蛾式青酱披萨"
	desc = "意大利青酱是一种受欢迎的披萨配料，很可能是因为它体现了蛾子最喜欢的味道:奶酪、香草和蔬菜."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_pesto_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("面团" = 1, "青酱" = 1, "奶酪" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | NUTS | RAW
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_pesto/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_pesto, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_pesto
	name = "蛾式青酱披萨"
	desc = "像花园里的草一样绿,并不是说船上有很多这样的人."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "pesto_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("披萨" = 1, "青酱" = 1, "奶酪" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | NUTS | RAW
	slice_type = /obj/item/food/pizzaslice/mothic_pesto
	boxtag = "Presto 青酱" // Presto pesto
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pizzaslice/mothic_pesto
	name = "蛾式青酱披萨片"
	desc = "一片蛾式青酱披萨."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "pesto_slice"
	tastes = list("披萨" = 1, "青酱" = 1, "奶酪" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | NUTS
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_mothic_garlic
	name = "生蛾式蒜香披萨"
	desc = "啊,大蒜,一种大家都喜欢的食材,可能除了吸血鬼。"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "raw_garlic_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("面团" = 1, "蒜香" = 1, "黄油" = 1)
	foodtypes = GRAIN | VEGETABLES | RAW
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/raw_mothic_garlic/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mothic_garlic, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/mothic_garlic
	name = "蛾式蒜香披萨"
	desc = "全银河最好的食物,毫无疑问."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "garlic_pizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("披萨" = 1, "蒜香" = 1, "黄油" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | NUTS
	slice_type = /obj/item/food/pizzaslice/mothic_garlic
	boxtag = "蒜香披萨" // Garlic Bread alla Moffuchi
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizzaslice/mothic_garlic
	name = "蛾式蒜香披萨片"
	desc = "这是大蒜和面团的最佳组合."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "garlic_slice"
	tastes = list("面团" = 1, "蒜香" = 1, "黄油" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4

//Bread
/obj/item/food/bread/corn
	name = "玉米面包"
	desc = "具有乡村风格的老古董面包."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "cornbread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 18)
	tastes = list("玉米面包" = 10)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	slice_type = /obj/item/food/breadslice/corn
	yield = 6
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/breadslice/corn
	name = "玉米面包片"
	desc = "经久不衰的西部美食."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "cornbread_slice"
	foodtypes = GRAIN
	food_reagents = list(/datum/reagent/consumable/nutriment = 3)
	crafting_complexity = FOOD_COMPLEXITY_2

//Sweets
/obj/item/food/moth_cheese_cakes
	name = "\improper ælorölen" //ælo = cheese, rölen = balls
	desc = "Ælorölen (芝士球) 是一种传统的蛾子甜点，由柔软的奶酪、糖粉和面粉制成，揉成球状，捣碎，然后油炸。通常与巧克力酱或蜂蜜搭配，或有时两者兼而有之！"
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "moth_cheese_cakes"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/sugar = 12,
	)
	tastes = list("芝士蛋糕" = 1, "巧克力" = 1, "蜂蜜" = 1)
	foodtypes = SUGAR | FRIED | DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cake/mothmallow
	name = "云块"
	desc = "一种清淡蓬松的棉花糖，散发出香草和朗姆酒的香味，上面覆盖着柔软的巧克力。这被蛾子称为höllflöfstarkken-云块" //höllflöf = cloud (höll = wind, flöf = cotton), starkken = squares
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothmallow_tray"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/sugar = 20,
	)
	tastes = list("香草" = 1, "云彩" = 1, "巧克力" = 1)
	foodtypes = VEGETABLES | SUGAR
	slice_type = /obj/item/food/cakeslice/mothmallow
	yield = 6
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cakeslice/mothmallow
	name = "小云块"
	desc = "蓬松的云彩被捏成了蛾子的形状."
	icon = 'icons/obj/food/moth.dmi'
	icon_state = "mothmallow_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("香草" = 1, "云彩" = 1, "巧克力" = 1)
	foodtypes = VEGETABLES | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2

//misc food
/obj/item/food/bubblegum/wake_up
	name = "wake-up口香糖"
	desc = "一块条状的口香糖,上面有蛾子舰队的标志"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 13,
		/datum/reagent/drug/methamphetamine = 2,
	)
	tastes = list("草药" = 1)
	color = "#567D46"

/obj/item/storage/box/gum/wake_up
	name = "\improper 12小时提神口香糖包"
	desc = "在维修隧道的长时间轮班中保持清醒!蛾子游牧舰队的批准印章被印在包装上，旁边是蛾语和银河通用语写成的一连串健康和安全免责声明."
	icon_state = "bubblegum_wake_up"
	custom_premium_price = PAYCHECK_CREW * 1.5

/obj/item/storage/box/gum/wake_up/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你看了一些健康和安全信息...</i>")
	. += "\t[span_info("本产品是为了缓解工作时的疲劳和困倦.")]"
	. += "\t[span_info("每12小时不要咀嚼超过一条,不能替代睡眠.")]"
	. += "\t[span_info("16岁以下儿童请勿服用,不要超过最大剂量,不要吞食,不要连续服用超过3天,不要与其他药物同时服用,可能对已有心脏病的患者造成不良反应.")]"
	. += "\t[span_info("使用后的副作用可能包括触角抽搐、翅膀过度活跃、角蛋白光泽丧失、刚毛覆盖范围丧失、心律失常、视力模糊和欣快感.如果出现副作用，请停止服用。")]"
	. += "\t[span_info("反复使用可能会上瘾.")]"
	. += "\t[span_info("如果超过最大剂量，请立即通知指定船只的医务人员.不要催吐.")]"
	. += "\t[span_info("成份:每条含活络素(右旋脱氧麻黄碱)500mg。其他成分包括绿色染料450(翠绿草地)和人工草本香料。")]"
	. += "\t[span_info("贮存:置于阴凉干燥处。超过32/4/350使用期限，请勿使用。")]"
	return .

/obj/item/storage/box/gum/wake_up/PopulateContents()
	for(var/i in 1 to 4)
		new/obj/item/food/bubblegum/wake_up(src)

/obj/item/food/spacers_sidekick
	name = "\improper 太空友人薄荷糖" // Spacer's Sidekick mints
	desc = "太空友人:放轻松,深呼吸,朋友就在身边!"
	icon_state = "spacers_sidekick"
	trash_type = /obj/item/trash/spacers_sidekick
	food_reagents = list(
		/datum/reagent/consumable/sugar = 1,
		/datum/reagent/consumable/menthol = 1,
		/datum/reagent/medicine/salbutamol = 1,
	)
	tastes = list("强烈的薄荷味" = 1)
	junkiness = 15
	foodtypes = JUNKFOOD
	w_class = WEIGHT_CLASS_SMALL
