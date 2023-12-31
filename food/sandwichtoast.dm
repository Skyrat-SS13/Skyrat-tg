/obj/item/food/sandwich
	name = "三明治"
	desc = "一个由肉、奶酪、面包和几片生菜组成的伟大作品!"
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("肉" = 2, "奶酪" = 1, "面包" = 2, "生菜" = 1)
	foodtypes = GRAIN | VEGETABLES
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/sandwich/cheese
	name = "奶酪三明治"
	desc = "为一个温暖的天准备的小吃. ...但是如果你烤了它呢?"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("面包" = 1, "奶酪" = 1)
	foodtypes = GRAIN | DAIRY
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/sandwich/cheese/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/sandwich/cheese/grilled, rand(30 SECONDS, 60 SECONDS), TRUE)

/obj/item/food/sandwich/cheese/grilled
	name = "烤奶酪三明治"
	desc = "一个温暖的，奶酪融化了的三明治，与番茄汤完美搭配."
	icon_state = "toastedsandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/carbon = 4,
	)
	tastes = list("烤面包片" = 2, "奶酪" = 3, "黄油" = 1)
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/sandwich/jelly
	name = "果酱三明治"
	desc = "你向上天许愿再给你一点花生酱..."
	icon_state = "jellysandwich"
	bite_consumption = 3
	tastes = list("面包" = 1, "果酱" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/sandwich/jelly/slime
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/toxin/slimejelly = 10, /datum/reagent/consumable/nutriment/vitamin = 4)
	foodtypes = GRAIN | TOXIC

/obj/item/food/sandwich/jelly/cherry
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/cherryjelly = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	foodtypes = GRAIN | FRUIT | SUGAR

/obj/item/food/sandwich/notasandwich
	name = "非三明治"
	desc = "这似乎有什么问题，你不知道是为什么，也许是因为胡子。"
	icon_state = "notasandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/vitamin = 10,
	)
	tastes = list("毫无可疑的气息" = 1)
	foodtypes = GRAIN | GROSS
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/griddle_toast
	name = "烤面包片"
	desc = "厚切面包，烤得恰到好处."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "griddle_toast"
	food_reagents = list(/datum/reagent/consumable/nutriment/vitamin = 3)
	tastes = list("烤面包片" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_MASK
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/butteredtoast
	name = "黄油吐司"
	desc = "把黄油轻轻涂在一片吐司上."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "butteredtoast"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("黄油" = 1, "烤吐司" = 1)
	foodtypes = GRAIN | BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/jelliedtoast
	name = "果酱面包"
	desc = "带着果酱的面包."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "jellytoast"
	bite_consumption = 3
	tastes = list("面包" = 1, "果酱" = 1)
	foodtypes = GRAIN | BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/jelliedtoast/cherry
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/cherryjelly = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	foodtypes = GRAIN | FRUIT | SUGAR | BREAKFAST

/obj/item/food/jelliedtoast/slime
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/toxin/slimejelly = 8, /datum/reagent/consumable/nutriment/vitamin = 4)
	foodtypes = GRAIN | TOXIC | SUGAR | BREAKFAST

/obj/item/food/twobread
	name = "双面包" // two bread
	desc = "看起来很糟糕."
	icon = 'icons/obj/food/burgerbread.dmi'
	icon_state = "twobread"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("面包" = 2)
	foodtypes = GRAIN
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/hotdog
	name = "热狗"
	desc = "热狗鱼雷准备发射！"
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "hotdog"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/ketchup = 3,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("面包" = 3, "肉" = 2)
	foodtypes = GRAIN | MEAT //Ketchup is not a vegetable
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_3

// Used for unit tests, do not delete
/obj/item/food/hotdog/debug
	eat_time = 0

