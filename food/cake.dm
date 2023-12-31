/obj/item/food/cake
	icon = 'icons/obj/food/piecake.dmi'
	bite_consumption = 3
	max_volume = 80
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("cake" = 1)
	foodtypes = GRAIN | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_2
	/// type is spawned 5 at a time and replaces this cake when processed by cutting tool
	var/obj/item/food/cakeslice/slice_type
	/// changes yield of sliced cake, default for cake is 5
	var/yield = 5

/obj/item/food/cake/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/food_storage)

/obj/item/food/cake/make_processable()
	if (slice_type)
		AddElement(/datum/element/processable, TOOL_KNIFE, slice_type, yield, 3 SECONDS, table_required = TRUE, screentip_verb = "Slice")

/obj/item/food/cakeslice
	icon = 'icons/obj/food/piecake.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("cake" = 1)
	foodtypes = GRAIN | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cake/plain
	name = "蛋糕"
	desc = "一个蛋糕,并非谎言."
	icon_state = "plaincake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 30,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	tastes = list("甜脂" = 2, "蛋糕" = 5)
	foodtypes = GRAIN | DAIRY | SUGAR
	slice_type = /obj/item/food/cakeslice/plain

/obj/item/food/cakeslice/plain
	name = "蛋糕块"
	desc = "只是一小块蛋糕,不够大家一起吃的."
	icon_state = "plaincake_slice"
	tastes = list("甜脂" = 2, "蛋糕" = 5)
	foodtypes = GRAIN | DAIRY | SUGAR

