//Pastry is a food that is made from dough which is made from wheat or rye flour.糕点
//This file contains pastries that don't fit any existing categories.
////////////////////////////////////////////MUFFINS////////////////////////////////////////////

/obj/item/food/muffin
	name = "松饼"
	desc = "美味又松软的小蛋糕。"
	icon_state = "muffin"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("松饼" = 1)
	foodtypes = GRAIN | SUGAR | BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/muffin/berry
	name = "浆果松饼"
	icon_state = "berrymuffin"
	desc = "美味又松软的浆果松饼."
	tastes = list("松饼" = 3, "浆果" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR | BREAKFAST
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/muffin/booberry
	name = "boo果松饼"
	icon_state = "berrymuffin"
	alpha = 125
	desc = "我的胃就是个墓地!没有任何生物能止息我的嗜血!"
	tastes = list("松饼" = 3, "spookiness" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR | BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/muffin/booberry/Initialize(mapload, starting_reagent_purity, no_base_reagents)
	. = ..()
	AddComponent(/datum/component/ghost_edible, bite_consumption = bite_consumption)

/obj/item/food/muffin/moffin
	name = "菘饼"
	icon_state = "moffin_1"
	base_icon_state = "moffin"
	desc = "美味又松软的小蛋糕."
	tastes = list("松饼" = 3, "灰尘" = 1, "棉绒" = 1)
	foodtypes = CLOTH | GRAIN | SUGAR | BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/muffin/moffin/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 3)]"

/obj/item/food/muffin/moffin/examine(mob/user)
	. = ..()
	if(!isliving(user))
		return
	var/mob/living/moffin_observer = user
	if(moffin_observer.get_liked_foodtypes() & CLOTH)
		. += span_nicegreen("哦！上面甚至还有衣服碎片！太棒了！")
	else
		. += span_warning("你不太确定上面是什么...")

////////////////////////////////////////////WAFFLES////////////////////////////////////////////

/obj/item/food/waffles
	name = "华夫饼"
	desc = "这是华夫饼,经常出现在美式早餐里."
	icon_state = "waffles"
	trash_type = /obj/item/trash/waffles
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("华夫饼" = 1)
	foodtypes = GRAIN | SUGAR | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/soylentgreen
	name = "\improper 绿色食品"
	desc = "原料不是人类,没说谎." //Totally people.
	icon_state = "soylent_green"
	trash_type = /obj/item/trash/waffles
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("华夫饼" = 7, "人类" = 1)
	foodtypes = GRAIN | MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/soylenviridians
	name = "\improper 营养食品"
	desc = "原料不是人类,没说谎." //Actually honest for once.
	icon_state = "soylent_yellow"
	trash_type = /obj/item/trash/waffles
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("华夫饼" = 7, "绿色素" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/rofflewaffles
	name = "roffle华夫饼"
	desc = "Roffle. Co的华夫饼."
	icon_state = "rofflewaffles"
	trash_type = /obj/item/trash/waffles
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/drug/mushroomhallucinogen = 2,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("华夫饼" = 1, "蘑菇" = 1)
	foodtypes = GRAIN | VEGETABLES | SUGAR | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

////////////////////////////////////////////OTHER////////////////////////////////////////////

/obj/item/food/cookie
	name = "曲奇饼干"
	desc = "COOKIE!!!"
	icon_state = "COOKIE!!!"
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("曲奇" = 1)
	foodtypes = GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cookie/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/cookie/sleepy
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin/chloralhydrate = 10)

/obj/item/food/fortunecookie
	name = "幸运曲奇"
	desc = "每个饼干里都有一个真正的预言!"
	icon_state = "fortune_cookie"
	trash_type = /obj/item/paper/paperslip/fortune
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("曲奇" = 1)
	foodtypes = GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/fortunecookie/proc/get_fortune()
	var/atom/drop_location = drop_location()

	var/obj/item/paper/fortune = locate(/obj/item/paper) in src
	// If a fortune exists, use that.
	if (fortune)
		fortune.forceMove(drop_location)
		return fortune

	// Otherwise, use a generic one
	var/obj/item/paper/paperslip/fortune/fortune_slip = new trash_type(drop_location)
	// if someone adds lottery tickets in the future, be sure to add random numbers to this
	return fortune_slip

