// Sweets that didn't make it into any other category

/obj/item/food/candy_corn
	name = "玉米糖"
	desc = "这是一把玉米糖，可以放在侦探的帽子里。"
	icon_state = "candy_corn"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/sugar = 2,
	)
	tastes = list("玉米糖" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/candy_corn/prison
	name = "硬玉米糖"
	desc = "如果这个玉米糖再硬一点保安就会没收它，因为它可能是一把刀。"
	force = 1 // the description isn't lying 这种描述并没有说谎
	throwforce = 1 // if someone manages to bust out of jail with candy corn god bless them 如果有人拿着玉米糖成功越狱上帝保佑他们
	tastes = list("苦蜡" = 1)
	foodtypes = GROSS

/obj/item/food/candiedapple
	name = "苹果糖"
	desc = "裹着糖衣的苹果."
	icon_state = "candiedapple"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/caramel = 5,
	)
	tastes = list("苹果" = 2, "焦糖" = 3)
	foodtypes = JUNKFOOD | FRUIT | SUGAR
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/mint
	name = "薄荷糖"
	desc = "它很薄。"
	icon_state = "mint"
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/mintextract = 2)
	foodtypes = TOXIC | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/ant_candy
	name = "蚂蚁糖"
	desc = "一群裹在硬糖中的蚂蚁，那些东西都死了，对吧?"
	icon_state = "ant_pop"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/ants = 3,
	)
	tastes = list("糖果" = 1, "昆虫" = 1)
	foodtypes = JUNKFOOD | SUGAR | BUGS
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

// Chocolates
/obj/item/food/chocolatebar
	name = "巧克力棒"
	desc = "这种又甜又肥的食物."
	icon_state = "chocolatebar"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/sugar = 2,
		/datum/reagent/consumable/coco = 2,
	)
	tastes = list("巧克力" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/chococoin
	name = "巧克力币"
	desc = "一枚完全可食用但不可抛的节庆硬币。"
	icon_state = "chococoin"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("巧克力" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/fudgedice
	name = "巧克力骰子"
	desc = "一小块巧克力，如果你一次吃太多，味道会不那么浓烈。"
	icon_state = "chocodice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/coco = 1,
		/datum/reagent/consumable/sugar = 1,
	)
	trash_type = /obj/item/dice/fudge
	tastes = list("巧克力软糖" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/chocoorange
	name = "巧克力橙子"
	desc = "适合节庆的巧克力橙子."
	icon_state = "chocoorange"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 1,
	)
	tastes = list("巧克力" = 3, "橙子" = 1)
	foodtypes = JUNKFOOD | SUGAR | ORANGES
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/bonbon
	name = "bon bon"
	desc = "一小块甜甜的巧克力."
	icon_state = "tiny_chocolate"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/sugar = 1,
		/datum/reagent/consumable/coco = 1,
	)
	tastes = list("巧克力" = 1)
	foodtypes = DAIRY | JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_TINY

/obj/item/food/bonbon/caramel_truffle
	name = "焦糖巧克力松露"
	desc = "一口大小的巧克力松露，内馅是有嚼劲的焦糖。"
	icon_state = "caramel_truffle"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("巧克力" = 1, "耐嚼焦糖" = 1)
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/bonbon/chocolate_truffle
	name = "巧克力松露"
	desc = "一口大小的巧克力松露，内含美味的巧克力慕斯."
	icon_state = "chocolate_truffle"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)

/obj/item/food/bonbon/peanut_truffle
	name = "花生巧克力松露"
	desc = "一口大小的巧克力松露和脆花生混合在一起。"
	icon_state = "peanut_truffle"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("巧克力" = 1, "脆花生" = 1)
	foodtypes = DAIRY | SUGAR | JUNKFOOD | NUTS
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/bonbon/peanut_butter_cup
	name = "花生酱杯"
	desc = "超甜的巧克力配上美味的花生酱."
	icon_state = "peanut_butter_cup"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("巧克力" = 1, "花生酱" = 1)
	foodtypes = DAIRY | SUGAR | JUNKFOOD | NUTS
	crafting_complexity = FOOD_COMPLEXITY_1

// Gum
/obj/item/food/bubblegum
	name = "泡泡糖"
	desc = "不能让你填饱肚子，但能让你嘴里停不下来."
	icon_state = "bubblegum"
	inhand_icon_state = null
	color = "#E48AB5" // craftable custom gums someday? 有一天可以制作定制口香糖?
	food_reagents = list(/datum/reagent/consumable/sugar = 5)
	tastes = list("candy" = 1)
	food_flags = FOOD_FINGER_FOOD
	slot_flags = ITEM_SLOT_MASK
	w_class = WEIGHT_CLASS_TINY

	/// The amount to metabolize per second 每秒钟要代谢的量
	var/metabolization_amount = REAGENTS_METABOLISM / 2

/obj/item/food/bubblegum/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]要吞下[src]!这是一种自杀行为!"))
	qdel(src)
	return TOXLOSS

/obj/item/food/bubblegum/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/chewable, metabolization_amount = metabolization_amount)

/obj/item/food/bubblegum/nicotine
	name = "尼古丁口香糖"
	food_reagents = list(
		/datum/reagent/drug/nicotine = 10,
		/datum/reagent/consumable/menthol = 5,
	)
	tastes = list("口香糖" = 1)
	color = "#60A584"

