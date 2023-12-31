// Pizza (Whole)
/obj/item/food/pizza
	icon = 'icons/obj/food/pizza.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	max_volume = 80
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 28,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1)
	foodtypes = GRAIN | DAIRY | VEGETABLES
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2
	/// type is spawned 6 at a time and replaces this pizza when processed by cutting tool
	var/obj/item/food/pizzaslice/slice_type
	///What label pizza boxes use if this pizza spawns in them.
	var/boxtag = ""

/obj/item/food/pizza/raw
	foodtypes = GRAIN | DAIRY | VEGETABLES | RAW
	slice_type = null
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pizza/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/make_processable()
	if (slice_type)
		AddElement(/datum/element/processable, TOOL_KNIFE, slice_type, 6, 3 SECONDS, table_required = TRUE, screentip_verb = "片")
		AddElement(/datum/element/processable, TOOL_SAW, slice_type, 6, 4.5 SECONDS, table_required = TRUE, screentip_verb = "片")
		AddElement(/datum/element/processable, TOOL_SCALPEL, slice_type, 6, 6 SECONDS, table_required = TRUE, screentip_verb = "片")

// Pizza Slice
/obj/item/food/pizzaslice
	icon = 'icons/obj/food/pizza.dmi'
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	foodtypes = GRAIN | DAIRY | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	decomp_type = /obj/item/food/pizzaslice/moldy
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pizzaslice/make_processable()
	AddElement(/datum/element/processable, TOOL_ROLLINGPIN, /obj/item/stack/sheet/pizza, 1, 1 SECONDS, table_required = TRUE, screentip_verb = "Flatten")

/obj/item/food/pizza/margherita
	name = "玛格丽特披萨"
	desc = "全银河系最普通的披萨."
	icon_state = "pizzamargherita"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/margherita
	boxtag = "豪华玛格丽特"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/margherita/raw
	name = "生玛格丽特披萨"
	icon_state = "pizzamargherita_raw"
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	slice_type = null

/obj/item/food/pizza/margherita/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/margherita, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizza/margherita/robo
	food_reagents = list(
		/datum/reagent/cyborg_mutation_nanomachines = 70,
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)

/obj/item/food/pizzaslice/margherita
	name = "玛格丽特披萨片"
	desc = "全银河系最普通的披萨片."
	icon_state = "pizzamargheritaslice"
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizzaslice/margherita/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, null, CUSTOM_INGREDIENT_ICON_FILL, max_ingredients = 12)

/obj/item/food/pizza/meat
	name = "烤肉披萨"
	desc = "油腻的披萨配上美味的肉."
	icon_state = "meatpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	foodtypes = GRAIN | VEGETABLES| DAIRY | MEAT
	slice_type = /obj/item/food/pizzaslice/meat
	boxtag = "肉食者赛高！"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/meat/raw
	name = "生肉披萨"
	icon_state = "meatpizza_raw"
	foodtypes = GRAIN | VEGETABLES| DAIRY | MEAT | RAW
	slice_type = null

/obj/item/food/pizza/meat/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/meat, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/meat
	name = "烤肉披萨片"
	desc = "一片营养丰富的烤肉披萨."
	icon_state = "meatpizzaslice"
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1, "肉" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/mushroom
	name = "蘑菇披萨"
	desc = "非常特别的披萨."
	icon_state = "mushroompizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 28,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1, "蘑菇" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/mushroom
	boxtag = "蘑菇特快"
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pizza/mushroom/raw
	name = "生蘑菇披萨"
	icon_state = "mushroompizza_raw"
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	slice_type = null

/obj/item/food/pizza/mushroom/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/mushroom, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/mushroom
	name = "蘑菇披萨片"
	desc = "也许是你人生最后一片披萨."
	icon_state = "mushroompizzaslice"
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1, "蘑菇" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_2


