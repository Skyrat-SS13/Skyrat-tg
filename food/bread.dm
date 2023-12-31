
/// Abstract parent object for bread items. Should not be made obtainable in game.
/// 面包项的抽象父对象。不应该在游戏中获得。
/obj/item/food/bread
	name = "bread?"
	desc = "You shouldn't see this, call the coders."
	icon = 'icons/obj/food/burgerbread.dmi'
	max_volume = 80
	tastes = list("bread" = 10)
	foodtypes = GRAIN
	eat_time = 3 SECONDS
	crafting_complexity = FOOD_COMPLEXITY_2
	/// type is spawned 5 at a time and replaces this bread loaf when processed by cutting tool
	/// Type每次生成5个，并在被切时替换此面包条
	var/obj/item/food/breadslice/slice_type
	/// so that the yield can change if it isnt 5
	/// 如果不是5，(营养)收益率会改变
	var/yield = 5

/obj/item/food/bread/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)
	AddComponent(/datum/component/food_storage)

/obj/item/food/bread/make_processable()
	if (slice_type)
		AddElement(/datum/element/processable, TOOL_KNIFE, slice_type, yield, 3 SECONDS, table_required = TRUE, screentip_verb = "Slice")
		AddElement(/datum/element/processable, TOOL_SAW, slice_type, yield, 4 SECONDS, table_required = TRUE, screentip_verb = "Slice")

// Abstract parent object for sliced bread items. Should not be made obtainable in game.
// 面包片的抽象父对象.不应该在游戏中获得
/obj/item/food/breadslice
	name = "breadslice?"
	desc = "You shouldn't see this, call the coders."
	icon = 'icons/obj/food/burgerbread.dmi'
	foodtypes = GRAIN
	food_flags = FOOD_FINGER_FOOD
	eat_time = 0.5 SECONDS
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/breadslice/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, 10)

/obj/item/food/bread/plain
	name = "面包"
	desc = "一些朴素的面包."
	icon_state = "bread"
	food_reagents = list(/datum/reagent/consumable/nutriment = 10)
	tastes = list("面包" = 10)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/breadslice/plain
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/bread/plain/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, /obj/item/food/bread/empty, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 8)

/obj/item/food/breadslice/plain
	name = "面包片"
	desc = "家的一片."
	icon_state = "breadslice"
	foodtypes = GRAIN
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	venue_value = FOOD_PRICE_TRASH
	decomp_type = /obj/item/food/breadslice/moldy
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/breadslice/plain/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, null, CUSTOM_INGREDIENT_ICON_STACK)

/obj/item/food/breadslice/plain/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/griddle_toast, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)

/obj/item/food/breadslice/moldy
	name = "发霉面包片"
	desc = "整个电视台都在争论这道菜是否还好吃。"
	icon_state = "moldybreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/mold = 10,
	)
	tastes = list("腐烂的真菌" = 1)
	foodtypes = GROSS
	preserved_food = TRUE
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/breadslice/moldy/bacteria
	name = "富含细菌的发霉面包片"
	desc = "某种东西(可能是死灵酵母)导致这种面包以一种可怕的无生命状态发酵.最好找牧师和火焰喷射器处理它."

/obj/item/food/breadslice/moldy/bacteria/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_MOLD, CELL_VIRUS_TABLE_GENERIC, rand(2, 4), 25)

