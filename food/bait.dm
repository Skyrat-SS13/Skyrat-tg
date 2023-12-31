/obj/item/food/bait
	name = "这是鱼饵"
	desc = "你上钩了."
	icon = 'icons/obj/fishing.dmi'
	/// Quality trait of this bait
	/// 这种鱼饵的质量trait
	var/bait_quality = TRAIT_BASIC_QUALITY_BAIT
	/// Icon state added to main fishing rod icon when this bait is equipped
	/// 当这个诱饵装备时，图标状态添加到主鱼竿图标
	var/rod_overlay_icon_state

/obj/item/food/bait/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, bait_quality, INNATE_TRAIT)

/obj/item/food/bait/worm
	name = "蠕虫"
	desc = "这是一条从鱼饵罐里爬出来的虫子。你不会吃的，对吧?"
	icon = 'icons/obj/fishing.dmi'
	icon_state = "worm"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 1)
	tastes = list("meat" = 1, "worms" = 1)
	foodtypes = GROSS | MEAT | BUGS
	w_class = WEIGHT_CLASS_TINY
	bait_quality = TRAIT_BASIC_QUALITY_BAIT
	rod_overlay_icon_state = "worm_overlay"

/obj/item/food/bait/worm/premium
	name = "黏蠕虫"
	desc = "这蠕虫看起来见多识广."
	bait_quality = TRAIT_GOOD_QUALITY_BAIT

/obj/item/food/bait/natural
	name = "天然饵料"
	desc = "鱼似乎怎么也吃不够!"
	icon = 'icons/obj/medical/chemical.dmi'
	icon_state = "pill9"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	inhand_icon_state = "pen"
	food_reagents = list(/datum/reagent/drug/kronkaine = 1)
	tastes = list("hypocrisy" = 1)
	bait_quality = TRAIT_GREAT_QUALITY_BAIT

/obj/item/food/bait/doughball
	name = "小块面团"
	desc = "一小块面团。简单但有效的鱼饵."
	icon = 'icons/obj/fishing.dmi'
	icon_state = "doughball"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 1)
	tastes = list("dough" = 1)
	foodtypes = GRAIN
	w_class = WEIGHT_CLASS_TINY
	bait_quality = TRAIT_BASIC_QUALITY_BAIT
	rod_overlay_icon_state = "dough_overlay"

/**
 * Bound to the tech fishing rod, from which cannot be removed,
 * Bait-related preferences and traits, both negative and positive,
 * should be ignored by this bait.
 * Otherwise it'd be hard/impossible to cath some fish with it,
 * making that rod a shoddy choice in the long run.
 * 与tech fishing rod捆绑在一起，无法移除，与诱饵相关的preferences和traits，无论是消极的还是积极的，都应与这个诱饵无关。
 * 否则，用它很难/不可能钓到鱼，从长远来看，这是一个劣质的选择。
 */
/obj/item/food/bait/doughball/synthetic
	name = "人造鱼饵"
	icon_state = "doughball"
	preserved_food = TRUE

/obj/item/food/bait/doughball/synthetic/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, OMNI_BAIT_TRAIT, INNATE_TRAIT)
