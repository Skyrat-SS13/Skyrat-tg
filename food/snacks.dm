////////////////////////////////////////////SNACKS FROM VENDING MACHINES////////////////////////////////////////////
//in other words: junk food
//don't even bother looking for recipes for these

/obj/item/food/candy
	name = "糖果"
	desc = "牛轧糖，你爱也好，恨也罢."
	icon_state = "candy"
	trash_type = /obj/item/trash/candy
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 3,
	)
	junkiness = 25
	tastes = list("糖果" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/candy/bronx
	name = "\improper 南布朗克斯奇生糖果"
	desc = "有助于减肥!焦糖摩卡口味.本产品的消..."
	icon_state = "bronx"
	inhand_icon_state = "candy"
	trash_type = /obj/item/trash/candy
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/yuck = 1,
	)
	junkiness = 10
	bite_consumption = 10
	tastes = list("糖果" = 5, "减肥" = 4, "幼虫" = 1)
	foodtypes = JUNKFOOD | RAW | BUGS
	custom_price = 80
	w_class = WEIGHT_CLASS_TINY
	var/revelation = FALSE

/obj/item/food/candy/bronx/make_edible()
	. = ..()
	AddComponent(/datum/component/edible, on_consume = CALLBACK(src, PROC_REF(on_consume)))

/obj/item/food/candy/bronx/proc/on_consume(mob/living/eater)
	if(ishuman(eater))
		var/mob/living/carbon/human/carl = eater
		var/datum/disease/disease = new /datum/disease/parasite()
		carl.ForceContractDisease(disease, make_copy = FALSE, del_on_fail = TRUE)

/obj/item/food/candy/bronx/examine(mob/user)
	. = ..()
	if(!revelation && !isobserver(user))
		. += span_notice("天啊，你得去检查一下眼睛。你应该再看看...")

		name = "\improper 南布朗克斯寄生糖果"
		desc = "有助于减肥!焦糖摩卡口味! 警告:本产品不适合人类食用。內含活的双翅虫样本."
		revelation = TRUE

/obj/item/food/sosjerky
	name = "\improper Scaredy's私人储备牛肉干"
	icon_state = "sosjerky"
	desc = "牛肉出在最好的太空牛身上."
	trash_type = /obj/item/trash/sosjerky
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/salt = 2,
	)
	junkiness = 25
	tastes = list("风干肉" = 1)
	w_class = WEIGHT_CLASS_SMALL
	foodtypes = JUNKFOOD | MEAT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/sosjerky/healthy
	name = "自制牛肉干"
	desc = "牛肉出在最好的太空牛身上."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	junkiness = 0

/obj/item/food/chips
	name = "薯片"
	desc = "瑞克指挥官的What-The-Crisps.."
	icon_state = "chips"
	trash_type = /obj/item/trash/chips
	bite_consumption = 1
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/salt = 1,
	)
	junkiness = 20
	tastes = list("咸味" = 1, "薯片" = 1)
	foodtypes = JUNKFOOD | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/chips/make_leave_trash()
	if(trash_type)
		AddElement(/datum/element/food_trash, trash_type, FOOD_TRASH_POPABLE)

/obj/item/food/chips/shrimp
	name = "虾片"
	desc = "虾味薯片,海鲜鉴赏家最喜欢的垃圾食品!"
	icon_state = "shrimp_chips"
	trash_type = /obj/item/trash/shrimp_chips
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 3,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("咸" = 1, "虾" = 1)
	foodtypes = JUNKFOOD | FRIED | SEAFOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/no_raisin
	name = "\improper 4no葡萄干"
	icon_state = "4no_raisins"
	desc = "全宇宙最好的葡萄干,不知道为什么。"
	trash_type = /obj/item/trash/raisins
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	junkiness = 25
	tastes = list("葡萄干" = 1)
	foodtypes = JUNKFOOD | FRUIT | SUGAR
	food_flags = FOOD_FINGER_FOOD
	custom_price = PAYCHECK_CREW * 0.7
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/no_raisin/healthy
	name = "自制的葡萄干"
	desc = "自制的葡萄干，是所有葡萄中最好的."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	junkiness = 0
	foodtypes = FRUIT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/spacetwinkie
	name = "\improper 太空小蛋糕"
	icon_state = "space_twinkie"
	desc = "保证会比你活得更久."
	food_reagents = list(/datum/reagent/consumable/sugar = 4)
	junkiness = 25
	foodtypes = JUNKFOOD | GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	custom_price = PAYCHECK_LOWER
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/candy_trash
	name = "糖果烟头"
	icon = 'icons/obj/clothing/masks.dmi'
	icon_state = "candybum"
	desc = "抽完后剩下的糖果烟头,可以吃!"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/ash = 3,
	)
	junkiness = 10 //powergame trash food by buying candy cigs in bulk and eating them when they extinguish
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/candy_trash/nicotine
	desc = "抽完后剩下的糖果香烟。闻起来像尼古丁?"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/ash = 3,
		/datum/reagent/drug/nicotine = 1,
	)

