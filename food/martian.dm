//Ingredients and Simple Dishes
/obj/item/food/kimchi
	name = "韩国泡菜"
	desc = "火星风味的经典韩国菜——切碎的白菜配辣椒、konbu、鲣鱼和各种香料."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("辣白菜" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/inferno_kimchi
	name = "地狱辣泡菜"
	desc = "当普通泡菜无法满足你对吃辣的渴望时,地狱辣泡菜可以帮你解决这个问题."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "inferno_kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 3,
	)
	tastes = list("地狱辣" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/garlic_kimchi
	name = "蒜蓉泡菜"
	desc = "经典配方的新花样——泡菜和大蒜,终于完美地融合在一起."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "garlic_kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/capsaicin = 1,
		/datum/reagent/consumable/garlic = 2,
	)
	tastes = list("辣白菜" = 1, "大蒜" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/surimi
	name = "鱼糜"
	desc = "一份生鱼糜."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "surimi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("鱼" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/surimi/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dryable, /obj/item/food/kamaboko)

/obj/item/food/kamaboko
	name = "未切的鸣门卷"
	desc = "一种从江户时代传下来的日式鱼糕,也叫蒲鉾,常用于小吃和拉面中."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kamaboko_sunrise"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("鱼" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/kamaboko/Initialize(mapload)
	. = ..()
	var/design = pick("smiling", "spiral", "star", "sunrise")
	name = "[design] kamaboko"
	icon_state = "kamaboko_[design]"

/obj/item/food/kamaboko/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/kamaboko_slice, 4, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/kamaboko_slice
	name = "鸣门卷"
	desc = "一种从江户时代传下来的日式鱼糕,也叫蒲鉾,常用于小吃和拉面中."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kamaboko_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("鱼" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/sambal
	name = "参巴辣椒酱"
	desc = "一种来自印度尼西亚的辣酱,广泛用于东南亚的烹饪中."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "sambal"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/capsaicin = 2
	)
	tastes = list("辣" = 1, "鲜" = 1)
	foodtypes = SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/katsu_fillet
	name = "日式煎猪排"
	desc = "裹上面包屑和油炸过的肉,用于各种菜肴。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "katsu_fillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment = 2
	)
	tastes = list("肉" = 1, "面包糠" = 1)
	foodtypes = MEAT | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/rice_dough
	name = "米粉团"
	desc = "用等量的米粉和米粉做成的面团,味道独特."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "rice_dough"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6
	)
	tastes = list("稻米" = 1)
	foodtypes = GRAIN

/obj/item/food/rice_dough/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/bread/reispan, rand(30 SECONDS, 45 SECONDS), TRUE, TRUE)

/obj/item/food/rice_dough/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/spaghetti/rawnoodles, 6, 3 SECONDS, table_required = TRUE)

/obj/item/food/spaghetti/rawnoodles
	name = "米粉"
	desc = "新鲜的米粉.记住,没有什么秘方."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "raw_noodles"

	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	tastes = list("稻米" = 1)
	foodtypes = GRAIN

/obj/item/food/spaghetti/boilednoodles
	name = "熟面条"
	desc = "即食熟食."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "cooked_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	tastes = list("米饭" = 1)
	foodtypes = GRAIN

/obj/item/food/bread/reispan
	name = "米粉面包"
	desc = "纯纯的神秘食品."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "reispan"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15
	)
	tastes = list("面包" = 10)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_TRASH

/obj/item/food/bread/reispan/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/breadslice/reispan, 5, 3 SECONDS, table_required = TRUE)

/obj/item/food/breadslice/reispan
	name = "米粉面包片"
	desc = "有些人觉得人活着就不能没有三明治."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "reispan_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3
	)
	foodtypes = GRAIN | VEGETABLES

// Fried Rice

