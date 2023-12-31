//Not only meat, actually, but also snacks that are almost meat, such as fish meat or tofu


////////////////////////////////////////////FISH////////////////////////////////////////////

/obj/item/food/cubancarp
	name = "\improper 古巴鲤鱼"
	desc = "美味的鱼肉会灼烧你的舌头,然后让它麻痹!"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "cubancarp"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/capsaicin = 1,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("鱼肉" = 4, "面糊" = 1, "辣椒" = 1)
	foodtypes = SEAFOOD | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/fishmeat
	name = "生鱼片" // fillet
	desc = "一片生鱼片"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishfillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	bite_consumption = 6
	tastes = list("鱼肉" = 1)
	foodtypes = SEAFOOD
	eatverbs = list("bite", "chew", "gnaw", "swallow", "chomp")
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/fishmeat/carp
	name = "生鲤鱼片"
	desc = "一片生鲤鱼片"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/toxin/carpotoxin = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	/// Cytology category you can swab the meat for.
	var/cell_line = CELL_LINE_TABLE_CARP

/obj/item/food/fishmeat/carp/Initialize(mapload)
	. = ..()
	if(cell_line)
		AddElement(/datum/element/swabable, cell_line, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/fishmeat/carp/imitation
	name = "仿生鲤鱼片"
	desc = "就像真的一样."
	cell_line = null
	starting_reagent_purity = 0.3

/obj/item/food/fishmeat/moonfish
	name = "生月鱼片"
	desc = "一片生月鱼片."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "moonfish_fillet"

/obj/item/food/fishmeat/moonfish/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/grilled_moonfish, rand(40 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/fishmeat/gunner_jellyfish
	name = "生水母片"
	desc = "移除毒刺的炮手水母,轻微的迷幻."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "jellyfish_fillet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/toxin/mindbreaker = 2,
	)

/obj/item/food/fishmeat/armorfish
	name = "甲鱼肉" // armorfish
	desc = "剥去内脏和壳的甲鱼,准备用于烹饪."
	icon = 'icons/obj/food/lizard.dmi'
	icon_state = "armorfish_fillet"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 3)

///donkfish fillets. The yuck reagent is now added by the fish trait of the same name.
/obj/item/food/fishmeat/donkfish
	name = "河豚片" // donkfish
	desc = "可怕的河豚片.理智的太空人都不会吃这个,而且煮熟了也没用."
	icon_state = "donkfillet"

/obj/item/food/fishmeat/octopus
	name = "鱿鱼须"
	desc = "鱿鱼的大触手."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "octopus_fillet"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 3)

/obj/item/food/fishmeat/octopus/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/grilled_octopus, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/fishfingers
	name = "鱼柳条"
	desc = "一种将鱼肉切成长条状,裹上面包屑后炸制而成的食品,常作为零食或主食食用."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishfingers"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	bite_consumption = 1
	tastes = list("鱼肉" = 1, "面包糠" = 1)
	foodtypes = SEAFOOD | FRIED
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/fishandchips
	name = "炸鱼薯条"
	desc = "I do say so myself chap."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishandchips"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("鱼肉" = 1, "薯条" = 1)
	foodtypes = SEAFOOD | VEGETABLES | FRIED
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/fishfry
	name = "炸鱼"
	desc = "就这些,没有薯条..."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fishfry"
	food_reagents = list (
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("鱼肉" = 1, "蔬菜" = 1)
	foodtypes = SEAFOOD | VEGETABLES | FRIED
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/vegetariansushiroll
	name = "素食寿司卷"
	desc = "一卷简单的素食寿司,可以切成片."
	icon_state = "vegetariansushiroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("米饭" = 4, "胡萝卜" = 2, "土豆" = 2)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/vegetariansushiroll/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/vegetariansushislice, 4, screentip_verb = "Chop")

/obj/item/food/vegetariansushislice
	name = "素食寿司"
	desc = "一片简单的素食寿司."
	icon_state = "vegetariansushislice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("米饭" = 4, "胡萝卜" = 2, "土豆" = 2)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/spicyfiletsushiroll
	name = "辣鱼寿司卷"
	desc = "用鱼和蔬菜做成的一卷美味而辛辣的寿司卷,可以切成片."
	icon_state = "spicyfiletroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/capsaicin = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("米饭" = 4, "鱼肉" = 2, "辣酱" = 2)
	foodtypes = VEGETABLES | SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/spicyfiletsushiroll/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/spicyfiletsushislice, 4, screentip_verb = "Chop")