/obj/item/food/cheesiehonkers
	name = "\improper 奶酪小零食"
	desc = "一口大小的奶酪零食会让你满嘴都是."
	icon_state = "cheesie_honkers"
	trash_type = /obj/item/trash/cheesie
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 3,
	)
	junkiness = 25
	tastes = list("奶酪" = 5, "薯片" = 2)
	foodtypes = JUNKFOOD | DAIRY | SUGAR
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/syndicake
	name = "\improper 辛迪糕"
	icon_state = "syndi_cakes"
	desc = "一个非常湿润的零食蛋糕，在核爆后味道一样好."
	trash_type = /obj/item/trash/syndi_cakes
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/doctor_delight = 5,
	)
	tastes = list("甜" = 3, "蛋糕" = 1)
	foodtypes = GRAIN | FRUIT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/energybar
	name = "\improper 高能量棒"
	icon_state = "energybar"
	desc = "一个能量棒，如果你不是Ethereal，你可能不应该吃这个."
	trash_type = /obj/item/trash/energybar
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/liquidelectricity/enriched = 3,
	)
	tastes = list("能量" = 3, "刺激" = 2)
	foodtypes = TOXIC
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/peanuts
	name = "\improper Gallery花生"
	desc = "极度愤怒下的最爱零食。"
	icon_state = "peanuts"
	trash_type = /obj/item/trash/peanuts
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("花生" = 4, "愤怒" = 1)
	foodtypes = JUNKFOOD | NUTS
	custom_price = PAYCHECK_CREW * 0.8 //nuts are expensive in real life, and this is the best food in the vendor. 坚果在现实生活中很贵，而这是摊贩卖的最好的食物
	junkiness = 10 //less junky than other options, since peanuts are a decently healthy snack option 不像其他选择那么垃圾，因为花生是一种相当健康的零食选择
	w_class = WEIGHT_CLASS_SMALL
	grind_results = list(/datum/reagent/consumable/peanut_butter = 5, /datum/reagent/consumable/nutriment/fat/oil = 2)
	var/safe_for_consumption = TRUE

/obj/item/food/peanuts/salted
	name = "\improper Gallery盐花生"
	desc = "Tastes salty."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/salt = 1,
	)
	tastes = list("花生" = 3, "盐" = 1, "高血压" = 1)

/obj/item/food/peanuts/wasabi
	name = "\improper Gallery芥末花生"
	desc = "所有花生口味中最令人愤怒的."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/capsaicin = 1,
	)
	tastes = list("花生" = 3, "芥末" = 1, "狂怒" = 1)

/obj/item/food/peanuts/honey_roasted
	name = "\improper Gallery无甜花生"
	desc = "甜到发苦."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("花生" = 3, "蜂蜜" = 1, "苦" = 1)

/obj/item/food/peanuts/barbecue
	name = "\improper GalleryIDEDBBQ花生"
	desc = "有烟的地方不一定有火——有时只是烧烤酱."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/bbqsauce = 1,
	)
	tastes = list("花生" = 3, "烧烤酱" = 1, "争吵" = 1)

/obj/item/food/peanuts/ban_appeal
	name = "\improper Gallery什锦花生"
	desc = "一种注定失败的什锦果，在6个地区被禁止。每年的游说都被否决了，不是因为苹果有毒，而是因为他们一直在逃避禁令."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/toxin/cyanide = 1,
	) //uses dried poison apples
	tastes = list("花生" = 3, "苹果" = 1, "懊悔" = 1)
	safe_for_consumption = FALSE

/obj/item/food/peanuts/random
	name = "\improper Gallery怪味花生"
	desc = "下一口是什么味道?"
	icon_state = "peanuts"
	safe_for_consumption = FALSE

GLOBAL_LIST_INIT(safe_peanut_types, populate_safe_peanut_types())

