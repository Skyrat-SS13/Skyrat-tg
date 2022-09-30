/obj/structure/reagent_water_basin
	name = "water basin"
	desc = "A basin full of water, ready to quench the hot metal."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_structures.dmi'
	icon_state = "water_basin"
	anchored = TRUE
	density = TRUE

/obj/structure/reagent_water_basin/Initialize(mapload)
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

/obj/structure/reagent_water_basin/attackby(obj/item/attacking_item, mob/living/user, params)
	if(istype(attacking_item, /obj/item/stack/ore/glass))
		var/obj/item/stack/ore/glass/glass_obj = attacking_item
		if(!glass_obj.use(1))
			return
		new /obj/item/stack/clay(get_turf(src))
		user.mind.adjust_experience(/datum/skill/production, 1)
		return

	if(istype(attacking_item, /obj/item/stack/ore/bluespace_crystal))
		var/check_fishable = GetComponent(/datum/component/fishing)
		if(check_fishable)
			return
		var/obj/item/stack/ore/bluespace_crystal/bs_crystal = attacking_item
		if(!bs_crystal.use(1))
			return
		balloon_alert(user, "the water deepens!")
		AddComponent(/datum/component/fishing, set_loot = GLOB.fishing_weights, allow_fishes = TRUE)
		return

	return ..()

/obj/structure/reagent_water_basin/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	for(var/i in 1 to 5)
		new /obj/item/stack/sheet/mineral/wood(get_turf(src))
	qdel(src)
	return TRUE

/obj/structure/reagent_water_basin/tong_act(mob/living/user, obj/item/tool)
	var/obj/item/forging/incomplete/search_incomplete = locate(/obj/item/forging/incomplete) in tool.contents
	if(!search_incomplete)
		return FALSE
	playsound(src, 'modular_skyrat/modules/reagent_forging/sound/hot_hiss.ogg', 50, TRUE)
	if(search_incomplete?.times_hit < search_incomplete.average_hits)
		to_chat(user, span_warning("You cool down the metal-- it wasn't ready yet."))
		COOLDOWN_RESET(search_incomplete, heating_remainder)
		return FALSE
	if(search_incomplete?.times_hit >= search_incomplete.average_hits)
		to_chat(user, span_notice("You cool down the metal-- it is ready."))
		user.mind.adjust_experience(/datum/skill/smithing, 10) //using the water basin on a ready item gives decent experience.
		var/obj/spawned_obj = new search_incomplete.spawn_item(get_turf(src))
		if(search_incomplete.custom_materials)
			spawned_obj.set_custom_materials(search_incomplete.custom_materials, 1) //lets set its material
		qdel(search_incomplete)
		tool.icon_state = "tong_empty"
	return FALSE
