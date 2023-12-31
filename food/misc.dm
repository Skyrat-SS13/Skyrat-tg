
////////////////////////////////////////////OTHER////////////////////////////////////////////
/obj/item/food/watermelonslice
	name = "西瓜片"
	desc = "一片西瓜."
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "watermelonslice"
	food_reagents = list(
		/datum/reagent/water = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("西瓜" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	juice_typepath = /datum/reagent/consumable/watermelonjuice
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/appleslice
	name = "苹果片"
	desc = "每天一苹果，医生远离我."
	icon = 'icons/obj/service/hydroponics/harvest.dmi'
	icon_state = "appleslice"
	food_reagents = list(
		/datum/reagent/consumable/applejuice = 1,
		/datum/reagent/consumable/nutriment/vitamin = 0.2,
		/datum/reagent/consumable/nutriment = 1,
	)
	tastes = list("苹果" = 1)
	foodtypes = FRUIT
	food_flags = FOOD_FINGER_FOOD
	juice_typepath = /datum/reagent/consumable/applejuice
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/hugemushroomslice
	name = "巨型蘑菇块"
	desc = "一快巨型蘑菇."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "hugemushroomslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("蘑菇" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/hugemushroomslice/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_WALKING_MUSHROOM, CELL_VIRUS_TABLE_GENERIC_MOB, 1, 5)

/obj/item/food/popcorn
	name = "爆米花"
	desc = "Now let's find some cinema."
	icon_state = "popcorn"
	trash_type = /obj/item/trash/popcorn
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	bite_consumption = 0.1 //this snack is supposed to be eating during looooong time. And this it not dinner food! --rastaf0
	tastes = list("爆米花" = 3, "黄油" = 1)
	foodtypes = JUNKFOOD
	eatverbs = list("吃了一口", "不停咀嚼", "吞了几颗", "嚼了几颗", "尝了几口")
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/popcorn/salty
	name = "咸爆米花"
	icon_state = "salty_popcorn"
	desc = "为每时每刻而准备的经典."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("咸味" = 2, "爆米花" = 1)
	trash_type = /obj/item/trash/popcorn/salty
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/popcorn/caramel
	name = "焦糖爆米花"
	icon_state = "caramel_popcorn"
	desc = "焦糖覆盖在爆米花上，超甜！"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/caramel = 4,
	)
	tastes = list("焦糖" = 2, "爆米花" = 1)
	foodtypes = JUNKFOOD | SUGAR
	trash_type = /obj/item/trash/popcorn
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/soydope
	name = "soy dope"
	desc = "Dope from a soy."
	icon_state = "soydope"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/protein = 1,
	)
	tastes = list("大豆" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/badrecipe
	name = "失败料理"
	desc = "应该有人因此被追责."
	icon_state = "badrecipe"
	food_reagents = list(/datum/reagent/toxin/bad_food = 30)
	foodtypes = GROSS
	w_class = WEIGHT_CLASS_SMALL
	preserved_food = TRUE //Can't decompose any more than this
	/// Variable that holds the reference to the stink lines we get when we're moldy, yucky yuck
	var/stink_particles

/obj/item/food/badrecipe/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_GRILL_PROCESS, PROC_REF(OnGrill))
	if(stink_particles)
		particles = new stink_particles

// We override the parent procs here to prevent burned messes from cooking into burned messes.
// 我们在这里重写父进程，以防止烧焦的烂摊子再变成烧焦的烂摊子。
/obj/item/food/badrecipe/make_grillable()
	return
/obj/item/food/badrecipe/make_bakeable()
	return

/obj/item/food/badrecipe/moldy
	name = "腐败的失败料理"
	desc = "臭气熏天，充满霉菌和蚂蚁.在那下面的某个地方，在某个地方，有食物."
	food_reagents = list(/datum/reagent/consumable/mold = 30)
	preserved_food = FALSE
	ant_attracting = TRUE
	decomp_type = null
	decomposition_time = 30 SECONDS
	stink_particles = /particles/stink