/obj/item/food/salad/hurricane_rice
	name = "旋风炒饭"
	desc = "这道辛辣的米饭受到了印度炒饭的启发,因其在烹饪时颠锅像飓风而得名."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "hurricane_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("米饭" = 1, "肉丁" = 1, "菠萝" = 1, "蔬菜" = 1)
	foodtypes = MEAT | GRAIN | PINEAPPLE | FRUIT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/ikareis
	name = "墨汁鱿鱼炒饭"
	desc = "用墨汁,辣椒,洋葱,香肠和美味的辣椒做成的辛辣米饭."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ikareis"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 4
	)
	tastes = list("米饭" = 1, "墨汁" = 1, "蔬菜" = 1, "香肠" = 1, "辛辣" = 1)
	foodtypes = MEAT | GRAIN | SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/hawaiian_fried_rice
	name = "\improper 夏威夷炒饭"
	desc = "夏威夷炒饭不是传统的夏威夷菜,而是使用了一系列的夏威夷食材——包括切丁的菠菜和有争议的菠萝."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "hawaiian_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("米饭" = 1, "肉丁" = 1, "菠萝" = 1, "酱油" = 1, "蔬菜" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/ketchup_fried_rice
	name = "番茄酱炒饭"
	desc = "番茄酱炒饭是一种受西方启发的炒饭,用甜而浓的番茄酱制成.在日本很受欢迎,."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ketchup_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/ketchup = 2,
	)
	tastes = list("米饭" = 1, "香肠" = 1, "番茄酱" = 1, "蔬菜" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/mediterranean_fried_rice
	name = "地中海炒饭"
	desc = "一种奇妙的炒饭配方:香草、奶酪、橄榄，还有肉丸.有点像意大利烩饭和炒饭的混合体."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "mediterranean_fried_rice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("米饭" = 1, "奶酪" = 1, "肉丸" = 1, "橄榄" = 1, "香草" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/egg_fried_rice
	name = "蛋炒饭"
	desc = "就像炒饭一样简单:米饭、鸡蛋、酱油.快捷方便量大。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "egg_fried_稻米"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("米饭" = 1, "鸡蛋" = 1, "酱油" = 1)
	foodtypes = MEAT | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/egg_fried_rice/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

/obj/item/food/salad/bibimbap
	name = "石锅拌饭"
	desc = "一种韩国菜,由米饭和各种配料组成,盛在滚烫的砂锅里."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "bibimbap"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("米饭" = 1, "辣白菜" = 1, "辛辣" = 1, "蛋" = 1, "肉" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/bibimbap/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

// Noodles
/obj/item/food/salad/bulgogi_noodles
	name = "烤肉拌面"
	desc = "韩式烤肉配面条!加入了辣椒酱."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "bulgogi_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("韩式烤肉" = 1, "面条" = 1, "辛辣" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | FRUIT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/yakisoba_katsu
	name = "炸猪排炒面"
	desc = "炸猪排铺在炒面上."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "yakisoba_katsu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("炒面" = 1, "肉" = 1, "面包糠" = 1, "蔬菜" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/martian_fried_noodles
	name = "\improper 火星炒面"
	desc = "来自红色星球的炒面.火星料理借鉴了许多文化,这些面条也不例外——这里有马来西亚、泰国、中国、韩国和日本料理的元素."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "martian_fried_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("炒面" = 1, "肉" = 1, "坚果" = 1, "洋葱" = 1, "蛋" = 1)
	foodtypes = GRAIN | NUTS | MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/simple_fried_noodles
	name = "炒面"
	desc = "一道简单而美味的炒面菜,非常适合有创意的厨师做任何他们想做的炒面."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "simple_fried_noodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 6,
	)
	tastes = list("炒面" = 1, "酱油" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/simple_fried_noodles/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

// Curry
/obj/item/food/salad/setagaya_curry //let me explain...
	name = "\improper 世田谷咖喱"
	desc = "这种咖喱因世田谷的一家咖啡馆而出名,其广泛的配方一直是世界各地咖啡馆老板们严守的秘密.据说这种味道可以填补食客的灵魂."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "setagaya_curry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/medicine/omnizine = 5,
	)
	tastes = list("极品咖喱" = 1, "米饭" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

// Burgers and Sandwiches
/obj/item/food/burger/big_blue
	name = "\improper Big blue burger"
	desc = "来自火星人民最喜欢的汉堡店!"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "big_blue_burger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("圆面包" = 1, "汉堡" = 2, "照烧洋葱" = 1, "芝士" = 1, "培根" = 1, "菠萝" = 1)
	foodtypes = MEAT | GRAIN | DAIRY | VEGETABLES | FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/burger/chappy // 这里是它的原文，我他妈不会给他翻译半句. Originally born of a night of drinking in a Big Blue Burger's kitchen, the Chappy patty has since become a staple of both Big Blue's menu and Hawaiian (or at least, faux-Hawaiian) cuisine galaxy-wide. Given Big Kahuna operates most of its stores on Mars, it's perhaps no wonder this dish is popular there.
	name = "\improper Chappy patty"
	desc = "同样来自火星人民最喜欢的汉堡店."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chappy_patty"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("汉堡包" = 1, "煎猪排" = 2, "蛋" = 1, "芝士" = 1, "番茄酱" = 1)
	foodtypes = MEAT | GRAIN | DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/king_katsu_sandwich // 他妈的外国佬无语了
	name = "\improper 肉王三明治"
	desc = "一个大三明治,里面有酥脆的炸猪排、培根、泡菜沙拉和沙拉,全都放在米面包片上."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "king_katsu_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("肉" = 1, "培根" = 1, "韩国泡菜" = 1, "沙拉" = 1, "米粉面包" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/marte_cubano_sandwich
	name = "\improper 古巴三明治"
	desc = "一种来自火星的食物,以经典的古巴菜为基础,但根据原料的口味与获取难度进行了改良."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "marte_cubano_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("培根" = 1, "腌菜" = 1, "芝士" = 1, "米粉面包" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/little_shiro_sandwich
	name = "\improper little shiro三明治"
	desc = "经典的火星三明治,以TerraGov公司第一位来自火星的总裁命名。它的特色是煎蛋、烤牛肉、泡菜沙拉和健康的马苏里拉奶酪。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "marte_cubano_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("蛋" = 1, "肉" = 1, "韩国泡菜" = 1, "马苏里拉奶酪" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/croque_martienne
	name = "火腿起司三明治"
	desc = "典型的火星早餐三明治.鸡蛋,五花肉,菠萝,奶酪.简单经典.在新大阪的每家咖啡馆都可以买到."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "croque_martienne"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("鸡蛋" = 1, "吐司" = 1, "猪肉" = 1, "菠萝" = 1, "芝士" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES | GRAIN | PINEAPPLE | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/prospect_sunrise
	name = "\improper 日升三明治"
	desc = "第二种最典型的火星早餐三明治.煎蛋,培根,泡菜和奶酪的完美组合.在展望街的每家咖啡馆都有."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "prospect_sunrise"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("鸡蛋" = 1, "吐司" = 1, "培根" = 1, "韩国泡菜" = 1, "芝士" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES | GRAIN | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL

// Snacks
/obj/item/food/takoyaki
	name = "章鱼小丸子"
	desc = "章鱼烧是一种经典的日本街头小吃,由章鱼和洋葱在油炸面糊中制成,上面浇上调味汁."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "takoyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("章鱼" = 1, "面糊" = 1, "洋葱" = 1, "乌酢" = 1)
	foodtypes = SEAFOOD | GRAIN | FRIED | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/takoyaki/russian
	name = "俄罗斯章鱼小丸子"
	desc = "在一道经典菜肴上做了一个危险的改变,这是逃避警察的完美掩护."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "russian_takoyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/capsaicin = 10,
	)
	tastes = list("章鱼" = 1, "面糊" = 1, "洋葱" = 1, "辛辣" = 1)
	foodtypes = SEAFOOD | GRAIN | FRIED | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/takoyaki/taco
	name = "墨西哥小丸子"
	desc = "从火星最具创意的街头小吃摊上流传而来,这是墨西哥版章鱼小丸子——用墨西哥卷肉和玉米及墨西哥干酪换章鱼和乌酢.¡Tan sabroso !"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "tacoyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("塔可肉" = 1, "面糊" = 1, "玉米" = 1, "芝士" = 1)
	foodtypes = MEAT | GRAIN | FRIED | VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/okonomiyaki
	name = "御好烧"
	desc = "御好烧是来自广岛的一种好吃的薄饼（也可称为“日本比萨”）,它是由面糊、蔬菜、海藻、肉、类似乌酢的甜酱和日本蛋黄酱做成的.实际上你可以加入自己的配料."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "okonomiyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("面糊" = 1, "卷心菜" = 1, "洋葱" = 1, "乌酢" = 1)
	foodtypes = SEAFOOD | GRAIN | FRIED | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

//hey, the name literally means "grilled how you like it", it'd be crazy to not make it customisable
/obj/item/food/okonomiyaki/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

/obj/item/food/brat_kimchi
	name = "炸泡菜"
	desc = "炸泡菜,拌上糖,切点小香肠.火星上居酒屋最受欢迎的一道菜."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "brat_kimchi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/sugar = 2,
	)
	tastes = list("辣白菜" = 1, "香肠" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/tonkatsuwurst
	name = "东胜香肠"
	desc = "这是德国和日本烹饪文化的融合,炸猪排和咖喱混合成熟悉而又新鲜的东西."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "tonkatsuwurst"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/worcestershire = 2,
	)
	tastes = list("香肠" = 1, "辣酱" = 1, "薯条" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/kebab/ti_hoeh_koe
	name = "炸猪血糕"
	desc = "猪血,与米面混合,油炸,上面撒上花生和香菜.台湾美食."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ti_hoeh_koe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/peanut_butter = 1,
	)
	tastes = list("猪血" = 1, "坚果" = 1, "香菜" = 1)
	foodtypes = MEAT | NUTS | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/kitzushi
	name = "辣稻荷寿司"
	desc = "这是一种在火星上很受vulpinids欢迎的稻荷寿司的变体,辣稻荷寿司将辣芝士和辣椒混合在一起,以增加额外的味道."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kitzushi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("米饭" = 1, "豆腐" = 1, "辣芝士" = 1)
	foodtypes = GRAIN | FRIED | VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/epok_epok
	name = "epok-epok"
	desc = "和稻荷寿司有关的神秘糕点。”."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "epok_epok"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("咖喱" = 1, "鸡蛋" = 1, "糕点" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/roti_john
	name = "约翰面包"
	desc = "这是一种经典的马来西亚小吃,由面包和肉、鸡蛋和洋葱混合油炸而成,其味道介于法式吐司和煎蛋卷之间."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "roti_john"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment = 10,
	)
	tastes = list("面包" = 1, "鸡蛋" = 1, "肉" = 1, "洋葱" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES | FRIED | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/izakaya_fries
	name = "居酒屋薯条"
	desc = "两个世纪以来,大阪最受欢迎的新薯条——这一切都要归功于杨梅、日式香松和蛋黄酱的结合."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "izakaya_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("薯条" = 1, "居酒屋的味道" = 1)
	foodtypes = VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/kurry_ok_subsando
	name = "kurry-ok subsando"
	desc = "一片很长的面包,夹了薯条,蛋黄酱,肉与咖喱."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kurry_ok_subsando"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("长面包" = 1, "辣酱薯条" = 1, "mayonnaise" = 1, "curry" = 1, "肉" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/loco_moco
	name = "loco moco"
	desc = "来自夏威夷的简单经典.这是一顿充实、美味又便宜的饭.你也可以叫它牛肉汉堡饭."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "loco_moco"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("米饭" = 1, "汉堡" = 1, "肉汁" = 1, "鸡蛋" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/wild_duck_fries
	name = "酱鸭薯条"
	desc = "薯条配酱鸭,番茄酱,蛋黄酱和杨梅.这是火星上的经典街头小吃,它们通常与火星上最受欢迎的(也是唯一的)鸭子主题快餐连锁店Kwik-Kwak联系在一起。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "wild_duck_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("薯条" = 1, "酱鸭" = 1, "番茄酱" = 1, "蛋黄酱" = 1, "辛辣的调味料" = 1)
	foodtypes = MEAT | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/little_hawaii_hotdog
	name = "\improper 小夏威夷热狗"
	desc = "火奴鲁鲁大道上友好的小贩们带来了小夏威夷热狗!"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "little_hawaii_hotdog"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("香肠" = 1, "菠萝" = 1, "洋葱" = 1, "照烧酱" = 1)
	foodtypes = MEAT | VEGETABLES | FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salt_chilli_fries
	name = "椒盐薯条"
	desc = "这道菜简单的名字并不能说明它的美味——当然,盐和辣椒是重要的成分,但洋葱、姜和大蒜才是真正的关键."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "salt_chilli_fries"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("薯条" = 1, "大蒜" = 1, "姜" = 1, "麻木" = 1, "咸味" = 1)
	foodtypes = VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/grilled_octopus
	name = "铁板鱿鱼触手"
	desc = "一道简单的海鲜菜,凡是吃章鱼的地方都有.火星人喜欢配上梅干."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "grilled_octopus"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/char = 2)
	tastes = list("鱿鱼" = 1)
	foodtypes = SEAFOOD | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/steak_croquette
	name = "炸牛排"
	desc = "老兄，把大块牛排裹上淀粉,一定是乡村做法."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "steak_croquette"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("牛排" = 1, "淀粉" = 1)
	foodtypes = MEAT | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/chapsilog
	name = "菲律宾盖饭"
	desc = "一种传统的菲律宾风格的简单而充实的早餐."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chapsilog"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/garlic = 1,
	)
	tastes = list("火腿" = 1, "蒜蓉炒饭" = 1, "鸡蛋" = 1)
	foodtypes = MEAT | GRAIN | VEGETABLES | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/chap_hash
	name = "烤盘杂烩" // chap hash
	desc = "把辣椒、洋葱、辣椒和土豆混合在一起会得到什么?当然是烤盘杂烩了!再加上一些梅干,你就有了一顿美味的早餐."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chap_hash"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment = 3,
	)
	tastes = list("火腿" = 1, "洋葱" = 1, "辣椒" = 1, "土豆" = 1)
	foodtypes = MEAT | VEGETABLES | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/agedashi_tofu
	name = "日式炸豆腐"
	desc = "脆炸豆腐,配上美味的鲜汤.常在居酒屋享用."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "agedashi_tofu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("鲜汤" = 1, "豆腐" = 1)
	foodtypes = SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

// Curries and Stews
/obj/item/food/salad/po_kok_gai
	name = "椰子咖喱鸡"
	desc = "这道菜也被称为galinha à portuguesa,尽管这道菜本身并不是葡萄牙菜,而是葡萄牙殖民时期诞生在澳门的经典菜肴.这是一种温和的椰子咖喱."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "po_kok_gai"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("鸡肉" = 1, "椰子" = 1, "咖喱" = 1)
	foodtypes = MEAT | VEGETABLES | FRUIT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/huoxing_tofu
	name = "\improper 火星豆腐"
	desc = "这是一种由麻婆豆腐改编而成的豆腐,在火星美食圣地Prospect出名.如果你真的眯着眼睛看的话,它甚至有点像火星."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "huoxing_tofu"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/capsaicin = 2
	)
	tastes = list("肉" = 1, "辛辣" = 1, "豆腐" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/feizhou_ji
	name = "非洲鸡"
	desc = "虽然叫非洲鸡,但是是澳门菜."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "feizhou_ji"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("鸡肉" = 1, "辛辣" = 1, "醋" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/galinha_de_cabidela
	name = "卡比德拉米饭"
	desc = "卡比德拉米饭最初是一道葡萄牙菜,传统上在葡萄牙是用鸡肉做的,在澳门是用鸭子做的——最终,由于欧洲的影响,鸡肉版在火星上胜出。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "galinha_de_cabidela"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 12,
	)
	tastes = list("鸡肉" = 1, "葡萄牙风味" = 1, "醋" = 1, "米饭" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/katsu_curry
	name = "猪排咖喱" // katsu 猪排
	desc = "咖喱饭上放了猪排。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "katsu_curry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("咖喱" = 1, "肉" = 1, "面包糠" = 1, "米饭" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/beef_bowl
	name = "牛肉丼"
	desc = "炖牛肉和洋葱的美味混合物,配米饭食用.典型的配料包括腌姜、辣椒粉和煎蛋."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "beef_bowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("牛肉" = 25, "洋葱" = 25, "辣" = 15, "米饭" = 34, "触及灵魂的美味" = 1) //I pour my soul into this bowl
	foodtypes = MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/salt_chilli_bowl
	name = "辣鱿鱼丼"
	desc = "受日本盖饭传统的启发,这种辣味的盖饭风靡整个火星国度."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "salt_chilli_bowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("海鲜" = 1, "米饭" = 1, "大蒜" = 1, "姜" = 1, "麻辣" = 1, "咸味" = 1)
	foodtypes = SEAFOOD | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/kansai_bowl
	name = "\improper 关西丼"
	desc = "这种盖饭也被称为konohadon,是关西地区的经典美食,由鱼饼、鸡蛋和洋葱组成."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kansai_bowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("海鲜" = 1, "米饭" = 1, "鸡蛋" = 1, "洋葱" = 1)
	foodtypes = SEAFOOD | MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/salad/eigamudo_curry //Eigamudo curry
	name = "\improper 臭咖喱"
	desc = "一种莫名其妙的咖喱菜是由各种不和谐的食材做成的.对某个地方的某个人来说,味道可能很好——不过要找到它们就得祝你好运了."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "eigamudo_curry"
	food_reagents = list(
		/datum/reagent/consumable/nutraslop = 8,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/toxin/slimejelly = 4,
	)
	tastes = list("勇气" = 1, "黏糊" = 1, "软骨" = 1, "米饭" = 1, "神秘食材X" = 1)
	foodtypes = GROSS | GRAIN | TOXIC
	w_class = WEIGHT_CLASS_SMALL

// Entrees
/obj/item/food/cilbir
	name = "cilbir" // 土耳其鸡蛋 无中文译名
	desc = "也叫土耳其鸡蛋,配上美味的酸奶和辣油.它最初是一道土耳其菜,随着德国-土耳其移民来到火星,从那时起就成为了早餐的主食."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "cilbir"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/capsaicin = 2,
		/datum/reagent/consumable/garlic = 1,
	)
	tastes = list("酸奶" = 1, "大蒜" = 1, "柠檬" = 1, "鸡蛋" = 1, "辛辣" = 1)
	foodtypes = DAIRY | VEGETABLES | FRUIT | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/peking_duck_crepes
	name = "\improper 橙鸭可丽" // Peking duck crepes a l'orange
	desc = "这道菜融合了北京和巴黎两大菜系的精华,味道鲜美可口."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "peking_duck_crepes"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/orangejuice = 4,
	)
	tastes = list("肉" = 1, "可丽饼" = 1, "橙味" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES | FRUIT
	w_class = WEIGHT_CLASS_SMALL

// Desserts
/obj/item/food/cake/spekkoek
	name = "香兰千层糕" // vulgaris spekkoek  vulgaris译为香兰叶
	desc = "千层糕是荷兰和印尼殖民者带到火星上的一种常见的节日蛋糕,通常作为传统的rijsttael的一部分."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "spekkoek"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 30,
		/datum/reagent/consumable/nutriment/vitamin = 15
	)
	tastes = list("冬香料" = 2, "香兰叶" = 2, "蛋糕" = 5)
	foodtypes = GRAIN | SUGAR | DAIRY

/obj/item/food/cake/spekkoek/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/cakeslice/spekkoek, 5, 3 SECONDS, table_required = TRUE)

/obj/item/food/cakeslice/spekkoek
	name = "香兰千层糕片"
	desc = "一片香兰千层糕.会让一个火星人想起家乡。"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "spekkoek_slice"
	tastes = list("冬香料" = 2, "香兰叶" = 2, "蛋糕" = 5)
	foodtypes = GRAIN | SUGAR | DAIRY

/obj/item/food/salad/pineapple_foster
	name = "菠萝甜碗"
	desc = "这是火星人民对另一种经典甜点的经典改编,菠萝甜碗是一种烤制的甜点,只有轻微到中度的火灾风险。."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pineapple_foster"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/caramel = 4,
		/datum/reagent/consumable/pineapplejuice = 2,
		/datum/reagent/consumable/milk = 4
	)
	tastes = list("菠萝" = 1, "香草" = 1, "焦糖" = 1, "冰淇淋" = 1)
	foodtypes = FRUIT | DAIRY | PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/pastel_de_nata
	name = "奶油蛋糕"
	desc = "最初由葡萄牙僧侣发明,在葡萄牙殖民帝国的统治下,pastsamis de nata走向了世界——它与香港和澳门的定居者一起从澳门来到了火星."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pastel_de_nata"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("蛋奶沙司" = 1, "香草" = 1, "甜品" = 1)
	foodtypes = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/boh_loh_yah
	name = "菠萝包"
	desc = "这种被称为“菠萝包”的香港小吃其实并不含菠萝,而是一种像糖饼干一样的面包,里面夹着黄油."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "boh_loh_yah"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("糖饼干" = 1, "黄油" = 1)
	foodtypes = DAIRY | GRAIN | PINEAPPLE //it's funny
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/banana_fritter
	name = "香蕉油酥" // banana fritter
	desc = "这是一种来自东南亚沿海地区的无处不在的甜点."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "banana_fritter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("香蕉" = 1, "面糊" = 1)
	foodtypes = GRAIN | FRUIT | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/pineapple_fritter
	name = "菠萝油酥"
	desc = "和它的表亲香蕉油酥一样,菠萝油酥也是一种受欢迎的小吃,尽管菠萝味道对不同的人来说各有喜好."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pineapple_fritter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("菠萝" = 1, "面糊" = 1)
	foodtypes = GRAIN | FRUIT | FRIED | PINEAPPLE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/kebab/kasei_dango
	name = "日式丸子"
	desc = "日式丸子,用石榴和橙子调味,最终的结果看起来像火星,吃起来像甜点."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "kasei_dango"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/orangejuice = 3,
		/datum/reagent/consumable/grenadine = 3
	)
	tastes = list("石榴" = 1, "橙子" = 1)
	foodtypes = FRUIT | GRAIN
	w_class = WEIGHT_CLASS_SMALL

