/obj/item/food/icecreamsandwich
	name = "冰淇淋威化"
	desc = "自带包装的便携式冰淇淋."
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "icecreamsandwich"
	w_class = WEIGHT_CLASS_TINY
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/ice = 4,
	)
	tastes = list("冰淇淋" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/strawberryicecreamsandwich
	name = "草莓冰淇淋威化"
	desc = "自带包装的便携式草莓冰淇淋."
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "strawberryicecreamsandwich"
	w_class = WEIGHT_CLASS_TINY
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/ice = 4,
	)
	tastes = list("冰淇淋" = 2, "草莓" = 2)
	foodtypes = FRUIT | DAIRY | SUGAR
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_3


/obj/item/food/spacefreezy
	name = "太空飞霜"
	desc = "太空中最好的冰淇淋."
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "spacefreezy"
	w_class = WEIGHT_CLASS_TINY
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/bluecherryjelly = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("蓝樱桃" = 2, "冰淇淋" = 2)
	foodtypes = FRUIT | DAIRY | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/spacefreezy/make_edible()
	. = ..()
	AddComponent(/datum/component/ice_cream_holder)

/obj/item/food/sundae
	name = "圣代"
	desc = "经典甜点."
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "sundae"
	w_class = WEIGHT_CLASS_SMALL
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/banana = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("冰淇淋" = 1, "香蕉" = 1)
	foodtypes = FRUIT | DAIRY | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/sundae/make_edible()
	. = ..()
	AddComponent(/datum/component/ice_cream_holder, y_offset = -2, sweetener = /datum/reagent/consumable/caramel)

/obj/item/food/honkdae
	name = "蕉代"
	desc = "小丑最喜欢的甜点."
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "honkdae"
	w_class = WEIGHT_CLASS_SMALL
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/banana = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("冰淇淋" = 1, "香蕉" = 1, "烂笑话" = 1)
	foodtypes = FRUIT | DAIRY | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/honkdae/make_edible()
	. = ..()
	AddComponent(/datum/component/ice_cream_holder, y_offset = -2) //The sugar will react with the banana forming laughter. Honk!

/////////////
//SNOWCONES//
/////////////

/obj/item/food/snowcones //We use this as a base for all other snowcones
	name = "原味刨冰"
	desc = "这只是一个刨冰,但咀嚼起来仍然很有趣."
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "flavorless_sc"
	w_class = WEIGHT_CLASS_SMALL
	trash_type = /obj/item/reagent_containers/cup/glass/sillycup //We dont eat paper cups
	food_reagents = list(
		/datum/reagent/water = 11,
	) // We dont get food for water/juices
	tastes = list("冰" = 1, "水" = 1)
	foodtypes = SUGAR //We use SUGAR as a base line to act in as junkfood, other wise we use fruit
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/snowcones/lime
	name = "酸橙刨冰"
	desc = "酸橙汁淋在纸杯里的刨冰上."
	icon_state = "lime_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/limejuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "酸橙" = 5)
	foodtypes = FRUIT

/obj/item/food/snowcones/lemon
	name = "柠檬刨冰"
	desc = "柠檬糖浆淋在纸杯里的刨冰上."
	icon_state = "lemon_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/lemonjuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "柠檬" = 5)
	foodtypes = FRUIT

/obj/item/food/snowcones/apple
	name = "苹果刨冰"
	desc = "苹果糖浆淋在纸杯里的刨冰上."
	icon_state = "amber_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/applejuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "苹果" = 5)
	foodtypes = FRUIT

/obj/item/food/snowcones/grape
	name = "葡萄刨冰"
	desc = "葡萄糖浆淋在纸杯里的雪球上."
	icon_state = "grape_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/grapejuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "葡萄" = 5)
	foodtypes = FRUIT

/obj/item/food/snowcones/orange
	name = "橙子刨冰"
	desc = "橙汁淋在纸杯里的刨冰上."
	icon_state = "orange_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/orangejuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "橙子" = 5)
	foodtypes = FRUIT | ORANGES

/obj/item/food/snowcones/blue
	name = "蓝樱桃刨冰"
	desc = "蓝樱桃糖浆淋在纸杯里的刨冰上,如此珍奇!"
	icon_state = "blue_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/bluecherryjelly = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "樱桃蓝" = 5, "樱桃" = 5)
	foodtypes = FRUIT

/obj/item/food/snowcones/red
	name = "樱桃刨冰"
	desc = "樱桃淋在纸杯里的刨冰上."
	icon_state = "red_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/cherryjelly = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "樱桃红" = 5, "樱桃" = 5)
	foodtypes = FRUIT

/obj/item/food/snowcones/berry
	name = "浆果刨冰"
	desc = "浆果汁淋在纸杯里的刨冰上."
	icon_state = "berry_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/berryjuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "浆果" = 5)
	foodtypes = FRUIT

/obj/item/food/snowcones/fruitsalad
	name = "柑橘沙拉刨冰"
	desc = "在纸杯里的刨冰上淋上令人愉悦的多种柑橘水果汁."
	icon_state = "fruitsalad_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/lemonjuice = 5,
		/datum/reagent/consumable/limejuice = 5,
		/datum/reagent/consumable/orangejuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "橙子" = 5, "酸橙" = 5, "柠檬" = 5, "柑橘" = 5, "沙拉" = 5)
	foodtypes = FRUIT | ORANGES

/obj/item/food/snowcones/pineapple
	name = "菠萝刨冰"
	desc = "菠萝汁淋在纸杯里的刨冰上."
	icon_state = "pineapple_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/pineapplejuice = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "菠萝" = 5)
	foodtypes = PINEAPPLE //Pineapple to allow all that like pineapple to enjoy