/obj/item/food/pizza/vegetable
	name = "蔬菜披萨"
	desc = "在制作披萨的过程中，没有一个番茄人受伤."
	icon_state = "vegetablepizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("披萨饼" = 1, "番茄" = 2, "芝士" = 1, "胡萝卜" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/vegetable
	boxtag = "蔬菜佳肴"
	venue_value = FOOD_PRICE_NORMAL

/obj/item/food/pizza/vegetable/raw
	name = "生蔬菜披萨"
	icon_state = "vegetablepizza_raw"
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	slice_type = null
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/vegetable/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/vegetable, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/vegetable
	name = "蔬菜披萨片"
	desc = "史上最绿的披萨不含绿色素."
	icon_state = "vegetablepizzaslice"
	tastes = list("披萨饼" = 1, "番茄" = 2, "芝士" = 1, "胡萝卜" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/donkpocket
	name = "口袋饼披萨"
	desc = "谁想出了这个好主意?"
	icon_state = "donkpocketpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/medicine/omnizine = 10,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1, "肉" = 1, "快捷食品" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | JUNKFOOD
	slice_type = /obj/item/food/pizzaslice/donkpocket
	boxtag = "快捷披萨" // Bangin' Donk
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/donkpocket/raw
	name = "生口袋饼披萨"
	icon_state = "donkpocketpizza_raw"
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | JUNKFOOD | RAW
	slice_type = null

/obj/item/food/pizza/donkpocket/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/donkpocket, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/donkpocket
	name = "口袋饼披萨片"
	desc = "尝起来像口袋饼."
	icon_state = "donkpocketpizzaslice"
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1, "肉" = 1, "快捷食品" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | JUNKFOOD

/obj/item/food/pizza/dank
	name = "哈草披萨"
	desc = "嬉皮披萨之选."
	icon_state = "dankpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/doctor_delight = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1, "肉" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY
	slice_type = /obj/item/food/pizzaslice/dank
	boxtag = "新鲜草药"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/dank/raw
	name = "生哈草披萨"
	icon_state = "dankpizza_raw"
	foodtypes = GRAIN | VEGETABLES | DAIRY | RAW
	slice_type = null

/obj/item/food/pizza/dank/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/dank, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/dank
	name = "哈草披萨"
	desc = "哎妈，劲..."
	icon_state = "dankpizzaslice"
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1, "肉" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY

/obj/item/food/pizza/sassysage
	name = "香肠披萨"
	desc = "你几乎可以尝到香肠味."
	icon_state = "sassysagepizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/protein = 15,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1, "肉" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT
	slice_type = /obj/item/food/pizzaslice/sassysage
	boxtag = "香肠之爱"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/sassysage/raw
	name = "生香肠披萨"
	icon_state = "sassysagepizza_raw"
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | RAW
	slice_type = null

/obj/item/food/pizza/sassysage/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/sassysage, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/sassysage
	name = "香肠披萨片"
	desc = "美味滴香肠."
	icon_state = "sassysagepizzaslice"
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1, "肉" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pizza/pineapple
	name = "\improper 夏威夷披萨"
	desc = "堪比爱因斯坦之谜的披萨"
	icon_state = "pineapplepizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 20,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/tomatojuice = 6,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/pineapplejuice = 8,
	)
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1, "菠萝" = 2, "火腿" = 2)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | FRUIT | PINEAPPLE
	slice_type = /obj/item/food/pizzaslice/pineapple
	boxtag = "火奴鲁鲁特快"
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizza/pineapple/raw
	name = "生夏威夷披萨"
	icon_state = "pineapplepizza_raw"
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | FRUIT | PINEAPPLE | RAW
	slice_type = null

/obj/item/food/pizza/pineapple/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/pineapple, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/pineapple
	name = "\improper 夏威夷披萨片"
	desc = "带有争议的一片美味."
	icon_state = "pineapplepizzaslice"
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1, "菠萝" = 2, "火腿" = 2)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT | FRUIT | PINEAPPLE