// Frozen
/obj/item/food/pb_ice_cream_mochi
	name = "花生酱冰淇淋麻糬"
	desc = "作为Prospect阿拉伯街夜市的经典甜点,花生酱冰淇淋麻糬是以花生酱口味的冰淇淋为主要馅料,再裹上一层台湾传统的花生碎."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pb_ice_cream_mochi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/peanut_butter = 4,
		/datum/reagent/consumable/milk = 2,
	)
	tastes = list("花生酱" = 1, "麻糬" = 1)
	foodtypes = NUTS | GRAIN | DAIRY | SUGAR
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/popsicle/pineapple_pop
	name = "冰菠萝糖"
	desc = "很少有文化像火星人那样爱吃菠萝,而这道甜点就证明了这一点."
	overlay_state = "pineapple_pop"
	food_reagents = list(
		/datum/reagent/consumable/pineapplejuice = 4,
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("冻菠萝" = 1, "巧克力" = 1)
	foodtypes = SUGAR | PINEAPPLE

/obj/item/food/popsicle/sea_salt
	name = "海盐雪糕"
	desc = "这款天蓝色的冰淇淋是用最好的进口海盐调味的.咸的……不,甜!"
	overlay_state = "sea_salt_pop"
	food_reagents = list(
		/datum/reagent/consumable/salt = 1,
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("咸味" = 1, "甜味" = 1)
	foodtypes = SUGAR | DAIRY

// topsicles, also known as tofu popsicles
/obj/item/food/popsicle/topsicle
	name = "浆果豆腐冰棒"
	desc = "一种由豆腐和浆果汁混合制成的冷冻食品,然后冷冻.据说是熊的最爱,但这说不通……"
	overlay_state = "topsicle_berry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/berryjuice = 4
	)
	tastes = list("浆果" = 1, "豆腐" = 1)
	foodtypes = FRUIT | VEGETABLES

/obj/item/food/popsicle/topsicle/banana
	name = "香蕉豆腐冰棒"
	desc = "由豆腐和香蕉汁混合制成的冷冻食品,然后冷冻.夏天在日本农村很流行."
	overlay_state = "topsicle_banana"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/banana = 4
	)
	tastes = list("香蕉" = 1, "豆腐" = 1)

