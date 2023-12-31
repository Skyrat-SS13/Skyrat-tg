//Lizard Foods, for lizards (and weird humans!)

//Meat Dishes

/obj/item/food/raw_tiziran_sausage
	name = "生血肠"
	desc = "生的蜥蜴人血肠,准备放在架子上烘干."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "raw_lizard_sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/blood = 3,
	)
	tastes = list("生肉" = 1, "'黑布丁'" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_tiziran_sausage/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dryable, /obj/item/food/tiziran_sausage)

/obj/item/food/tiziran_sausage
	name = "\improper 血肠"
	desc = "一种粗糙的干腌血肠,传统上由Zagoskeld附近农田的农民制作,与古地球西班牙辣香肠质地相似."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("腌肉" = 1, "'黑布丁'" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/raw_headcheese
	name = "生脑酪块"
	desc = "脑酪是Tizira上常见的食物,传统上是用动物的头做成的,把内脏取出来煮到破裂,然后把它收集起来,沥干水分,加大量盐,装成块,晾干和老化几个月.最终的硬块尝起来像奶酪."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "raw_lizard_cheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/salt = 5,
	)
	tastes = list("生肉" = 1, "盐" = 1)
	foodtypes = MEAT | GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_headcheese/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dryable, /obj/item/food/headcheese)

/obj/item/food/headcheese
	name = "脑酪块"
	desc = "一块腌过的脑酪,如果你是只蜥蜴,那就太美味了."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_cheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/salt = 5,
	)
	tastes = list("脑酪" = 1, "盐" = 1)
	foodtypes = MEAT | GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/headcheese/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/headcheese_slice, 5, 3 SECONDS, table_required = TRUE, screentip_verb = "Slice")

/obj/item/food/headcheese_slice
	name = "脑酪片"
	desc = "一片脑酪,用来做三明治和零食.或者熬过Tiziran寒冷的冬天."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_cheese_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("脑酪" = 1, "盐" = 1)
	foodtypes = MEAT | GORE
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/shredded_lungs
	name = "脆肺条"
	desc = "脆肺条,配蔬菜和辣酱.很好吃,如果你喜欢肺的话."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lung_stirfry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("肉" = 1, "辣" = 1, "蔬菜" = 1)
	foodtypes = MEAT | VEGETABLES | GORE
	trash_type = /obj/item/reagent_containers/cup/bowl
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/tsatsikh
	name = "蜥碎肚"
	desc = "Tiziran菜,一种由五香碎内脏塞进胃里煮熟的Tiziran菜对不习惯这种味道的人来说很恶心."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "tsatsikh"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 10)
	tastes = list("什锦杂肝碎" = 1)
	foodtypes = MEAT | GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/liver_pate
	name = "肝酱"
	desc = "一种口感丰富的肉酱,由肝、肉和一些调味料制成."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "pate"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 5)
	tastes = list("肝" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/moonfish_eggs
	name = "月鱼子"
	desc = "月鱼产的大而透明的白色卵在蜥蜴的烹饪中很珍贵.它们的味道与鱼子酱相似,但相比之下又被形容为更深、更复杂."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "moonfish_eggs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("鱼子酱" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/moonfish_caviar
	name = "月鱼子酱"
	desc = "一种由月鱼子制成的浓郁的糊状物.一般来说,这是大多数蜥蜴吃到的月鱼子唯一途径,在沿海料理中常用."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "moonfish_caviar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("鱼子酱" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/lizard_escargot
	name = "沙漠蜗牛烩"
	desc = "一个蜥蜴和人类文化交融的例子,沙漠蜗牛烩比当代法国蜗牛烩还要接近古罗马蜗牛绘.这是沙漠城市里常见的街头小吃."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_escargot"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/garlic = 2,
	)
	tastes = list("蜗牛" = 1, "蒜香" = 1, "色拉油" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/fried_blood_sausage
	name = "炸血肠"
	desc = "血肠,裹面糊并油炸.在Zagoskeld的街道上,它通常和薯条一起作为一种快速而简单的小吃."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "fried_blood_sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/salt = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 1,
	)
	tastes = list("'黑布丁'" = 1, "面糊" = 1, "油" = 1)
	foodtypes = MEAT | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

