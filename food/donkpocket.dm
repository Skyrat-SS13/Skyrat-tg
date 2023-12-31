////////////////////////////////////////////DONK POCKETS////////////////////////////////////////////

/obj/item/food/donkpocket
	name = "\improper 原味口袋饼"
	desc = "经验丰富的叛徒的最爱."
	icon_state = "donkpocket"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("肉" = 2, "面饼" = 2, "怠惰" = 1)
	foodtypes = GRAIN
	food_flags = FOOD_FINGER_FOOD
	w_class = WEIGHT_CLASS_SMALL
	crafting_complexity = FOOD_COMPLEXITY_3

	/// What type of donk pocket we're warmed into via baking or microwaving.
	var/warm_type = /obj/item/food/donkpocket/warm
	/// The lower end for how long it takes to bake
	var/baking_time_short = 25 SECONDS
	/// The upper end for how long it takes to bake
	var/baking_time_long = 30 SECONDS
	/// The reagents added when microwaved. Needed since microwaving ignores food_reagents
	var/static/list/added_reagents = list(/datum/reagent/medicine/omnizine = 6)
	/// The reagents that most child types add when microwaved. Needed because you can't override static lists.
	var/static/list/child_added_reagents = list(/datum/reagent/medicine/omnizine = 2)

/obj/item/food/donkpocket/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), TRUE, TRUE, added_reagents)

/obj/item/food/donkpocket/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, added_reagents)

/obj/item/food/donkpocket/warm
	name = "温原味口袋饼"
	desc = "经验丰富的叛徒最爱的热食."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/omnizine = 6,
	)
	tastes = list("肉" = 2, "面饼" = 2, "怠惰" = 1)
	foodtypes = GRAIN

	// Warmed donk pockets will burn if you leave them in the oven or microwave.
	warm_type = /obj/item/food/badrecipe
	baking_time_short = 10 SECONDS
	baking_time_long = 15 SECONDS

/obj/item/food/dankpocket
	name = "\improper 哈草口袋饼"
	desc = "经验丰富的植物学家的首选食物。."
	icon_state = "dankpocket"
	food_reagents = list(
		/datum/reagent/toxin/lipolicide = 3,
		/datum/reagent/drug/space_drugs = 3,
		/datum/reagent/consumable/nutriment = 4,
	)
	tastes = list("肉" = 2, "面饼" = 2)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/donkpocket/spicy
	name = "\improper 辣味口袋饼"
	desc = "经典的休闲食品,现在有了辛辣味道."
	icon_state = "donkpocketspicy"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/capsaicin = 2,
	)
	tastes = list("肉" = 2, "面饼" = 2, "辣味" = 1)
	foodtypes = GRAIN
	warm_type = /obj/item/food/donkpocket/warm/spicy

/obj/item/food/donkpocket/spicy/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), TRUE, TRUE, child_added_reagents)

/obj/item/food/donkpocket/spicy/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, child_added_reagents)

/obj/item/food/donkpocket/warm/spicy
	name = "温辣味口袋饼"
	desc = "经典的零食,可能有点太辣了."
	icon_state = "donkpocketspicy"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/capsaicin = 5,
	)
	tastes = list("肉" = 2, "面饼" = 2, "热辣味" = 2)
	foodtypes = GRAIN

/obj/item/food/donkpocket/teriyaki
	name = "\improper 照烧味口袋饼"
	desc = "这是一种东亚风味的经典太空小吃."
	icon_state = "donkpocketteriyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/soysauce = 2,
	)
	tastes = list("肉" = 2, "面饼" = 2, "酱油" = 2)
	foodtypes = GRAIN
	warm_type = /obj/item/food/donkpocket/warm/teriyaki

/obj/item/food/donkpocket/teriyaki/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), TRUE, TRUE, child_added_reagents)

/obj/item/food/donkpocket/teriyaki/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, child_added_reagents)

/obj/item/food/donkpocket/warm/teriyaki
	name = "温照烧味口袋饼"
	desc = "这是一种东亚风味的经典车站小吃,又热又多汁."
	icon_state = "donkpocketteriyaki"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/soysauce = 2,
	)
	tastes = list("肉" = 2, "面饼" = 2, "酱油" = 2)
	foodtypes = GRAIN