/obj/item/food/badrecipe/moldy/bacteria
	name = "富含细菌的失败料理"
	desc = "难以名状腐败外表下有着各种各样的生命形态,<i>你感觉它在你不注意的时候蠕动.</i>"

/obj/item/food/badrecipe/moldy/bacteria/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_MOLD, CELL_VIRUS_TABLE_GENERIC, rand(2, 4), 25)

///Prevents grilling burnt shit from well, burning.
//阻止燃烧
/obj/item/food/badrecipe/proc/OnGrill()
	SIGNAL_HANDLER
	return COMPONENT_HANDLED_GRILLING

/obj/item/food/spidereggs
	name = "蜘蛛卵"
	desc = "一簇多汁的蜘蛛卵,当你不在乎食品健康时,这是一道很好的配菜."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "spidereggs"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/toxin = 2,
	)
	tastes = list("蜘蛛网" = 1)
	foodtypes = MEAT | TOXIC | BUGS
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/spidereggs/processed
	name = "加工过的蜘蛛卵"
	desc = "一簇多汁的蜘蛛卵,直接放进嘴里也不会让你恶心."
	icon_state = "spidereggs"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 4)
	tastes = list("蜘蛛网" = 1)
	foodtypes = MEAT | BUGS
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/spiderling
	name = "幼蛛"
	desc = "它在你手里微微抽搐.ew...."
	icon = 'icons/mob/simple/arachnoid.dmi'
	icon_state = "spiderling_dead"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/toxin = 4,
	)
	tastes = list("蜘蛛网" = 1, "决心" = 2)
	foodtypes = MEAT | TOXIC | BUGS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/melonfruitbowl
	name = "甜瓜果盘"
	desc = "适合想要食用果盘的人."
	icon_state = "melonfruitbowl"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("瓜果" = 1)
	foodtypes = FRUIT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/melonkeg
	name = "瓜桶"
	desc = "谁能想到伏特加是一种水果?"
	icon_state = "melonkeg"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/ethanol/vodka = 15,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	max_volume = 80
	bite_consumption = 5
	tastes = list("粮食酒" = 1, "水果" = 1)
	foodtypes = FRUIT | ALCOHOL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/honeybar
	name = "蜂蜜坚果棒"
	desc = "燕麦和坚果挤在一起，并用蜂蜜粘上."
	icon_state = "honeybar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/honey = 5,
	)
	tastes = list("燕麦" = 3, "坚果" = 2, "蜂蜜" = 1)
	foodtypes = GRAIN | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/powercrepe
	name = "Powercrepe"
	desc = "With great power, comes great crepes.  It looks like a pancake filled with jelly but packs quite a punch."
	icon_state = "powercrepe"
	inhand_icon_state = "powercrepe"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/cherryjelly = 5,
	)
	force = 30
	throwforce = 15
	block_chance = 55
	armour_penetration = 80
	block_sound = 'sound/weapons/parry.ogg'
	wound_bonus = -50
	attack_verb_continuous = list("slaps", "slathers")
	attack_verb_simple = list("slap", "slather")
	w_class = WEIGHT_CLASS_BULKY
	tastes = list("cherry" = 1, "crepe" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/branrequests
	name = "Bran Requests Cereal"
	desc = "A dry cereal that satiates your requests for bran. Tastes uniquely like raisins and salt."
	icon_state = "bran_requests"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/salt = 8,
	)
	tastes = list("bran" = 4, "raisins" = 3, "salt" = 1)
	foodtypes = GRAIN | FRUIT | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/butter
	name = "小块黄油"
	desc = "一根美味的，金黄的，肥美的东西."
	icon_state = "butter"
	food_reagents = list(/datum/reagent/consumable/nutriment/fat = 6)
	tastes = list("黄油" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL
	dog_fashion = /datum/dog_fashion/head/butter

/obj/item/food/butter/examine(mob/user)
	. = ..()
	. += span_notice("如果你有一根棍子，你可以可以把黄油插在棍子上.")

/obj/item/food/butter/attackby(obj/item/item, mob/user, params)
	if(istype(item, /obj/item/stack/rods))
		var/obj/item/stack/rods/rods = item
		if(!rods.use(1))//borgs can still fail this if they have no metal
			to_chat(user, span_warning("你没有足够的铁把[src]放在一根棍子上!"))
			return ..()
		to_chat(user, span_notice("你把小块黄油插到棍子上."))
		var/obj/item/food/butter/on_a_stick/new_item = new(usr.loc)
		var/replace = (user.get_inactive_held_item() == rods)
		if(!rods && replace)
			user.put_in_hands(new_item)
		qdel(src)
		return TRUE
	..()

/obj/item/food/butter/on_a_stick //there's something so special about putting it on a stick.
	name = "黄油棒"
	desc = "棒上的美味，金黄，肥美."
	icon_state = "butteronastick"
	trash_type = /obj/item/stack/rods
	food_flags = FOOD_FINGER_FOOD
	venue_value = FOOD_PRICE_CHEAP

/obj/item/food/butter/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/butterslice, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Slice")

/obj/item/food/butterslice
	name = "黄油片"
	desc = "一片黄油，用来涂黄油."
	icon_state = "butterslice"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("butter" = 1)
	foodtypes = DAIRY
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/onionrings
	name = "洋葱圈"
	desc = "涂上面糊的洋葱片."
	icon_state = "onionrings"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3)
	gender = PLURAL
	tastes = list("面衣" = 3, "洋葱" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/pineappleslice
	name = "菠萝片"
	desc = "一片多汁的菠萝"
	icon_state = "pineapple_slice"
	juice_typepath = /datum/reagent/consumable/pineapplejuice
	tastes = list("菠萝" = 1)
	foodtypes = FRUIT | PINEAPPLE
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/crab_rangoon
	name = "炸蟹角"
	desc = "炸蟹角，有时也被称为蟹肉泡芙、或奶酪馄饨，是一种主要在美国中餐馆供应的酥脆饺子开胃菜，馅料由奶油芝士、蟹肉或仿蟹肉、葱或洋葱、大蒜和其他调味料混合而成."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "crabrangoon"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("奶酪" = 4, "蟹肉" = 3, "脆皮" = 2)
	foodtypes = MEAT | DAIRY | GRAIN
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pesto
	name = "意大利青酱"
	desc = "由硬奶酪、盐、香草、大蒜、油和松子混合而成，常用作意大利面或披萨的酱料，或涂在面包上食用."
	icon_state = "pesto"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("青酱" = 1)
	foodtypes = VEGETABLES | DAIRY | NUTS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/tomato_sauce
	name = "番茄酱"
	desc = "番茄酱，最适合做披萨或意大利面.Mamma mia!"
	icon_state = "tomato_sauce"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("tomato" = 1, "herbs" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/bechamel_sauce
	name = "白酱"
	desc = "Béchamel sauce,也被称为白酱,是由面糊(黄油和面粉)和牛奶制成的。它是法国菜和意大利菜的母酱之一。"
	icon_state = "bechamel_sauce"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("奶油" = 1)
	foodtypes = DAIRY | GRAIN
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/roasted_bell_pepper
	name = "烤甜椒"
	desc = "一种变黑起泡的甜椒非常适合做酱汁。"
	icon_state = "roasted_bell_pepper"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/char = 1,
	)
	tastes = list("甜椒" = 1, "烤焦" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/pierogi
	name = "波兰饺子"
	desc = "用未发酵的生面团包上咸味或甜味的馅料，在沸水中烹煮而成的饺子。这是土豆和洋葱的混合物。"
	icon_state = "pierogi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("土豆" = 1, "洋葱" = 1)
	foodtypes = GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/stuffed_cabbage
	name = "卷心菜卷" // stuffed cabbage
	desc = "一种用煮熟的卷心菜叶包裹着肉和米饭的美味卷饼，上面撒上番茄酱。好吃到死。"
	icon_state = "stuffed_cabbage"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("多汁的肉" = 1, "米饭" = 1, "卷心菜" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/seaweedsheet
	name = "海苔片"
	desc = "用来做寿司的干海苔片，将食材添加到上面来定制寿司!"
	icon_state = "seaweedsheet"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("海苔" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/seaweedsheet/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, /obj/item/food/sushi/empty, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 6)

/obj/item/food/granola_bar
	name = "燕麦棒"
	desc = "燕麦、坚果、水果和巧克力的干燥混合物，浓缩成有嚼劲的棒状，是太空旅行时的美味小吃。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "granola_bar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("燕麦" = 1, "坚果" = 1, "巧克力" = 1, "葡萄干" = 1)
	foodtypes = GRAIN | NUTS | FRUIT | SUGAR | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/onigiri
	name = "饭团"
	desc = "饭团一种由煮熟的米饭捏成三角形并包有海藻的饭团，可以往里添加馅料!"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "onigiri"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("米饭" = 1, "干海苔" = 1)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/onigiri/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, /obj/item/food/onigiri/empty, CUSTOM_INGREDIENT_ICON_NOCHANGE, max_ingredients = 4)

// empty onigiri for custom onigiri
/obj/item/food/onigiri/empty
	name = "饭团"
	desc = "一种由煮熟的米饭围绕着馅料制成的三角形，并用海藻包裹着。"
	icon_state = "onigiri"
	foodtypes = VEGETABLES
	tastes = list()

/obj/item/food/pacoca
	name = "花生酥糖"
	desc = "一种传统的巴西小吃，由碾碎的花生、糖和盐压缩成一个圆柱体。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "pacoca"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("花生" = 1, "甜蜜" = 1)
	foodtypes = NUTS | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/pickle
	name = "腌黄瓜"
	desc = "略干的深色黄瓜。闻到一股酸味，但非常诱人。"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "pickle"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/pickle = 1,
		/datum/reagent/medicine/antihol = 2,
	)
	tastes = list("腌菜" = 1, "香料" = 1, "盐水" = 2)
	juice_typepath = /datum/reagent/consumable/pickle
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/pickle/make_edible()
	. = ..()
	AddComponent(/datum/component/edible, check_liked = CALLBACK(src, PROC_REF(check_liked)))

/obj/item/food/pickle/proc/check_liked(mob/living/carbon/human/consumer)
	var/obj/item/organ/internal/liver/liver = consumer.get_organ_slot(ORGAN_SLOT_LIVER)
	if(!HAS_TRAIT(consumer, TRAIT_AGEUSIA) && liver && HAS_TRAIT(liver, TRAIT_CORONER_METABOLISM))
		return FOOD_LIKED

/obj/item/food/springroll
	name = "春卷"
	desc = "一盘半透明的米皮，里面装满了新鲜蔬菜，并配上了甜辣酱。你要么爱他们，要么恨他们."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "springroll"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("米皮" = 1, "香料" = 1, "新鲜蔬菜" = 1)
	foodtypes = GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cheese_pierogi
	name = "波兰奶酪饺子"
	desc = "用未发酵的生面团包上咸味或甜味的馅料，在沸水中煮成的饺子，这个里面是土豆和奶酪."
	icon_state = "cheese_pierogi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("土豆" = 1, "奶酪" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/meat_pierogi
	name = "波兰肉馅饺子"
	desc = "用未发酵的生面团包上咸味或甜味的馅料，在沸水中煮成的饺子，这个里面是土豆和肉."
	icon_state = "meat_pierogi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("土豆" = 1, "肉" = 1)
	foodtypes = GRAIN | VEGETABLES | MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/stuffed_eggplant
	name = "茄盒" // stuffed eggplant
	desc = "茄子半熟的茄子，用勺子舀出里面的部分，与肉、奶酪和蔬菜混合."
	icon_state = "stuffed_eggplant"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("煮过的茄子" = 5, "奶酪" = 4, "碎肉" = 3, "蔬菜" = 2)
	foodtypes = VEGETABLES | MEAT | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/moussaka
	name = "希腊茄盒" // moussaka
	desc = "一种地中海菜，由茄子、蔬菜和肉混合而成，浇上白酱汁。可切成小块"
	icon_state = "moussaka"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 30,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 20,
	)
	tastes = list("煮过的茄子" = 5, "土豆" = 1, "烤蔬菜" = 2, "肉" = 4, "白酱" = 3)
	foodtypes = MEAT | DAIRY | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/moussaka/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/moussaka_slice, 4, 3 SECONDS, table_required = TRUE,  screentip_verb = "Cut")