//Why does like, every language on the planet besides English call them pommes? Who knows, who cares- the lizards call them it too, because funny.
/obj/item/food/lizard_fries
	name = "蜥式炸薯条"
	desc = "许多人类食物中有一种是炸薯条,在蜥蜴语中被称为poms-franzisks。再加上烤肉和调味汁,就成了一顿丰盛的大餐."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/salt = 1,
		/datum/reagent/consumable/bbqsauce = 2,
	)
	tastes = list("薯条" = 2, "烧烤酱" = 1, "烤肉" = 1)
	foodtypes = MEAT | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/brain_pate
	name = "脑酱"
	desc = "一种用剁碎的水煮眼球和脑、炸洋葱和脂肪制成的浓稠的粉红色酱.蜥蜴吃了都说好!"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "brain_pate"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/liquidgibs = 2,
	)
	tastes = list("大脑" = 2)
	foodtypes = MEAT | VEGETABLES | GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/crispy_headcheese
	name = "炸脑块"
	desc = "Zagoskeld街头的一种美味小吃,由裹着根面包屑的脑酪片组成,通常与薯条一起食用."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "crispy_headcheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("芝士" = 1, "油" = 1)
	foodtypes = MEAT | VEGETABLES | NUTS | GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/kebab/picoss_skewers
	name = "岸边烧"
	desc = "这是一种很受欢迎的蒂兹兰街头小吃,由醋腌制的甲鱼和洋葱于辣椒串在一起."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "picoss_skewer"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/vinegar = 1,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("鱼" = 1, "醋酸" = 1, "洋葱" = 1, "辣椒" = 1)
	foodtypes = SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/nectar_larvae
	name = "蜜汁腌虫"
	desc = "脆脆的幼虫在科尔塔蜜为基底的甜辣酱里. Bugtastic!"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "nectar_larvae"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/korta_nectar = 3,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("肉" = 1, "甜" = 1, "辣" = 1)
	foodtypes = GORE | MEAT | BUGS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/mushroomy_stirfry
	name = "菌子炒"
	desc = "菌子杂烩,专为满足你的食欲而做的.吃了看小人!"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "mushroomy_stirfry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("梦幻的味道" = 1, "菌菇鲜" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