/obj/item/food/snowcones/mime
	name = "默剧刨冰"
	desc = "..."
	icon_state = "mime_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nothing = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "nothing" = 5)
	foodtypes = SUGAR

/obj/item/food/snowcones/clown
	name = "小丑刨冰"
	desc = "纸杯里的刨冰上飘来一阵笑声."
	icon_state = "clown_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/laughter = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "玩笑" = 5, "大脑冰镇体验" = 5, "欢乐" = 5)
	foodtypes = SUGAR | FRUIT

/obj/item/food/snowcones/soda
	name = "可乐刨冰"
	desc = "太空可乐洒在纸杯里的刨冰上."
	icon_state = "soda_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/space_cola = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "可乐" = 5)
	foodtypes = SUGAR

/obj/item/food/snowcones/spacemountainwind
	name = "山风刨冰"
	desc = "太空山风洒在纸杯里的刨冰上."
	icon_state = "mountainwind_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/spacemountainwind = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "山风" = 5)
	foodtypes = SUGAR


/obj/item/food/snowcones/pwrgame
	name = "pwrgame刨冰"
	desc = "Pwrgame soda 洒在纸杯里的刨冰上."
	icon_state = "pwrgame_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/pwr_game = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "效力" = 5, "盐" = 5, "电力" = 5)
	foodtypes = SUGAR

/obj/item/food/snowcones/honey
	name = "蜂蜜刨冰"
	desc = "蜂蜜洒在纸杯里的刨冰上."
	icon_state = "amber_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/honey = 5,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "花朵" = 5, "蜜" = 5, "蜂蜡" = 1)
	foodtypes = SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/snowcones/rainbow
	name = "彩虹刨冰"
	desc = "一份缤纷多彩的刨冰."
	icon_state = "rainbow_sc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/laughter = 25,
		/datum/reagent/water = 11,
	)
	tastes = list("冰" = 1, "水" = 1, "阳光" = 5, "白日" = 5, "史莱姆" = 5, "涂料" = 3, "云彩" = 3)
	foodtypes = SUGAR

/obj/item/food/popsicle
	name = "虫子棒冰"
	desc = "Mmmm,这不该存在在这个世上."
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "popsicle_stick_s"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("甲虫汁")
	trash_type = /obj/item/popsicle_stick
	w_class = WEIGHT_CLASS_SMALL
	foodtypes = DAIRY | SUGAR
	food_flags = FOOD_FINGER_FOOD
	crafting_complexity = FOOD_COMPLEXITY_3

	var/overlay_state = "creamsicle_o" //This is the edible part of the popsicle. 这是冰棒的可食用部分。
	var/bite_states = 4 //This value value is used for correctly setting the bite_consumption to ensure every bite changes the sprite. Do not set to zero.
	var/bitecount = 0


/obj/item/food/popsicle/Initialize(mapload)
	. = ..()
	bite_consumption = reagents.total_volume / bite_states
	update_icon() // make sure the popsicle overlay is primed so it's not just a stick until you start eating it

/obj/item/food/popsicle/make_edible()
	. = ..()
	AddComponent(/datum/component/edible, after_eat = CALLBACK(src, PROC_REF(after_bite)))

/obj/item/food/popsicle/update_overlays()
	. = ..()
	if(!bitecount)
		. += initial(overlay_state)
		return
	. += "[initial(overlay_state)]_[min(bitecount, 3)]"

/obj/item/food/popsicle/proc/after_bite(mob/living/eater, mob/living/feeder, bitecount)
	src.bitecount = bitecount
	update_appearance()

/obj/item/popsicle_stick
	name = "棒冰"
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "popsicle_stick"
	desc = "冰块裹住了这个不起眼的小棍子,此刻它到了返璞归真的境界."
	custom_materials = list(/datum/material/wood = SMALL_MATERIAL_AMOUNT * 0.20)
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_TINY
	force = 0

/obj/item/food/popsicle/creamsicle_orange
	name = "柑橙雪糕"
	desc = "经典的橙子雪糕,冷冻大餐."
	food_reagents = list(
		/datum/reagent/consumable/orangejuice = 4,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	foodtypes = FRUIT | DAIRY | SUGAR | ORANGES
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/popsicle/creamsicle_berry
	name = "浆果雪糕"
	desc = "充满活力的浆果雪糕,一种很好的浆果冷冻食品."
	food_reagents = list(
		/datum/reagent/consumable/berryjuice = 4,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 2,
		/datum/reagent/consumable/sugar = 4,
	)
	overlay_state = "creamsicle_m"
	foodtypes = FRUIT | DAIRY | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/popsicle/jumbo
	name = "巧克力雪糕"
	desc = "一种覆盖着浓郁巧克力的豪华雪糕,它似乎比你记忆中的要小."
	food_reagents = list(
		/datum/reagent/consumable/hot_coco = 4,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 3,
		/datum/reagent/consumable/sugar = 2,
	)
	overlay_state = "巧克力"
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/popsicle/licorice_creamsicle
	name = "Void Bar™"
	desc = "一个咸甘草雪糕,咸的冷冻食品."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/salt = 1,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 1,
		/datum/reagent/consumable/sugar = 4,
	)
	tastes = list("咸甘草")
	overlay_state = "licorice_creamsicle"
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/cornuto
	name = "巧乐吱"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/food/frozen_treats.dmi'
	icon_state = "cornuto"
	desc = "那不勒斯香草巧克力甜筒,上面撒着焦糖坚果."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/hot_coco = 4,
		/datum/reagent/consumable/cream = 2,
		/datum/reagent/consumable/vanilla = 4,
		/datum/reagent/consumable/sugar = 2,
	)
	tastes = list("榛子碎", "华夫冰")
	foodtypes = DAIRY | SUGAR
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3