// Moldly Pizza
// Used in cytobiology.
/obj/item/food/pizzaslice/moldy
	name = "发霉披萨片"
	desc = "这曾经是一片完美的披萨派，但现在它躺在这里，腐臭了，到处都是孢子，这真是糟透了!但还是不要沉湎于过去，面向未来吧。"
	icon_state = "moldy_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/peptides = 3,
		/datum/reagent/consumable/tomatojuice = 1,
		/datum/reagent/toxin/amatoxin = 2,
	)
	tastes = list("变味的披萨饼" = 1, "腐烂芝士" = 2, "孢子" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | GROSS
	preserved_food = TRUE

/obj/item/food/pizzaslice/moldy/bacteria
	name = "富含细菌的发霉披萨片"
	desc = "这个曾经美味的披萨不仅覆盖着一层喷出孢子的真菌，而且在无人看管的情况下，它似乎还会蠕动，充满了新的生命."

/obj/item/food/pizzaslice/moldy/bacteria/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_MOLD, CELL_VIRUS_TABLE_GENERIC, rand(2, 4), 25)

// Arnold Pizza
// Has meme code.
/obj/item/food/pizza/arnold
	name = "\improper 阿诺德披萨" // Arnold pizza
	desc = "你好，这里是阿诺德披萨店.我现在腾不开手,我要去杀意大利辣香肠."
	icon_state = "arnoldpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 25,
		/datum/reagent/consumable/nutriment/protein = 9,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/iron = 10,
		/datum/reagent/medicine/omnizine = 30,
	)
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1, "意大利辣香肠" = 2, "9mm子弹" = 2)
	slice_type = /obj/item/food/pizzaslice/arnold
	boxtag = "9mm 意大利辣香肠"
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizza/arnold/raw
	name = "生阿诺德披萨"
	icon_state = "arnoldpizza_raw"
	foodtypes = GRAIN | DAIRY | VEGETABLES | RAW
	slice_type = null

/obj/item/food/pizza/arnold/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/arnold, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

//fuck it, i will leave this at the food level for now.
/obj/item/food/proc/try_break_off(mob/living/attacker, mob/living/user) //maybe i give you a pizza maybe i break off your arm 也许我给你一个披萨也许我打断你的手臂
	if(prob(50) || (attacker != user) || !iscarbon(user) || HAS_TRAIT(user, TRAIT_NODISMEMBER))
		return
	var/obj/item/bodypart/arm/left = user.get_bodypart(BODY_ZONE_L_ARM)
	var/obj/item/bodypart/arm/right = user.get_bodypart(BODY_ZONE_R_ARM)
	var/did_the_thing = (left?.dismember() || right?.dismember()) //not all limbs can be removed, so important to check that we did. the. thing. 不是所有的肢体都可以切除的，所以检查一下很重要
	if(!did_the_thing)
		return
	to_chat(user, span_userdanger("也许我会给你一个披萨,也许我会打断你的胳膊.")) //makes the reference more obvious
	user.visible_message(span_warning("[src]打断了[user]的胳膊!"), span_warning("[src]打断了你的胳膊!"))
	playsound(user, SFX_DESECRATION, 50, TRUE, -1)

/obj/item/food/proc/i_kill_you(obj/item/item, mob/living/user)
	if(istype(item, /obj/item/food/pineappleslice))
		to_chat(user, "<font color='red' size='7'>如果你想搞点疯狂的东西吃，比如菠萝，那么我要杀了你.</font>") //this is in bigger text because it's hard to spam something that gibs you, and so that you're perfectly aware of the reason why you died
		user.investigate_log("在阿诺德披萨上放菠萝的人已经被做掉了.", INVESTIGATE_DEATHS)
		user.gib(DROP_ALL_REMAINS) //if you want something crazy like pineapple, i'll kill you
	else if(istype(item, /obj/item/food/grown/mushroom) && iscarbon(user))
		to_chat(user, span_userdanger("如果你想吃蘑菇，就闭嘴.")) //not as large as the pineapple text, because you could in theory spam it
		var/mob/living/carbon/shutup = user
		shutup.gain_trauma(/datum/brain_trauma/severe/mute)