/obj/item/food/cake/carrot
	name = "胡萝卜蛋糕"
	desc = "某只野兔最喜欢的沙漠. 并非谎言."
	icon_state = "carrotcake"
	tastes = list("蛋糕" = 5, "甜脂" = 2, "胡萝卜" = 1)
	foodtypes = GRAIN | DAIRY | VEGETABLES | SUGAR
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/carrot
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/carrot
	name = "胡萝卜蛋糕块"
	desc = "胡萝卜不仅有益你的眼睛,还有益于你的生活! 此话不假."
	icon_state = "carrotcake_slice"
	tastes = list("蛋糕" = 5, "甜脂" = 2, "胡萝卜" = 1)
	foodtypes = GRAIN | DAIRY | VEGETABLES | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/brain
	name = "脑蛋糕"
	desc = "一个黏糊糊的蛋糕."
	icon_state = "braincake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/medicine/mannitol = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("蛋糕" = 5, "甜脂" = 2, "大脑" = 1)
	foodtypes = GRAIN | DAIRY | MEAT | GORE | SUGAR
	slice_type = /obj/item/food/cakeslice/brain
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/brain
	name = "脑蛋糕块"
	desc = "让我告诉你一些关于朊病毒的事情,它们是美味的."
	icon_state = "braincakeslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/medicine/mannitol = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("蛋糕" = 5, "甜脂" = 2, "大脑" = 1)
	foodtypes = GRAIN | DAIRY | MEAT | GORE | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/cheese
	name = "芝士蛋糕"
	desc = "危险的奶酪."
	icon_state = "cheesecake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment/protein = 5,
	)
	tastes = list("蛋糕" = 4, "奶酪芝士" = 3)
	foodtypes = GRAIN | DAIRY
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/cheese
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/cheese
	name = "芝士蛋糕块"
	desc = "一块芝士蛋糕."
	icon_state = "cheesecake_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1.3,
	)
	tastes = list("蛋糕" = 4, "奶酪芝士" = 3)
	foodtypes = GRAIN | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/orange
	name = "甘橙蛋糕"
	desc = "一块加了橘子的蛋糕."
	icon_state = "orangecake"
	tastes = list("蛋糕" = 5, "甜脂" = 2, "橙子" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR | ORANGES
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/orange
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/orange
	name = "甘橙蛋糕块"
	desc = "一小块橘子蛋糕,不够大伙吃的."
	icon_state = "orangecake_slice"
	tastes = list("蛋糕" = 5, "甜脂" = 2, "橙子" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR | ORANGES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/lime
	name = "酸橙蛋糕"
	desc = "一块加了酸橙的蛋糕."
	icon_state = "limecake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("蛋糕" = 5, "甜脂" = 2, "生命无法承受之酸" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/lime
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/lime
	name = "酸橙蛋糕块"
	desc = "一小块酸橙蛋糕,不够大伙酸的."
	icon_state = "limecake_slice"
	tastes = list("蛋糕" = 5, "甜脂" = 2, "生命无法承受之酸" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/lemon
	name = "柠檬蛋糕"
	desc = "一块加了柠檬的蛋糕."
	icon_state = "lemoncake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("蛋糕" = 5, "甜脂" = 2, "柠檬酸" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/lemon
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/lemon
	name = "柠檬蛋糕块"
	desc = "一小块柠檬蛋糕,不够大伙吃的."
	icon_state = "lemoncake_slice"
	tastes = list("蛋糕" = 5, "甜脂" = 2, "柠檬酸" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/chocolate
	name = "巧克力蛋糕"
	desc = "一块掺了巧克力的蛋糕."
	icon_state = "chocolatecake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("蛋糕" = 5, "甜脂" = 1, "巧克力" = 4)
	foodtypes = GRAIN | DAIRY | JUNKFOOD | SUGAR
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/chocolate
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/chocolate
	name = "巧克力蛋糕块"
	desc = "一小块巧克力蛋糕,不够大伙吃的."
	icon_state = "chocolatecake_slice"
	tastes = list("蛋糕" = 5, "甜脂" = 1, "巧克力" = 4)
	foodtypes = GRAIN | DAIRY | JUNKFOOD | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/birthday
	name = "生日蛋糕"
	desc = "生日快乐,小小丑..."
	icon_state = "birthdaycake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/sprinkles = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("蛋糕" = 5, "甜脂" = 1)
	foodtypes = GRAIN | DAIRY | JUNKFOOD | SUGAR
	slice_type = /obj/item/food/cakeslice/birthday
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/birthday/make_microwaveable() // super sekrit club
	AddElement(/datum/element/microwavable, /obj/item/clothing/head/utility/hardhat/cakehat)

/obj/item/food/cakeslice/birthday
	name = "生日蛋糕块"
	desc = "一块你的生日."
	icon_state = "birthdaycakeslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sprinkles = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("蛋糕" = 5, "甜脂" = 1)
	foodtypes = GRAIN | DAIRY | JUNKFOOD | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/birthday/energy
	name = "能量蛋糕"
	desc = "有足够的卡路里供整个核队成员享用."
	icon_state = "energycake"
	force = 5
	hitsound = 'sound/weapons/blade1.ogg'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/sprinkles = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/pwr_game = 10,
		/datum/reagent/consumable/liquidelectricity/enriched = 10,
	)
	tastes = list("蛋糕" = 3, "一份弗拉德沙拉" = 1)
	slice_type = /obj/item/food/cakeslice/birthday/energy
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cake/birthday/energy/make_microwaveable() //super sekriter club
	AddElement(/datum/element/microwavable, /obj/item/clothing/head/utility/hardhat/cakehat/energycake)

/obj/item/food/cake/birthday/energy/proc/energy_bite(mob/living/user)
	to_chat(user, "<font color='red' size='5'>在你吃蛋糕的时候，你不小心被嵌在里面的能量剑弄伤了!</font>")
	user.apply_damage(30, BRUTE, BODY_ZONE_HEAD)
	playsound(user, 'sound/weapons/blade1.ogg', 5, TRUE)

/obj/item/food/cake/birthday/energy/attack(mob/living/target_mob, mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM) && target_mob != user) //Prevents pacifists from attacking others directly
		return
	energy_bite(target_mob, user)

/obj/item/food/cakeslice/birthday/energy
	name = "能量蛋糕块"
	desc = "为逃亡的叛徒准备的."
	icon_state = "energycakeslice"
	force = 2
	hitsound = 'sound/weapons/blade1.ogg'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sprinkles = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/pwr_game = 2,
		/datum/reagent/consumable/liquidelectricity/enriched = 2,
	)
	tastes = list("蛋糕" = 3, "一份弗拉德沙拉" = 1)
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cakeslice/birthday/energy/proc/energy_bite(mob/living/user)
	to_chat(user, "<font color='red' size='5'>在你吃蛋糕的时候，你不小心被嵌在里面的能量剑弄伤了!</font>")
	user.apply_damage(18, BRUTE, BODY_ZONE_HEAD)
	playsound(user, 'sound/weapons/blade1.ogg', 5, TRUE)

/obj/item/food/cakeslice/birthday/energy/attack(mob/living/target_mob, mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM) && target_mob != user) //Prevents pacifists from attacking others directly
		return
	energy_bite(target_mob, user)

