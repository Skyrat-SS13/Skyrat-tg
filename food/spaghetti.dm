///spaghetti prototype used by all subtypes
/obj/item/food/spaghetti
	icon = 'icons/obj/food/spaghetti.dmi'
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 1,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_CHEAP
	crafting_complexity = FOOD_COMPLEXITY_2

// Why are you putting cooked spaghetti in your pockets?
/obj/item/food/spaghetti/make_microwaveable()
	var/list/display_message = list(
		span_notice("一些湿的东西从他们的口袋里掉出来，那是... [name]?"),
		span_warning("哎呀!你口袋里的[name]都掉出来了!"))
	AddComponent(/datum/component/spill, display_message, 'sound/effects/splat.ogg', /datum/memory/lost_spaghetti)

	return ..()

/obj/item/food/spaghetti/raw
	name = "意大利面"
	desc = "这就是意大利面!"
	icon_state = "spaghetti"
	tastes = list("意大利面" = 1)
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/spaghetti/make_bakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/spaghetti/boiledspaghetti, rand(15 SECONDS, 20 SECONDS), TRUE, TRUE)

/obj/item/food/spaghetti/raw/make_microwaveable()
	AddElement(/datum/element/microwavable, /obj/item/food/spaghetti/boiledspaghetti)

/obj/item/food/spaghetti/boiledspaghetti
	name = "煮意大利面"
	desc = "一道普通的面条，这需要更多的配料."
	icon_state = "spaghettiboiled"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/spaghetti/boiledspaghetti/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/customizable_reagent_holder, null, CUSTOM_INGREDIENT_ICON_SCATTER, max_ingredients = 6)

/obj/item/food/spaghetti/pastatomato
	name = "意大利面"
	desc = "意大利面和番茄!"
	icon_state = "pastatomato"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/tomatojuice = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("意大利面" = 1, "番茄" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/pastatomato/soulful
	name = "灵魂食品"
	desc = "可能是美国人的童年回忆吧，传统上由美国南方黑人食用的食物，如猪肠、猪蹄和羽衣甘蓝等。"
	food_reagents = list(
		// same as normal pasghetti
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/tomatojuice = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		// where the soul comes from
		/datum/reagent/pax = 5,
		/datum/reagent/medicine/psicodine = 10,
		/datum/reagent/medicine/morphine = 5,
	)
	tastes = list("怀旧" = 1, "幸福" = 1)

/obj/item/food/spaghetti/copypasta
	name = "复制意面"
	desc = "此为双关梗：copypasta（复制粘贴）。"
	icon_state = "copypasta"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/tomatojuice = 20,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("意面" = 1, "番茄" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/meatballspaghetti
	name = "肉丸意大利面"
	desc = "这是一个美味的肉丸!"
	icon_state = "meatballspaghetti"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 10,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("意大利面" = 1, "肉" = 1)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/spesslaw
	name = "律师最爱的意大利面" // spesslaw
	desc = "律师的最爱，也是一种意大利面."
	icon_state = "spesslaw"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 20,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	tastes = list("意大利面" = 1, "肉" = 1)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/chowmein
	name = "炒面"
	desc = "加了蔬菜和肉的炒面."
	icon_state = "chowmein"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("面条" = 1, "肉" = 1, "蔬菜" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/spaghetti/beefnoodle
	name = "牛肉面"
	desc = "营养美味还有牛肉."
	icon_state = "beefnoodle"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/liquidgibs = 3,
	)
	tastes = list("面条" = 1, "肉" = 1)
	foodtypes = GRAIN | MEAT | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/spaghetti/butternoodles
	name = "黄油面"
	desc = "覆盖着美味黄油的面条，简单滑滑，但很美味。"
	icon_state = "butternoodles"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("面条" = 1, "黄油" = 1)
	foodtypes = GRAIN | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/spaghetti/mac_n_cheese
	name = "奶酪通心粉"
	desc = "用最好的奶酪和面包屑做成的，然而它不能像Ready-Donk那样搔痒。"
	icon_state = "mac_n_cheese"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 9,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("奶酪" = 1, "面包屑" = 1, "通心粉" = 1)
	foodtypes = GRAIN | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/shoyu_tonkotsu_ramen
	name = "豚骨拉面"
	desc = "一种简单的拉面，由肉、鸡蛋、洋葱和一片海苔制成。."
	icon_state = "shoyu_tonkotsu_ramen"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 6,
	)
	tastes = list("拉面" = 5, "肉" = 3, "鸡蛋" = 4, "海苔" = 2)
	foodtypes = GRAIN | MEAT | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/kitakata_ramen
	name = "喜多方拉面"
	desc = "由肉、蘑菇、洋葱和大蒜组成的丰盛的拉面,常给病人以温暖内心。"
	icon_state = "kitakata_ramen"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/vitamin = 6,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("拉面" = 5, "肉" = 4, "蘑菇" = 3, "洋葱" = 2)
	foodtypes = GRAIN | MEAT | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/kitsune_udon
	name = "油炸豆腐乌冬面"
	desc = "由油炸豆腐、洋葱、糖和酱油做成甜而可口的乌冬面 ，原名kitsune udon,来源于一个古老的民间故事，讲的是一只狐狸喜欢吃炸豆腐。"
	icon_state = "kitsune_udon"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("乌冬面" = 5, "乌冬面" = 4, "糖" = 3, "酱油" = 2)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/nikujaga
	name = "日式马铃薯炖肉"
	desc = "一道美味的日式炖菜，有面条、洋葱、土豆、肉和什锦蔬菜。"
	icon_state = "nikujaga"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 16,
		/datum/reagent/consumable/nutriment/vitamin = 12,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("面条" = 5, "肉" = 4, "土豆" = 3, "洋葱" = 2, "什锦蔬菜" = 2)
	foodtypes = GRAIN | VEGETABLES | MEAT
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/pho
	name = "越南河粉"
	desc = "一种越南菜，由面条、蔬菜和肉制成，这是一种很受欢迎的街头小吃。"
	icon_state = "pho"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 8,
		/datum/reagent/consumable/nutriment/protein = 8,
	)
	tastes = list("河粉" = 5, "肉" = 4, "卷心菜" = 3, "洋葱" = 2, "草药" = 2)
	foodtypes = GRAIN | VEGETABLES | MEAT
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/spaghetti/pad_thai
	name = "泰式炒河粉"
	desc = "用花生、豆腐、酸橙和洋葱做成的炒面，在泰国很受欢迎。"
	icon_state = "pad_thai"
	trash_type = /obj/item/reagent_containers/cup/bowl
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 15,
		/datum/reagent/consumable/nutriment/vitamin = 10,
		/datum/reagent/consumable/nutriment/protein = 4,
	)
	tastes = list("河粉" = 5, "炸豆腐" = 4, "酸橙" = 2, "花生" = 3, "洋葱" = 2)
	foodtypes = GRAIN | VEGETABLES | NUTS | FRUIT
	crafting_complexity = FOOD_COMPLEXITY_4