/obj/item/food/spicyfiletsushislice
	name = "辣鱼寿司"
	desc = "用鱼和蔬菜做成的一片美味、辛辣的寿司.不要吃得太快!."
	icon_state = "spicyfiletslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/capsaicin = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("米饭" = 4, "鱼肉" = 2, "辣酱" = 2)
	foodtypes = VEGETABLES | SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

// empty sushi for custom sushi
/obj/item/food/sushi/empty
	name = "寿司卷"
	foodtypes = NONE
	tastes = list()
	icon_state = "vegetariansushiroll"
	desc = "一卷寿司卷,可以自定义."
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/sushi/empty/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/sushislice/empty, 4, screentip_verb = "Chop")

/obj/item/food/sushislice/empty
	name = "寿司"
	foodtypes = NONE
	tastes = list()
	icon_state = "vegetariansushislice"
	desc = "一片自定义寿司."
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/nigiri_sushi
	name = "手握寿司"
	desc = "一个简单的生鱼片寿司,在包好的饭团上加上海藻和酱油."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "nigiri_sushi"
	food_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 6, /datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("米饭" = 4, "生鱼片" = 2, "酱油" = 2)
	foodtypes = SEAFOOD | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/meat_poke
	name = "肉波奇饭"
	desc = "波奇饭,也叫夏威夷盖浇饭,就是将各种食材切成块搅拌在饭中."
	icon = 'icons/obj/food/soupsalad.dmi'
	icon_state = "pokemeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	foodtypes = SEAFOOD | MEAT | VEGETABLES
	tastes = list("米肉相杂" = 4, "生菜" = 2, "酱油" = 2)
	trash_type = /obj/item/reagent_containers/cup/bowl
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/fish_poke
	name = "鱼波奇饭"
	desc = "波奇饭,也叫夏威夷盖浇饭,就是将各种食材切成块搅拌在饭中."
	icon = 'icons/obj/food/soupsalad.dmi'
	icon_state = "poke鱼肉"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	foodtypes = SEAFOOD | VEGETABLES
	tastes = list("鱼米相杂" = 4, "生菜" = 2, "酱油" = 2)
	trash_type = /obj/item/reagent_containers/cup/bowl
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

////////////////////////////////////////////MEATS AND ALIKE////////////////////////////////////////////

/obj/item/food/tempeh
	name = "生天贝" // raw tempeh block
	desc = "天贝,又名丹贝、天培,源于南洋岛国,一种天然发酵大豆制品,从1990s开始,天贝成为欧美餐饮健康的代表食物,至今风行."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "tempeh"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 8)
	tastes = list("土味" = 3, "坚果" = 2, "清淡" = 1 )
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

// sliceable into 4xtempehslices
/obj/item/food/tempeh/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/tempehslice, 4, 5 SECONDS, table_required = TRUE, screentip_verb = "Slice")

//add an icon for slices
/obj/item/food/tempehslice
	name = "天贝片"
	desc = "天贝,又名丹贝、天培,源于南洋岛国,一种天然发酵大豆制品,从1990s开始,天贝成为欧美餐饮健康的代表食物,至今风行."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "tempehslice"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("土味" = 3, "坚果" = 2, "清淡" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

//add an icon for blends
/obj/item/food/tempehstarter
	name = "天贝混合物"
	desc = "大豆和欢乐的混合.它摸起来是温暖的...而且在动?"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "tempehstarter"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("nutty" = 2, "bland" = 2)
	foodtypes = VEGETABLES | GROSS
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/tofu
	name = "豆腐"
	desc = "我们都爱豆腐"
	icon_state = "tofu"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("豆腐" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/tofu/prison
	name = "湿豆腐"
	desc = "你拒绝吃这个奇怪的豆制品."
	tastes = list("酸腐的水" = 1)
	foodtypes = GROSS

/obj/item/food/spiderleg
	name = "蜘蛛腿"
	desc = "一只大蜘蛛还在抽搐的腿……你不会真的想吃这个吧?"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spiderleg"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/toxin = 2,
	)
	tastes = list("蜘蛛网" = 1)
	foodtypes = MEAT | TOXIC
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/spiderleg/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/boiledspiderleg, rand(50 SECONDS, 60 SECONDS), TRUE, TRUE)

