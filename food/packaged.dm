// Pre-packaged meals, canned, wrapped, and vended 预包装菜

// Cans
/obj/item/food/canned
	name = "罐装空气"
	desc = "如果你好奇空气是从哪里来的...."
	food_reagents = list(
		/datum/reagent/oxygen = 6,
		/datum/reagent/nitrogen = 24,
	)
	icon = 'icons/obj/food/canned.dmi'
	icon_state = "peachcan"
	food_flags = FOOD_IN_CONTAINER
	w_class = WEIGHT_CLASS_NORMAL
	max_volume = 30
	w_class = WEIGHT_CLASS_SMALL
	preserved_food = TRUE

/obj/item/food/canned/make_germ_sensitive(mapload)
	return // It's in a can

/obj/item/food/canned/proc/open_can(mob/user)
	to_chat(user, span_notice("你打开了[src]."))
	playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)
	reagents.flags |= OPENCONTAINER
	preserved_food = FALSE

/obj/item/food/canned/attack_self(mob/user)
	if(!is_drainable())
		open_can(user)
		icon_state = "[icon_state]_open"
	return ..()

/obj/item/food/canned/attack(mob/living/target, mob/user, def_zone)
	if (!is_drainable())
		to_chat(user, span_warning("[src]的盖子还没有打开!"))
		return FALSE
	return ..()

/obj/item/food/canned/beans
	name = "豆子罐头"
	desc = "Musical fruit装在不那么musical的容器里."
	icon_state = "beans"
	trash_type = /obj/item/trash/can/food/beans
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/ketchup = 4,
	)
	tastes = list("豆子" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/canned/peaches
	name = "桃子罐头"
	desc = "熟透的桃子在自己的果汁里游动."
	icon_state = "peachcan"
	trash_type = /obj/item/trash/can/food/peaches
	food_reagents = list(
		/datum/reagent/consumable/peachjuice = 20,
		/datum/reagent/consumable/sugar = 8,
		/datum/reagent/consumable/nutriment = 2,
	)
	tastes = list("桃子" = 7, "罐头食品" = 1)
	foodtypes = FRUIT | SUGAR

/obj/item/food/canned/peaches/maint
	name = "管道桃子"
	desc = "人长嘴,就得吃."
	icon_state = "peachcanmaint"
	trash_type = /obj/item/trash/can/food/peaches/maint
	tastes = list("桃子" = 1, "罐头食品" = 7)
	venue_value = FOOD_PRICE_EXOTIC

/obj/item/food/canned/tomatoes
	name = "圣马扎诺番茄罐头"
	desc = "一罐来自意大利南部山区的优质圣马扎诺番茄."
	icon_state = "tomatoescan"
	trash_type = /obj/item/trash/can/food/tomatoes
	food_reagents = list(
		/datum/reagent/consumable/tomatojuice = 20,
		/datum/reagent/consumable/salt = 2,
	)
	tastes = list("番茄" = 7, "罐头食品" = 1)
	foodtypes = VEGETABLES //fuck you, real life!

/obj/item/food/canned/pine_nuts
	name = "松子罐头" // canned pine nuts
	desc = "一小罐松子.可以单独吃，如果你喜欢的话."
	icon_state = "pinenutscan"
	trash_type = /obj/item/trash/can/food/pine_nuts
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("松子" = 1)
	foodtypes = NUTS
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/canned/envirochow
	name = "狗吃狗粮"
	desc = "史上第一种完全可持续的宠物食品，采用古代英国畜牧业技术."
	icon_state = "envirochow"
	trash_type = /obj/item/trash/can/food/envirochow
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("狗粮" = 5, "狗肉" = 3)
	foodtypes = MEAT | GROSS
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/canned/envirochow/attack_animal(mob/living/simple_animal/user, list/modifiers)
	if(!check_buffability(user))
		return ..()
	apply_buff(user)

/obj/item/food/canned/envirochow/attack_basic_mob(mob/living/basic/user, list/modifiers)
	if(!check_buffability(user))
		return ..()
	apply_buff(user)

/obj/item/food/canned/envirochow/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(!proximity_flag)
		return
	if(!check_buffability(target))
		return
	apply_buff(target, user)

///This proc checks if the mob is able to recieve the buff.
/obj/item/food/canned/envirochow/proc/check_buffability(mob/living/hungry_pet)
	if(!isanimal_or_basicmob(hungry_pet)) // Not a pet
		return FALSE
	if(!is_drainable()) // Can is not open
		return FALSE
	if(hungry_pet.stat) // Parrot deceased
		return FALSE
	if(hungry_pet.mob_biotypes & (MOB_BEAST|MOB_REPTILE|MOB_BUG))
		return TRUE
	else
		return FALSE // Humans, robots & spooky ghosts not allowed

///This makes the animal eat the food, and applies the buff status effect to them.
/obj/item/food/canned/envirochow/proc/apply_buff(mob/living/simple_animal/hungry_pet, mob/living/dog_mom)
	hungry_pet.apply_status_effect(/datum/status_effect/limited_buff/health_buff) //the status effect keeps track of the stacks
	hungry_pet.visible_message(
		span_notice("[hungry_pet]狼吞虎咽地吃[src]."),
		span_nicegreen("你狼吞虎咽地吃[src]."),
		span_notice("你听到吃东西的声音."))
	SEND_SIGNAL(src, COMSIG_FOOD_CONSUMED, hungry_pet, dog_mom ? dog_mom : hungry_pet) //If there is no dog mom, we assume the pet fed itself.
	playsound(loc, 'sound/items/eatfood.ogg', rand(30, 50), TRUE)
	qdel(src)

/obj/item/food/canned/squid_ink
	name = "墨汁罐头"
	desc = "鱿鱼墨汁是典型烹饪中一种奇怪的配料，它能给任何菜肴带来大海的味道，同时还能把菜肴染成黑色."
	icon_state = "squidinkcan"
	trash_type = /obj/item/trash/can/food/squid_ink
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/salt = 5)
	tastes = list("海鲜" = 7, "罐头食品" = 1)
	foodtypes = SEAFOOD