/proc/populate_safe_peanut_types()
	. = list()
	for(var/obj/item/food/peanuts/peanut_type as anything in subtypesof(/obj/item/food/peanuts))
		if(!initial(peanut_type.safe_for_consumption))
			continue
		. += peanut_type

/obj/item/food/peanuts/random/Initialize(mapload)
	// Generate a sample p
	var/peanut_type = pick(GLOB.safe_peanut_types)
	var/obj/item/food/sample = new peanut_type(loc)

	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	tastes = sample.tastes

	qdel(sample)

	. = ..()

/obj/item/food/cnds
	name = "\improper C&Ds"
	desc = "从法律上讲，我们不能说这些不会在你手中融化."
	icon_state = "cnds"
	trash_type = /obj/item/trash/cnds
	food_reagents = list(
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/coco = 1,
	)
	tastes = list("巧克力糖果" = 3)
	junkiness = 25
	foodtypes = JUNKFOOD
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/cnds/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]让[src]融化在自己手心里!这是一种自杀行为!"))
	return TOXLOSS

/obj/item/food/cnds/caramel
	name = "焦糖C&Ds"
	desc = "里面塞满了甜的焦糖，这是糖尿病患者最可怕的噩梦."
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/caramel = 1,
	)
	tastes = list("巧克力糖果" = 2, "焦糖" = 1)

/obj/item/food/cnds/pretzel
	name = "椒盐C&Ds"
	desc = "Eine köstliche Begleitung zu Ihrem Lieblingsbier."
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
	)
	tastes = list("巧克力糖" = 2, "椒盐饼干" = 1)
	foodtypes = JUNKFOOD | GRAIN

/obj/item/food/cnds/peanut_butter
	name = "花生酱C&Ds"
	desc = "深受小孩和外星人的喜爱."
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/peanut_butter = 1,
	)
	tastes = list("巧克力糖" = 2, "花生酱" = 1)

/obj/item/food/cnds/banana_honk
	name = "香蕉C&Ds"
	desc = "到处都是小丑的官方糖果. Honk honk!"
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/banana = 1,
	)
	tastes = list("巧克力糖果" = 2, "香蕉" = 1)

/obj/item/food/cnds/random
	name = "夹心C&Ds"
	desc = "里面有四种美味的味道!"

/obj/item/food/cnds/random/Initialize(mapload)
	var/random_flavour = pick(subtypesof(/obj/item/food/cnds) - /obj/item/food/cnds/random)
	var/obj/item/food/sample = new random_flavour(loc)
	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	tastes = sample.tastes

	qdel(sample)

	. = ..()

/obj/item/food/pistachios
	name = "\improper 甜心牌开心果"
	desc = "一包甜心牌高级开心果."
	icon_state = "pistachio"
	trash_type = /obj/item/trash/pistachios
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	) //a healthy but expensive snack
	tastes = list("开心果" = 4, "微妙的甜蜜" = 1)
	foodtypes = JUNKFOOD | NUTS
	custom_price = PAYCHECK_CREW//pistachios are even more expensive.
	junkiness = 10 //on par with peanuts
	w_class = WEIGHT_CLASS_SMALL
	grind_results = list(/datum/reagent/consumable/peanut_butter = 5, /datum/reagent/consumable/nutriment/fat/oil = 2)

/obj/item/food/semki
	name = "\improper 烤瓜子"
	desc = "一包烤葵花籽,深受俄罗斯人和巴布什卡人的喜爱."
	icon_state = "semki"
	trash_type = /obj/item/trash/semki
	food_reagents = list(
		/datum/reagent/consumable/nutriment/fat/oil = 1,
		/datum/reagent/consumable/salt = 6,
	) //1 cornoil is equal to 1.33 nutriment
	tastes = list("葵花籽" = 5)
	foodtypes = JUNKFOOD | NUTS
	custom_price = PAYCHECK_LOWER * 0.4 //sunflowers are cheap in real life.
	bite_consumption = 1
	junkiness = 25
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/semki/healthy
	name = "烤葵花籽"
	desc = "纸杯里的自制烤葵花籽，你可以一边嗑瓜子一边看着来来往往的行人，健康又饱腹。"
	icon_state = "sunseeds"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/iron = 2,
	)
	junkiness = 5 //Homemade or not, sunflower seets are always kinda junky
	foodtypes = JUNKFOOD | NUTS
	trash_type = /obj/item/trash/semki/healthy
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/cornchips
	name = "\improper Boritos 玉米片"
	desc = "三角形的玉米片。它们看起来确实有点平淡无奇，但蘸酱可能会很好吃."
	icon_state = "boritos"
	trash_type = /obj/item/trash/boritos
	bite_consumption = 2
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
	)
	junkiness = 20
	custom_price = PAYCHECK_LOWER * 0.8  //we are filled to the brim with flavor
	tastes = list("玉米片" = 1)
	foodtypes = JUNKFOOD | FRIED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/cornchips/make_leave_trash()
	AddElement(/datum/element/food_trash, trash_type, FOOD_TRASH_POPABLE)

