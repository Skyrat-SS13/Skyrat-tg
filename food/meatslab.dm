/obj/item/food/meat
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 4)
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/obj/food/meat.dmi'
	var/subjectname = ""
	var/subjectjob = null
	var/blood_decal_type = /obj/effect/decal/cleanable/blood

/obj/item/food/meat/Initialize(mapload)
	. = ..()

	if(!blood_decal_type)
		return

	AddComponent(
		/datum/component/blood_walk,\
		blood_type = blood_decal_type,\
		blood_spawn_chance = 45,\
		max_blood = custom_materials[custom_materials[1]],\
	)

	AddComponent(
		/datum/component/bloody_spreader,\
		blood_left = custom_materials[custom_materials[1]],\
		blood_dna = list("meaty DNA" = "MT-"),\
		diseases = null,\
	)

/obj/item/food/meat/slab
	name = "肉"
	desc = "一块肉."
	icon_state = "meat"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/fat = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	) //Meat has fats that a food processor can process into cooking oil
	tastes = list("肉" = 1)
	foodtypes = MEAT | RAW
	///Legacy code, handles the coloring of the overlay of the cutlets made from this.
	var/slab_color = "#FF0000"


/obj/item/food/meat/slab/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/dryable,  /obj/item/food/sosjerky/healthy)

/obj/item/food/meat/slab/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/meat/rawcutlet/plain, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切")

///////////////////////////////////// HUMAN MEATS //////////////////////////////////////////////////////

/obj/item/food/meat/slab/human
	name = "肉"
	tastes = list("嫩肉" = 1)
	foodtypes = MEAT | RAW | GORE
	venue_value = FOOD_MEAT_HUMAN

/obj/item/food/meat/slab/human/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain/human, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/human/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/meat/rawcutlet/plain/human, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切")

/obj/item/food/meat/slab/human/mutant/slime
	icon_state = "果冻肉"
	desc = "只因果冻对素食主义者来说还不够冒犯."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/toxin/slimejelly = 3,
	)
	tastes = list("黏糊糊" = 1, "果冻" = 1)
	foodtypes = MEAT | RAW | TOXIC
	venue_value = FOOD_MEAT_MUTANT_RARE
	blood_decal_type = null

/obj/item/food/meat/slab/human/mutant/golem
	icon_state = "傀儡肉"
	desc = "可食用石头,欢迎来到未来."
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/iron = 3,
	)
	tastes = list("岩石" = 1)
	foodtypes = MEAT | RAW | GROSS
	venue_value = FOOD_MEAT_MUTANT_RARE
	blood_decal_type = null

/obj/item/food/meat/slab/human/mutant/golem/adamantine
	icon_state = "精金傀儡肉" // agolemeat
	desc = "从史莱姆到符文再到厨房,这就是科学."
	foodtypes = MEAT | RAW | GROSS

/obj/item/food/meat/slab/human/mutant/lizard
	icon_state = "蜥蜴肉"
	desc = "侏罗纪美味."
	tastes = list("meat" = 4, "scales" = 1)
	foodtypes = MEAT | RAW | GORE
	venue_value = FOOD_MEAT_MUTANT
	starting_reagent_purity = 0.4 // Take a look at their diet

/obj/item/food/meat/slab/human/mutant/lizard/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain/human/lizard, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/human/mutant/plant
	icon_state = "植物肉" // plant meat
	desc = "健康饮食的乐趣和同类相食的乐趣."
	tastes = list("蔬菜沙拉" = 1, "木纤维" = 1)
	foodtypes = VEGETABLES
	venue_value = FOOD_MEAT_MUTANT_RARE
	blood_decal_type = /obj/effect/decal/cleanable/food/plant_smudge

/obj/item/food/meat/slab/human/mutant/shadow
	icon_state = "影之肉" // shadowmeat
	desc = "哦,深渊."
	tastes = list("黑暗" = 1, "肉" = 1)
	foodtypes = MEAT | RAW | GORE
	venue_value = FOOD_MEAT_MUTANT_RARE

/obj/item/food/meat/slab/human/mutant/fly
	icon_state = "蠕动的肉"
	desc = "没有什么比充满蛆的放射性突变体肉更美味的了."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/uranium = 3,
	)
	tastes = list("蛆虫" = 1, "反应堆炉芯" = 1)
	foodtypes = MEAT | RAW | GROSS | BUGS | GORE
	venue_value = FOOD_MEAT_MUTANT
	blood_decal_type = /obj/effect/decal/cleanable/insectguts

