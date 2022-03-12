/obj/structure/reagent_anvil
	name = "anvil"
	desc = "An object with the intent to hammer metal against. One of the most important parts for forging an item."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_structures.dmi'
	icon_state = "anvil_empty"

	anchored = TRUE
	density = TRUE
	///if on the mining zlevel, it is primitive and has a different icon
	var/primitive = FALSE

/obj/structure/reagent_anvil/Initialize()
	. = ..()
	if(is_mining_level(z))
		primitive = TRUE
		icon_state = "primitive_anvil_empty"

/obj/structure/reagent_anvil/attackby(obj/item/I, mob/living/user, params)
	var/obj/item/forging/incomplete/search_incomplete_src = locate(/obj/item/forging/incomplete) in contents
	if(istype(I, /obj/item/forging/hammer) && search_incomplete_src)
		playsound(src, 'modular_skyrat/modules/reagent_forging/sound/forge.ogg', 50, TRUE)
		if(COOLDOWN_FINISHED(search_incomplete_src, heating_remainder))
			to_chat(user, span_warning("You mess up, the metal was too cool!"))
			search_incomplete_src.times_hit -= 3
			return TRUE
		if(COOLDOWN_FINISHED(search_incomplete_src, striking_cooldown))
			var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER) * search_incomplete_src.average_wait
			COOLDOWN_START(search_incomplete_src, striking_cooldown, skill_modifier)
			search_incomplete_src.times_hit++
			balloon_alert(user, "good hit!")
			user.mind.adjust_experience(/datum/skill/smithing, 1) //A good hit gives minimal experience
			if(search_incomplete_src?.times_hit >= search_incomplete_src.average_hits)
				to_chat(user, span_notice("The metal is sounding ready."))
			return TRUE
		search_incomplete_src.times_hit -= 3
		balloon_alert(user, "bad hit!")
		if(search_incomplete_src?.times_hit <= -(search_incomplete_src.average_hits))
			to_chat(user, span_warning("The hits were too inconsistent-- the metal breaks!"))
			icon_state = "[primitive ? "primitive_" : ""]anvil_empty"
			qdel(search_incomplete_src)
		return TRUE

	if(istype(I, /obj/item/forging/tongs))
		var/obj/item/forging/forge_item = I
		if(forge_item.in_use)
			to_chat(user, span_warning("You cannot do multiple things at the same time!"))
			return
		var/obj/item/forging/incomplete/search_incomplete_item = locate(/obj/item/forging/incomplete) in I.contents
		if(search_incomplete_src && !search_incomplete_item)
			search_incomplete_src.forceMove(I)
			icon_state = "[primitive ? "primitive_" : ""]anvil_empty"
			I.icon_state = "tong_full"
			return TRUE
		if(!search_incomplete_src && search_incomplete_item)
			search_incomplete_item.forceMove(src)
			icon_state = "[primitive ? "primitive_" : ""]anvil_full"
			I.icon_state = "tong_empty"
		return TRUE

	if(I.tool_behaviour == TOOL_WRENCH)
		new /obj/item/stack/sheet/iron/ten(get_turf(src))
		qdel(src)
		return

	return ..()