/obj/item/food/cornchips/blue
	name = "\improper Coolest Ranch Boritos 玉米片"
	desc = "Which came first, ranch or cool ranch?"
	icon_state = "boritos"
	trash_type = /obj/item/trash/boritos
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
		/datum/reagent/consumable/yoghurt = 1,
		/datum/reagent/consumable/garlic = 1,
	)
	tastes = list("玉米片" = 1, "coolest ranch" = 3)

/obj/item/food/cornchips/green
	name = "\improper Spess Salsa Boritos 玉米片"
	desc = "里面有萨尔萨酱，所以你不需要额外的蘸酱。"
	icon_state = "boritosgreen"
	trash_type = /obj/item/trash/boritos/green
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
		/datum/reagent/consumable/astrotame = 1,
		/datum/reagent/consumable/blackpepper = 1,
	)
	tastes = list("玉米片" = 1, "萨尔萨酱" = 3)

/obj/item/food/cornchips/red
	name = "\improper Nacho Cheese Boritos 玉米片"
	desc = "因能让你接触到的所有东西都沾上橙色奶酪粉而臭名昭著."
	icon_state = "boritosred"
	trash_type = /obj/item/trash/boritos/red
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
		/datum/reagent/consumable/astrotame = 1,
		/datum/reagent/consumable/cornmeal = 1,
	)
	tastes = list("玉米片" = 1, "nacho cheese" = 3)

/obj/item/food/cornchips/purple
	name = "\improper Spicy Sweet Chili Boritos 玉米片"
	desc = "唯一真正吃起来辣的正宗玉米片."
	icon_state = "boritospurple"
	trash_type = /obj/item/trash/boritos/purple
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
		/datum/reagent/consumable/salt = 3,
		/datum/reagent/consumable/capsaicin = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("玉米片" = 1, "spicy & sweet chili" = 3)

/obj/item/food/cornchips/random
	name = "\improper Boritos 玉米片"
	desc = "里面有四种美味的味道!"

/obj/item/food/cornchips/random/Initialize(mapload)
	var/random_flavour = pick(subtypesof(/obj/item/food/cornchips) - /obj/item/food/cornchips/random)

	var/obj/item/food/sample = new random_flavour(loc)

	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	icon_state = sample.icon_state
	trash_type = sample.trash_type
	tastes = sample.tastes

	qdel(sample)

	. = ..()

/obj/item/food/hot_shots
	name = "\improper Hot Shots"
	desc = "终极棒球零食，一旦开始，就很难停下来!"
	icon_state = "hot_shots"
	trash_type = /obj/item/trash/hot_shots
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("爆米花" = 1, "焦糖" = 1, "花生" = 1)
	foodtypes = JUNKFOOD | SUGAR | NUTS
	junkiness = 25
	w_class = WEIGHT_CLASS_SMALL
	grind_results = list(/datum/reagent/consumable/nutriment/fat/oil = 3, /datum/reagent/consumable/caramel = 2)

/obj/item/food/sticko
	name = "\improper 经典零食棒"
	desc = "老少咸宜的经典零食棒，这款是最原始的口味:饼干和牛奶巧克力。"
	icon_state = "sticko_classic"
	trash_type = /obj/item/trash/sticko
	food_reagents = list(
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/coco = 1,
	)
	tastes = list("饼干" = 1, "巧克力" = 1)
	junkiness = 25
	foodtypes = JUNKFOOD | GRAIN
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/sticko/matcha
	name = "\improper 抹茶零食棒"
	desc = "老少咸宜的经典零食棒，这款是传统的口味:抹茶和牛奶巧克力。"
	icon_state = "sticko_matcha"
	trash_type = /obj/item/trash/sticko/matcha
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/caramel = 1,
	)
	tastes = list("饼干" = 1, "抹茶" = 1)

