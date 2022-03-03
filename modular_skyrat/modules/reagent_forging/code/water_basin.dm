/obj/structure/reagent_water_basin
	name = "water basin"
	desc = "A basin full of water, ready to quench the hot metal."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_structures.dmi'
	icon_state = "water_basin"
	anchored = TRUE
	density = TRUE

/obj/structure/reagent_water_basin/Initialize()
	. = ..()
	if(is_mining_level(z))
		icon_state = "primitive_water_basin"

/obj/structure/reagent_water_basin/examine(mob/user)
	. = ..()
	var/check_fishable = GetComponent(/datum/component/fishing)
	if(!check_fishable)
		. += span_notice("[src] can be upgraded through a bluespace crystal or a journeyman smithy!")
	else
		. += span_notice("[src] has been upgraded! There is a strange orb that floats within the water... it seems to be replacing the water slowly.")

/obj/structure/reagent_water_basin/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	var/smithing_skill = user.mind.get_skill_level(/datum/skill/smithing)
	var/check_fishable = GetComponent(/datum/component/fishing)
	if(smithing_skill < SKILL_LEVEL_JOURNEYMAN || check_fishable)
		return
	balloon_alert(user, "the water deepens!")
	AddComponent(/datum/component/fishing, set_loot = GLOB.fishing_weights, allow_fishes = TRUE)

/obj/structure/reagent_water_basin/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/forging/tongs))
		var/obj/item/forging/incomplete/search_incomplete = locate(/obj/item/forging/incomplete) in I.contents
		if(search_incomplete?.times_hit < search_incomplete.average_hits)
			to_chat(user, span_warning("You cool down the metal-- it wasn't ready yet."))
			COOLDOWN_RESET(search_incomplete, heating_remainder)
			playsound(src, 'modular_skyrat/modules/reagent_forging/sound/hot_hiss.ogg', 50, TRUE)
			return
		if(search_incomplete?.times_hit >= search_incomplete.average_hits)
			to_chat(user, span_notice("You cool down the metal-- it is ready."))
			user.mind.adjust_experience(/datum/skill/smithing, 4) //using the water basin on a ready item gives decent experience.
			playsound(src, 'modular_skyrat/modules/reagent_forging/sound/hot_hiss.ogg', 50, TRUE)
			var/obj/item/forging/complete/spawn_item = search_incomplete.spawn_item
			new spawn_item(get_turf(src))
			qdel(search_incomplete)
			I.icon_state = "tong_empty"
		return

	if(I.tool_behaviour == TOOL_WRENCH)
		for(var/i in 1 to 5)
			new /obj/item/stack/sheet/mineral/wood(get_turf(src))
		I.play_tool_sound(src, 50)
		qdel(src)
		return

	if(istype(I, /obj/item/stack/ore/glass))
		var/obj/item/stack/ore/glass/glass_obj = I
		if(!glass_obj.use(1))
			return
		new /obj/item/ceramic/clay(get_turf(src))
		return

	if(istype(I, /obj/item/stack/ore/bluespace_crystal))
		var/check_fishable = GetComponent(/datum/component/fishing)
		if(check_fishable)
			return
		var/obj/item/stack/ore/bluespace_crystal/bs_crystal = I
		if(!bs_crystal.use(1))
			return
		balloon_alert(user, "the water deepens!")
		AddComponent(/datum/component/fishing, set_loot = GLOB.fishing_weights, allow_fishes = TRUE)

	return ..()