/obj/item/food/cornedbeef
	name = "咸牛肉和卷心菜"
	desc = "一种传统的爱尔兰美食,通常在圣帕特里克节食用,就是那个穿绿衣服带绿帽子还拿着绿三叶草的节日."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "cornedbeef"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("咸牛肉" = 1, "卷心菜" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/bearsteak
	name = "燃力熊排"
	desc = "因为吃熊肉还不够有男子气概."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "bearsteak"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 9,
		/datum/reagent/consumable/ethanol/manly_dorf = 5,
	)
	tastes = list("肉" = 1, "鲑鱼" = 1)
	foodtypes = MEAT | ALCOHOL
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/raw_meatball
	name = "生肉丸"
	desc = "一顿丰盛的大餐."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "raw_meatball"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("肉" = 1)
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_SMALL
	var/meatball_type = /obj/item/food/meatball
	var/patty_type = /obj/item/food/raw_patty

/obj/item/food/raw_meatball/make_grillable()
	AddComponent(/datum/component/grillable, meatball_type, rand(30 SECONDS, 40 SECONDS), TRUE)

/obj/item/food/raw_meatball/make_processable()
	AddElement(/datum/element/processable, TOOL_ROLLINGPIN, patty_type, 1, table_required = TRUE, screentip_verb = "Flatten")

/obj/item/food/raw_meatball/human
	name = "奇怪的生肉丸"
	meatball_type = /obj/item/food/meatball/human
	patty_type = /obj/item/food/raw_patty/human

/obj/item/food/raw_meatball/corgi
	name = "生柯基肉丸"
	meatball_type = /obj/item/food/meatball/corgi
	patty_type = /obj/item/food/raw_patty/corgi

/obj/item/food/raw_meatball/xeno
	name = "生异形肉丸"
	meatball_type = /obj/item/food/meatball/xeno
	patty_type = /obj/item/food/raw_patty/xeno

/obj/item/food/raw_meatball/bear
	name = "生熊肉丸"
	meatball_type = /obj/item/food/meatball/bear
	patty_type = /obj/item/food/raw_patty/bear

/obj/item/food/raw_meatball/chicken
	name = "生鸡肉丸"
	meatball_type = /obj/item/food/meatball/chicken
	patty_type = /obj/item/food/raw_patty/chicken

/obj/item/food/meatball
	name = "肉丸"
	desc = "一顿丰盛的大餐."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meatball"
	inhand_icon_state = "meatball"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("肉丸" = 1)
	foodtypes = MEAT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/meatball/human
	name = "奇怪的肉丸"

/obj/item/food/meatball/corgi
	name = "柯基肉丸"

/obj/item/food/meatball/bear
	name = "熊肉丸"
	tastes = list("肉" = 1, "鲑鱼" = 1)

/obj/item/food/meatball/xeno
	name = "异形肉丸"
	tastes = list("肉" = 1, "酸液" = 1)

/obj/item/food/meatball/chicken
	name = "鸡肉丸"
	tastes = list("鸡肉" = 1)
	icon_state = "chicken_meatball"

/obj/item/food/raw_patty
	name = "生肉饼"
	desc = "I'm.....NOT REAAADDYY."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "raw_patty"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("肉" = 1)
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_SMALL
	var/patty_type = /obj/item/food/patty/plain

/obj/item/food/raw_patty/make_grillable()
	AddComponent(/datum/component/grillable, patty_type, rand(30 SECONDS, 40 SECONDS), TRUE)

