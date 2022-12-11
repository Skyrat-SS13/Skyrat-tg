/obj/structure/water_basin
	name = "water basin"
	desc = "A basin full of water, ready to quench the hot metal."
	icon = 'modular_skyrat/modules/primitive_production/icons/forge_structures.dmi'
	icon_state = "water_basin"
	anchored = TRUE
	density = TRUE

/obj/structure/water_basin/crowbar_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	deconstruct(TRUE)
	qdel(src)
	return TRUE

/obj/structure/water_basin/deconstruct(disassembled)
	new /obj/item/stack/sheet/iron/ten(get_turf(src))
	return ..()

/obj/structure/water_basin/tong_act(mob/living/user, obj/item/tool)
	var/obj/item/forging/incomplete/search_incomplete = locate(/obj/item/forging/incomplete) in tool.contents
	if(!search_incomplete)
		return TOOL_ACT_TOOLTYPE_SUCCESS

	playsound(src, 'modular_skyrat/modules/primitive_production/sound/hot_hiss.ogg', 50, TRUE)

	if(search_incomplete?.times_hit < search_incomplete.average_hits)
		to_chat(user, span_warning("You cool down [search_incomplete], but it wasn't ready yet."))
		COOLDOWN_RESET(search_incomplete, heating_remainder)
		return TOOL_ACT_TOOLTYPE_SUCCESS

	if(search_incomplete?.times_hit >= search_incomplete.average_hits)
		to_chat(user, span_notice("You cool down [search_incomplete] and it's ready."))
		user.mind.adjust_experience(/datum/skill/smithing, 10) //using the water basin on a ready item gives decent experience.

		var/obj/spawned_obj = new search_incomplete.spawn_item(get_turf(src))
		if(search_incomplete.custom_materials)
			spawned_obj.set_custom_materials(search_incomplete.custom_materials, 1) //lets set its material

		qdel(search_incomplete)
		tool.icon_state = "tong_empty"
	return TOOL_ACT_TOOLTYPE_SUCCESS
