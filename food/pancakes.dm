#define PANCAKE_MAX_STACK 10

/obj/item/food/pancakes
	name = "煎饼"
	desc = "松软的煎饼,比华夫饼更柔软."
	icon_state = "pancakes_1"
	inhand_icon_state = null
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("煎饼" = 1)
	foodtypes = GRAIN | SUGAR | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	///Used as a base name while generating the icon states when stacked
	var/stack_name = "煎饼"
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pancakes/raw
	name = "黏糊的煎饼"
	desc = "一个几乎没弄熟的煎饼,它渴望着煎锅."
	icon_state = "rawpancakes_1"
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/vitamin = 1)
	tastes = list("奶油面糊" = 1)
	stack_name = "生煎饼"
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/pancakes/raw/make_grillable()
	AddComponent(/datum/component/grillable,\
				cook_result = /obj/item/food/pancakes,\
				required_cook_time = rand(30 SECONDS, 40 SECONDS),\
				positive_result = TRUE,\
				use_large_steam_sprite = TRUE)

/obj/item/food/pancakes/raw/attackby(obj/item/garnish, mob/living/user, params)
	var/newresult
	if(istype(garnish, /obj/item/food/grown/berries))
		newresult = /obj/item/food/pancakes/blueberry
		name = "生蓝莓煎饼"
		icon_state = "rawbbpancakes_1"
		stack_name = "生煎饼"
	else if(istype(garnish, /obj/item/food/chocolatebar))
		newresult = /obj/item/food/pancakes/chocolatechip
		name = "生巧克力煎饼"
		icon_state = "rawccpancakes_1"
		stack_name = "生煎饼"
		return ..()
	if(newresult)
		qdel(garnish)
		to_chat(user, span_notice("你添加[garnish]到[src]上."))
		AddComponent(/datum/component/grillable, cook_result = newresult)

/obj/item/food/pancakes/raw/examine(mob/user)
	. = ..()
	if(name == initial(name))
		. += "<span class='notice'>在未煎好前你可以通过添加 <b>蓝莓</b> 或者 <b>巧克力</b> 来改变煎饼."

/obj/item/food/pancakes/blueberry
	name = "蓝莓煎饼"
	desc = "松软美味的蓝莓煎饼。"
	icon_state = "bbpancakes_1"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("煎饼" = 1, "蓝莓" = 1)
	stack_name = "bbpancakes"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pancakes/chocolatechip
	name = "巧克力煎饼"
	desc = "松软可口的巧克力薄饼."
	icon_state = "ccpancakes_1"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("煎饼" = 1, "巧克力" = 1)
	stack_name = "ccpancakes"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pancakes/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/food/pancakes/update_name()
	name = contents.len ? "煎饼堆" : initial(name)
	return ..()

/obj/item/food/pancakes/update_icon(updates = ALL)
	if(!(updates & UPDATE_OVERLAYS))
		return ..()

	updates &= ~UPDATE_OVERLAYS
	. = ..() // Don't update overlays. We're doing that here

	if(contents.len < LAZYLEN(overlays))
		overlays -= overlays[overlays.len]
	. |= UPDATE_OVERLAYS

/obj/item/food/pancakes/examine(mob/user)
	var/ingredients_listed = ""
	var/pancakeCount = contents.len
	switch(pancakeCount)
		if(0)
			desc = initial(desc)
		if(1 to 2)
			desc = "一个松软的煎饼堆."
		if(3 to 6)
			desc = "一大堆松软的煎饼！!"
		if(7 to 9)
			desc = "像塔一样的松软美味的煎饼堆!"
		if(PANCAKE_MAX_STACK to INFINITY)
			desc = "松软可口的煎饼堆成的巨大之塔,看起来随时会倒!"
	. = ..()
	if (pancakeCount)
		for(var/obj/item/food/pancakes/ING in contents)
			ingredients_listed += "[ING.name], "
		. += "它包含着 [contents.len?"[ingredients_listed]":"没有成分, "]在 [initial(name)] 之上."

/obj/item/food/pancakes/attackby(obj/item/item, mob/living/user, params)
	if(istype(item, /obj/item/food/pancakes))
		var/obj/item/food/pancakes/pancake = item
		if((contents.len >= PANCAKE_MAX_STACK) || ((pancake.contents.len + contents.len) > PANCAKE_MAX_STACK))
			to_chat(user, span_warning("我不能向 [src] 添加这么多的煎饼!"))
		else
			if(!user.transferItemToLoc(pancake, src))
				return
			to_chat(user, span_notice("你添加了 [pancake] 在 [src] 上."))
			pancake.name = initial(pancake.name)
			contents += pancake
			update_snack_overlays(pancake)
			if (pancake.contents.len)
				for(var/pancake_content in pancake.contents)
					pancake = pancake_content
					pancake.name = initial(pancake.name)
					contents += pancake
					update_snack_overlays(pancake)
			pancake = item
			pancake.contents.Cut()
		return
	else if(contents.len)
		var/obj/O = contents[contents.len]
		return O.attackby(item, user, params)
	..()

/obj/item/food/pancakes/proc/update_snack_overlays(obj/item/food/pancakes/pancake)
	var/mutable_appearance/pancake_visual = mutable_appearance(icon, "[pancake.stack_name]_[rand(1, 3)]")
	pancake_visual.pixel_x = rand(-1, 1)
	pancake_visual.pixel_y = 3 * contents.len - 1
	pancake_visual.layer = layer + (contents.len * 0.01)
	add_overlay(pancake_visual)
	update_appearance()

/obj/item/food/pancakes/attack(mob/target, mob/living/user, params, stacked = TRUE)
	if(user.combat_mode || !contents.len || !stacked)
		return ..()
	var/obj/item/item = contents[contents.len]
	. = item.attack(target, user, params, FALSE)
	update_appearance()

#undef PANCAKE_MAX_STACK