/obj/item/food/fortunecookie/make_leave_trash()
	if(trash_type)
		AddElement(/datum/element/food_trash, trash_type, food_flags, TYPE_PROC_REF(/obj/item/food/fortunecookie, get_fortune))

/obj/item/food/cookie/sugar
	name = "糖霜曲奇"
	desc = "就像你妹妹以前做的一样."
	icon_state = "sugarcookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 6,
	)
	tastes = list("糖霜" = 1)
	foodtypes = GRAIN | JUNKFOOD | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cookie/sugar/Initialize(mapload)
	. = ..()
	if(check_holidays(FESTIVE_SEASON))
		var/shape = pick("圣诞树", "熊", "圣诞老人", "长袜", "礼物", "拐杖")
		desc = "一个[shape]形状的糖霜曲奇.我希望圣诞老人喜欢它!"
		icon_state = "sugarcookie_[shape]"

/obj/item/food/chococornet
	name = "巧克力螺"
	desc = "话说回来哪边是头哪边是尾呢？"
	icon_state = "chococornet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("饼干" = 3, "巧克力" = 1)
	foodtypes = GRAIN | JUNKFOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/oatmeal
	name = "燕麦饼干"
	desc = "最好的饼干和燕麦。"
	icon_state = "oatmealcookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("饼干" = 2, "燕麦" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/raisin
	name = "葡萄干曲奇"
	desc = "为什么要在曲奇上放葡萄干？"
	icon_state = "raisincookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("曲奇" = 1, "葡萄干" = 1)
	foodtypes = GRAIN | FRUIT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/poppypretzel
	name = "罂粟椒盐卷饼"
	desc = "都扭歪了!"
	icon_state = "poppypretzel"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("椒盐卷饼" = 1)
	foodtypes = GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/plumphelmetbiscuit
	name = "厚头菇饼干"
	desc = "一个花了心思去做的厚头菇饼干.配料是切碎的厚头蘑菇与矮人小麦粉."
	icon_state = "phelmbiscuit"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("蘑菇" = 1, "饼干" = 1)
	foodtypes = GRAIN | VEGETABLES
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/plumphelmetbiscuit/Initialize(mapload)
	var/fey = prob(10)
	if(fey)
		name = "异常的厚头菇饼干"
		desc = "微波炉被一股奇怪的情绪所占据!它煮出了一种特别的厚头菇饼干!"
		food_reagents = list(
			/datum/reagent/medicine/omnizine = 5,
			/datum/reagent/consumable/nutriment = 1,
			/datum/reagent/consumable/nutriment/vitamin = 1,
		)
	. = ..()
	if(fey)
		reagents.add_reagent(/datum/reagent/medicine/omnizine, 5)