/obj/item/food/meat/slab/human/mutant/moth
	icon_state = "蛾子肉"
	desc = "令人讨厌的鳞粉,不过还是挺漂亮的."
	tastes = list("灰尘" = 1, "鳞粉" = 1, "肉" = 2)
	foodtypes = MEAT | RAW | BUGS | GORE
	venue_value = FOOD_MEAT_MUTANT

/obj/item/food/meat/slab/human/mutant/skeleton
	name = "骨头"
	icon_state = "skeletonmeat"
	desc = "过去已去,未来已来."
	tastes = list("bone" = 1)
	foodtypes = GROSS | GORE
	venue_value = FOOD_MEAT_MUTANT_RARE
	blood_decal_type = null

/obj/item/food/meat/slab/human/mutant/skeleton/make_processable()
	return //skeletons dont have cutlets

/obj/item/food/meat/slab/human/mutant/zombie
	name = "肉(腐烂)"
	icon_state = "rottenmeat"
	desc = "能当作半个花园肥料."
	tastes = list("brains" = 1, "meat" = 1)
	foodtypes = RAW | MEAT | TOXIC | GORE | GROSS

/obj/item/food/meat/slab/human/mutant/ethereal
	icon_state = "etherealmeat" // etherealmeat
	desc = "So shiny you feel like ingesting it might make you shine too"
	food_reagents = list(/datum/reagent/consumable/liquidelectricity/enriched = 10)
	tastes = list("pure electricity" = 2, "meat" = 1)
	foodtypes = RAW | MEAT | TOXIC | GORE
	venue_value = FOOD_MEAT_MUTANT
	blood_decal_type = null

////////////////////////////////////// OTHER MEATS ////////////////////////////////////////////////////////

/obj/item/food/meat/slab/synthmeat
	name = "合成肉"
	icon_state = "meat_old"
	desc = "一块合成肉."
	foodtypes = RAW | MEAT //hurr durr chemicals were harmed in the production of this meat thus its non-vegan.
	venue_value = FOOD_PRICE_WORTHLESS
	starting_reagent_purity = 0.3

/obj/item/food/meat/slab/synthmeat/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain/synth, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/meatproduct
	name = "肉制品"
	icon_state = "meatproduct"
	desc = "通过回收和化学加工而出的肉制品。"
	tastes = list("调味添加剂" = 2, "变性淀粉" = 2, "天然和人造染料" = 1, "丁酸" = 1)
	foodtypes = RAW | MEAT
	starting_reagent_purity = 0.3

/obj/item/food/meat/slab/meatproduct/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/meatproduct, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/monkey
	name = "猴子肉"
	foodtypes = RAW | MEAT
	starting_reagent_purity = 0.3 // Monkeys are considered synthetic life

/obj/item/food/meat/slab/bugmeat
	name = "虫肉"
	icon_state = "spidermeat"
	foodtypes = RAW | MEAT | BUGS
	blood_decal_type = /obj/effect/decal/cleanable/insectguts

/obj/item/food/meat/slab/mouse
	name = "鼠肉"
	desc = "一块鼠肉,最好不要生吃."
	foodtypes = RAW | MEAT | GORE

/obj/item/food/meat/slab/mouse/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_MOUSE, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/meat/slab/corgi
	name = "柯基肉"
	desc = "尝起来像……嗯,你知道……"
	tastes = list("肉" = 4, "戴帽子的爱好" = 1)
	foodtypes = RAW | MEAT | GORE

/obj/item/food/meat/slab/corgi/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CORGI, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/meat/slab/mothroach
	name = "mothroach meat"
	desc = "A light slab of meat."
	foodtypes = RAW | MEAT | GROSS

/obj/item/food/meat/slab/mothroach/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/meat/slab/pug
	name = "哈巴狗肉"
	desc = "Tastes like... well you know..."
	foodtypes = RAW | MEAT | GORE