/obj/item/food/canned/chap
	name = "CHAP罐头"
	desc = "CHAP: Chopped Ham And Pork-猪肉火腿碎.这种经典的美国肉类罐头产品赢得了世界大战，但却让数百万军人因心肌梗塞而回家。"
	icon_state = "chapcan"
	trash_type = /obj/item/trash/can/food/chap
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/salt = 5)
	tastes = list("肉" = 7, "罐头食品" = 1)
	foodtypes = MEAT

/obj/item/food/canned/chap/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/chapslice, 5, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/chapslice
	name = "午餐肉片"
	desc = "用于煎炸或做三明治."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chapslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	tastes = list("肉" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/chapslice/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/grilled_chapslice, rand(20 SECONDS, 40 SECONDS), TRUE, TRUE)

/obj/item/food/grilled_chapslice
	name = "煎午餐肉片"
	desc = "一片油腻的热午餐肉片，是均衡膳食的重要组成部分."
	icon = 'icons/obj/food/martian.dmi'
	icon_state = "chapslice_grilled"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 3
	)
	tastes = list("肉" = 1)
	foodtypes = MEAT
	w_class = WEIGHT_CLASS_SMALL

// DONK DINNER: THE INNOVATIVE WAY TO GET YOUR DAILY RECOMMENDED ALLOWANCE OF SALT... AND THEN SOME!
/obj/item/food/ready_donk
	name = "\improper Donk快捷餐:尊贵单身速食" // Ready-Donk: Bachelor Chow
	desc = "一顿带着美味的Donk快捷晚餐!"
	icon_state = "ready_donk"
	trash_type = /obj/item/trash/ready_donk
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("食物?" = 2, "速食食品" = 1)
	foodtypes = MEAT | JUNKFOOD
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL

	/// What type of ready-donk are we warmed into?
	var/warm_type = /obj/item/food/ready_donk/warm

	/// What reagents should be added when this item is warmed?
	var/static/list/added_reagents = list(/datum/reagent/medicine/omnizine = 3)

/obj/item/food/ready_donk/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE, added_reagents)

/obj/item/food/ready_donk/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, added_reagents)

/obj/item/food/ready_donk/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>你浏览盒子的背面……</i>")
	. += "\t[span_info("Donk快捷餐: Donk Co的产品.")]"
	. += "\t[span_info("加热方法:打开包装盒,刺穿薄膜,放入微波炉高温加热2分钟。在吃之前静置60秒,以防止烫伤。")]"
	. += "\t[span_info("每200克含有:8克钠,25克脂肪(其中22克是饱和脂肪),2克糖.")]"
	return .

/obj/item/food/ready_donk/warm
	name = "温Donk快捷餐:尊贵单身速食"
	desc = "一顿带着美味还热乎的Donk快捷晚餐!"
	icon_state = "ready_donk_warm"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/medicine/omnizine = 3,
	)
	tastes = list("食物?" = 2, "速食食品" = 1)

	// Don't burn your warn ready donks.
	warm_type = /obj/item/food/badrecipe