/obj/item/food/moussaka_slice
	name = "小块希腊茄盒"
	desc = "一种地中海菜，由茄子、蔬菜和肉混合而成，浇上白酱汁。美味!"
	icon_state = "moussaka_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 5,
	)
	tastes = list("煮过的茄子" = 5, "土豆" = 1, "烤蔬菜" = 2, "肉" = 4, "白酱" = 3)
	foodtypes = MEAT | DAIRY | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/candied_pineapple
	name = "菠萝蜜饯"
	desc = "一大块菠萝，裹上糖，晒干后很有嚼劲."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	icon_state = "candied_pineapple_1"
	base_icon_state = "candied_pineapple"
	tastes = list("糖" = 2, "耐嚼的菠萝" = 4)
	foodtypes = FRUIT | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/candied_pineapple/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state]_[rand(1, 3)]"

/obj/item/food/raw_pita_bread
	name = "生皮塔饼"
	desc = "一盘粘稠的生皮塔饼."
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "raw_pita_bread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("面团" = 2)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_pita_bread/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/pita_bread, rand(15 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/raw_pita_bread/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pita_bread, rand(15 SECONDS, 30 SECONDS), TRUE, TRUE)

/obj/item/food/pita_bread
	name = "皮塔饼"
	desc = "一种起源于地中海的多用途甜面饼，据说是土耳其美食。"
	icon = 'icons/obj/food/food_ingredients.dmi'
	icon_state = "pita_bread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("皮塔饼" = 2)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/tzatziki_sauce
	name = "希腊酸奶酱"
	desc = "一种以大蒜为基础的酱料或蘸料，广泛用于地中海和中东的烹饪中，与皮塔饼或蔬菜蘸着吃."
	icon_state = "tzatziki_sauce"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("大蒜" = 4, "黄瓜" = 2, "橄榄油" = 2)
	foodtypes = VEGETABLES
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/tzatziki_and_pita_bread
	name = "皮塔饼配希腊酸奶酱"
	desc = "酸奶酱，现在用皮塔饼蘸着吃。非常健康又美味。"
	icon_state = "tzatziki_and_pita_bread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("皮塔饼" = 4, "希腊酸奶酱" = 2, "橄榄油" = 2)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/grilled_beef_gyro
	name = "希腊烤牛肉卷"
	desc = "一种传统的希腊菜肴，用皮塔饼包肉，配以西红柿、卷心菜、洋葱和酸奶酱"
	icon_state = "grilled_beef_gyro"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("皮塔饼" = 4, "嫩肉" = 2, "希腊酸奶酱" = 2, "混杂的蔬菜" = 2)
	foodtypes = VEGETABLES | GRAIN | MEAT
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/vegetarian_gyro
	name = "希腊蔬菜卷"
	desc = "用黄瓜代替肉的传统希腊蔬菜卷。仍然充满浓郁的味道，非常有营养。"
	icon_state = "vegetarian_gyro"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 12,
	)
	tastes = list("皮塔饼" = 4, "黄瓜" = 2, "希腊酸奶酱" = 2, "混杂的蔬菜" = 2)
	foodtypes = VEGETABLES | GRAIN
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_4