/obj/item/food/bread/meat
	name = "肉面包"
	desc = "每个小BEE的烹饪基础."
	icon_state = "meatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 12,
	)
	tastes = list("面包" = 10, "肉" = 10)
	foodtypes = GRAIN | MEAT
	venue_value = FOOD_PRICE_CHEAP
	slice_type = /obj/item/food/breadslice/meat
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/breadslice/meat
	name = "肉面包片"
	desc = "一片美味的肉面包."
	icon_state = "meatbreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2.4,
	)
	tastes = list("面包" = 1, "肉" = 1)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/sausage
	name = "香肠面包"
	desc = "不要想太多."
	icon_state = "sausagebread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 12,
	)
	tastes = list("面包" = 10, "肉" = 10)
	foodtypes = GRAIN | MEAT
	slice_type = /obj/item/food/breadslice/sausage
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/breadslice/sausage
	name = "香肠面包片"
	desc = "一片美味的香肠面包."
	icon_state = "sausagebreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2.4,
	)
	tastes = list("面包" = 10, "肉" = 10)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/xenomeat
	name = "异形肉面包"
	desc = "小BEE的烹饪基础,外加一点强健要素."
	icon_state = "xenomeatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 15,
	)
	tastes = list("面包" = 10, "酸液" = 10)
	foodtypes = GRAIN | MEAT
	slice_type = /obj/item/food/breadslice/xenomeat
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/breadslice/xenomeat
	name = "异形肉面包片"
	desc = "一片美味的异形肉面包."
	icon_state = "xenobreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 3,
	)
	tastes = list("面包" = 10, "酸液" = 10)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/spidermeat
	name = "蜘蛛肉面包"
	desc = "由蜘蛛肉做成的绿色天然食品."
	icon_state = "spidermeatbread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/toxin = 15,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 12,
	)
	tastes = list("面包" = 10, "蛛网" = 5)
	foodtypes = GRAIN | MEAT | TOXIC
	slice_type = /obj/item/food/breadslice/spidermeat
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/breadslice/spidermeat
	name = "蜘蛛肉面包片"
	desc = "一块肉卷,是由一种很可能还想置你于死地的动物做成的."
	icon_state = "spidermeatslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/toxin = 3,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("面包" = 10, "蛛网" = 5)
	foodtypes = GRAIN | MEAT | TOXIC
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/banana
	name = "奶油香蕉坚果面包"
	desc = "这是一种天堂般的丰盛享受."
	icon_state = "bananabread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/banana = 20,
	)
	tastes = list("面包" = 10) // bananjuice will also flavour
	foodtypes = GRAIN | FRUIT
	slice_type = /obj/item/food/breadslice/banana
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/breadslice/banana
	name = "奶油香蕉坚果面包片"
	desc = "这是一片美味的奶油香蕉坚果面包."
	icon_state = "bananabreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/banana = 4,
	)
	tastes = list("面包" = 10)
	foodtypes = GRAIN | FRUIT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/tofu
	name = "豆腐面包"
	desc = "像肉面包一样，但适合素食者."
	icon_state = "tofubread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 10,
	)
	tastes = list("面包" = 10, "豆腐" = 10)
	foodtypes = GRAIN | VEGETABLES
	venue_value = FOOD_PRICE_TRASH
	slice_type = /obj/item/food/breadslice/tofu
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/breadslice/tofu
	name = "豆腐面包片"
	desc = "出神入化的刀工."
	icon_state = "tofubreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("面包" = 10, "豆腐" = 10)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/creamcheese
	name = "奶油芝士面包"
	desc = "好吃好吃好吃!"
	icon_state = "creamcheesebread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("面包" = 10, "芝士" = 10)
	foodtypes = GRAIN | DAIRY
	slice_type = /obj/item/food/breadslice/creamcheese

/obj/item/food/breadslice/creamcheese
	name = "奶油芝士面包片"
	desc = "一整片的好吃!"
	icon_state = "creamcheesebreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("面包" = 10, "芝士" = 10)
	foodtypes = GRAIN | DAIRY