/obj/item/food/meat/slab/pug/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_PUG, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/meat/slab/killertomato
	name = "杀手番茄肉"
	desc = "从巨大番茄上切下来的肉."
	icon_state = "tomatomeat"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2)
	tastes = list("番茄" = 1)
	foodtypes = FRUIT
	blood_decal_type = /obj/effect/decal/cleanable/food/tomato_smudge

/obj/item/food/meat/slab/killertomato/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/killertomato, rand(70 SECONDS, 85 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/killertomato/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/killertomato, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切")

/obj/item/food/meat/slab/bear
	name = "熊肉"
	desc = "一块非常有男子气概的肉."
	icon_state = "bearmeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 16,
		/datum/reagent/medicine/morphine = 5,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/fat = 6,
	)
	tastes = list("肉" = 1, "鲑鱼" = 1)
	foodtypes = RAW | MEAT

/obj/item/food/meat/slab/bear/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/bear, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切")

/obj/item/food/meat/slab/bear/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/bear, rand(40 SECONDS, 70 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/bear/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_BEAR, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/meat/slab/xeno
	name = "异形肉"
	desc = "一块异形肉."
	icon_state = "xenomeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 8,
		/datum/reagent/consumable/nutriment/vitamin = 3,
	)
	bite_consumption = 4
	tastes = list("肉" = 1, "酸液" = 1)
	foodtypes = RAW | MEAT
	blood_decal_type = /obj/effect/decal/cleanable/xenoblood

/obj/item/food/meat/slab/xeno/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/xeno, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切")

/obj/item/food/meat/slab/xeno/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/xeno, rand(40 SECONDS, 70 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/spider
	name = "蜘蛛肉"
	desc = "一块蜘蛛肉,犹如卡夫卡的《变形记》."
	icon_state = "spidermeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/toxin = 3,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	tastes = list("蜘蛛网" = 1)
	foodtypes = RAW | MEAT | TOXIC
	blood_decal_type = /obj/effect/decal/cleanable/insectguts

/obj/item/food/meat/slab/spider/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/spider, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切")

/obj/item/food/meat/slab/spider/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/spider, rand(40 SECONDS, 70 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/goliath
	name = "歌莉娅肉"
	desc = "这种歌莉娅肉必须在极高温的岩浆中才能烧熟."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/toxin = 5,
		/datum/reagent/consumable/nutriment/fat = 3,
	)
	icon_state = "goliathmeat"
	tastes = list("肉" = 1)
	foodtypes = RAW | MEAT | TOXIC

/obj/item/food/meat/slab/goliath/burn()
	visible_message(span_notice("[src] 烧好了!"))
	new /obj/item/food/meat/steak/goliath(loc)
	qdel(src)

/obj/item/food/meat/slab/meatwheat
	name = "肉麦团"
	desc = "这看起来不像肉,但你的标准一开始就没那么高。"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 4, /datum/reagent/consumable/nutriment/vitamin = 2, /datum/reagent/blood = 5, /datum/reagent/consumable/nutriment/fat = 1)
	icon_state = "meatwheat_clump"
	bite_consumption = 4
	tastes = list("肉" = 1, "麦子" = 1)
	foodtypes = GRAIN

/obj/item/food/meat/slab/gorilla
	name = "大猩猩肉"
	desc = "比猴子肉还要肉."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/fat = 5, //Plenty of fat!
	)

/obj/item/food/meat/rawbacon
	name = "生培根"
	desc = "一条生培根."
	icon_state = "baconb"
	bite_consumption = 2
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/fat = 3,
	)
	tastes = list("培根" = 1)
	foodtypes = RAW | MEAT
	crafting_complexity = FOOD_COMPLEXITY_1

/obj/item/food/meat/rawbacon/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/bacon, rand(25 SECONDS, 45 SECONDS), TRUE, TRUE)

/obj/item/food/meat/bacon
	name = "培根"
	desc = "一条美味的培根."
	icon_state = "baconcookedb"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/fat = 2,
	)
	tastes = list("培根" = 1)
	foodtypes = MEAT | BREAKFAST
	crafting_complexity = FOOD_COMPLEXITY_1
	blood_decal_type = null

/obj/item/food/meat/slab/gondola
	name = "贡多拉肉"
	desc = "根据古老的传说,食用生贡多拉肉可以使人内心平静."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/gondola_mutation_toxin = 5,
		/datum/reagent/consumable/nutriment/fat = 3,
	)
	tastes = list("肉" = 4, "宁静" = 1)
	foodtypes = RAW | MEAT | GORE