/obj/item/food/danish_hotdog
	name = "丹麦热狗"
	desc = "面包中间夹有香肠，炸洋葱圈与腌菜."
	icon = 'icons/obj/food/meat.dmi'
	icon_state = "danish_hotdog"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/ketchup = 3,
		/datum/reagent/consumable/nutriment/vitamin = 7,
	)
	tastes = list("面包" = 3, "肉" = 2, "炸洋葱" = 1, "腌菜" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES
	w_class = WEIGHT_CLASS_SMALL
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/sandwich/blt
	name = "\improper BLT"
	desc = "经典的培根(Bacon)生菜(lettuce)番茄(tomato)三明治."
	icon_state = "blt"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("培根" = 3, "生菜" = 2, "番茄" = 2, "面包" = 2)
	foodtypes = GRAIN | MEAT | VEGETABLES | BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/sandwich/peanut_butter_jelly
	name = "花生果酱三明治"
	desc = "经典花生果酱三明治，就像你妈妈做得那样."
	icon_state = "peanut_butter_jelly_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("花生酱" = 1, "果酱" = 1, "面包" = 2)
	foodtypes = GRAIN | FRUIT | NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/sandwich/peanut_butter_banana
	name = "花生香蕉三明治"
	desc = "面包中间夹了花生酱和香蕉片，是一种高蛋白的美味."
	icon_state = "peanut_butter_banana_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/banana = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("花生酱" = 1, "香蕉" = 1, "面包" = 2)
	foodtypes = GRAIN | FRUIT | NUTS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/sandwich/philly_cheesesteak
	name = "费城芝士牛排三明治"
	desc = "一种很受欢迎的三明治，由肉、洋葱、融化的奶酪夹在长长的面包卷里，令人垂涎欲滴都不足以形容它了."
	icon_state = "philly_cheesesteak"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("面包" = 1, "多汁的肉" = 1, "融化的奶酪" = 1, "洋葱" = 1)
	foodtypes = GRAIN | MEAT | DAIRY | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/sandwich/toast_sandwich
	name = "吐司三明治"
	desc = "两片面包中间的夹了一片涂了黄油的吐司。你为什么要做这个?"
	icon_state = "toast_sandwich"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("面包" = 2, "英国食物" = 1, "黄油" = 1, "吐司" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/sandwich/death
	name = "死亡三明治"
	desc = "记得吃对了，不然你就死定了!"
	icon_state = "death_sandwich"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/protein = 14,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("面包" = 1, "肉" = 1, "番茄酱" = 1, "死亡" = 1)
	foodtypes = GRAIN | MEAT
	eat_time = 4 SECONDS // Makes it harder to force-feed this to people as a weapon, as funny as that is. 这样就很难把这个当做武器强行灌输给人们，虽然这很有趣。

/obj/item/food/sandwich/death/Initialize(mapload)
	. = ..()
	obj_flags &= ~UNIQUE_RENAME // You shouldn't be able to disguise this on account of how it kills you 你不应该掩饰这一点因为它会杀死你

// Makes you feel disgusted if you look at it wrong. 如果你看错了，你会觉得恶心。
/obj/item/food/sandwich/death/examine(mob/user)
	. = ..()
	// Only human mobs, not animals or silicons, can like/dislike by this. 只有人类mob，而不是动物或硅，可以喜欢/不喜欢这个。
	if(!ishuman(user))
		return
	if(check_liked(user) == FOOD_LIKED)
		return
	to_chat(user, span_warning("你想象你自己在吃[src].你突然感到嘴里有一股酸味，一种可怕的感觉涌上心头，你做错了什么."))
	user.adjust_disgust(33)

// Override for after_eat and check_liked callbacks. 覆盖after_eat和check_like回调。
/obj/item/food/sandwich/death/make_edible()
	. = ..()
	AddComponent(/datum/component/edible, after_eat = CALLBACK(src, PROC_REF(after_eat)), check_liked = CALLBACK(src, PROC_REF(check_liked)))

/**
* Callback to be used with the edible component. 回调函数与可食用组件一起使用。
* If you have the right clothes and hairstyle, you like it. 如果你有合适的衣服和发型，你会喜欢的。
* If you don't, you don't like it. 如果你没有，说明你不喜欢。
*/
/obj/item/food/sandwich/death/proc/check_liked(mob/living/carbon/human/consumer)
	// Closest thing to a mullet we have 最接近鲻鱼发型的
	if(consumer.hairstyle == "Gelled Back" && istype(consumer.get_item_by_slot(ITEM_SLOT_ICLOTHING), /obj/item/clothing/under/rank/civilian/cookjorts))
		return FOOD_LIKED
	return FOOD_ALLERGIC

/**
* Callback to be used with the edible component.
* If you take a bite of the sandwich with the right clothes and hairstyle, you like it. 如果你穿上合适的衣服和发型，咬一口三明治，你就会喜欢它。
* If you don't, you contract a deadly disease. 如果你没有，你会感染一种致命的疾病。
*/
/obj/item/food/sandwich/death/proc/after_eat(mob/living/carbon/human/consumer)
	// If you like it, you're eating it right.
	if(check_liked(consumer) == FOOD_LIKED)
		return
	// I thought it didn't make sense for it to instantly kill you, so instead enjoy shitloads of toxin damage per bite.
	balloon_alert(consumer, "吃错了!")
	consumer.ForceContractDisease(new /datum/disease/death_sandwich_poisoning())

/obj/item/food/sandwich/death/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user]开始以错误的方式将[src]塞入自己的喉咙.这是一种自杀行为!"))
	qdel(src)
	user.gib()
	return MANUAL_SUICIDE