/obj/item/food/popsicle/topsicle/pineapple
	name = "菠萝豆腐冰棒"
	desc = "由豆腐和菠萝汁混合制成的冷冻食品,然后冷冻.就像在电视上看到的."
	overlay_state = "topsicle_菠萝"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/pineapplejuice = 4
	)
	tastes = list("菠萝" = 1, "豆腐" = 1)

// Ballpark Food
/obj/item/food/plasma_dog_supreme
	name = "\improper 等离子至尊狗"
	desc = "新大阪啄木鸟(New Osaka Woodpeckers)的故乡赛博孙公园(Cybersun Park)的招牌小吃:棒球热狗配参巴、大葱烤洋葱和菠萝酸橙莎莎酱."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "plasma_dog_supreme"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment = 6
	)
	tastes = list("香肠" = 1, "好滋味" = 1, "洋葱" = 1, "水果沙拉" = 1)
	foodtypes = FRUIT | MEAT | PINEAPPLE | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/frickles
	name = "辣丸子"
	desc = "辣炸腌菜?如此大胆的组合肯定只可能来自一个地方——火星棒球场?"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "frickles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("辣丸子" = 1)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/raw_ballpark_pretzel
	name = "生椒盐卷饼"
	desc = "一团扭曲的面团,准备烘烤或煎烤?"
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "raw_ballpark_pretzel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("长面包" = 1, "椒盐" = 1)
	foodtypes = GRAIN | RAW
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/raw_ballpark_pretzel/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/ballpark_pretzel, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/raw_ballpark_pretzel/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/ballpark_pretzel, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/ballpark_pretzel
	name = "椒盐卷饼"
	desc = "一种经典的德国面包,被美帝国主义改造成比赛日的小吃,后被日本移民带到火星上."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ballpark_pretzel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("长面包" = 1, "椒盐" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/kebab/raw_ballpark_tsukune
	name = "生鸡肉串"
	desc = "生鸡肉肉丸串,准备烤成美味的东西."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "raw_ballpark_tsukune"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment = 2,
	)
	tastes = list("生鸡肉" = 7, "沙门氏菌" = 1)
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/kebab/raw_ballpark_tsukune/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/kebab/ballpark_tsukune, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/kebab/ballpark_tsukune
	name = "鸡肉串"
	desc = "香辣烤鸡肉串,火星棒球场的常见景象."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "ballpark_tsukune"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment = 4,
	)
	tastes = list("鸡肉" = 1, "鲜香酱" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL

// Ethereal-suitable cross-culture food
/*	Ethereals are, as part of the uplifting process, considered as citizens of the Terran Federation.
	For this reason, a lot of ethereals have chosen to move throughout human space, settling on various planets to a mixed reception.
	Mars is no exception to this rule, where the ethereal population has been more welcomed than most, due to Mars' more cosmopolitan past.
	Here, the ethereals have developed a distinct culture, neither that of their homeland nor that of Mars, and with that a distinct cuisine.
*/

// Pickled Voltvine
/obj/item/food/pickled_voltvine
	name = "泡泡菜"
	desc = "泡泡菜在Sprout(在那里被称为hinu' ashuruhk)的传统菜,与腌姜和韩国泡菜(至少在适当的时候)一起在神圣的火星泡菜神殿中占有一席之地."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "pickled_voltvine"
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity/enriched = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("酸萝卜" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

// 24-Volt Energy
/obj/item/food/volt_fish
	name = "24伏特电气鱼"
	desc = "有些人可能会质疑这道菜.毕竟,用电蓝色的超酸能量饮料泡鱼看起来很糟糕.确实,味道很糟糕." //beats the hell out of me
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "volt_fish"
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity/enriched = 6,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("鱼" = 1, "酸梨" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_SMALL

// Sprout Bowl
/obj/item/food/salad/sprout_bowl
	name = "\improper 鱼芽丼"
	desc = "以Ethereal的家园命名,这款以米饭为基础的碗借鉴了盖饭的传统,但拒绝了典型的盖饭配料."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "sprout_bowl"
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity/enriched = 8,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("鱼" = 1, "酸梨" = 1, "米饭" = 1)
	foodtypes = SEAFOOD | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