//Fish Dishes
/obj/item/food/grilled_moonfish
	name = "月鱼排"
	desc = "一块烤月鱼.传统上是在扇贝根上配上葡萄酒酱汁."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "grilled_moonfish"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("月鱼" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/moonfish_demiglace
	name = "月鱼拼盘"
	desc = "一块烤得很漂亮的月鱼,左边放着土豆和胡萝卜,右边放着红酒和半蜜糖.简单的不可思议的."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "moonfish_demiglace"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 2,
	)
	tastes = list("鱼" = 2, "土豆" = 1, "胡萝卜" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/lizard_surf_n_turf
	name = "\improper 沙滩蜥戏大餐"
	desc = "一大盘Tizira最好的肉和海鲜,通常在海滩上由大伙一起分享。当然.没有什么能阻止你一个人吃……肥仔."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "surf_n_turf"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("冲浪的体验" = 1, "蜥戏的快乐" = 1)
	foodtypes = MEAT | SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_BULKY
	crafting_complexity = FOOD_COMPLEXITY_5

//Spaghetti Dishes

/obj/item/food/spaghetti/nizaya
	name = "蜥式汤团"
	desc = "一种由根和坚果制成的面糊,原产于Tizira的海边地区.它的质地和外观都很像意式汤团."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("汤团" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/snail_nizaya
	name = "沙蜗牛汤团"
	desc = "来自Tizira葡萄园地区的高级汤团,传统上由最好的Tizira葡萄酒制成…但在紧要关头,人类的泔水也可以."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "snail_nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("蜗牛" = 1, "葡萄酒" = 1, "汤团" = 1)
	foodtypes = VEGETABLES | MEAT | NUTS
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/garlic_nizaya
	name = "蒜油汤团"
	desc = "意大利面食的蜥蜴改编,用Tizira面食制成."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "garlic_nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("蒜香" = 1, "香油" = 1, "汤团" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/spaghetti/demit_nizaya
	name = "奶油汤团"
	desc = "一种甜的,奶油味的意式汤团,用科尔塔奶和蜜制成."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "demit_nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/korta_nectar = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("甜辣" = 1, "蔬菜" = 1, "汤团" = 1)
	foodtypes = VEGETABLES | SUGAR | NUTS
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/mushroom_nizaya
	name = "菌子汤团"
	desc = "一种由菌子和优质油制成的意大利面食.有古怪的味道."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "mushroom_nizaya"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("食欲大开" = 1, "癫狂" = 1, "汤团" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4

//Dough Dishes

/obj/item/food/rootdough
	name = "粗面团"
	desc = "由坚果和块茎揉成的块茎面团.广泛用于Tiziran烹饪."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "rootdough"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("块茎根" = 1, "粗面" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/rootdough/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/bread/root, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/rootdough/make_processable()
	AddElement(/datum/element/processable, TOOL_ROLLINGPIN, /obj/item/food/flatrootdough, 1, 3 SECONDS, table_required = TRUE, screentip_verb = "Flatten")

/obj/item/food/flatrootdough
	name = "粗面饼"
	desc = "压扁的生面团,可以烤成熟饼,或切成块."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "flat_rootdough"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("块茎根" = 1, "粗面" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/flatrootdough/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/rootdoughslice, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Slice")

/obj/item/food/flatrootdough/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/root_flatbread, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/rootdoughslice
	name = "粗面团团"
	desc = "粗面团团非常适合做汤团或面包卷."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "rootdough_slice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("块茎根" = 1, "粗面" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/rootdoughslice/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/spaghetti/nizaya, 1, 3 SECONDS, table_required = TRUE, screentip_verb = "Slice")

/obj/item/food/rootdoughslice/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/rootroll, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/root_flatbread
	name = "粗烤饼"
	desc = "一种普通的粗烤饼,上面能放上蜥蜴喜欢吃的各种食物."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "root_flatbread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 8)
	tastes = list("烤饼" = 1, "粗面" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/rootroll
	name = "粗面卷"
	desc = "一种用块茎做成的致密的有嚼劲的粗面卷是一碗汤的好搭档."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "rootroll"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("有嚼劲的粗面" = 1) // the roll tastes of roll.
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_2

//Bread Dishes

/obj/item/food/bread/root
	name = "粗面包"
	desc = "这种蜥蜴面包由土豆和山药等块茎混合坚果和种子制成,明显比普通面包难咬数倍."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_bread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes = list("粗面包" = 8, "坚果" = 2)
	foodtypes = VEGETABLES | NUTS
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/breadslice/root

/obj/item/food/bread/root/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, /obj/item/food/bread/empty, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 8)

/obj/item/food/breadslice/root
	name = "粗面包片"
	desc = "有嚼劲的粗面包片."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_breadslice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("粗面包" = 8, "坚果" = 2)
	foodtypes = VEGETABLES | NUTS
	venue_value = FOOD_PRICE_TRASH

/obj/item/food/breadslice/root/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

//Pizza Dishes
/obj/item/food/pizza/flatbread
	icon = 'icons/obj/food/lizard.dmi'
	slice_type = null

/obj/item/food/pizza/flatbread/rustic
	name = "乡村粗饼"
	desc = "一种简单的Tiziran乡村菜,作为肉或鱼的配菜而流行.上面会撒上香草和油."
	icon_state = "rustic_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/vitamin = 15,
		/datum/reagent/consumable/garlic = 2,
	)
	tastes = list("粗面包" = 1, "乡村气息" = 1, "油" = 1, "葱香" = 1)
	foodtypes = VEGETABLES | NUTS
	boxtag = "Tiziran Flatbread"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/flatbread/italic
	name = "\improper 传统粗饼"
	desc = "将人类食物引入Tizira后,蜥蜴的烹饪技术也有了进步——传统烤饼现在是地球上外卖店菜单上的一道常见菜品."
	icon_state = "italic_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 15,
	)
	tastes = list("粗面包" = 1, "乡村气息" = 1, "油" = 1, "葱香" = 1, "番茄" = 1, "肉" = 1)
	foodtypes = VEGETABLES | NUTS | MEAT
	boxtag = "Italic Flatbread"
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizza/flatbread/imperial
	name = "\improper 皇帝粗饼"
	desc = "一种顶上有肉酱、腌蔬菜和切成块的脑酪的烤饼.是一种除了蜥蜴,谁都不喜欢的菜."
	icon_state = "imperial_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("粗面包" = 1, "乡村气息" = 1, "油" = 1, "葱香" = 1, "番茄" = 1, "肉" = 1)
	foodtypes = VEGETABLES | MEAT | NUTS | GORE
	boxtag = "Imperial Victory Flatbread"
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizza/flatbread/rawmeat
	name = "大肉粗饼"
	desc = "越是注重健康的蜥蜴人越是喜爱这道菜."
	icon_state = "rawmeat_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 10,
	)
	tastes = list("粗面包" = 1, "肉" = 1)
	foodtypes = MEAT | NUTS | RAW | GORE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/flatbread/stinging
	name = "\improper 爽口粗饼"
	desc = "海蜇和蜜蜂幼虫的触电混合产生了一种味道,让你想要更多!"
	icon_state = "stinging_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 20,
		/datum/reagent/consumable/honey = 2,
	)
	tastes = list("粗面包" = 1, "清甜" = 1, "触电口感" = 1, "粘腻" = 1)
	foodtypes = BUGS | NUTS | SEAFOOD | GORE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/flatbread/zmorgast  // Name is based off of the Swedish dish Smörgåstårta
	name = "\improper 夹心粗饼"
	desc = "夹心粗饼是在瑞典菜Smörgåstårta的基础上改良而来的,是家庭聚会上的一道常见菜肴."
	icon_state = "zmorgast_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 16,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("粗面包" = 1, "肝脏" = 1, "家的味道" = 1)
	foodtypes = VEGETABLES | NUTS | MEAT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/flatbread/fish
	name = "\improper 烤鱼粗饼"
	desc = "超物质分层,小丑整活,外面的世界太冷了,我只想要Tizira烧烤!"
	icon_state = "fish_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/bbqsauce = 2,
	)
	tastes = list("粗面包" = 1, "鱼" = 1)
	foodtypes = SEAFOOD | NUTS
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizza/flatbread/mushroom
	name = "番茄菌菇粗饼"
	desc = "当你已经在其他地方吃饱了肉的时候,这是传统粗饼的简单替代品."
	icon_state = "mushroom_flatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 18,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes =  list("粗面包" = 1, "菌菇" = 1, "番茄" = 1)
	foodtypes = VEGETABLES | NUTS
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizza/flatbread/nutty
	name = "坚果粗饼"
	desc = "现代烹饪技术的进步使得科尔塔坚果的美味得到了双重提升,既可以作为饼的底料,也可以作为饼的浇头."
	icon_state = "nutty_flatbread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 20)
	tastes =  list("粗面包" = 1, "坚果" = 2)
	foodtypes = NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

