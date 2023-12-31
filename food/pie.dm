/obj/item/food/pie
	icon = 'icons/obj/food/piecake.dmi'
	inhand_icon_state = "pie"
	bite_consumption = 3
	w_class = WEIGHT_CLASS_NORMAL
	max_volume = 80
	food_reagents = list(/datum/reagent/consumable/nutriment = 10, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("派" = 1)
	foodtypes = GRAIN
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_2
	/// type is spawned 5 at a time and replaces this pie when processed by cutting tool    type每次生成5个，并在切割工具处理时替换此pie
	var/obj/item/food/pieslice/slice_type
	/// so that the yield can change if it isnt 5     如果不是5，收益率会改变
	var/yield = 5

/obj/item/food/pie/make_processable()
	if (slice_type)
		AddElement(/datum/element/processable, TOOL_KNIFE, slice_type, yield, table_required = TRUE, screentip_verb = "Slice")

/obj/item/food/pieslice
	name = "小块的派"
	icon = 'icons/obj/food/piecake.dmi'
	w_class = WEIGHT_CLASS_TINY
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("pie" = 1, "uncertainty" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pie/plain
	name = "简单派"
	desc = "一个简单的派，仍然很好吃."
	icon_state = "pie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("派" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/pie/cream
	name = "奶油香蕉派"
	desc = "就像在小丑星球上! HONK!"
	icon_state = "pie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/consumable/banana = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	var/stunning = TRUE
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/cream/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!.) //if we're not being caught
		splat(hit_atom)

/obj/item/food/pie/cream/proc/splat(atom/movable/hit_atom)
	if(isliving(loc)) //someone caught us!
		return
	var/turf/hit_turf = get_turf(hit_atom)
	new/obj/effect/decal/cleanable/food/pie_smudge(hit_turf)
	if(reagents?.total_volume)
		reagents.expose(hit_atom, TOUCH)
	var/is_creamable = TRUE
	if(isliving(hit_atom))
		var/mob/living/living_target_getting_hit = hit_atom
		if(stunning)
			living_target_getting_hit.Paralyze(2 SECONDS) //splat!
		if(iscarbon(living_target_getting_hit))
			is_creamable = !!(living_target_getting_hit.get_bodypart(BODY_ZONE_HEAD))
		if(is_creamable)
			living_target_getting_hit.adjust_eye_blur(2 SECONDS)
		living_target_getting_hit.visible_message(span_warning("[living_target_getting_hit] is creamed by [src]!"), span_userdanger("You've been creamed by [src]!"))
		playsound(living_target_getting_hit, SFX_DESECRATION, 50, TRUE)
	if(is_creamable && is_type_in_typecache(hit_atom, GLOB.creamable))
		hit_atom.AddComponent(/datum/component/creamed, src)
	qdel(src)

/obj/item/food/pie/cream/nostun
	stunning = FALSE

/obj/item/food/pie/berryclafoutis
	name = "克拉芙提"
	desc = "没有黑鸟，这是个好兆头."
	icon_state = "berryclafoutis"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/berryjuice = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1, "黑莓" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	venue_value = FOOD_PRICE_NORMAL
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/bearypie
	name = "熊肉派"
	desc = "没有棕熊，这是个好兆头."
	icon_state = "bearypie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("派" = 1, "肉" = 1, "鲑鱼" = 1)
	foodtypes = GRAIN | SUGAR | MEAT | FRUIT
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pie/meatpie
	name = "肉派" // meat-pie
	icon_state = "meatpie"
	desc = "一个老理发师的食谱，非常好吃!"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 4,
		/datum/reagent/consumable/nutriment/protein = 2,
	)
	tastes = list("派" = 1, "肉" = 1)
	foodtypes = GRAIN | MEAT
	venue_value = FOOD_PRICE_NORMAL
	slice_type = /obj/item/food/pieslice/meatpie
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/meatpie
	name = "小块肉派"
	desc = "Oh nice,肉派!"
	icon_state = "meatpie_slice"
	tastes = list("派" = 1, "肉" = 1)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/tofupie
	name = "豆腐派"
	icon_state = "meatpie"
	desc = "一块美味的豆腐派."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/protein = 1,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("派" = 1, "豆腐" = 1)
	foodtypes = GRAIN | VEGETABLES
	slice_type = /obj/item/food/pieslice/tofupie
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/tofupie
	name = "小块豆腐派"
	desc = "哇，这是肉派!...等等？"
	icon_state = "meatpie_slice"
	tastes = list("派" = 1, "失望" = 1, "豆腐" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/amanita_pie
	name = "毒鹅膏派" // amanita pie
	desc = "又甜又好吃的有毒蘑菇派."
	icon_state = "amanita_pie"
	bite_consumption = 4
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/toxin/amatoxin = 3,
		/datum/reagent/drug/mushroomhallucinogen = 1,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1, "蘑菇" = 1)
	foodtypes = GRAIN | VEGETABLES | TOXIC | GROSS
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/plump_pie
	name = "厚头菇派"
	desc = "我敢打赌你一定喜欢用蘑菇做的东西!"
	icon_state = "plump_pie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1, "蘑菇" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/plump_pie/Initialize(mapload)
	var/fey = prob(10)
	if(fey)
		name = "异常的厚头菇派"
		desc = "微波炉被一股奇怪的情绪所占据!它做了一个异常的派!"
		food_reagents = list(
			/datum/reagent/consumable/nutriment = 11,
			/datum/reagent/medicine/omnizine = 5,
			/datum/reagent/consumable/nutriment/vitamin = 4,
		)
	. = ..()

