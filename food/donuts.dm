#define DONUT_SPRINKLE_CHANCE 30

/obj/item/food/donut
	name = "甜甜圈"
	desc = "和浓咖啡搭配非常好."
	icon = 'icons/obj/food/donuts.dmi'
	inhand_icon_state = "donut1"
	bite_consumption = 5
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3)
	tastes = list("甜甜圈" = 1)
	foodtypes = JUNKFOOD | GRAIN | SUGAR | BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_2
	var/decorated_icon = "donut_homer"
	var/is_decorated = FALSE
	var/extra_reagent = null
	var/decorated_adjective = "sprinkled"
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/donut/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dunkable, amount_per_dunk = 10)
	if(prob(DONUT_SPRINKLE_CHANCE))
		decorate_donut()

///Override for checkliked callback
/obj/item/food/donut/make_edible()
	. = ..()
	AddComponent(/datum/component/edible, check_liked = CALLBACK(src, PROC_REF(check_liked)))

/obj/item/food/donut/proc/decorate_donut()
	if(is_decorated || !decorated_icon)
		return
	is_decorated = TRUE
	name = "[decorated_adjective] [name]"
	icon_state = decorated_icon //delish~!
	inhand_icon_state = "donut2"
	reagents.add_reagent(/datum/reagent/consumable/sprinkles, 1)
	return TRUE

/// Returns the sprite of the donut while in a donut box
/obj/item/food/donut/proc/in_box_sprite()
	return "[icon_state]_inbox"

///Override for checkliked in edible component, because all cops LOVE donuts
/obj/item/food/donut/proc/check_liked(mob/living/carbon/human/consumer)
	var/obj/item/organ/internal/liver/liver = consumer.get_organ_slot(ORGAN_SLOT_LIVER)
	if(!HAS_TRAIT(consumer, TRAIT_AGEUSIA) && liver && HAS_TRAIT(liver, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		return FOOD_LIKED

//Use this donut ingame
/obj/item/food/donut/plain
	icon_state = "donut"

/obj/item/food/donut/chaos
	name = "混乱甜甜圈"
	desc = "就像生活,永远不会尝到同样的味道."
	icon_state = "donut_chaos"
	bite_consumption = 10
	tastes = list("肉" = 3, "混乱" = 1)
	is_decorated = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/donut/chaos/Initialize(mapload)
	. = ..()
	extra_reagent = pick(
		/datum/reagent/consumable/nutriment,
		/datum/reagent/consumable/capsaicin,
		/datum/reagent/consumable/frostoil,
		/datum/reagent/drug/krokodil,
		/datum/reagent/toxin/plasma,
		/datum/reagent/consumable/coco,
		/datum/reagent/toxin/slimejelly,
		/datum/reagent/consumable/banana,
		/datum/reagent/consumable/berryjuice,
		/datum/reagent/medicine/omnizine,
	)
	reagents.add_reagent(extra_reagent, 3)

/obj/item/food/donut/meat
	name = "肉甜甜圈"
	desc = "尝起来和看起来一样恶心."
	icon_state = "donut_meat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/ketchup = 3,
	)
	tastes = list("肉" = 1)
	foodtypes = JUNKFOOD | MEAT | GORE | FRIED | BREAKFAST
	is_decorated = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/donut/berry
	name = "甜甜圈"
	desc = "和咖啡拿铁很搭."
	icon_state = "donut_pink"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/berryjuice = 3,
		/datum/reagent/consumable/sprinkles = 1, //Extra sprinkles to reward frosting
	)
	decorated_icon = "donut_homer"

/obj/item/food/donut/trumpet
	name = "宇航员甜甜圈"
	desc = "和一大杯麦芽酒搭配很好."
	icon_state = "donut_purple"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/sprinkles = 1,
	)
	tastes = list("甜甜圈" = 3, "紫罗兰" = 1)
	is_decorated = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/donut/apple
	name = "苹果甜甜圈"
	desc = "再来点肉桂杜松子酒就好了."
	icon_state = "donut_green"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/applejuice = 3,
		/datum/reagent/consumable/sprinkles = 1,
	)
	tastes = list("甜甜圈" = 3, "青苹果" = 1)
	is_decorated = TRUE

/obj/item/food/donut/caramel
	name = "焦糖甜甜圈"
	desc = "再来一杯热可可就好了."
	icon_state = "donut_beige"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/caramel = 3,
		/datum/reagent/consumable/sprinkles = 1,
	)
	tastes = list("甜甜圈" = 3, "甜蜜" = 1)
	is_decorated = TRUE