/obj/item/food/bubblegum/happiness
	name = "HP+ 口香糖"
	desc = "闻起来怪怪的口香糖。"
	food_reagents = list(/datum/reagent/drug/happiness = 15)
	tastes = list("油漆稀释剂" = 1)
	color = "#EE35FF"

/obj/item/food/bubblegum/bubblegum
	name = "泡泡糖口香糖"
	desc = "猜猜bubblegum除了泡泡糖还指什么？"
	color = "#913D3D"
	food_reagents = list(/datum/reagent/blood = 15)
	tastes = list("地狱" = 1, "人的血肉" = 1)
	metabolization_amount = REAGENTS_METABOLISM

/obj/item/food/bubblegum/bubblegum/process()
	. = ..()
	if(iscarbon(loc))
		hallucinate(loc)

/obj/item/food/bubblegum/bubblegum/make_edible()
	. = ..()
	AddComponent(/datum/component/edible, on_consume = CALLBACK(src, PROC_REF(OnConsume)))

/obj/item/food/bubblegum/bubblegum/proc/OnConsume(mob/living/eater, mob/living/feeder)
	if(iscarbon(eater))
		hallucinate(eater)

///This proc has a 5% chance to have a bubblegum line appear, with an 85% chance for just text and 15% for a bubblegum hallucination and scarier text.这个过程有5%的机会出现泡泡糖线，85%的机会出现文字，15%的机会出现泡泡糖幻觉和更可怕的文字
/obj/item/food/bubblegum/bubblegum/proc/hallucinate(mob/living/carbon/victim)
	if(prob(95)) //cursed by bubblegum 被泡泡糖诅咒了
		return
	if(prob(15))
		victim.cause_hallucination(/datum/hallucination/oh_yeah, "泡泡糖 泡泡糖...", haunt_them = TRUE)
	else
		to_chat(victim, span_warning("[pick("你听到微弱的低语.", "你闻到灰烬的味道.", "你感觉热起来了.", "你听到远方的吼声.")]"))

/obj/item/food/bubblegum/bubblegum/suicide_act(mob/living/user)
	user.say(";[pick(BUBBLEGUM_HALLUCINATION_LINES)]")
	return ..()

/obj/item/food/gumball
	name = "口香糖糖球"
	desc = "一种彩色的、含糖的口香糖。"
	icon = 'icons/obj/food/lollipop.dmi'
	icon_state = "gumball"
	worn_icon_state = "bubblegum"
	food_reagents = list(/datum/reagent/consumable/sugar = 5, /datum/reagent/medicine/sal_acid = 2, /datum/reagent/medicine/oxandrolone = 2) //Kek
	tastes = list("糖果")
	foodtypes = JUNKFOOD
	food_flags = FOOD_FINGER_FOOD
	slot_flags = ITEM_SLOT_MASK
	w_class = WEIGHT_CLASS_TINY
	venue_value = FOOD_PRICE_WORTHLESS

/obj/item/food/gumball/Initialize(mapload)
	. = ..()
	color = rgb(rand(0, 255), rand(0, 255), rand(0, 255))
	AddElement(/datum/element/chewable)


// Lollipop
/obj/item/food/lollipop
	name = "棒棒糖"
	desc = "美味的棒棒糖，是情人节最好的礼物。"
	icon = 'icons/obj/food/lollipop.dmi'
	icon_state = "lollipop_stick"
	inhand_icon_state = null
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/iron = 10, /datum/reagent/consumable/sugar = 5,
		/datum/reagent/medicine/omnizine = 2,
	)
	tastes = list("糖果" = 1)
	foodtypes = JUNKFOOD | SUGAR
	food_flags = FOOD_FINGER_FOOD
	slot_flags = ITEM_SLOT_MASK
	w_class = WEIGHT_CLASS_TINY
	venue_value = FOOD_PRICE_WORTHLESS
	var/mutable_appearance/head
	var/head_color = rgb(0, 0, 0)

/obj/item/food/lollipop/Initialize(mapload)
	. = ..()
	head = mutable_appearance('icons/obj/food/lollipop.dmi', "lollipop_head")
	change_head_color(rgb(rand(0, 255), rand(0, 255), rand(0, 255)))
	AddElement(/datum/element/chewable)

/obj/item/food/lollipop/proc/change_head_color(C)
	head_color = C
	cut_overlay(head)
	head.color = C
	add_overlay(head)

/obj/item/food/lollipop/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..(hit_atom)
	throw_speed = 1
	throwforce = 0

/obj/item/food/lollipop/cyborg
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/iron = 10,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/medicine/psicodine = 2, //psicodine instead of omnizine, because the latter was making coders freak out 用Psicodine代替omnizine，因为后者会让程序员抓狂
	)

/obj/item/food/spiderlollipop
	name = "蜘蛛棒棒糖"
	desc = "还是很恶心，但至少上面有一堆糖."
	icon_state = "spiderlollipop"
	worn_icon_state = "lollipop_stick"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/toxin = 1,
		/datum/reagent/iron = 10,
		/datum/reagent/consumable/sugar = 5,
		/datum/reagent/medicine/omnizine = 2,
	) //lollipop, but vitamins = toxins
	tastes = list("蜘蛛网" = 1, "糖" = 2)
	foodtypes = JUNKFOOD | SUGAR | BUGS
	food_flags = FOOD_FINGER_FOOD
	slot_flags = ITEM_SLOT_MASK
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/spiderlollipop/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/chewable)