//Sandwiches/Toast Dishes
/obj/item/food/emperor_roll
	name = "皇帝卷"
	desc = "Tizira上很受欢迎的三明治,以皇帝之名命名."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "emperor_roll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("粗面包" = 1, "芝士" = 1, "肝" = 1, "鱼子酱" = 1)
	foodtypes = VEGETABLES | NUTS | MEAT | GORE | SEAFOOD
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/honey_roll
	name = "蜂蜜甜卷"
	desc = "一种加了切片水果的甜粗面卷,在Tizira上作为时令甜点享用."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "honey_roll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/honey = 2,
	)
	tastes = list("粗面包" = 1, "蜂蜜" = 1, "水果" = 1)
	foodtypes = VEGETABLES | NUTS | FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

//Egg Dishes
/obj/item/food/black_eggs
	name = "黑炒蛋"
	desc = "一道来自Tizira乡村的乡村菜。用鸡蛋、血和野菜做成的.传统上是和粗面包和辣酱一起吃."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "black_eggs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("鸡蛋" = 1, "野菜" = 1, "血" = 1)
	foodtypes = MEAT | BREAKFAST | GORE
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/patzikula
	name = "酱鸡蛋"
	desc = "味道醇厚的番茄辣酱上煎蛋."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "patzikula"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("煎蛋" = 1, "番茄" = 1, "辣" = 1)
	foodtypes = VEGETABLES | MEAT | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

//Cakes/Sweets

