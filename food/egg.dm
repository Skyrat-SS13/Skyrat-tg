
////////////////////////////////////////////EGGS////////////////////////////////////////////

/obj/item/food/chocolateegg
	name = "巧克力蛋"
	desc = "这种又甜又肥的食物."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "chocolateegg"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/coco = 2, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("巧克力" = 4, "甜腻" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_2

/// 计数器通过投掷鸡蛋孵化小鸡的数量，minecraft风格。如果这个值超过max_chicks的定义，小鸡将不会从扔的鸡蛋中出现。
/// Counter for number of chicks hatched by throwing eggs, minecraft style. Chicks will not emerge from thrown eggs if this value exceeds the MAX_CHICKENS define.
GLOBAL_VAR_INIT(chicks_from_eggs, 0)

/obj/item/food/egg
	name = "鸡蛋"
	desc = "一个鸡蛋!"
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "egg"
	inhand_icon_state = "egg"
	food_reagents = list(/datum/reagent/consumable/eggyolk = 2, /datum/reagent/consumable/eggwhite = 4)
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_TINY
	ant_attracting = FALSE
	decomp_type = /obj/item/food/egg/rotten
	decomp_req_handle = TRUE //so laid eggs can actually become chickens 所以下的蛋可以变成鸡
	/// How likely is it that a chicken will come out of here if we throw it?
	/// 如果我们把一只鸡扔出去，它飞出来的可能性有多大?
	var/chick_throw_prob = 13

/obj/item/food/egg/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/boiledegg, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/egg/make_microwaveable()
	AddElement(/datum/element/microwavable, /obj/item/food/boiledegg)

/obj/item/food/egg/organic
	name = "土鸡蛋"
	desc = "100%纯天然鸡蛋,产自最好的母鸡."
	starting_reagent_purity = 1

/obj/item/food/egg/rotten
	food_reagents = list(/datum/reagent/consumable/eggrot = 10, /datum/reagent/consumable/mold = 10)
	foodtypes = GROSS
	preserved_food = TRUE

/obj/item/food/egg/rotten/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/boiledegg/rotten, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/egg/rotten/make_microwaveable()
	AddElement(/datum/element/microwavable, /obj/item/food/boiledegg/rotten)

/obj/item/food/egg/gland
	desc = "一个鸡蛋!看起来很奇怪……"

/obj/item/food/egg/gland/Initialize(mapload)
	. = ..()
	reagents.add_reagent(get_random_reagent_id(), 15)

	var/color = mix_color_from_reagents(reagents.reagent_list)
	add_atom_colour(color, FIXED_COLOUR_PRIORITY)

/obj/item/food/egg/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if (..()) // was it caught by a mob? 它被mob抓住了吗?
		return

	var/turf/hit_turf = get_turf(hit_atom)
	new /obj/effect/decal/cleanable/food/egg_smudge(hit_turf)
	if (prob(chick_throw_prob))
		spawn_impact_chick(hit_turf)
	reagents.expose(hit_atom, TOUCH)
	qdel(src)

/// Spawn a baby chicken from throwing an egg 从扔鸡蛋中孵出小鸡
/obj/item/food/egg/proc/spawn_impact_chick(turf/spawn_turf)
	var/chickens_remaining = MAX_CHICKENS - GLOB.chicks_from_eggs
	if (chickens_remaining < 1)
		return
	var/spawned_chickens = prob(97) ? 1 : min(4, chickens_remaining) // We don't want to go over the limit 我们不想超过限额
	if (spawned_chickens > 1) // Chicken jackpot! 鸡大奖!
		visible_message(span_notice("[spawned_chickens] 小鸡从蛋里面出来了,中大奖了!"))
	else
		visible_message(span_notice("一只小鸡从破蛋里钻出来!"))
	for(var/i in 1 to spawned_chickens)
		new /mob/living/basic/chick(spawn_turf)
		GLOB.chicks_from_eggs++

/obj/item/food/egg/attackby(obj/item/item, mob/user, params)
	if(istype(item, /obj/item/toy/crayon))
		var/obj/item/toy/crayon/crayon = item
		var/clr = crayon.crayon_color

		if(!(clr in list("blue", "green", "mime", "orange", "purple", "rainbow", "red", "yellow")))
			to_chat(usr, span_notice("[src] 拒绝这种颜色!"))
			return

		to_chat(usr, span_notice("你用 [item] 给 [src] 上色."))
		icon_state = "egg-[clr]"

	else if(istype(item, /obj/item/stamp/clown))
		var/clowntype = pick("grock", "grimaldi", "rainbow", "chaos", "joker", "sexy", "standard", "bobble",
			"krusty", "bozo", "pennywise", "ronald", "jacobs", "kelly", "popov", "cluwne")
		icon_state = "egg-clown-[clowntype]"
		desc = "小丑蛋是一种被装饰成小丑脸的奇形怪状的蛋. "
		to_chat(usr, span_notice("你用 [item] 给 [src] 印上,创造出一种艺术的,不那么恐怖的小丑妆容."))

	else if(is_reagent_container(item))
		var/obj/item/reagent_containers/dunk_test_container = item
		if (!dunk_test_container.is_drainable() || !dunk_test_container.reagents.has_reagent(/datum/reagent/water))
			return

		to_chat(user, span_notice("你检查 [src] 是否坏了."))
		if(istype(src, /obj/item/food/egg/rotten))
			to_chat(user, span_warning("[src] 在 [dunk_test_container] 中浮动!"))
		else
			to_chat(user, span_notice("[src] 沉入 [dunk_test_container]!"))
	else
		..()

/obj/item/food/egg/afterattack_secondary(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(!istype(target, /obj/machinery/griddle))
		return SECONDARY_ATTACK_CALL_NORMAL

	var/atom/broken_egg = new /obj/item/food/rawegg(target.loc)
	broken_egg.pixel_x = pixel_x
	broken_egg.pixel_y = pixel_y
	playsound(get_turf(user), 'sound/items/sheath.ogg', 40, TRUE)
	reagents.copy_to(broken_egg,reagents.total_volume)

	var/obj/machinery/griddle/hit_griddle = target
	hit_griddle.AddToGrill(broken_egg, user)
	target.balloon_alert(user, "[src]裂开")

	qdel(src)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/item/food/egg/blue
	icon_state = "egg-blue"
	inhand_icon_state = "egg-blue"
/obj/item/food/egg/green
	icon_state = "egg-green"
	inhand_icon_state = "egg-green"
/obj/item/food/egg/mime
	icon_state = "egg-mime"
	inhand_icon_state = "egg-mime"
/obj/item/food/egg/orange
	icon_state = "egg-orange"
	inhand_icon_state = "egg-orange"

/obj/item/food/egg/purple
	icon_state = "egg-purple"
	inhand_icon_state = "egg-purple"

/obj/item/food/egg/rainbow
	icon_state = "egg-rainbow"
	inhand_icon_state = "egg-rainbow"

/obj/item/food/egg/red
	icon_state = "egg-red"
	inhand_icon_state = "egg-red"

/obj/item/food/egg/yellow
	icon_state = "egg-yellow"
	inhand_icon_state = "egg-yellow"

/obj/item/food/egg/penguin_egg
	icon = 'icons/mob/simple/penguins.dmi'
	icon_state = "penguin_egg"

/obj/item/food/egg/fertile
	name = "受精蛋"
	desc = "一个看起来已经受精了的蛋.\nQuite how you can tell this just by looking at it is a mystery."
	chick_throw_prob = 100

/obj/item/food/egg/fertile/Initialize(mapload, loc)
	. = ..()

	AddComponent(/datum/component/fertile_egg,\
		embryo_type = /mob/living/basic/chick,\
		minimum_growth_rate = 1,\
		maximum_growth_rate = 2,\
		total_growth_required = 200,\
		current_growth = 0,\
		location_allowlist = typecacheof(list(/turf)),\
		spoilable = FALSE,\
	)

/obj/item/food/friedegg
	name = "煎蛋"
	desc = "一个煎蛋.加一点盐和胡椒粉会不会更好."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "friedegg"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/eggyolk = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	bite_consumption = 1
	tastes = list("蛋" = 4)
	foodtypes = MEAT | FRIED | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/rawegg
	name = "生鸡蛋"
	desc = "据说对你有好处,如果你能忍受生吃的话.最好煎一下."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "rawegg"
	food_reagents = list() //Recieves all reagents from its whole egg counterpart
	bite_consumption = 1
	tastes = list("生鸡蛋" = 6, "滑溜溜" = 1)
	eatverbs = list("gulp down")
	foodtypes = MEAT | RAW
	w_class = WEIGHT_CLASS_SMALL

/obj/item/food/rawegg/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/friedegg, rand(20 SECONDS, 35 SECONDS), TRUE, FALSE)

/obj/item/food/boiledegg
	name = "煮鸡蛋"
	desc = "煮熟的鸡蛋."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "egg"
	inhand_icon_state = "egg"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("煮蛋" = 1)
	foodtypes = MEAT | BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	ant_attracting = FALSE
	decomp_type = /obj/item/food/boiledegg/rotten
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/eggsausage
	name = "香肠煎蛋"
	desc = "一个鸡蛋配上香肠."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "eggsausage"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 8, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/consumable/nutriment = 4)
	foodtypes = MEAT | FRIED | BREAKFAST
	tastes = list("煎蛋" = 4, "香肠" = 4)
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/boiledegg/rotten
	food_reagents = list(/datum/reagent/consumable/eggrot = 10)
	tastes = list("臭鸡蛋" = 1)
	foodtypes = GROSS
	preserved_food = TRUE