/obj/item/food/meat/slab/gondola/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/gondola, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切")

/obj/item/food/meat/slab/gondola/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/gondola, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/penguin
	name = "企鹅肉"
	icon_state = "birdmeat"
	desc = "一块企鹅肉."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 4,
		/datum/reagent/consumable/nutriment/fat = 3,
	)
	tastes = list("肉" = 1, "冷水鱼" = 1)

/obj/item/food/meat/slab/penguin/make_processable()
	. = ..()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/penguin, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切")

/obj/item/food/meat/slab/penguin/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/penguin, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/slab/rawcrab
	name = "生蟹肉"
	desc = "一堆生蟹肉."
	icon_state = "crabmeatraw"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/fat = 3,
	)
	tastes = list("生蟹肉" = 1)
	foodtypes = RAW | MEAT

/obj/item/food/meat/slab/rawcrab/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/crab, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe?

/obj/item/food/meat/crab
	name = "熟蟹肉"
	desc = "一些美味的熟蟹肉."
	icon_state = "crabmeat"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 2,
		/datum/reagent/consumable/nutriment/vitamin = 2,
		/datum/reagent/consumable/nutriment/fat = 2,
	)
	tastes = list("蟹肉" = 1)
	foodtypes = SEAFOOD
	crafting_complexity = FOOD_COMPLEXITY_1
	blood_decal_type = null

/obj/item/food/meat/slab/chicken
	name = "鸡肉"
	icon_state = "birdmeat"
	desc = "一块鸡肉,注意卫生!"
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 6) //low fat
	tastes = list("鸡肉" = 1)
	starting_reagent_purity = 1

/obj/item/food/meat/slab/chicken/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE, /obj/item/food/meat/rawcutlet/chicken, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "切")

/obj/item/food/meat/slab/chicken/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/chicken, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE) //Add medium rare later maybe? (no this is chicken)

/obj/item/food/meat/slab/chicken/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CHICKEN, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/meat/slab/pig
	name = "生猪肉"
	desc = "一块生猪肉."
	icon_state = "pig_meat"
	tastes = list("pig" = 1)
	foodtypes = RAW | MEAT | GORE
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 2,
		/datum/reagent/consumable/nutriment/fat = 5,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	) // Fatty piece
	starting_reagent_purity = 1

/obj/item/food/meat/slab/pig/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/plain/pig, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/slab/grassfed
	name = "eco肉"
	desc = "一块100%草饲的获奖肉."
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 3,
		/datum/reagent/consumable/nutriment/fat = 4,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	) // Marble 大理石
	starting_reagent_purity = 1

////////////////////////////////////// MEAT STEAKS ///////////////////////////////////////////////////////////
/obj/item/food/meat/steak
	name = "肉排"
	desc = "一块熟肉排."
	icon_state = "meatsteak"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/consumable/nutriment/fat = 2,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)
	foodtypes = MEAT
	tastes = list("肉" = 1)
	crafting_complexity = FOOD_COMPLEXITY_1
	blood_decal_type = null

/obj/item/food/meat/steak/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_MICROWAVE_COOKED, PROC_REF(on_microwave_cooked))

/obj/item/food/meat/steak/proc/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency = 1)
	SIGNAL_HANDLER

	name = "[source_item.name] 肉排"

/obj/item/food/meat/steak/plain
	foodtypes = MEAT

/obj/item/food/meat/steak/plain/human
	tastes = list("嫩肉" = 1)
	foodtypes = MEAT | GORE

///Make sure the steak has the correct name
/obj/item/food/meat/steak/plain/human/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency = 1)
	. = ..()
	if(!istype(source_item, /obj/item/food/meat))
		return

	var/obj/item/food/meat/origin_meat = source_item
	subjectname = origin_meat.subjectname
	subjectjob = origin_meat.subjectjob
	if(subjectname)
		name = "[origin_meat.subjectname] 肉排"
	else if(subjectjob)
		name = "[origin_meat.subjectjob] 肉排"


/obj/item/food/meat/steak/killertomato
	name = "杀手番茄排"
	tastes = list("番茄" = 1)
	foodtypes = FRUIT