/obj/item/food/ready_donk/mac_n_cheese
	name = "\improper Donk快捷餐:橙爽通心粉"
	desc = "霓虹橙味芝士通心粉，几秒搞定!"
	tastes = list("芝士通心粉" = 2, "速食食品" = 1)
	foodtypes = GRAIN | DAIRY | JUNKFOOD

	warm_type = /obj/item/food/ready_donk/warm/mac_n_cheese

/obj/item/food/ready_donk/warm/mac_n_cheese
	name = "温Donk快捷餐:橙爽通心粉"
	desc = "霓虹橙味芝士通心粉，几秒搞定!"
	icon_state = "ready_donk_warm_mac"
	tastes = list("芝士通心粉" = 2, "速食食品" = 1)
	foodtypes = GRAIN | DAIRY | JUNKFOOD

/obj/item/food/ready_donk/donkhiladas
	name = "\improper Donk快捷餐:唐琪拉达"
	desc = "Donk Co的招牌美食配Donk酱,只为还原'正宗'墨西哥风味."
	tastes = list("安琪拉达" = 2, "速食食品" = 1)
	foodtypes = GRAIN | DAIRY | MEAT | VEGETABLES | JUNKFOOD

	warm_type = /obj/item/food/ready_donk/warm/donkhiladas

/obj/item/food/ready_donk/warm/donkhiladas
	name = "温Donk快捷餐:唐琪拉达"
	desc = "Donk Co的招牌美食配Donk酱,只为还原'正宗'墨西哥风味."
	icon_state = "ready_donk_warm_mex"
	tastes = list("安琪拉达" = 2, "速食食品" = 1)
	foodtypes = GRAIN | DAIRY | MEAT | VEGETABLES | JUNKFOOD

/obj/item/food/ready_donk/nachos_grandes //which translates to... big nachos
	name = "\improper Donk快捷餐: Donk Sol Series Boritos Nachos Grandes"
	desc = "与Donk Sol系列的经典经典玉米片共享赛事,不仅有奶酪,辣肉与豆子,还有鳄梨酱,皮可酱与Donk酱!"
	tastes = list("玉米片" = 2, "速食食品" = 1)
	foodtypes = GRAIN | DAIRY | MEAT | VEGETABLES | JUNKFOOD

	warm_type = /obj/item/food/ready_donk/warm/nachos_grandes

/obj/item/food/ready_donk/warm/nachos_grandes
	name = "温Donk快捷餐: Donk Sol Series Boritos Nachos Grandes"
	desc = "与Donk Sol系列的经典经典玉米片共享赛事,不仅有奶酪,辣肉与豆子,还有鳄梨酱,皮可酱与Donk酱!"
	icon_state = "ready_donk_warm_nachos"
	tastes = list("玉米片" = 2, "速食食品" = 1)
	foodtypes = GRAIN | DAIRY | MEAT | VEGETABLES | JUNKFOOD

/obj/item/food/ready_donk/donkrange_chicken
	name = "\improper Donk快捷餐: Donk鸡"
	desc = "这是一道经典的中餐，由Donk独创的橙子鸡加上炒辣椒和洋葱，再配上白米饭。"
	tastes = list("橙子鸡" = 2, "速食食品" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES | JUNKFOOD

	warm_type = /obj/item/food/ready_donk/warm/donkrange_chicken

/obj/item/food/ready_donk/warm/donkrange_chicken
	name = "温Donk快捷餐: Donk鸡"
	desc = "这是一道经典的中餐，由Donk独创的橙子鸡加上炒辣椒和洋葱，再配上白米饭。"
	icon_state = "ready_donk_warm_orange"
	tastes = list("橙子鸡" = 2, "速食食品" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES | JUNKFOOD

// Rations
/obj/item/food/rationpack
	name = "口粮包"
	desc = "一个方形的巧克力棒,起码看起来像巧克力,包装在一个普通的灰色包装纸里,能以挡子弹的方式救士兵一命。"
	icon_state = "rationpack"
	bite_consumption = 3
	junkiness = 15
	tastes = list("硬纸板" = 3, "悲伤往事" = 3)
	foodtypes = null //Don't ask what went into them. You're better off not knowing.
	food_reagents = list(
		/datum/reagent/consumable/nutriment/stabilized = 10,
		/datum/reagent/consumable/nutriment = 2,
	) //Won't make you fat. Will make you question your sanity.

///Override for checkliked callback
/obj/item/food/rationpack/make_edible()
	. = ..()
	AddComponent(/datum/component/edible, check_liked = CALLBACK(src, PROC_REF(check_liked)))

/obj/item/food/rationpack/proc/check_liked(mob/mob) //Nobody likes rationpacks. Nobody.
	return FOOD_DISLIKED
