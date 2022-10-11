/obj/structure/reagent_anvil
	name = "anvil"
	desc = "An object with the intent to hammer metal against. One of the most important parts for forging an item."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_structures.dmi'
	icon_state = "anvil_empty"

	anchored = TRUE
	density = TRUE
	///if on the mining zlevel, it is primitive and has a different icon
	var/primitive = FALSE

/obj/structure/reagent_anvil/Initialize(mapload)
	. = ..()
	if(is_mining_level(z))
		primitive = TRUE
		icon_state = "primitive_anvil_empty"

/obj/structure/reagent_anvil/update_appearance()
	. = ..()
	cut_overlays()
	if(!length(contents))
		return
	var/image/overlayed_item = image(icon = contents[1].icon, icon_state = contents[1].icon_state)
	overlayed_item.transform = matrix(1.5, 0, 0, 0, 0.8, 0)
	add_overlay(overlayed_item)

/obj/structure/reagent_anvil/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	new /obj/item/stack/sheet/iron/ten(get_turf(src))
	qdel(src)
	return TRUE

/obj/structure/reagent_anvil/tong_act(mob/living/user, obj/item/tool)
	var/obj/item/forging/forge_item = tool
	var/obj/obj_anvil_search = locate() in contents
	if(forge_item.in_use)
		balloon_alert(user, "anvil in use already!")
		return TOOL_ACT_TOOLTYPE_SUCCESS
	var/obj/obj_tong_search = locate() in forge_item.contents
	if(obj_anvil_search && !obj_tong_search)
		obj_anvil_search.forceMove(forge_item)
		update_appearance()
		forge_item.icon_state = "tong_full"
		return TOOL_ACT_TOOLTYPE_SUCCESS
	if(!obj_anvil_search && obj_tong_search)
		obj_tong_search.forceMove(src)
		update_appearance()
		forge_item.icon_state = "tong_empty"
		return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/structure/reagent_anvil/hammer_act(mob/living/user, obj/item/tool)
	//regardless, we will make a sound
	playsound(src, 'modular_skyrat/modules/reagent_forging/sound/forge.ogg', 50, TRUE, ignore_walls = FALSE)
	//do we have an incomplete item to hammer out? if so, here is our block of code
	var/obj/item/forging/incomplete/locate_incomplete = locate() in contents
	if(locate_incomplete)
		if(COOLDOWN_FINISHED(locate_incomplete, heating_remainder))
			balloon_alert(user, "metal cooled down, reheat it!")
			locate_incomplete.times_hit -= 3
			return TOOL_ACT_TOOLTYPE_SUCCESS
		if(COOLDOWN_FINISHED(locate_incomplete, striking_cooldown))
			var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER) * locate_incomplete.average_wait
			COOLDOWN_START(locate_incomplete, striking_cooldown, skill_modifier)
			locate_incomplete.times_hit++
			balloon_alert(user, "good hit!")
			user.mind.adjust_experience(/datum/skill/smithing, 1) //A good hit gives minimal experience
			if(locate_incomplete.times_hit >= locate_incomplete.average_hits)
				user.balloon_alert(user, "[locate_incomplete] sounds ready!")
			return TOOL_ACT_TOOLTYPE_SUCCESS
		locate_incomplete.times_hit -= 3
		balloon_alert(user, "bad hit!")
		if(locate_incomplete.times_hit <= -locate_incomplete.average_hits)
			balloon_alert(user, "[locate_incomplete] breaks from the bad hits!")
			qdel(locate_incomplete)
			update_appearance()
		return TOOL_ACT_TOOLTYPE_SUCCESS

	var/obj/locate_obj = locate() in contents
	//okay, so we didn't find an incomplete item to hammer, do we have a hammerable item?
	if(locate_obj && (locate_obj.skyrat_obj_flags & TRAIT_ANVIL_REPAIR))
		if(locate_obj.get_integrity() >= locate_obj.max_integrity)
			balloon_alert(user, "full integrity already!")
			return TOOL_ACT_TOOLTYPE_SUCCESS
		while(locate_obj.get_integrity() < locate_obj.max_integrity)
			if(!do_after(user, 1 SECONDS, src))
				balloon_alert(user, "stopped repairing!")
				return TOOL_ACT_TOOLTYPE_SUCCESS
			locate_obj.repair_damage(locate_obj.get_integrity() + 10)
			user.mind.adjust_experience(/datum/skill/smithing, 5) //repairing does give some experience
			playsound(src, 'modular_skyrat/modules/reagent_forging/sound/forge.ogg', 50, TRUE, ignore_walls = FALSE)
	return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/structure/reagent_anvil/hammer_act_secondary(mob/living/user, obj/item/tool)
	hammer_act(user, tool)