/obj/item/food/cake/apple
	name = "苹果蛋糕"
	desc = "一个以苹果为中心的蛋糕."
	icon_state = "applecake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("蛋糕" = 5, "甜脂" = 1, "苹果" = 1)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/apple
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/apple
	name = "苹果蛋糕块"
	desc = "一块丰收的蛋糕."
	icon_state = "applecakeslice"
	tastes = list("蛋糕" = 5, "甜脂" = 1, "苹果" = 1)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/slimecake
	name = "史莱姆蛋糕"
	desc = "一块由史莱姆做成的蛋糕."
	icon_state = "slimecake"
	tastes = list("cake" = 5, "甜脂" = 1, "史莱姆" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	slice_type = /obj/item/food/cakeslice/slimecake
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/slimecake
	name = "史莱姆蛋糕块"
	desc = "一块史莱姆蛋糕."
	icon_state = "slimecake_slice"
	tastes = list("蛋糕" = 5, "甜脂" = 1, "史莱姆" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/pumpkinspice
	name = "南瓜香料蛋糕"
	desc = "一个有真正南瓜的万圣节蛋糕."
	icon_state = "pumpkinspicecake"
	tastes = list("蛋糕" = 5, "甜脂" = 1, "南瓜" = 1)
	foodtypes = GRAIN | DAIRY | VEGETABLES | SUGAR
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/pumpkinspice
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/pumpkinspice
	name = "南瓜香料蛋糕块"
	desc = "一块香料南瓜蛋糕."
	icon_state = "pumpkinspicecakeslice"
	tastes = list("蛋糕" = 5, "甜脂" = 1, "南瓜" = 1)
	foodtypes = GRAIN | DAIRY | VEGETABLES | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/berry_vanilla_cake // blackberry strawberries vanilla cake
	name = "莓果香草蛋糕"
	desc = "里面有各种各样的黑莓和草莓!"
	icon_state = "blackbarry_strawberries_cake_vanilla_cake"
	tastes = list("黑莓" = 2, "草莓" = 2, "香草" = 2, "甜脂" = 2, "蛋糕" = 3)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	slice_type = /obj/item/food/cakeslice/berry_vanilla_cake
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/berry_vanilla_cake
	name = "莓果香草蛋糕块"
	desc = "里面有各种各样的黑莓和草莓!"
	icon_state = "blackbarry_strawberries_cake_vanilla_slice"
	tastes = list("黑莓" = 2, "草莓" = 2, "香草" = 2, "甜脂" = 2, "蛋糕" = 3)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/berry_chocolate_cake // blackbarry strawberries chocolate cake <- this is a relic from before resprite
	name = "草莓巧克力蛋糕"
	desc = "上面有五个草莓的巧克力蛋糕.这就是儿时梦想."
	icon_state = "liars_cake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/coco = 5,
	)
	tastes = list("黑莓" = 2, "草莓" = 2, "巧克力" = 2, "甜脂" = 2, "蛋糕" = 3)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	slice_type = /obj/item/food/cakeslice/berry_chocolate_cake
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cakeslice/berry_chocolate_cake
	name = "草莓巧克力蛋糕块"
	desc = "上面有五个草莓的巧克力蛋糕.这就是儿时梦想."
	icon_state = "liars_slice"
	tastes = list("草莓" = 2, "巧克力" = 2, "甜脂" = 2, "蛋糕" = 3)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cake/holy_cake
	name = "神圣蛋糕"
	desc = "一个为天使和牧师做的蛋糕!含有圣水."
	icon_state = "holy_cake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/water/holywater = 10,
	)
	tastes = list("蛋糕" = 5, "甜脂" = 1, "云彩" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	slice_type = /obj/item/food/cakeslice/holy_cake_slice

/obj/item/food/cakeslice/holy_cake_slice
	name = "神圣蛋糕块"
	desc = "一块神圣的蛋糕."
	icon_state = "holy_cake_slice"
	tastes = list("蛋糕" = 5, "甜脂" = 1, "云彩" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR

/obj/item/food/cake/pound_cake
	name = "黄油蛋糕"
	desc = "一种用来快速填饱肚子的重油蛋糕."
	icon_state = "pound_cake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 60,
		/datum/reagent/consumable/nutriment/vitamin = 20,
	)
	tastes = list("蛋糕" = 5, "甜脂" = 5, "黄油" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR | JUNKFOOD
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/pound_cake_slice
	yield = 7
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cakeslice/pound_cake_slice
	name = "黄油蛋糕块"
	desc = "一种用来快速填饱肚子的重油蛋糕."
	icon_state = "pound_cake_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("蛋糕" = 5, "甜脂" = 5, "黄油" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR | JUNKFOOD
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cake/hardware_cake
	name = "硬糕"
	desc = "一个用电路板做成的 \"cake\" 会漏酸..."
	icon_state = "hardware_cake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/toxin/acid = 15,
		/datum/reagent/fuel/oil = 15,
	)
	tastes = list("酸液" = 3, "金属" = 4, "玻璃" = 5)
	foodtypes = GRAIN | GROSS
	slice_type = /obj/item/food/cakeslice/hardware_cake_slice
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/hardware_cake_slice
	name = "硬糕块"
	desc = "一片用电路板做成的硫酸硬糕块."
	icon_state = "hardware_cake_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/toxin/acid = 3,
		/datum/reagent/fuel/oil = 3,
	)
	tastes = list("酸液" = 3, "金属" = 4, "玻璃" = 5)
	foodtypes = GRAIN | GROSS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/vanilla_cake
	name = "香草蛋糕"
	desc = "香草糖霜蛋糕."
	icon_state = "vanillacake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/sugar = 15,
		/datum/reagent/consumable/vanilla = 15,
	)
	tastes = list("蛋糕" = 1, "糖霜" = 1, "香草" = 10)
	foodtypes = GRAIN | SUGAR | DAIRY
	slice_type = /obj/item/food/cakeslice/vanilla_slice
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/vanilla_slice
	name = "香草蛋糕块"
	desc = "香草糖霜蛋糕块."
	icon_state = "vanillacake_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/vanilla = 3,
	)
	tastes = list("蛋糕" = 1, "糖霜" = 1, "香草" = 10)
	foodtypes = GRAIN | SUGAR | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/clown_cake
	name = "小丑蛋糕"
	desc = "你他妈在搞笑啊."
	icon_state = "clowncake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/banana = 15,
	)
	tastes = list("蛋糕" = 1, "糖霜" = 1, "乐子" = 10)
	foodtypes = GRAIN | SUGAR | DAIRY
	slice_type = /obj/item/food/cakeslice/clown_slice
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/cakeslice/clown_slice
	name = "小丑蛋糕块"
	desc = "你他妈在搞笑啊."
	icon_state = "clowncake_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/banana = 3,
	)
	tastes = list("蛋糕" = 1, "糖霜" = 1, "乐子" = 10)
	foodtypes = GRAIN | SUGAR | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/cake/trumpet
	name = "宇航员蛋糕"
	desc = "休斯顿...."
	icon_state = "trumpetcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/cream = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/berryjuice = 5,
	)
	tastes = list("蛋糕" = 4, "紫罗兰" = 2, "麻烦" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	slice_type = /obj/item/food/cakeslice/trumpet
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cakeslice/trumpet
	name = "宇航员蛋糕"
	desc = "休斯顿...."
	icon_state = "trumpetcakeslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/cream = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/berryjuice = 1,
	)
	tastes = list("蛋糕" = 4, "紫罗兰" = 2, "麻烦" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cake/brioche
	name = "奶油糕"
	desc = "一圈甜甜的夹了奶油的小圆面包."
	icon_state = "briochecake"
	tastes = list("蛋糕" = 4, "黄油" = 2, "奶油" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	slice_type = /obj/item/food/cakeslice/brioche
	yield = 6
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cakeslice/brioche
	name = "奶油小蛋糕"
	desc = "美味的甜面包.谁还需要别的东西??"
	icon_state = "briochecake_slice"
	tastes = list("蛋糕" = 4, "黄油" = 2, "奶油" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/cake/pavlova
	name = "帕芙洛娃"
	desc = "蛋白水果蛋糕。发明于新西兰,但以一位俄罗斯芭蕾舞演员的名字命名……而且被科学证明是最适合参加晚宴的!"
	icon_state = "pavlova"
	tastes = list("蛋白酥饼" = 5, "乳脂" = 1, "浆果" = 1)
	foodtypes = DAIRY | FRUIT | SUGAR
	slice_type = /obj/item/food/cakeslice/pavlova
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/pavlova/nuts
	name = "坚果帕芙洛娃"
	foodtypes = NUTS | FRUIT | SUGAR
	slice_type = /obj/item/food/cakeslice/pavlova/nuts

/obj/item/food/cakeslice/pavlova
	name = "帕芙洛娃块"
	desc = "蛋白水果蛋糕。发明于新西兰,但以一位俄罗斯芭蕾舞演员的名字命名……而且被科学证明是最适合参加晚宴的!."
	icon_state = "pavlova_slice"
	tastes = list("蛋白酥饼" = 5, "乳脂" = 1, "浆果" = 1)
	foodtypes = DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/pavlova/nuts
	foodtypes = NUTS | FRUIT | SUGAR

/obj/item/food/cake/fruit
	name = "英式水果蛋糕"
	desc = "一块很好的蛋糕，对吧?"
	icon_state = "fruitcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/sugar = 10,
		/datum/reagent/consumable/cherryjelly = 5,
	)
	tastes = list("干果" = 5, "蜜糖" = 2, "圣诞节" = 2)
	force = 7
	throwforce = 7
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	slice_type = /obj/item/food/cakeslice/fruit
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cakeslice/fruit
	name = "英式水果蛋糕片"
	desc = "一块很好的蛋糕，对吧?"
	icon_state = "fruitcake_slice1"
	base_icon_state = "fruitcake_slice"
	tastes = list("干果" = 5, "蜜糖" = 2, "圣诞节" = 2)
	force = 2
	throwforce = 2
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cakeslice/fruit/Initialize(mapload)
	. = ..()
	icon_state = "[base_icon_state][rand(1,3)]"

/obj/item/food/cake/plum
	name = "李子蛋糕"
	desc = "以李子为中心的蛋糕."
	icon_state = "plumcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/impurity/rosenol = 8,
	)
	tastes = list("蛋糕" = 5, "甜脂" = 1, "李子" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/cakeslice/plum
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/plum
	name = "李子蛋糕片"
	desc = "以李子为中心的蛋糕."
	icon_state = "plumcakeslice"
	tastes = list("cake" = 5, "甜脂" = 1, "李子" = 2)
	foodtypes = GRAIN | DAIRY | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cake/wedding
	name = "婚庆蛋糕"
	desc = "一种昂贵的多层蛋糕."
	icon_state = "weddingcake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 40,
		/datum/reagent/consumable/sugar = 30,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("蛋糕" = 3, "霜糖" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	slice_type = /obj/item/food/cakeslice/wedding
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/wedding
	name = "婚庆蛋糕块"
	desc = "传统上，结婚的人会给对方喂一块蛋糕."
	icon_state = "weddingcake_slice"
	tastes = list("蛋糕" = 3, "霜糖" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR

/obj/item/food/cake/pineapple_cream_cake
	name = "菠萝奶油蛋糕"
	desc = "一个充满活力的蛋糕,上面有一层厚厚的奶油和菠萝."
	icon_state = "pineapple_cream_cake"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 30,
		/datum/reagent/consumable/sugar = 15,
		/datum/reagent/consumable/nutriment/vitamin = 15,
	)
	tastes = list("蛋糕" = 2, "奶油" = 3, "菠萝" = 4)
	foodtypes = GRAIN | DAIRY | SUGAR | FRUIT | PINEAPPLE
	slice_type = /obj/item/food/cakeslice/pineapple_cream_cake
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/cakeslice/pineapple_cream_cake
	name = "菠萝奶油蛋糕块"
	desc = "一个充满活力的蛋糕,上面有一层厚厚的奶油和菠萝."
	icon_state = "pineapple_cream_cake_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("蛋糕" = 2, "奶油" = 3, "菠萝" = 4)
	foodtypes = GRAIN | DAIRY | SUGAR | FRUIT | PINEAPPLE
	crafting_complexity = FOOD_COMPLEXITY_3
