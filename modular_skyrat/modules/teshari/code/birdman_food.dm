/obj/item/food/meat/slab/chicken/human
	name = "meat"
	tastes = list("tender meat" = 1)
	foodtypes = MEAT | RAW | GORE
	venue_value = FOOD_MEAT_HUMAN

/obj/item/food/meat/slab/chicken/human/make_grillable()
	AddComponent(/datum/component/grillable, /obj/item/food/meat/steak/chicken/human, rand(30 SECONDS, 90 SECONDS), TRUE, TRUE)

/obj/item/food/meat/steak/chicken/human/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency = 1)
	. = ..()
	if(!istype(source_item, /obj/item/food/meat))
		return

	var/obj/item/food/meat/origin_meat = source_item
	subjectname = origin_meat.subjectname
	subjectjob = origin_meat.subjectjob
	if(subjectname)
		name = "[origin_meat.subjectname] meatsteak"
	else if(subjectjob)
		name = "[origin_meat.subjectjob] meatsteak"

/obj/item/food/meat/slab/chicken/human/make_processable()
	AddElement(/datum/element/processable, TOOL_KNIFE,  /obj/item/food/meat/rawcutlet/chicken/human, 3, 3 SECONDS, table_required = TRUE, screentip_verb = "Cut")

/obj/item/food/meat/steak/chicken/human
	tastes = list("tender meat" = 1)
	foodtypes = MEAT | GORE

/obj/item/food/meat/rawcutlet/chicken/human
	tastes = list("tender meat" = 1)
	foodtypes = MEAT | RAW | GORE

/obj/item/food/meat/cutlet/chicken/human
	tastes = list("tender meat" = 1)
	foodtypes = MEAT | GORE

/obj/item/food/meat/cutlet/chicken/human/on_microwave_cooked(datum/source, atom/source_item, cooking_efficiency)
	. = ..()
	if(!istype(source_item, /obj/item/food/meat))
		return

	var/obj/item/food/meat/origin_meat = source_item
	if(subjectname)
		name = "[origin_meat.subjectname] [initial(name)]"
	else if(subjectjob)
		name = "[origin_meat.subjectjob] [initial(name)]"

/obj/item/food/raw_meatball/chicken/human
	name = "strange raw chicken meatball"
	meatball_type = /obj/item/food/meatball/chicken/human
	patty_type = /obj/item/food/raw_patty/chicken/human

/obj/item/food/meatball/chicken/human
	name = "strange chicken meatball"

/obj/item/food/raw_patty/chicken/human
	name = "strange raw chicken patty"
	patty_type = /obj/item/food/patty/human/chicken

/obj/item/food/patty/human/chicken
	name = "strange chicken patty"
	tastes = list("chikun" = 1)
	icon_state = "chicken_patty"

/datum/food_processor_process/meat/chicken
	blacklist = list(/obj/item/food/meat/slab/chicken/human)

/datum/food_processor_process/meat/chicken/human
	input = /obj/item/food/meat/slab/chicken/human
	output = /obj/item/food/raw_meatball/chicken/human
	blacklist = null

/obj/item/food/burger/human/chicken
	name = "birdman sandwich"
	desc = "You're pretty sure this sandwich doesn't fund a good cause..."
	icon_state = "chickenburger"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 3,
		/datum/reagent/consumable/mayonnaise = 3,
		/datum/reagent/consumable/nutriment/protein = 7,
		/datum/reagent/consumable/nutriment/vitamin = 1,
		/datum/reagent/consumable/nutriment/fat/oil = 2,
	)
	tastes = list("bun" = 2, "chikun" = 4, "Against God and Nature" = 1)
	foodtypes = GRAIN | MEAT | FRIED | GORE
	crafting_complexity = FOOD_COMPLEXITY_3
	venue_value = FOOD_PRICE_CHEAP

/obj/item/food/burger/human/chicken/CheckParts(list/parts_list)
	..()
	var/obj/item/food/patty/human/human_patty = locate(/obj/item/food/patty/human/chicken) in contents
	for(var/datum/material/meat/mob_meat/mob_meat_material in human_patty.custom_materials)
		if(mob_meat_material.subjectname)
			name = "[mob_meat_material.subjectname] burger"
		else if(mob_meat_material.subjectjob)
			name = "[mob_meat_material.subjectjob] burger"

/datum/crafting_recipe/food/chickenburger/human
	name = "Birdman Sandwich"
	reqs = list(
			/obj/item/food/patty/human/chicken = 1,
			/datum/reagent/consumable/mayonnaise = 5,
			/obj/item/food/bun = 1
	)
	result = /obj/item/food/burger/human/chicken
	category = CAT_BURGER
