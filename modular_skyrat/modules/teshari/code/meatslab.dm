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
	foodtypes = MEAT | GORE

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