/obj/item/food/raw_patty/human
	name = "奇怪的生肉饼"
	patty_type = /obj/item/food/patty/human

/obj/item/food/raw_patty/corgi
	name = "生柯基肉饼"
	patty_type = /obj/item/food/patty/corgi

/obj/item/food/raw_patty/bear
	name = "生熊肉丸"
	tastes = list("肉" = 1, "鲑鱼" = 1)
	patty_type = /obj/item/food/patty/bear

/obj/item/food/raw_patty/xeno
	name = "生异形肉饼"
	tastes = list("肉" = 1, "酸液" = 1)
	patty_type = /obj/item/food/patty/xeno

/obj/item/food/raw_patty/chicken
	name = "生鸡肉饼"
	tastes = list("鸡肉" = 1)
	patty_type = /obj/item/food/patty/chicken

/obj/item/food/patty
	name = "肉饼"
	desc = "你可以叫他汉堡肉."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "patty"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("肉" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

///Exists purely for the crafting recipe (because itll take subtypes)
/obj/item/food/patty/plain

/obj/item/food/patty/human
	name = "奇怪的肉饼"

/obj/item/food/patty/corgi
	name = "柯基肉饼"

/obj/item/food/patty/bear
	name = "熊肉饼"
	tastes = list("肉" = 1, "鲑鱼" = 1)

/obj/item/food/patty/xeno
	name = "异形肉饼"
	tastes = list("肉" = 1, "酸液" = 1)

/obj/item/food/patty/chicken
	name = "鸡肉饼"
	tastes = list("鸡肉饼" = 1)
	icon_state = "chicken_patty"

/obj/item/food/raw_sausage
	name = "生香肠"
	desc = "一堆被捏成长条形状的生肉."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "raw_sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("肉" = 1)
	foodtypes = MEAT | RAW
	eatverbs = list("咬", "咀嚼", "啃", "吞", "大口咀嚼", "撕咬")
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1
	// bite chew nibble deep throat gobble chomp

/obj/item/food/raw_sausage/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/sausage, rand(60 SECONDS, 75 SECONDS), TRUE)

/obj/item/food/sausage
	name = "香肠"
	desc = "一堆被捏成长条形状的肉."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "sausage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("肉" = 1)
	foodtypes = MEAT | BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	eatverbs = list("咬", "咀嚼", "啃", "吞", "大口咀嚼", "撕咬")
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/sausage/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/salami, 6, 3 SECONDS, table_required = TRUE,  screentip_verb = "片") // Slice
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/sausage/american, 1, 3 SECONDS, table_required = TRUE,  screentip_verb = "片")

/obj/item/food/sausage/american
	name = "美式香肠"
	desc = "Snip."
	icon_state = "american_sausage"

/obj/item/food/sausage/american/make_processable()
	return

/obj/item/food/salami
	name = "萨拉米腊肠"
	desc = "萨拉米是欧洲尤其是南欧民众喜爱食用的一种腌制肉肠,肉一般是单一种肉类,不经过任何烹饪、只经过发酵和风干程序."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "salami"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 1)
	tastes = list("肉" = 1, "烟熏味" = 1)
	foodtypes = MEAT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/rawkhinkali
	name = "生卡里饺"
	desc = "最早起源于格鲁吉亚山区,后流传到高加索地区.和中国的小笼包外形极为相似,内馅上也大同小异."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "khinkali"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/garlic = 1,
	)
	tastes = list("肉末" = 1, "洋葱" = 1, "蒜蓉" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/rawkhinkali/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/khinkali, rand(50 SECONDS, 60 SECONDS), TRUE)