/obj/item/food/pie/xemeatpie
	name = "异形派"
	icon_state = "xenomeatpie"
	desc = "美味的肉饼,可能有点异端."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("派" = 1, "肉" = 1, "酸液" = 1)
	foodtypes = GRAIN | MEAT
	slice_type = /obj/item/food/pieslice/xemeatpie
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/xemeatpie
	name = "小块异形派"
	desc = "哎我草...它好像还在动?"
	icon_state = "xenopie_slice"
	tastes = list("派" = 1, "酸液" = 1, "肉" = 1)
	foodtypes = GRAIN | MEAT
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/applepie
	name = "苹果派"
	desc = "一个包裹着甜甜的爱的派."
	icon_state = "applepie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("派" = 1, "苹果" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	slice_type = /obj/item/food/pieslice/apple
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/apple
	name = "小块苹果派"
	desc = "一片苹果派，温暖的秋日回忆浮现在你的心头."
	icon_state = "applepie_slice"
	tastes = list("派" = 1, "苹果" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3


/obj/item/food/pie/cherrypie
	name = "樱桃派"
	desc = "尝起来非常美味，会让一个成年人流下热泪."
	icon_state = "cherrypie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("派" = 7, "Nicole Paige Brooks" = 2)
	foodtypes = GRAIN | FRUIT | SUGAR
	slice_type = /obj/item/food/pieslice/cherry
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/cherry
	name = "小块樱桃派"
	desc = "一片美味的樱桃派,我希望是欧洲酸樱桃!"
	icon_state = "cherrypie_slice"
	tastes = list("派" = 1, "樱桃" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/pumpkinpie
	name = "南瓜派"
	desc = "秋日的美味佳肴."
	icon_state = "pumpkinpie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("派" = 1, "南瓜" = 1)
	foodtypes = GRAIN | VEGETABLES | SUGAR
	slice_type = /obj/item/food/pieslice/pumpkin
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/pumpkin
	name = "小块南瓜派"
	desc = "一片美味的南瓜派，上面点缀了一点鲜奶油，完美."
	icon_state = "pumpkinpieslice"
	tastes = list("派" = 1, "南瓜" = 1)
	foodtypes = GRAIN | VEGETABLES | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/appletart
	name = "金苹果派"
	desc = "一种无法通过金属探测仪的美味甜点."
	icon_state = "gappletart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 8,
		/datum/reagent/gold = 5,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1, "苹果" = 1, "奢华" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pie/grapetart
	name = "葡萄馅饼"
	desc = "美味的甜点，让你想起没有做完的葡萄酒。"
	icon_state = "grapetart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1, "葡萄" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pie/mimetart
	name = "默剧馅饼"
	desc = "..."
	icon_state = "mimetart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 5,
		/datum/reagent/consumable/nutriment/vitamin = 5,
		/datum/reagent/consumable/nothing = 10,
	)
	tastes = list("nothing" = 3)
	foodtypes = GRAIN

/obj/item/food/pie/berrytart
	name = "浆果馅饼"
	desc = "一种美味的甜点，在馅饼皮上各种各样的小浆果."
	icon_state = "berrytart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("派" = 1, "浆果" = 2)
	foodtypes = GRAIN | FRUIT

/obj/item/food/pie/cocolavatart
	name = "巧克力熔岩馅饼"
	desc = "一种有着巧克力流心的甜点." //But it doesn't even contain chocolate...
	icon_state = "cocolavatart"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 4,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1, "黑巧克力" = 3)
	foodtypes = GRAIN | SUGAR