/obj/item/food/cracker
	name = "苏打饼干"
	desc = "这是一个咸苏打饼干."
	icon_state = "cracker"
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("苏打饼干" = 1)
	foodtypes = GRAIN
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/khachapuri
	name = "哈恰普哩"
	desc = "面包与蛋和奶酪，来自格鲁吉亚."
	icon_state = "khachapuri"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("面包" = 1, "蛋" = 1, "奶酪" = 1)
	foodtypes = GRAIN | MEAT | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cherrycupcake
	name = "樱桃纸杯蛋糕"
	desc = "带樱桃的纸杯蛋糕."
	icon_state = "cherrycupcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("蛋糕" = 3, "樱桃" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cherrycupcake/blue
	name = "蓝樱桃纸杯蛋糕"
	desc = "带蓝樱桃的纸杯蛋糕."
	icon_state = "bluecherrycupcake"
	tastes = list("cake" = 3, "blue cherry" = 1)
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/honeybun
	name = "蜂蜜小面包"
	desc = "涂有蜂蜜的小圆面包."
	icon_state = "honeybun"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/honey = 6,
	)
	tastes = list("糕点" = 1, "甜蜜" = 1)
	foodtypes = GRAIN | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cannoli
	name = "卡诺里"
	desc = "也称奶油甜馅煎饼卷，西西里美食，让你变成一个聪明人."
	icon_state = "cannoli"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("糕点" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	w_class = WEIGHT_CLASS_TINY
	venue_value = FOOD_PRICE_CHEAP // Pastry base, 3u of sugar and a single. fucking. unit. of. milk. really?
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/icecream
	name = "华夫蛋筒" // 鸡蛋仔？
	desc = "美味的华夫蛋筒，但没有冰淇淋."
	icon = 'icons/obj/service/kitchen.dmi'
	icon_state = "icecream_cone_waffle"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("冰淇淋" = 2, "华夫饼" = 1)
	bite_consumption = 4
	foodtypes = DAIRY | SUGAR
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_3
	max_volume = 10 //The max volumes scales up with the number of scoops of ice cream served. 最大容量随着冰淇淋勺数的增加而增加。
	/// These two variables are used by the ice cream vat. Latter is the one that shows on the UI. 这两个变量被冰淇淋桶使用。后者显示在UI上。
	var/list/ingredients = list(
		/datum/reagent/consumable/flour,
		/datum/reagent/consumable/sugar,
	)
	var/ingredients_text
	/*
	 * Assoc list var used to prefill the cone with ice cream. 关联列表变量用于在蛋筒中预先填充冰淇淋。
	 * Key is the flavour's name (use text defines; see __DEFINES/food.dm or ice_cream_holder.dm), 关键是味道的名字(用文字定义;见__DEFINES /food.Dm或ice_cream_holder.dm)，
	 * assoc is the list of args that is going to be used in [flavour/add_flavour()]. Can as well be null for simple flavours. Assoc是将在[flavour/add_flavour()]中使用的参数列表。对于简单的口味也可以为零。
	 */
	var/list/prefill_flavours

/obj/item/food/icecream/New(loc, list/prefill_flavours)
	return ..()

/obj/item/food/icecream/Initialize(mapload, list/prefill_flavours)
	if(prefill_flavours)
		src.prefill_flavours = prefill_flavours
	return ..()

/obj/item/food/icecream/make_edible()
	. = ..()
	AddComponent(/datum/component/ice_cream_holder, filled_name = "冰淇淋", change_desc = TRUE, prefill_flavours = prefill_flavours)

/obj/item/food/icecream/chocolate
	name = "巧克力筒"
	desc = "美味的巧克力筒，但是没有冰淇淋。"
	icon_state = "icecream_cone_chocolate"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/coco = 1,
	)
	ingredients = list(
		/datum/reagent/consumable/flour,
		/datum/reagent/consumable/sugar,
		/datum/reagent/consumable/coco,
	)
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/icecream/korta
	name = "科塔尔筒"
	desc = "美味的蜥式蛋卷，但没有冰淇淋。"
	foodtypes = NUTS | SUGAR
	ingredients = list(
		/datum/reagent/consumable/korta_flour,
		/datum/reagent/consumable/sugar,
	)

/obj/item/food/cookie/peanut_butter
	name = "花生酱饼干"
	desc = "美味的的花生酱饼干."
	icon_state = "peanut_butter_cookie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/peanut_butter = 5,
	)
	tastes = list("花生酱" = 2, "饼干" = 1)
	foodtypes = GRAIN | JUNKFOOD | NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_brownie_batter
	name = "生布朗尼面糊"
	desc = "粘稠的生布朗尼面糊，可以放进烤箱里烤。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "raw_brownie_batter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("生布朗尼面糊" = 1)
	foodtypes = GRAIN | JUNKFOOD | SUGAR | BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_brownie_batter/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/brownie_sheet, rand(20 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/brownie_sheet
	name = "布朗尼蛋糕"
	desc = "一块未切开的烤布朗尼蛋糕，用刀切开!."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "brownie_sheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/sugar = 12,
	)
	tastes = list("布朗尼" = 1, "完美的焦褐色" = 1)
	foodtypes = GRAIN | JUNKFOOD | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/brownie_sheet/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/brownie, 4, 3 SECONDS, table_required = TRUE,  screentip_verb = "Slice")