/obj/item/food/meat/steak/bear
	name = "熊肉排"
	tastes = list("肉" = 1, "鲑鱼" = 1)

/obj/item/food/meat/steak/xeno
	name = "异形肉排"
	tastes = list("肉" = 1, "酸液" = 1)

/obj/item/food/meat/steak/spider
	name = "蜘蛛肉排"
	tastes = list("蜘蛛网" = 1)

/obj/item/food/meat/steak/goliath
	name = "歌莉娅肉排"
	desc = "一块美味的歌莉娅肉排."
	resistance_flags = LAVA_PROOF | FIRE_PROOF
	icon_state = "goliathsteak"
	trash_type = null
	tastes = list("肉" = 1, "岩石" = 1)
	foodtypes = MEAT

/obj/item/food/meat/steak/gondola
	name = "贡多拉肉排"
	tastes = list("肉" = 1, "宁静" = 1)

/obj/item/food/meat/steak/penguin
	name = "企鹅肉排"
	icon_state = "birdsteak"
	tastes = list("肉" = 1, "冷水鱼" = 1)

/obj/item/food/meat/steak/chicken
	name = "鸡肉排" //Can you have chicken steaks? Maybe this should be renamed once it gets new sprites.
	icon_state = "birdsteak"
	tastes = list("鸡肉" = 1)

/obj/item/food/meat/steak/plain/human/lizard
	name = "蜥蜴肉排"
	icon_state = "birdsteak"
	tastes = list("多汁的鸡肉" = 3, "鳞屑" = 1)
	foodtypes = MEAT | GORE

/obj/item/food/meat/steak/meatproduct
	name = "热加工肉制品"
	icon_state = "meatproductsteak"
	tastes = list("调味添加剂" = 2, "可疑的柔和口感" = 2, "天然和人造染料" = 2, "乳化剂" = 1)

/obj/item/food/meat/steak/plain/synth
	name = "合成肉排"
	desc = "合成肉排.看起来不太对劲,不是吗?"
	icon_state = "meatsteak_old"
	tastes = list("肉" = 4, "合成材料" = 1)

/obj/item/food/meat/steak/plain/pig
	name = "猪排"
	desc = "猪排."
	icon_state = "pigsteak"
	tastes = list("猪排" = 1)
	foodtypes = MEAT

//////////////////////////////// MEAT CUTLETS ///////////////////////////////////////////////////////

//Raw cutlets

/obj/item/food/meat/rawcutlet
	name = "生肉片"
	desc = "生肉片."
	icon_state = "rawcutlet"
	bite_consumption = 2
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("肉" = 1)
	foodtypes = MEAT | RAW
	var/meat_type = "meat"

/obj/item/food/meat/rawcutlet/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/plain, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/OnCreatedFromProcessing(mob/living/user, obj/item/work_tool, list/chosen_option, atom/original_atom)
	. = ..()
	if(!istype(original_atom, /obj/item/food/meat/slab))
		return
	var/obj/item/food/meat/slab/original_slab = original_atom
	var/mutable_appearance/filling = mutable_appearance(icon, "rawcutlet_coloration")
	filling.color = original_slab.slab_color
	add_overlay(filling)
	name = "生 [original_atom.name] 肉片"
	meat_type = original_atom.name

/obj/item/food/meat/rawcutlet/plain
	foodtypes = MEAT

/obj/item/food/meat/rawcutlet/plain/human
	tastes = list("嫩肉" = 1)
	foodtypes = MEAT | RAW | GORE

/obj/item/food/meat/rawcutlet/plain/human/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/plain/human, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/plain/human/OnCreatedFromProcessing(mob/living/user, obj/item/item, list/chosen_option, atom/original_atom)
	. = ..()
	if(!istype(original_atom, /obj/item/food/meat))
		return
	var/obj/item/food/meat/origin_meat = original_atom
	subjectname = origin_meat.subjectname
	subjectjob = origin_meat.subjectjob
	if(subjectname)
		name = "生 [origin_meat.subjectname] 肉片"
	else if(subjectjob)
		name = "生 [origin_meat.subjectjob] 肉片"

/obj/item/food/meat/rawcutlet/killertomato
	name = "生杀手番茄片"
	tastes = list("番茄" = 1)
	foodtypes = FRUIT
	blood_decal_type = /obj/effect/decal/cleanable/food/tomato_smudge

