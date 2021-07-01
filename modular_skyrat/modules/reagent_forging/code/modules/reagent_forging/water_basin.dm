/obj/structure/reagent_water_basin
	name = "water basin"
	desc = "A basin full of water, ready to quench the hot metal."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_structures.dmi'
	icon_state = "water_basin"
	anchored = TRUE
	density = TRUE

/obj/structure/reagent_water_basin/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/forging/tongs))
		var/obj/item/forging/incomplete/searchIncomplete = locate(/obj/item/forging/incomplete) in I.contents
		if(searchIncomplete?.times_hit < searchIncomplete.average_hits)
			to_chat(user, span_warning("You cool down the metal-- it wasn't ready yet."))
			searchIncomplete.heat_world_compare = 0
			playsound(src, 'modular_skyrat/modules/reagent_forging/sound/hot_hiss.ogg', 50, TRUE)
			return
		if(searchIncomplete?.times_hit >= searchIncomplete.average_hits)
			to_chat(user, span_notice("You cool down the metal-- it is ready."))
			playsound(src, 'modular_skyrat/modules/reagent_forging/sound/hot_hiss.ogg', 50, TRUE)
			var/obj/item/forging/complete/spawnItem = searchIncomplete.spawn_item
			new spawnItem(get_turf(src))
			qdel(searchIncomplete)
			I.icon_state = "tong_empty"
		return
	if(I.tool_behaviour == TOOL_WRENCH)
		for(var/i in 1 to 5)
			new /obj/item/stack/sheet/mineral/wood(get_turf(src))
		qdel(src)
		return
	return ..()