/obj/item/food/omelette //FUCK THIS
	name = "奶酪煎蛋卷"
	desc = "这就是你所能言明的一切!"
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "omelette"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	bite_consumption = 1
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("鸡蛋" = 1, "奶酪" = 1)
	foodtypes = MEAT | BREAKFAST | DAIRY
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/omelette/attackby(obj/item/item, mob/user, params)
	if(istype(item, /obj/item/kitchen/fork))
		var/obj/item/kitchen/fork/fork = item
		if(fork.forkload)
			to_chat(user, span_warning("你的叉子上已经有煎蛋卷了!"))
		else
			fork.icon_state = "forkloaded"
			user.visible_message(span_notice("[user] 用叉子叉起了一个煎蛋卷!"), \
				span_notice("你用叉子叉起一块煎蛋卷."))

			var/datum/reagent/reagent = pick(reagents.reagent_list)
			reagents.remove_reagent(reagent.type, 1)
			fork.forkload = reagent
			if(reagents.total_volume <= 0)
				qdel(src)
		return
	..()

/obj/item/food/benedict
	name = "班尼迪克蛋"
	desc = "这上面只有一个鸡蛋,真不像话."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "benedict"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
		/datum/reagent/consumable/nutriment = 3,
	)
	w_class = WEIGHT_CLASS_SMALL
	tastes = list("鸡蛋" = 1, "培根" = 1, "圆面包" = 1)
	foodtypes = MEAT | BREAKFAST | GRAIN
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/eggwrap
	name = "鸡蛋卷"
	desc = "'毛毯里的猪'的前身."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "eggwrap"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("鸡蛋" = 1)
	foodtypes = MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/chawanmushi
	name = "日式蒸蛋"
	desc = "传说中的蒸蛋能化敌为友,但对猫来说可能太热了."
	icon = 'icons/obj/food/egg.dmi'
	icon_state = "chawanmushi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("蒸蛋" = 1)
	foodtypes = MEAT | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3