/obj/item/food/meat/rawcutlet/killertomato/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/killertomato, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/bear
	name = "生熊肉片"
	tastes = list("肉" = 1, "鲑鱼" = 1)

/obj/item/food/meat/rawcutlet/bear/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_BEAR, CELL_VIRUS_TABLE_GENERIC_MOB)

/obj/item/food/meat/rawcutlet/bear/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/bear, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/xeno
	name = "生异形肉片"
	tastes = list("肉" = 1, "酸液" = 1)
	blood_decal_type = /obj/effect/decal/cleanable/xenoblood

/obj/item/food/meat/rawcutlet/xeno/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/xeno, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/spider
	name = "生蜘蛛肉片"
	tastes = list("蜘蛛网" = 1)
	blood_decal_type = /obj/effect/decal/cleanable/insectguts

/obj/item/food/meat/rawcutlet/spider/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/spider, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/gondola
	name = "生贡多拉肉片"
	tastes = list("肉" = 1, "宁静" = 1)

/obj/item/food/meat/rawcutlet/gondola/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/gondola, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/penguin
	name = "生企鹅肉片"
	tastes = list("肉" = 1, "冷水鱼" = 1)

/obj/item/food/meat/rawcutlet/penguin/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/penguin, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/chicken
	name = "生鸡肉片 "
	tastes = list("鸡肉 " = 1)

/obj/item/food/meat/rawcutlet/chicken/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/cutlet/chicken, rand(35 SECONDS, 50 SECONDS), TRUE, TRUE)

/obj/item/food/meat/rawcutlet/chicken/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/swabable, CELL_LINE_TABLE_CHICKEN, CELL_VIRUS_TABLE_GENERIC_MOB)

//Cooked cutlets

/obj/item/food/meat/cutlet
	name = "熟肉片"
	desc = "一份熟肉片."
	icon_state = "cutlet"
	bite_consumption = 2
	food_reagents = list(/datum/reagent/consumable/nutriment/protein = 2)
	tastes = list("肉" = 1)
	foodtypes = MEAT
	crafting_complexity = FOOD_COMPLEXITY_1
	blood_decal_type = null

/obj/item/food/meat/cutlet/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ITEM_MICROWAVE_COOKED, PROC_REF(on_microwave_cooked))

///This proc handles setting up the correct meat name for the cutlet, this should definitely be changed with the food rework.
/obj/item/food/meat/cutlet/proc/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency)
	SIGNAL_HANDLER

	if(!istype(source_item, /obj/item/food/meat/rawcutlet))
		return

	var/obj/item/food/meat/rawcutlet/original_cutlet = source_item
	name = "[original_cutlet.meat_type] 肉片"

/obj/item/food/meat/cutlet/plain

/obj/item/food/meat/cutlet/plain/human
	tastes = list("嫩肉" = 1)
	foodtypes = MEAT | GORE

/obj/item/food/meat/cutlet/plain/human/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency)
	. = ..()
	if(!istype(source_item, /obj/item/food/meat))
		return

	var/obj/item/food/meat/origin_meat = source_item
	if(subjectname)
		name = "[origin_meat.subjectname] [initial(name)]"
	else if(subjectjob)
		name = "[origin_meat.subjectjob] [initial(name)]"

/obj/item/food/meat/cutlet/killertomato
	name = "熟杀手番茄片"
	tastes = list("番茄" = 1)
	foodtypes = FRUIT

/obj/item/food/meat/cutlet/bear
	name = "熟熊肉片"
	tastes = list("肉" = 1, "鲑鱼" = 1)

/obj/item/food/meat/cutlet/xeno
	name = "熟异形肉片"
	tastes = list("肉" = 1, "酸液" = 1)

/obj/item/food/meat/cutlet/spider
	name = "熟蜘蛛肉片"
	tastes = list("蜘蛛网" = 1)

/obj/item/food/meat/cutlet/gondola
	name = "熟贡多拉肉片"
	tastes = list("肉" = 1, "宁静" = 1)

/obj/item/food/meat/cutlet/penguin
	name = "熟企鹅肉片"
	tastes = list("肉" = 1, "冷水鱼" = 1)

/obj/item/food/meat/cutlet/chicken
	name = "熟鸡肉片"
	tastes = list("鸡肉" = 1)