/obj/item/food/khinkali
	name = "卡里饺"
	desc = "最早起源于格鲁吉亚山区,后流传到高加索地区.和中国的小笼包外形极为相似,内馅上也大同小异."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "khinkali"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/garlic = 2,
	)
	bite_consumption = 3
	tastes = list("肉末" = 1, "洋葱" = 1, "蒜蓉" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/meatbun
	name = "包肉烧"
	desc = "神秘的美味烧肉食品."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meatbun"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("圆面包" = 3, "肉" = 2)
	foodtypes = GRAIN | MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/stewedsoymeat
	name = "炖素肉"
	desc = "就算是肉食者也爱它!"
	icon_state = "stewedsoymeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("大豆" = 1, "蔬菜" = 1)
	eatverbs = list("喝了一口", "抿了一口", "吸了一口", "吞了一口")
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/boiledspiderleg
	name = "煮蜘蛛腿"
	desc = "一只大蜘蛛的腿被烤熟后还在抽搐,真恶心!"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spiderlegcooked"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/capsaicin = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("辣椒" = 1, "蜘蛛网" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/spidereggsham
	name = "绿蛋火腿"
	desc = "你会在火车上吃吗?你会在飞机上吃吗?你会在一个漂浮在太空中的属于公司的死亡陷阱上吃它们吗？"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spidereggsham"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	bite_consumption = 4
	tastes = list("肉" = 1, "五彩斑斓的绿" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/sashimi
	name = "胜利刺身"
	desc = "为了庆祝从敌对外星生物的攻击中幸存下来.你希望厨师确实地料理了食材."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "sashimi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/capsaicin = 9,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("鱼肉" = 1, "辣椒" = 1)
	foodtypes = SEAFOOD
	w_class = WEIGHT_CLASS_TINY
	//total price of this dish is 20 and a small amount more for soy sauce, all of which are available at the orders console
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/sashimi/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CARP, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/nugget
	name = "鸡块"
	desc = "一个 \"鸡块 \" ，形状有点像什么东西."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	icon = 'icons/obj/food/meat.dmi'
	/// Default nugget icon for recipes that need any nugget
	icon_state = "nugget_lump"
	tastes = list("\"鸡肉味\"" = 1)
	foodtypes = MEAT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/nugget/Initialize(mapload)
	. = ..()
	var/shape = pick("块状", "星形", "蜥蜴形", "柯基形")
	desc = "一个[shape]的鸡块."
	icon_state = "nugget_[shape]"

/obj/item/food/pigblanket
	name = "猪包毯"  // pig in blanket
	desc = "一根小香肠裹在酥脆的黄油面包卷里.这是一种墨西哥乡村菜,目前已经广泛地在西方世界流行."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "pigblanket"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("肉" = 1, "黄油" = 1)
	foodtypes = MEAT | DAIRY | GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bbqribs
	name = "烧烤肋排"
	desc = "烧烤肋排,涂上一层健康的烧烤酱.最不素的东西。"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "ribs"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/bbqsauce = 10,
	)
	tastes = list("肋排" = 3, "烧烤酱" = 1)
	foodtypes = MEAT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/meatclown
	name = "小丑肉"
	desc = "一块美味的圆形小丑肉,多么可怕."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meatclown"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/banana = 2,
	)
	tastes = list("肉" = 5, "小丑" = 3, "红色气球" = 1)
	w_class = WEIGHT_CLASS_SMALL
	foodtypes = MEAT | FRUIT
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/meatclown/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, 3 SECONDS)

/obj/item/food/lasagna
	name = "千层面"
	desc = "一片意大利千层面,星期一下午的绝配."
	icon_state = "lasagna"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/tomatojuice = 10,
	)
	tastes = list("肉" = 3, "意大利面" = 3, "番茄" = 2, "芝士" = 2)
	foodtypes = MEAT | DAIRY | GRAIN
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3

//////////////////////////////////////////// KEBABS AND OTHER SKEWERS ////////////////////////////////////////////

/obj/item/food/kebab
	trash_type = /obj/item/stack/rods
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "kebab"
	w_class = WEIGHT_CLASS_NORMAL
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 14)
	tastes = list("肉" = 3, "烤串" = 1)
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/kebab/human
	name = "烤人肉串"
	desc = "血淋淋的人肉."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 16,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("嫩肉" = 3, "烤串" = 1)
	foodtypes = MEAT | GORE
	venue_value = FOOD_PRICE_CHEAP

/obj/item/food/kebab/monkey
	name = "烤肉串"
	desc = "美味的肉在烤串上."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 16,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("肉" = 3, "烤串" = 1)
	foodtypes = MEAT
	venue_value = FOOD_PRICE_CHEAP

