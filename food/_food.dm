///Abstract class to allow us to easily create all the generic "normal" food without too much copy pasta of adding more components
///Abstract class允许我们轻松地创建所有通用的“normal”食品，而无需过多的复制面食或添加更多的组件
/obj/item/food
	name = "food"
	desc = "you eat this"
	resistance_flags = FLAMMABLE
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/food/food.dmi'
	icon_state = null
	lefthand_file = 'icons/mob/inhands/items/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/food_righthand.dmi'
	obj_flags = UNIQUE_RENAME
	grind_results = list()
	///List of reagents this food gets on creation during reaction or map spawn
	///该食物在反应或地图生成过程中生成的试剂列表
	///SS13里面的营养的实现方式是直接在食物里面加入一个叫营养的液体,然后你吃的时候就等于在喝营养,理解为蛋白质维生素碳水之类的
	var/list/food_reagents
	///Extra flags for things such as if the food is in a container or not
	///额外的标记，比如食物是否在容器中
	var/food_flags
	///Bitflag of the types of food this food is
	///这种食物的类型的bitflag
	var/foodtypes
	///Amount of volume the food can contain
	///食物所能容纳的体积
	var/max_volume
	///How long it will take to eat this food without any other modifiers
	///不加任何其他添加剂的食物需要多长时间才能吃完
	var/eat_time
	///Tastes to describe this food
	///味道形容
	var/list/tastes
	///Verbs used when eating this food in the to_chat messages
	///聊天栏中吃这种食物时使用的动词
	var/list/eatverbs
	///How much reagents per bite
	///每一口要多少试剂
	var/bite_consumption
	///Type of atom thats spawned after eating this item
	///吃了这个东西后产生的atom类型
	var/trash_type
	///How much junkiness this food has? God I should remove junkiness soon
	///这种食物有多少垃圾?天啊，我应该尽快清除垃圾
	var/junkiness
	///Price of this food if sold in a venue
	///这种食物的价格如果在一个场所出售
	var/venue_value
	///Food that's immune to decomposition.
	///不会腐烂的食物。
	var/preserved_food = FALSE
	///Does our food normally attract ants?
	///我们的食物通常会吸引蚂蚁吗?
	var/ant_attracting = FALSE
	///What our food decomposes into.
	///我们的食物分解成什么。
	var/decomp_type = /obj/item/food/badrecipe/moldy
	///Food that needs to be picked up in order to decompose.
	///需要被捡起来才能分解的食物。
	var/decomp_req_handle = FALSE
	///Used to set custom decomposition times for food. Set to 0 to have it automatically set via the food's flags.
	///用来设定食物的自定义分解时间。设置为0来通过食物flag自动设定
	var/decomposition_time = 0
	///Used to set decomposition stink particles for food, will have no particles if null
	///用于为食品设置分解臭味颗粒，若无颗粒则为null
	var/decomposition_particles = /particles/stink
	///Used to set custom starting reagent purity for synthetic and natural food. Ignored when set to null.
	///用于设定合成食品和天然食品的自定义起始试剂纯度。设置为null时忽略。
	var/starting_reagent_purity = null
	///How exquisite the meal is. Applicable to crafted food, increasing its quality. Spans from 0 to 5.
	///这顿饭有多复杂。适用于精加工食品，提高食品质量。从0到5。
	var/crafting_complexity = 0
	///Buff given when a hand-crafted version of this item is consumed. Randomized according to crafting_complexity if not assigned.
	///当这个物品的手工制作版本被消耗时给予Buff。随机根据crafting_complexity，如果没有分配。
	var/datum/status_effect/food/crafted_food_buff = null

/obj/item/food/Initialize(mapload)
	if(food_reagents)
		food_reagents = string_assoc_list(food_reagents)
	. = ..()
	if(tastes)
		tastes = string_assoc_list(tastes)
	if(eatverbs)
		eatverbs = string_list(eatverbs)
	if(venue_value)
		AddElement(/datum/element/venue_price, venue_value)
	make_edible()
	make_processable()
	make_leave_trash()
	make_grillable()
	make_germ_sensitive(mapload)
	make_bakeable()
	make_microwaveable()
	ADD_TRAIT(src, TRAIT_FISHING_BAIT, INNATE_TRAIT)

///This proc adds the edible component, overwrite this if you for some reason want to change some specific args like callbacks.
///此过程添加了可食用组件，如果您出于某种原因想要更改某些特定参数(如回调)，请覆盖此组件。
/obj/item/food/proc/make_edible()
	AddComponent(/datum/component/edible,\
		initial_reagents = food_reagents,\
		food_flags = food_flags,\
		foodtypes = foodtypes,\
		volume = max_volume,\
		eat_time = eat_time,\
		tastes = tastes,\
		eatverbs = eatverbs,\
		bite_consumption = bite_consumption,\
		junkiness = junkiness,\
		reagent_purity = starting_reagent_purity,\
	)

///This proc handles processable elements, overwrite this if you want to add behavior such as slicing, forking, spooning, whatever, to turn the item into something else
///这个过程处理可处理的元素，如果你想添加诸如切片、分叉、舀匙等行为，可以覆盖这个过程，将项目变成其他东西
/obj/item/food/proc/make_processable()
	return

///This proc handles grillable components, overwrite if you want different grill results etc.
///这个过程处理可烧烤的组件，如果你想要不同的烧烤结果等覆盖。
/obj/item/food/proc/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/badrecipe, rand(20 SECONDS, 30 SECONDS), FALSE)
	return

///This proc handles bakeable components, overwrite if you want different bake results etc.
///这个过程处理可烘焙组件，如果你想要不同的烘焙结果等，覆盖。
/obj/item/food/proc/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/badrecipe, rand(25 SECONDS, 40 SECONDS), FALSE)
	return

/// This proc handles the microwave component. Overwrite if you want special microwave results.
/// By default, all food is microwavable. However, they will be microwaved into a bad recipe (burnt mess).
/// 这个过程处理微波组件。如果您想要特殊的微波效果，请覆盖。
/// 默认情况下，所有食物都可以微波炉加热。然而，它们会被微波炉加热成糟糕的食谱(烧焦的一团糟)。
/obj/item/food/proc/make_microwaveable()
	AddElement(/datum/element/microwavable)

///This proc handles trash components, overwrite this if you want the object to spawn trash
///此进程处理垃圾组件，如果您希望对象生成垃圾，请重写此进程
/obj/item/food/proc/make_leave_trash()
	if(trash_type)
		AddElement(/datum/element/food_trash, trash_type)
	return

///This proc makes things infective and decomposing when they stay on the floor for too long.
///Set preserved_food to TRUE to make it never decompose.
///Set decomp_req_handle to TRUE to only make it decompose when someone picks it up.
///Requires /datum/component/germ_sensitive to detect exposure
///当这些东西在地板上停留太久时，这个过程会使它们具有传染性和分解性。
///将preserved_food设置为TRUE，使其永远不会分解。
///将decomp_req_handle设置为TRUE，只在有人捡起它时才分解。
///需要/datum/component/germ_sensitive来检测暴露
/obj/item/food/proc/make_germ_sensitive(mapload)
	if(!isnull(trash_type))
		return // You don't eat the package and it protects from decomposing,你不吃包装，它可以防止分解
	AddComponent(/datum/component/germ_sensitive, mapload)
	if(!preserved_food)
		AddComponent(/datum/component/decomposition, mapload, decomp_req_handle, decomp_flags = foodtypes, decomp_result = decomp_type, ant_attracting = ant_attracting, custom_time = decomposition_time, stink_particles = decomposition_particles)