/obj/item/food/bread/mimana
	name = "默蕉面包"
	desc = "食不言,寝不语."
	icon_state = "mimanabread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/toxin/mutetoxin = 5,
		/datum/reagent/consumable/nothing = 5,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("面包" = 10, "沉默" = 10)
	foodtypes = GRAIN | FRUIT
	slice_type = /obj/item/food/breadslice/mimana
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/breadslice/mimana
	name = "默蕉面包"
	desc = "一整片的沉默!"
	icon_state = "mimanabreadslice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/toxin/mutetoxin = 1,
		/datum/reagent/consumable/nothing = 1,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("面包" = 10, "沉默" = 10)
	foodtypes = GRAIN | FRUIT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/bread/empty
	name = "面包"
	icon_state = "tofubread"
	desc = "这是一块面包,装点着你最疯狂的梦."
	slice_type = /obj/item/food/breadslice/empty

// What you get from cutting a custom bread. Different from custom sliced bread.
/obj/item/food/breadslice/empty
	name = "面包片"
	icon_state = "tofubreadslice"
	foodtypes = GRAIN
	desc = "这是一片面包片,装点着你最疯狂的梦."

/obj/item/food/breadslice/empty/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, null, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 8)

/obj/item/food/baguette
	name = "法棍面包"
	desc = "Bon appetit!"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "baguette"
	inhand_icon_state = null
	worn_icon_state = "baguette"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	bite_consumption = 3
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	attack_verb_continuous = list("touche's")
	attack_verb_simple = list("touche")
	tastes = list("面包" = 1)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2
	/// whether this is in fake swordplay mode or not
	var/fake_swordplay = FALSE

/obj/item/food/baguette/Initialize(mapload)
	. = ..()
	register_context()

/obj/item/food/baguette/add_context(atom/source, list/context, obj/item/held_item, mob/user)
	. = ..()
	if(HAS_MIND_TRAIT(user, TRAIT_MIMING) && held_item == src)
		context[SCREENTIP_CONTEXT_LMB] = "开启剑斗模式"
		return CONTEXTUAL_SCREENTIP_SET

/obj/item/food/baguette/examine(mob/user)
	. = ..()
	if(HAS_MIND_TRAIT(user, TRAIT_MIMING))
		. += span_notice("你可以把它像剑一样握在手里.")

/obj/item/food/baguette/attack_self(mob/user, modifiers)
	. = ..()
	if(!HAS_MIND_TRAIT(user, TRAIT_MIMING))
		return
	if(fake_swordplay)
		end_swordplay(user)
	else
		begin_swordplay(user)

/obj/item/food/baguette/proc/begin_swordplay(mob/user)
	visible_message(
		span_notice("[user] 像握剑一样握住了 [src] !"),
		span_notice("你像握剑一样握住了 [src] , 手牢牢地抓着底部仿佛那就是剑柄一样.")
	)
	ADD_TRAIT(src, TRAIT_CUSTOM_TAP_SOUND, SWORDPLAY_TRAIT)
	attack_verb_continuous = list("劈", "砍")
	attack_verb_simple = list("劈", "砍")
	hitsound = 'sound/weapons/rapierhit.ogg'
	fake_swordplay = TRUE

	RegisterSignal(src, COMSIG_ITEM_EQUIPPED, PROC_REF(on_sword_equipped))
	RegisterSignal(src, COMSIG_ITEM_DROPPED, PROC_REF(on_sword_dropped))

/obj/item/food/baguette/proc/end_swordplay(mob/user)
	UnregisterSignal(src, list(COMSIG_ITEM_EQUIPPED, COMSIG_ITEM_DROPPED))

	REMOVE_TRAIT(src, TRAIT_CUSTOM_TAP_SOUND, SWORDPLAY_TRAIT)
	attack_verb_continuous = initial(attack_verb_continuous)
	attack_verb_simple = initial(attack_verb_simple)
	hitsound = initial(hitsound)
	fake_swordplay = FALSE

	if(user)
		visible_message(
			span_notice("[user] 不再像握剑一样握着 [src] !"),
			span_notice("你回到了正常拿着 [src] 的状态.")
		)

/obj/item/food/baguette/proc/on_sword_dropped(datum/source, mob/user)
	SIGNAL_HANDLER

	end_swordplay()