/obj/item/food/cake/korta_brittle
	name = "科塔尔坚果糖"
	desc = "一大块脆果仁,甜到犯罪!"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "korta_brittle"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 20,
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/korta_nectar = 15,
	)
	tastes = list("辛辣" = 1, "甜" = 1)
	foodtypes = NUTS | SUGAR
	slice_type = /obj/item/food/cakeslice/korta_brittle
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/korta_brittle
	name = "科塔尔坚果糖块"
	desc = "一小片坚果糖.糖尿病患者最大的敌人."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "korta_brittle_slice"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/korta_nectar = 3,
	)
	tastes = list("辛辣" = 1, "甜" = 1)
	foodtypes = NUTS | SUGAR

/obj/item/food/snowcones/korta_ice
	name = "科塔尔刨冰"
	desc = "刨冰,科尔塔蜜和浆果.一种消暑的甜食!"
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "korta_ice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/ice = 4,
		/datum/reagent/consumable/berryjuice = 6,
	)
	tastes = list("辛辣" = 1, "浆果" = 1)
	foodtypes = NUTS | SUGAR | FRUIT

/obj/item/food/kebab/candied_mushrooms
	name = "菌菇糖"
	desc = "这是一道来自Tizira的有点奇怪的菜,由烤串上涂有焦糖的蘑菇组成,甜味和咸味奇怪地交融在一起."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "candied_mushrooms"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/caramel = 4,
	)
	tastes = list("菌菇鲜" = 1, "甜" = 1)
	foodtypes = SUGAR | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

//Misc Dishes
/obj/item/food/sauerkraut
	name = "蜥蜴泡菜"
	desc = "泡菜,由德国人发扬光大,在蜥蜴烹饪中也很常见,被称为Zauerkrat."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "sauerkraut"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4)
	tastes = list("卷心菜" = 1, "酸" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/lizard_dumplings
	name = "\improper Tiziran饺子"
	desc = "捣碎的根茎蔬菜,与korta面粉混合,煮成一个又大又圆又辣的饺子.常作汤食用."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "lizard_dumplings"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("根茎蔬菜" = 1, "微辣" = 1)
	foodtypes = VEGETABLES | NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/steeped_mushrooms
	name = "浸渍菌菇"
	desc = "在碱水中浸泡以去除毒素的菌菇,从而使它们可以安全食用."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "steeped_mushrooms"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("菌菇鲜" = 1, "梦幻的味道" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/canned/jellyfish
	name = "海蜇罐头"
	desc = "一罐装在盐水里的炮手海蜇,含有一种温和的致幻毒素,烹调后会被破坏."
	icon_state = "jellyfish"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/toxin/mindbreaker = 2,
		/datum/reagent/consumable/salt = 1,
	)
	trash_type = /obj/item/trash/can/food/jellyfish
	tastes = list("滑溜溜" = 1, "火辣辣" = 1, "盐" = 1)
	foodtypes = SEAFOOD | GORE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/canned/desert_snails
	name = "沙蜗罐头"
	desc = "来自Tizira沙漠的巨型蜗牛,装在盐水里,没有去壳.最好不要生吃,除非你是只蜥蜴."
	icon_state = "snails"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/salt = 2,
	)
	trash_type = /obj/item/trash/can/food/desert_snails
	tastes = list("蜗牛" = 1)
	foodtypes = MEAT | GORE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/canned/larvae
	name = "蜜虫罐头"
	desc = "一罐用蜂蜜包装的蜜蜂幼虫.可能是在引诱某人."
	icon_state = "larvae"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/honey = 2,
	)
	trash_type = /obj/item/trash/can/food/larvae
	tastes = list("蜜虫" = 1)
	foodtypes = MEAT | GORE | BUGS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/rootbread_peanut_butter_jelly
	name = "花生果酱三明治"
	desc = "经典的花生酱三明治,就像你妈妈以前做的复制品一样."
	icon_state = "peanutbutter-jelly"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("花生酱" = 1, "果酱" = 1, "粗面包" = 2)
	foodtypes = FRUIT | NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/rootbread_peanut_butter_banana
	name = "花生果酱香蕉三明治"
	desc = "花生果酱三明治和香蕉片混合在一起,是一种很好的高蛋白食物."
	icon_state = "peanutbutter-banana"
	icon = 'icons/obj/food/lizard.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/banana = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("花生酱" = 1, "香蕉" = 1, "粗面包" = 2)
	foodtypes = FRUIT | NUTS
	crafting_complexity = FOOD_COMPLEXITY_3