/obj/item/food/sticko/nutty
	name = "\improper 花生零食棒"
	desc = "老少咸宜的经典零食棒，这款是浆果的口味:花生酱和饼干。"
	icon_state = "sticko_nutty"
	trash_type = /obj/item/trash/sticko/nutty
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/coco = 1,
	)
	tastes = list("饼干" = 1, "花生酱" = 1)
	foodtypes = JUNKFOOD | GRAIN | NUTS

/obj/item/food/sticko/pineapple
	name = "\improper 凤梨零食棒"
	desc = "老少咸宜的经典零食棒，这款是用菠萝味的白巧克力做外皮，还有些香蕉粉。"
	icon_state = "sticko_pineapple"
	trash_type = /obj/item/trash/sticko/pineapple
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/peanut_butter = 1,
	)
	tastes = list("饼干" = 1, "菠萝" = 1)
	foodtypes = JUNKFOOD | GRAIN | PINEAPPLE

/obj/item/food/sticko/yuyake
	name = "\improper 西瓜零食棒"
	desc = "老少咸宜的经典零食棒，这款是用西瓜味的白巧克力做外皮。"
	icon_state = "sticko_yuyake"
	trash_type = /obj/item/trash/sticko/yuyake
	food_reagents = list(
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/banana = 1,
	)
	tastes = list("饼干" = 1, "瓜" = 1)

/obj/item/food/sticko/random
	name = "\improper 怪味零食棒"
	desc = "老少咸宜的经典零食棒，这款是外面有一个纸套用来隐藏真正的味道。"

/obj/item/food/sticko/random/Initialize(mapload)
	var/random_flavour = pick(subtypesof(/obj/item/food/sticko) - /obj/item/food/sticko/random)
	var/obj/item/food/sample = new random_flavour(loc)
	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	tastes = sample.tastes

	qdel(sample)

	. = ..()

/obj/item/food/shok_roks
	name = "\improper Shok-Roks - 风暴跳跳糖"
	desc = "现有属于Ethereals的跳跳糖!这袋像棉花糖，但带电!"
	icon_state = "shok_roks_candy"
	trash_type = /obj/item/trash/shok_roks
	food_reagents = list(
		/datum/reagent/consumable/liquidelectricity/enriched = 2,
		/datum/reagent/consumable/sugar = 3
	)
	tastes = list("甜" = 1, "电光一闪" = 1)

/obj/item/food/shok_roks/citrus
	name = "\improper Shok-Roks - 柑橘跳跳糖"
	desc = "现有属于Ethereals的跳跳糖!这袋有柑橘味，但是不含任何柑橘成分!."
	icon_state = "shok_roks_citrus"
	trash_type = /obj/item/trash/shok_roks/citrus
	tastes = list("柑橘味" = 1, "电光一闪" = 1)

/obj/item/food/shok_roks/berry
	name = "\improper Shok-Roks - 浆果风暴跳跳糖"
	desc = "现有属于Ethereals的跳跳糖!这袋有酸到掉牙的酸梅味!"
	icon_state = "shok_roks_berry"
	trash_type = /obj/item/trash/shok_roks/berry
	tastes = list("酸梅味" = 1, "电光一闪" = 1)

/obj/item/food/shok_roks/tropical
	name = "\improper Shok-Roks - 热带狂雷跳跳糖"
	desc = "现有属于Ethereals的跳跳糖!这袋有所有的热带水果味，所有的！"
	icon_state = "shok_roks_tropical"
	trash_type = /obj/item/trash/shok_roks/tropical
	tastes = list("热带水果" = 1, "电光一闪" = 1)

/obj/item/food/shok_roks/lanternfruit
	name = "\improper Shok-Roks - 电光一闪跳跳糖"
	desc = "现有属于Ethereals的跳跳糖!这袋含有一种独特的名为“灯笼果”的水果。"
	icon_state = "shok_roks_lanternfruit"
	trash_type = /obj/item/trash/shok_roks/lanternfruit
	tastes = list("酸梨" = 1, "电光一闪" = 1)

/obj/item/food/shok_roks/random
	name = "\improper Shok-Roks - 暗潮跳跳糖"
	desc = "现有属于Ethereals的跳跳糖!这袋里可能会出现任何一种口味."

/obj/item/food/shok_roks/random/Initialize(mapload)
	var/random_flavour = pick(subtypesof(/obj/item/food/shok_roks) - /obj/item/food/shok_roks/random)
	var/obj/item/food/sample = new random_flavour(loc)
	name = sample.name
	desc = sample.desc
	food_reagents = sample.food_reagents
	tastes = sample.tastes

	qdel(sample)

	. = ..()
