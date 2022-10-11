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
	var/obj/item/forging/incomplete/search_incomplete_src = locate(/obj/item/forging/incomplete) in contents
	if(forge_item.in_use)
		to_chat(user, span_warning("You cannot do multiple things at the same time!"))
		return FALSE
	var/obj/item/forging/incomplete/search_incomplete_item = locate(/obj/item/forging/incomplete) in forge_item.contents
	if(search_incomplete_src && !search_incomplete_item)
		search_incomplete_src.forceMove(forge_item)
		update_appearance()
		forge_item.icon_state = "tong_full"
		return FALSE
	if(!search_incomplete_src && search_incomplete_item)
		search_incomplete_item.forceMove(src)
		update_appearance()
		forge_item.icon_state = "tong_empty"
		return FALSE

/obj/structure/reagent_anvil/hammer_act(mob/living/user, obj/item/tool)
	playsound(src, 'modular_skyrat/modules/reagent_forging/sound/forge.ogg', 50, TRUE, ignore_walls = FALSE)
	var/obj/item/forging/incomplete/search_incomplete_src = locate(/obj/item/forging/incomplete) in contents
	if(!search_incomplete_src)
		return FALSE
	if(COOLDOWN_FINISHED(search_incomplete_src, heating_remainder))
		to_chat(user, span_warning("You mess up, the metal was too cool!"))
		search_incomplete_src.times_hit -= 3
		return FALSE
	if(COOLDOWN_FINISHED(search_incomplete_src, striking_cooldown))
		var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER) * search_incomplete_src.average_wait
		COOLDOWN_START(search_incomplete_src, striking_cooldown, skill_modifier)
		search_incomplete_src.times_hit++
		balloon_alert(user, "good hit!")
		user.mind.adjust_experience(/datum/skill/smithing, 1) //A good hit gives minimal experience
		if(search_incomplete_src?.times_hit >= search_incomplete_src.average_hits)
			to_chat(user, span_notice("[search_incomplete_src] is sounding ready."))
		return FALSE
	search_incomplete_src.times_hit -= 3
	balloon_alert(user, "bad hit!")
	if(search_incomplete_src?.times_hit <= -(search_incomplete_src.average_hits))
		to_chat(user, span_warning("The hits were too inconsistent-- [search_incomplete_src] breaks!"))
		qdel(search_incomplete_src)
		update_appearance()
	return FALSE

/obj/structure/reagent_anvil/hammer_act_secondary(mob/living/user, obj/item/tool)
	hammer_act(user, tool)