/obj/item/food/pie/blumpkinpie
	name = "蓝瓜派"
	desc = "一个奇怪的蓝色派，用有毒的蓝瓜做成."
	icon_state = "blumpkinpie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 13,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("派" = 1, "满口池水" = 1)
	foodtypes = GRAIN | VEGETABLES
	slice_type = /obj/item/food/pieslice/blumpkin
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/blumpkin
	name = "小块蓝瓜派"
	desc = "一片美味的南瓜派，上面点缀了一点鲜奶油. 这个可以吃吗?"
	icon_state = "blumpkinpieslice"
	tastes = list("派" = 1, "满口池水" = 1)
	foodtypes = GRAIN | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/dulcedebatata
	name = "甜土豆派" // dulce de batata
	desc = "一块美味的甜土豆派."
	icon_state = "dulcedebatata"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 14,
		/datum/reagent/consumable/nutriment/vitamin = 8,
	)
	tastes = list("果酱" = 1, "甜土豆" = 1)
	foodtypes = VEGETABLES | SUGAR
	venue_value = FOOD_PRICE_EXOTIC
	slice_type = /obj/item/food/pieslice/dulcedebatata
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/dulcedebatata
	name = "小块甜土豆派"
	desc = "一块有果酱的美味甜土豆派."
	icon_state = "dulcedebatataslice"
	tastes = list("jelly" = 1, "sweet potato" = 1)
	foodtypes = VEGETABLES | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/frostypie
	name = "霜冻派"
	desc = "犹如寒气逼人的蓝光一闪."
	icon_state = "frostypie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 14,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("薄荷清香" = 1, "派" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	slice_type = /obj/item/food/pieslice/frostypie
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/frostypie
	name = "小块霜冻派"
	desc = "犹如寒气逼人的冷冻酮!"
	icon_state = "frostypie_slice"
	tastes = list("派" = 1, "薄荷清香" = 1)
	foodtypes = GRAIN | FRUIT | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/baklava
	name = "果仁蜜饼"
	desc = "由果仁和薄皮面饼做成的健康小吃."
	icon_state = "baklava"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 6,
	)
	tastes = list("果仁" = 1, "派" = 1)
	foodtypes = NUTS | SUGAR
	slice_type = /obj/item/food/pieslice/baklava
	yield = 6
	crafting_complexity = FOOD_COMPLEXITY_4

/obj/item/food/pieslice/baklava
	name = "小块果仁蜜饼"
	desc = "由果仁和薄皮面饼做成的健康小吃."
	icon_state = "baklavaslice"
	tastes = list("nuts" = 1, "pie" = 1)
	foodtypes = NUTS | SUGAR

/obj/item/food/pie/frenchsilkpie
	name = "法式丝绸派"
	desc = "一种由奶油巧克力慕斯馅料制成的华丽派，顶部是一层鲜奶油和巧克力屑，可以用刀切割。"
	icon_state = "frenchsilkpie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 12,
		/datum/reagent/consumable/nutriment/vitamin = 4,
	)
	tastes = list("派" = 1, "丝滑巧克力" = 1, "鲜奶油" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	slice_type = /obj/item/food/pieslice/frenchsilk
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pieslice/frenchsilk
	name = "小块法式丝绸派"
	desc = "一种由奶油巧克力慕斯馅料制成的华丽派，顶部是一层鲜奶油和巧克力屑.好吃到让你哭出来."
	icon_state = "frenchsilkpieslice"
	tastes = list("派" = 1, "丝滑巧克力" = 1, "鲜奶油" = 1)
	foodtypes = GRAIN | DAIRY | SUGAR
	crafting_complexity = FOOD_COMPLEXITY_3

/obj/item/food/pie/shepherds_pie
	name = "牧羊人派"
	desc = "在一层奶油土豆泥下有着烘烤的肉末和什锦蔬菜.可以切成小块."
	icon_state = "shepherds_pie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 40,
		/datum/reagent/consumable/nutriment/vitamin = 12,
		/datum/reagent/consumable/nutriment/protein = 20,
	)
	tastes = list("多汁的肉" = 2, "奶油土豆泥" = 2, "什锦烤蔬菜" = 2)
	foodtypes = MEAT | DAIRY | VEGETABLES
	slice_type = /obj/item/food/pieslice/shepherds_pie
	yield = 4
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pieslice/shepherds_pie
	name = "小块牧羊人派"
	desc = "在一层奶油土豆泥下有着烘烤的肉末和什锦蔬菜，这是危险的美味."
	icon_state = "shepherds_pie_slice"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 10,
		/datum/reagent/consumable/nutriment/vitamin = 3,
		/datum/reagent/consumable/nutriment/protein = 5,
	)
	tastes = list("多汁的肉" = 1, "奶油土豆泥" = 1, "什锦烤蔬菜" = 1)
	foodtypes = MEAT | DAIRY | VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_5

/obj/item/food/pie/asdfpie
	name = "派中派"
	desc = "我给你烤了个派!"
	icon_state = "asdfpie"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 16,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	tastes = list("派" = 1, "遥远的2010年" = 1)
	foodtypes = GRAIN
	crafting_complexity = FOOD_COMPLEXITY_2