/obj/item/food/donkpocket/pizza
	name = "\improper 披萨味口袋饼"
	desc = "美味,芝士含量吓人."
	icon_state = "donkpocketpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/tomatojuice = 2,
	)
	tastes = list("肉" = 2, "面饼" = 2, "芝士"= 2)
	foodtypes = GRAIN
	warm_type = /obj/item/food/donkpocket/warm/pizza

/obj/item/food/donkpocket/pizza/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), TRUE, TRUE, child_added_reagents)

/obj/item/food/donkpocket/pizza/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, child_added_reagents)

/obj/item/food/donkpocket/warm/pizza
	name = "温披萨味口袋饼"
	desc = "热芝士更是美味."
	icon_state = "donkpocketpizza"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/tomatojuice = 2,
	)
	tastes = list("肉" = 2, "面饼" = 2, "热芝士"= 2)
	foodtypes = GRAIN

/obj/item/food/donkpocket/honk
	name = "\improper 香蕉味口袋饼"
	desc = "一款赢得了小丑和人类的心的优等口袋饼."
	icon_state = "donkpocketbanana"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/banana = 4,
	)
	tastes = list("香蕉" = 2, "面饼" = 2, "童真" = 1)
	foodtypes = GRAIN
	warm_type = /obj/item/food/donkpocket/warm/honk
	crafting_complexity = FOOD_COMPLEXITY_3
	var/static/list/honk_added_reagents = list(
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/laughter = 6,
	)

/obj/item/food/donkpocket/honk/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), TRUE, TRUE, honk_added_reagents)

/obj/item/food/donkpocket/honk/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, honk_added_reagents)

/obj/item/food/donkpocket/warm/honk
	name = "热香蕉味口袋饼"
	desc = "屡获殊荣的优等口袋饼,现在更'火'了."
	icon_state = "donkpocketbanana"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/banana = 4,
		/datum/reagent/consumable/laughter = 6,
	)
	tastes = list("香蕉" = 2, "面饼" = 2, "童真" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/donkpocket/berry
	name = "\improper 浆果味口袋饼"
	desc = "一种非常甜的口袋饼,最初用于“甜点风暴”行动."
	icon_state = "donkpocketberry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/berryjuice = 3,
	)
	tastes = list("面饼" = 2, "果酱" = 2)
	foodtypes = GRAIN
	warm_type = /obj/item/food/donkpocket/warm/berry

/obj/item/food/donkpocket/berry/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), TRUE, TRUE, child_added_reagents)

/obj/item/food/donkpocket/berry/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, child_added_reagents)

/obj/item/food/donkpocket/warm/berry
	name = "温浆果味口袋饼"
	desc = "一种非常甜的口袋版,现在热气腾腾而且美味."
	icon_state = "donkpocketberry"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/consumable/berryjuice = 3,
	)
	tastes = list("面饼" = 2, "热果酱" = 2)
	foodtypes = GRAIN

/obj/item/food/donkpocket/gondola
	name = "\improper 贡多拉口袋饼"
	desc = "至少,在制作中是否使用真正的贡多拉肉是有争议的." //Only a monster would craft this.
	icon_state = "donkpocketgondola"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/gondola_mutation_toxin = 5,
	)
	tastes = list("肉" = 2, "面饼" = 2, "内在的宁静" = 1)
	foodtypes = GRAIN

	warm_type = /obj/item/food/donkpocket/warm/gondola
	var/static/list/gondola_added_reagents = list(
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/gondola_mutation_toxin = 5,
	)

/obj/item/food/donkpocket/gondola/make_bakeable()
	AddComponent(/datum/component/bakeable, warm_type, rand(baking_time_short, baking_time_long), TRUE, TRUE, gondola_added_reagents)

/obj/item/food/donkpocket/gondola/make_microwaveable()
	AddElement(/datum/element/microwavable, warm_type, gondola_added_reagents)

/obj/item/food/donkpocket/warm/gondola
	name = "温贡多拉口袋饼"
	desc = "至少,在制作中是否使用真正的贡多拉肉是有争议的."
	icon_state = "donkpocketgondola"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/medicine/omnizine = 2,
		/datum/reagent/gondola_mutation_toxin = 10,
	)
	tastes = list("肉" = 2, "面饼" = 2, "内在的宁静" = 1)
	foodtypes = GRAIN