/obj/item/food/donut/choco
	name = "巧克力甜甜圈"
	desc = "再配上一杯热牛奶就好了."
	icon_state = "donut_choc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/hot_coco = 3,
		/datum/reagent/consumable/sprinkles = 1,
	) //the coco reagent is just bitter.
	tastes = list("甜甜圈" = 4, "巧克力苦" = 1)
	decorated_icon = "donut_choc_sprinkles"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/donut/blumpkin
	name = "蓝瓜甜甜圈"
	desc = "再来一杯醉醺醺的蓝瓜酒就好了."
	icon_state = "donut_blue"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/blumpkinjuice = 3,
		/datum/reagent/consumable/sprinkles = 1,
	)
	tastes = list("甜甜圈" = 2, "蓝瓜" = 1)
	is_decorated = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/donut/bungo
	name = "bungo甜甜圈"
	desc = "和一杯嬉皮之乐很搭."
	icon_state = "donut_yellow"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/bungojuice = 3,
		/datum/reagent/consumable/sprinkles = 1,
	)
	tastes = list("甜甜圈" = 3, "热带风味" = 1)
	is_decorated = TRUE

/obj/item/food/donut/matcha
	name = "抹茶甜甜圈"
	desc = "配上一杯茶再好不过了."
	icon_state = "donut_olive"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/toxin/teapowder = 3,
		/datum/reagent/consumable/sprinkles = 1,
	)
	tastes = list("甜甜圈" = 3, "抹茶" = 1)
	is_decorated = TRUE

/obj/item/food/donut/laugh
	name = "甜浆甜甜圈"
	desc = "配瓶堡垒波本威士忌再好不过了!"
	icon_state = "donut_laugh"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/laughter = 3,
	)
	tastes = list("甜甜圈" = 3, "fizzy tutti frutti" = 1,)
	is_decorated = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

//////////////////////果酱甜甜圈S/////////////////////////

/obj/item/food/donut/jelly
	name = "果酱甜甜圈"
	desc = "酱紫好吗？"
	icon_state = "jelly"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/sugar = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	extra_reagent = /datum/reagent/consumable/berryjuice
	tastes = list("果酱" = 1, "甜甜圈" = 3)
	foodtypes = JUNKFOOD | GRAIN | FRIED | FRUIT | SUGAR | BREAKFAST

// 果酱甜甜圈s don't have holes, but look the same on the outside
/obj/item/food/donut/jelly/in_box_sprite()
	return "[replacetext(icon_state, "jelly", "donut")]_inbox"

/obj/item/food/donut/jelly/Initialize(mapload)
	. = ..()
	if(extra_reagent)
		reagents.add_reagent(extra_reagent, 3)

/obj/item/food/donut/jelly/plain //use this ingame to avoid inheritance related crafting issues.
	decorated_icon = "jelly_homer"

/obj/item/food/donut/jelly/berry
	name = "果酱甜甜圈"
	desc = "配上一杯咖啡拿铁就再好不过了."
	icon_state = "jelly_pink"
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/berryjuice = 3, /datum/reagent/consumable/sprinkles = 1, /datum/reagent/consumable/nutriment/vitamin = 1) //Extra sprinkles to reward frosting.
	decorated_icon = "jelly_homer"

/obj/item/food/donut/jelly/trumpet
	name = "宇航员果酱甜甜圈"
	desc = "和一大杯麦芽酒搭配很好."
	icon_state = "jelly_purple"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("果酱" = 1, "甜甜圈" = 3, "紫罗兰" = 1)
	is_decorated = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/donut/jelly/apple
	name = "苹果酱甜甜圈"
	desc = "再来点肉桂杜松子酒就好了."
	icon_state = "jelly_green"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/applejuice = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("果酱" = 1, "甜甜圈" = 3, "青苹果" = 1)
	is_decorated = TRUE

/obj/item/food/donut/jelly/caramel
	name = "焦糖果酱甜甜圈"
	desc = "再来一杯热可可就好了."
	icon_state = "jelly_beige"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/caramel = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("果酱" = 1, "甜甜圈" = 3, "甜蜜" = 1)
	is_decorated = TRUE

/obj/item/food/donut/jelly/choco
	name = "巧克力果酱甜甜圈"
	desc = "再配上一杯热牛奶就好了."
	icon_state = "jelly_choc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/hot_coco = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("果酱" = 1, "甜甜圈" = 4, "巧克力苦" = 1)
	decorated_icon = "jelly_choc_sprinkles"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/donut/jelly/blumpkin
	name = "蓝瓜果酱甜甜圈"
	desc = "再来一杯醉醺醺的蓝瓜酒就好了."
	icon_state = "jelly_blue"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/blumpkinjuice = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("果酱" = 1, "甜甜圈" = 2, "蓝瓜" = 1)
	is_decorated = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/donut/jelly/bungo
	name = "bungo果酱甜甜圈"
	desc = "再来一杯嬉皮之乐就好了."
	icon_state = "jelly_yellow"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/bungojuice = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("果酱" = 1, "甜甜圈" = 3, "热带风味" = 1)
	is_decorated = TRUE