/obj/item/food/pizza/arnold/attack(mob/living/target, mob/living/user)
	. = ..()
	try_break_off(target, user)

/obj/item/food/pizza/arnold/attackby(obj/item/item, mob/user)
	i_kill_you(item, user)
	. = ..()

/obj/item/food/pizzaslice/arnold
	name = "\improper 阿诺德披萨片"
	desc = "我向你走来,也许我会给你一个披萨,也许我会打断你的胳膊."
	icon_state = "arnoldpizzaslice"
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1, "意大利辣香肠" = 2, "9mm子弹" = 2)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pizzaslice/arnold/attack(mob/living/target, mob/living/user)
	. =..()
	try_break_off(target, user)

/obj/item/food/pizzaslice/arnold/attackby(obj/item/item, mob/user)
	i_kill_you(item, user)
	. = ..()

// Ant Pizza, now with more ants.
/obj/item/food/pizzaslice/ants
	name = "\improper 蚂蚁上树树萨"
	desc = "完美披萨的关键是不要放太多的蚂蚁."
	icon_state = "antpizzaslice"
	food_reagents = list(
		/datum/reagent/ants = 5,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("披萨饼" = 1, "番茄" = 1, "芝士" = 1, "虫子" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | BUGS

// Ethereal Pizza, for when they want a slice
/obj/item/food/pizza/energy
	name = "能量披萨"
	desc = "你可以用这个给雷普利充电. You should avoid eating this if you aren't an Ethereal."
	icon_state ="energypizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 18,
		/datum/reagent/consumable/liquidelectricity/enriched = 18,
	)
	tastes = list("高能源" = 4, "披萨" = 2)
	slice_type = /obj/item/food/pizzaslice/energy
	foodtypes = TOXIC
	boxtag = "24小时加油站"
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pizza/energy/raw
	name = "生能量披萨"
	icon_state = "energypizza_raw"
	foodtypes = TOXIC
	slice_type = null

/obj/item/food/pizza/energy/raw/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/pizza/energy, rand(70 SECONDS, 80 SECONDS), TRUE, TRUE)

/obj/item/food/pizzaslice/energy
	name = "能量披萨片"
	desc = "你可以用这个给模块服充电. You should avoid eating this if you aren't an Ethereal."
	icon_state ="energypizzaslice"
	tastes = list("pure electricity" = 4, "pizza" = 2)
	foodtypes = TOXIC
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/raw_meat_calzone
	name = "生披萨肉饺"
	desc = "生披萨饺，准备放进烤箱烤."
	icon_state = "raw_calzone"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("生面团" = 1, "生肉" = 1, "芝士" = 1, "番茄酱" = 1)
	foodtypes = GRAIN | RAW | DAIRY | MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_meat_calzone/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/meat_calzone, rand(20 SECONDS, 40 SECONDS), TRUE, TRUE)

/obj/item/food/meat_calzone
	name = "披萨肉饺"
	desc = "一个填满了芝士和肉的披萨饺.别烫到了!."
	icon_state = "meat_calzone"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("烤披萨饼" = 1, "多汁的肉" = 1, "流心芝士" = 1, "番茄酱" = 1)
	foodtypes = GRAIN | DAIRY | MEAT
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_vegetarian_calzone
	name = "生披萨蔬菜饺"
	desc = "生披萨饺，准备放进烤箱烤."
	icon_state = "raw_calzone"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("生面团" = 1, "蔬菜" = 1, "番茄酱" = 1)
	foodtypes = GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/raw_vegetarian_calzone/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/vegetarian_calzone, rand(20 SECONDS, 40 SECONDS), TRUE, TRUE)

/obj/item/food/vegetarian_calzone
	name = "披萨蔬菜饺"
	desc = "加了蔬菜和番茄酱的馅饼,一个更健康，但不那么爽的选择."
	icon_state = "vegetarian_calzone"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("烤披萨饼" = 1, "烤蔬菜" = 1, "番茄酱" = 1)
	foodtypes = GRAIN | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3