/obj/item/food/kebab/tofu
	name = "烤豆腐串"
	desc = "素肉在烤串上."
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 15)
	tastes = list("豆腐" = 3, "烤串" = 1)
	foodtypes = VEGETABLES
	venue_value = FOOD_PRICE_CHEAP

/obj/item/food/kebab/tail
	name = "烤蜥蜴尾串"
	desc = "切下来的蜥蜴尾巴串在烤串上."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 30,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("肉" = 8, "烤串" = 4, "鳞屑" = 1)
	foodtypes = MEAT | GORE

/obj/item/food/kebab/rat
	name = "鼠肉串"
	desc = "不美味的老鼠肉在烤串上."
	icon_state = "ratkebab"
	w_class = WEIGHT_CLASS_NORMAL
	trash_type = null
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("鼠肉" = 1, "烤串" = 1)
	foodtypes = MEAT | GORE
	venue_value = FOOD_PRICE_CHEAP

/obj/item/food/kebab/rat/double
	name = "大鼠肉串"
	icon_state = "doubleratkebab"
	tastes = list("鼠肉" = 2, "烤串" = 1)
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 20,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/iron = 2,
	)

/obj/item/food/kebab/fiesta
	name = "什锦肉串"
	desc = "不同的蔬菜和肉在烤串上."
	icon_state = "fiestaskewer"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/capsaicin = 3,
	)
	tastes = list("美墨边境烹饪风味" = 3, "孜然" = 2)
	foodtypes = MEAT | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/fried_chicken
	name = "炸鸡"
	desc = "一个炸得刚好得多汁炸鸡."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "fried_chicken1"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("鸡肉" = 3, "炸面衣" = 1)
	foodtypes = MEAT | FRIED
	junkiness = 25
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/fried_chicken/Initialize(mapload)
	. = ..()
	if(prob(50))
		icon_state = "fried_chicken2"

/obj/item/food/beef_stroganoff
	name = "俄式牛柳"
	desc = "一道起源于19世纪的俄罗斯菜,在世界各地都很受欢迎,主要由小块牛肉和酸奶油酱组成,并经常加入不同的蔬菜."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "beefstroganoff"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 16,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("牛柳" = 3, "酸奶油" = 1, "咸味" = 1, "辣味" = 1)
	foodtypes = MEAT | VEGETABLES | DAIRY

	w_class = WEIGHT_CLASS_SMALL
	//basic ingredients, but a lot of them. just covering costs here
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/beef_wellington
	name = "惠灵顿牛排"
	desc = "西餐的代表作之一,用以检验西餐厨师的能力,一大块肥美的牛肉,裹上一层蘑菇和烟熏火腿,然后裹上酥皮."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "beef_wellington"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 21,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("牛肉" = 3, "蘑菇" = 1, "熏肉" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_NORMAL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/beef_wellington/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/beef_wellington_slice, 3, 3 SECONDS, table_required = TRUE,  screentip_verb = "Cut")

/obj/item/food/beef_wellington_slice
	name = "惠灵顿牛排片"
	desc = "西餐的代表作之一,用以检验西餐厨师的能力,一大块肥美的牛肉,裹上一层蘑菇和烟熏火腿,然后裹上酥皮."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "beef_wellington_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("牛肉" = 3, "蘑菇" = 1, "熏肉" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/full_english
	name = "全套英式早餐"
	desc = "丰盛的一盘,配上所有的辅料,代表着早餐艺术的顶峰."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "full_english"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("香肠" = 1, "培根" = 1, "煎蛋" = 1, "番茄" = 1, "蘑菇" = 1, "面包" = 1, "豆子" = 1)
	foodtypes = MEAT | VEGETABLES | GRAIN | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_EXOTIC
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/raw_meatloaf
	name = "生肉"
	desc = "A heavy 'loaf' of minced meat, onions, and garlic. Bake it in an oven!"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "raw_meatloaf"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 40,
		/datum/reagent/consumable/nutriment/vitamin = 32,
		/datum/reagent/consumable/nutriment = 32,
	)
	tastes = list("raw meat" = 3, "onions" = 1)
	foodtypes = MEAT | RAW | VEGETABLES
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_meatloaf/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/meatloaf, rand(30 SECONDS, 40 SECONDS), TRUE, TRUE)