/obj/item/food/donut/jelly/matcha
	name = "抹茶果酱甜甜圈"
	desc = "配上一杯茶再好不过了."
	icon_state = "jelly_olive"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/toxin/teapowder = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("果酱" = 1, "甜甜圈" = 3, "抹茶" = 1)
	is_decorated = TRUE

/obj/item/food/donut/jelly/laugh
	name = "甜浆果酱甜甜圈"
	desc = "再来一瓶堡垒威士忌就好了!"
	icon_state = "jelly_laugh"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/laughter = 3,
	)
	tastes = list("果酱" = 3, "甜甜圈" = 1, "fizzy tutti frutti" = 1)
	is_decorated = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

//////////////////////////SLIME DONUTS/////////////////////////

/obj/item/food/donut/jelly/slimejelly
	name = "果酱甜甜圈"
	desc = "酱紫好吗?"
	extra_reagent = /datum/reagent/toxin/slimejelly
	foodtypes = JUNKFOOD | GRAIN | FRIED | TOXIC | SUGAR | BREAKFAST

/obj/item/food/donut/jelly/slimejelly/plain
	icon_state = "jelly"

/obj/item/food/donut/jelly/slimejelly/berry
	name = "果酱甜甜圈"
	desc = "和咖啡拿铁很搭."
	icon_state = "jelly_pink"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/berryjuice = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	) //Extra sprinkles to reward frosting

/obj/item/food/donut/jelly/slimejelly/trumpet
	name = "宇航员果酱甜甜圈"
	desc = "和一大杯麦芽酒搭配很好."
	icon_state = "jelly_purple"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("果酱" = 1, "甜甜圈" = 3, "紫罗兰" = 1)
	is_decorated = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/donut/jelly/slimejelly/apple
	name = "苹果酱甜甜圈"
	desc = "再来点肉桂杜松子酒就好了."
	icon_state = "jelly_green"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/applejuice = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("果酱" = 1, "甜甜圈" = 3, "青苹果" = 1)
	is_decorated = TRUE

/obj/item/food/donut/jelly/slimejelly/caramel
	name = "焦糖果酱甜甜圈"
	desc = "再来一杯热可可就好了."
	icon_state = "jelly_beige"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/caramel = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("果酱" = 1, "甜甜圈" = 3, "甜蜜" = 1)
	is_decorated = TRUE

/obj/item/food/donut/jelly/slimejelly/choco
	name = "巧克力果酱甜甜圈"
	desc = "再配上一杯热牛奶就好了."
	icon_state = "jelly_choc"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/hot_coco = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("果酱" = 1, "甜甜圈" = 4, "巧克力苦" = 1)
	decorated_icon = "jelly_choc_sprinkles"
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/donut/jelly/slimejelly/blumpkin
	name = "蓝瓜果酱甜甜圈"
	desc = "再来一杯醉醺醺的蓝瓜酒就好了."
	icon_state = "jelly_blue"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/blumpkinjuice = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("果酱" = 1, "甜甜圈" = 2, "蓝瓜" = 1)
	is_decorated = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/donut/jelly/slimejelly/bungo
	name = "bungo果酱甜甜圈"
	desc = "和一杯嬉皮之乐很搭."
	icon_state = "jelly_yellow"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/bungojuice = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("果酱" = 1, "甜甜圈" = 3, "热带风味" = 1)
	is_decorated = TRUE

/obj/item/food/donut/jelly/slimejelly/matcha
	name = "抹茶果酱甜甜圈"
	desc = "配上一杯茶再好不过了."
	icon_state = "jelly_olive"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/toxin/teapowder = 3,
		/datum/reagent/consumable/sprinkles = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("果酱" = 1, "甜甜圈" = 3, "抹茶" = 1)
	is_decorated = TRUE

/obj/item/food/donut/jelly/slimejelly/laugh
	name = "甜浆果酱甜甜圈"
	desc = "再来一瓶堡垒威士忌就好了!"
	icon_state = "jelly_laugh"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/sugar = 3,
		/datum/reagent/consumable/laughter = 3,
	)
	tastes = list("果酱" = 3, "甜甜圈" = 1, "fizzy tutti frutti" = 1)
	is_decorated = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

#undef DONUT_SPRINKLE_CHANCE