/obj/item/food/brownie
	name = "布朗尼蛋糕"
	desc = "一块方形的美味的布朗尼蛋糕."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "brownie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/sugar = 3,
	)
	tastes = list("布朗尼" = 1, "完美的焦褐色" = 1)
	foodtypes = GRAIN | JUNKFOOD | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/peanut_butter_brownie_batter
	name = "生花生酱布朗尼面糊"
	desc = "粘稠的生花生布朗尼面糊，可以放进烤箱里烤。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "peanut_butter_brownie_batter"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/peanut_butter = 4,
	)
	tastes = list("生花生酱布朗尼面糊" = 1)
	foodtypes = GRAIN | JUNKFOOD | SUGAR | NUTS
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/peanut_butter_brownie_batter/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/peanut_butter_brownie_sheet, rand(20 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/peanut_butter_brownie_sheet
	name = "花生酱布朗尼蛋糕"
	desc = "一块未切开的烤花生酱布朗尼蛋糕，用刀切开!"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "peanut_butter_brownie_sheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 24,
		/datum/reagent/consumable/sugar = 16,
		/datum/reagent/consumable/peanut_butter = 20,
	)
	tastes = list("布朗尼" = 1, "完美的焦褐色" = 1, "花生酱" = 1)
	foodtypes = GRAIN | JUNKFOOD | SUGAR | NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/peanut_butter_brownie_sheet/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/peanut_butter_brownie, 4, 3 SECONDS, table_required = TRUE,  screentip_verb = "Slice")

/obj/item/food/peanut_butter_brownie
	name = "花生酱布朗尼蛋糕"
	desc = "一块方形的美味的，有嚼劲的花生酱布朗尼。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "peanut_butter_brownie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/sugar = 4,
		/datum/reagent/consumable/peanut_butter = 5,
	)
	tastes = list("布朗尼" = 1, "完美的焦褐色" = 1)
	foodtypes = GRAIN | JUNKFOOD | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/crunchy_peanut_butter_tart
	name = "脆花生酱馅饼"
	desc = "一种小馅饼，里面有花生酱、奶油糖衣和碎坚果."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "crunchy_peanut_butter_tart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/sugar = 6,
		/datum/reagent/consumable/peanut_butter = 5,
	)
	tastes = list("花生酱" = 1, "碎坚果" = 1, "奶油" = 1)
	foodtypes = GRAIN | JUNKFOOD | SUGAR | NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/chocolate_chip_cookie
	name = "巧克力曲奇"
	desc = "香气怡人的巧克力曲奇，牛奶在哪里?"
	icon_state = "COOKIE!!!"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("软曲奇" = 2, "巧克力" = 3)
	foodtypes = GRAIN | SUGAR | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/snickerdoodle
	name = "肉桂甜饼"
	desc = "一种由香草和肉桂制成的软饼干."
	icon_state = "snickerdoodle"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("软饼干" = 2, "香草" = 3)
	foodtypes = GRAIN | SUGAR | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/macaron
	name = "马卡龙"
	desc = "一种类似三明治的糖果，有柔软的饼干外壳和奶油蛋白皮。"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	icon_state = "macaron_1"
	base_icon_state = "macaron"
	tastes = list("薄饼" = 2, "奶油蛋白" = 3)
	foodtypes = GRAIN | SUGAR | DAIRY
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cookie/macaron/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 4)]"

/obj/item/food/cookie/thumbprint_cookie
	name = "夹心饼干"
	desc = "饼干一种中间有拇指大小的凹痕用来填樱桃果酱."
	icon_state = "thumbprint_cookie"
	food_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("饼干" = 2, "樱桃果酱" = 3)
	foodtypes = GRAIN | SUGAR | FRUIT
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
