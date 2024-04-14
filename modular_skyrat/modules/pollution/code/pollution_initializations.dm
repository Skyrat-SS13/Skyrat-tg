/obj/effect/decal/cleanable/greenglow/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/pollution_emitter, /datum/pollutant/chemical_vapors, 10)

/obj/item/reagent_containers/cup/glass/coffee/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/food/coffee, 5, 3 MINUTES)

/obj/item/reagent_containers/cup/glass/mug/tea/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/food/tea, 5, 3 MINUTES)

/obj/item/reagent_containers/cup/glass/mug/coco/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/temporary_pollution_emission, /datum/pollutant/food/chocolate, 5, 3 MINUTES)