/obj/item/food/meatloaf
	name = "烘肉卷"  // meatloaf loaf就是切片面包没切之前那一整条的量词
	desc = "在美国流行的食物,其实就是把肉做成一个大面包状,并在烤箱中烘烤上面覆盖了一层厚厚的番茄酱.可以用刀切成片"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meatloaf"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 40,
		/datum/reagent/consumable/nutriment/vitamin = 32,
		/datum/reagent/consumable/nutriment = 32,
	)
	tastes = list("多汁的肉" = 3, "洋葱" = 1, "蒜蓉" = 1, "番茄酱" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/meatloaf/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/meatloaf_slice, 4, 3 SECONDS, table_required = TRUE,  screentip_verb = "Cut")

/obj/item/food/meatloaf_slice
	name = "烘肉卷片"
	desc = "在美国流行的食物,其实就是把肉做成一个大面包状,并在烤箱中烘烤上面覆盖了一层厚厚的番茄酱."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "meatloaf_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("多汁的肉" = 3, "洋葱" = 1, "蒜蓉" = 1, "番茄酱" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/sweet_and_sour_meatballs
	name = "糖醋肉丸" // sweet and sour meatballs
	desc = "金黄的肉丸淋上美味的酱汁,配上菠萝和胡椒."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "sweet_and_sour_meatballs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment = 8,
	)
	tastes = list("肉" = 5, "美味的酱汁" = 4, "菠萝" = 3, "胡椒" = 2)
	foodtypes = MEAT | VEGETABLES | FRUIT | PINEAPPLE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/kebab/pineapple_skewer
	name = "菠萝肉串"
	desc = "大块的肉和菠萝片串在一根烤串上,令人惊讶的是还不错!"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "pineapple_skewer"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("多汁的肉" = 4, "菠萝" = 3)
	foodtypes = MEAT | FRUIT | PINEAPPLE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/futomaki_sushi_roll
	name = "太卷寿司"
	desc = "太卷是直径比较粗的一种卷寿司,一般常用的材料有鸡蛋烧、香菇、干瓢、黄瓜、鱼肉松.可切片."
	icon_state = "futomaki_sushi_roll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("米饭" = 4, "鱼肉" = 5, "鸡蛋" = 3, "海苔片" = 2, "黄瓜" = 2)
	foodtypes = VEGETABLES | SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/futomaki_sushi_roll/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/futomaki_sushi_slice, 4, screentip_verb = "Chop")

/obj/item/food/futomaki_sushi_slice
	name = "太卷寿司"
	desc = "太卷是直径比较粗的一种卷寿司,一般常用的材料有鸡蛋烧、香菇、干瓢、黄瓜、鱼肉松."
	icon_state = "futomaki_sushi_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("米饭" = 4, "鱼肉" = 5, "鸡蛋" = 3, "海苔片" = 2, "黄瓜" = 2)
	foodtypes = VEGETABLES | SEAFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/philadelphia_sushi_roll
	name = "费城卷"
	desc = "以美国费城命名并在美国流行的寿司卷,可切片."
	icon_state = "philadelphia_sushi_roll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("米饭" = 4, "鱼肉" = 5, "奶油芝士" = 3, "海苔片" = 2, "黄瓜" = 2)
	foodtypes = VEGETABLES | SEAFOOD | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/philadelphia_sushi_roll/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/philadelphia_sushi_slice, 4, screentip_verb = "Chop")

/obj/item/food/philadelphia_sushi_slice
	name = "费城卷片"
	desc = "以美国费城命名并在美国流行的寿司卷,可切片."
	icon_state = "philadelphia_sushi_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("米饭" = 4, "鱼肉" = 5, "奶油芝士" = 3, "海苔片" = 2, "黄瓜" = 2)
	foodtypes = VEGETABLES | SEAFOOD | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