/obj/item/food/baguette/proc/on_sword_equipped(datum/source, mob/equipper, slot)
	SIGNAL_HANDLER

	if(!(slot & ITEM_SLOT_HANDS))
		end_swordplay()

/// Deadly bread used by a mime
/obj/item/food/baguette/combat
	block_sound = 'sound/weapons/parry.ogg'
	sharpness = SHARP_EDGED
	/// Force when wielded as a sword by a mime
	var/active_force = 20
	/// Block chance when wielded as a sword by a mime
	var/active_block = 50

/obj/item/food/baguette/combat/begin_swordplay(mob/user)
	. = ..()
	force = active_force
	block_chance = active_block

/obj/item/food/baguette/combat/end_swordplay(mob/user)
	. = ..()
	force = initial(force)
	block_chance = initial(block_chance)

/obj/item/food/garlicbread
	name = "蒜蓉面包"
	desc = "唉,它是有限的."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "garlicbread"
	inhand_icon_state = null
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/garlic = 2,
	)
	bite_consumption = 3
	tastes = list("面包" = 1, "蒜香" = 1, "黄油" = 1)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/butterbiscuit
	name = "奶油饼干"
	desc = "给我的饼干涂上黄油!"
	icon = 'icons/obj/food/food.dmi'
	icon_state = "butterbiscuit"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("黄油" = 1, "饼干" = 1)
	foodtypes = GRAIN | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/butterdog
	name = "黄狗"
	desc = "由异国黄油制成."
	icon = 'icons/obj/food/food.dmi'
	icon_state = "butterdog"
	bite_consumption = 1
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("黄油" = 1, "异国情调的黄油" = 1)
	foodtypes = GRAIN | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/butterdog/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/slippery, 8 SECONDS)

/obj/item/food/raw_frenchtoast
	name = "生法式吐司"
	desc = "面包片浸泡在打好的鸡蛋液中,它放在煎锅上开始烹饪!"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "raw_frenchtoast"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("生鸡蛋" = 2, "浸液面包" = 1)
	foodtypes = GRAIN | RAW | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/raw_frenchtoast/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/frenchtoast, rand(20 SECONDS, 30 SECONDS), TRUE)

/obj/item/food/frenchtoast
	name = "法式吐司"
	desc = "面包片在鸡蛋液中浸泡并烤至金黄色后淋上糖浆!"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "frenchtoast"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("法式吐司" = 1, "糖浆" = 1, "酥脆金边" = 1)
	foodtypes = GRAIN | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/raw_breadstick
	name = "生长面包"
	desc = "长面包形状的生面团."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "raw_breadstick"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("生面团" = 1)
	foodtypes = GRAIN | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_breadstick/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/breadstick, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/breadstick
	name = "长面包"
	desc = "美味的黄油面包棒.很容易上瘾,但是很值得."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "breadstick"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("松软的面包" = 1, "黄油" = 2)
	foodtypes = GRAIN | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/raw_croissant
	name = "生羊角面包"
	desc = "包好的面团,准备烘烤成羊角面包."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "raw_croissant"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("生面团" = 1)
	foodtypes = GRAIN | DAIRY
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/raw_croissant/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/croissant, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/croissant
	name = "羊角面包"
	desc = "美味的黄油牛角面包,美好的一天从这里开始."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "croissant"
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("松软的面包" = 1, "黄油" = 2)
	foodtypes = GRAIN | DAIRY | BREAKFAST
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

// Enhanced weaponised bread
// 强化武器化面包
/obj/item/food/croissant/throwing
	throwforce = 20
	tastes = list("松软的面包" = 1, "黄油" = 2, "肉" = 1)
	food_reagents = list(/datum/reagent/consumable/nutriment = 4, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/iron = 1)

/obj/item/food/croissant/throwing/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/boomerang, throw_range, TRUE)
