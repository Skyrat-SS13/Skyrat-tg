#define DEFAULT_SPIN 4 SECONDS

/obj/structure/water_source/puddle/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/stack/ore/glass))
		var/obj/item/stack/ore/glass/glass_item = O
		if(!glass_item.use(1))
			return
		new /obj/item/stack/clay(get_turf(src))
		user.mind.adjust_experience(/datum/skill/production, 1)
		return
	return ..()

/turf/open/water/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/stack/ore/glass))
		var/obj/item/stack/ore/glass/glass_item = C
		if(!glass_item.use(1))
			return
		new /obj/item/stack/clay(src)
		user.mind.adjust_experience(/datum/skill/production, 1)
		return
	return ..()

/obj/structure/sink/attackby(obj/item/O, mob/living/user, params)
	if(istype(O, /obj/item/stack/ore/glass))
		if(dispensedreagent != /datum/reagent/water)
			return
		if(reagents.total_volume <= 0)
			return
		var/obj/item/stack/ore/glass/glass_item = O
		if(!glass_item.use(1))
			return
		new /obj/item/stack/clay(get_turf(src))
		user.mind.adjust_experience(/datum/skill/production, 1)
		return
	return ..()

/obj/item/in_progress_ceramic
	name = "unfinished ceramic"
	desc = "You can finish setting this in a forge!"
	icon_state = "greyscale_ball"
	icon = 'modular_skyrat/modules/primitive_production/icons/misc_tools.dmi'
	color = "#837878"
	/// What this completes into when set in a forge
	var/type_to_complete_into

/obj/item/in_progress_ceramic/proc/set_yourself_up(type_to_look_like)
	if(!type_to_look_like)
		return
	var/obj/resulting_item = type_to_look_like
	icon = resulting_item.icon
	icon_state = resulting_item.icon_state
	type_to_complete_into = resulting_item

/obj/item/stack/clay
	name = "clay"
	desc = "A pile of clay that can be used to create ceramic artwork."
	icon = 'modular_skyrat/modules/primitive_production/icons/prim_fun.dmi'
	icon_state = "clay"
	merge_type = /obj/item/stack/clay
	singular_name = "glob of clay"

/obj/structure/throwing_wheel
	name = "throwing wheel"
	desc = "A machine that allows you to throw clay."
	icon = 'modular_skyrat/modules/primitive_production/icons/prim_fun.dmi'
	icon_state = "throw_wheel_empty"
	density = TRUE
	anchored = TRUE
	///if the structure has clay
	var/has_clay = FALSE
	//if the structure is in use or not
	var/in_use = FALSE
	///the list of messages that are sent whilst "working" the clay
	var/static/list/given_message = list(
		"You slowly start spinning the throwing wheel...",
		"You place your hands on the clay, slowly shaping it...",
		"You start becoming satisfied with what you have made...",
		"You stop the throwing wheel, admiring your new creation...",
	)
	/// Static list of all possible results
	var/static/list/possible_results = list(
		"Bowl" = /obj/item/reagent_containers/cup/bowl/generic_material/ceramic,
		"Cup" = /obj/item/reagent_containers/cup/beaker/generic_material/ceramic,
		"Buffet Plate" = /obj/item/plate/large/generic_material/ceramic,
		"Plate" = /obj/item/plate/generic_material/ceramic,
		"Appetizer Plate" = /obj/item/plate/small/generic_material/ceramic,
		"Oven Tray" = /obj/item/plate/oven_tray/generic_material/ceramic,
	)

/obj/structure/throwing_wheel/attackby(obj/item/attacking_item, mob/living/user, params)
	if(istype(attacking_item, /obj/item/stack/clay))
		if(has_clay)
			return
		var/obj/item/stack/stack_item = attacking_item
		if(!stack_item.use(1))
			return
		has_clay = TRUE
		icon_state = "throw_wheel_full"
		return
	return ..()

/obj/structure/throwing_wheel/crowbar_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	new /obj/item/stack/sheet/iron/ten(get_turf(src))
	if(has_clay)
		new /obj/item/stack/clay(get_turf(src))
	qdel(src)

/obj/structure/throwing_wheel/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	anchored = !anchored

/obj/structure/throwing_wheel/proc/use_clay(chosen_type, mob/user)
	var/spinning_speed = user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER) * DEFAULT_SPIN
	for(var/loop_try in 1 to length(given_message))
		if(!do_after(user, spinning_speed, target = src))
			in_use = FALSE
			return
		to_chat(user, span_notice(given_message[loop_try]))
	var/obj/item/in_progress_ceramic/in_progress_ceramic = new /obj/item/in_progress_ceramic(get_turf(src))
	in_progress_ceramic.set_yourself_up(chosen_type)
	user.mind.adjust_experience(/datum/skill/production, 50)
	has_clay = FALSE
	icon_state = "throw_wheel_empty"

/obj/structure/throwing_wheel/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(in_use)
		return
	in_use = TRUE
	var/spinning_speed = user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER) * DEFAULT_SPIN
	if(!has_clay)
		balloon_alert(user, "there is no clay!")
		return
	var/user_input = tgui_alert(user, "What would you like to do?", "Choice Selection", list("Create", "Remove"))
	if(!user_input)
		in_use = FALSE
		return
	switch(user_input)
		if("Create")
			var/creation_choice = tgui_alert(user, "What you like to create?", "Creation Choice", possible_results)
			if(!creation_choice)
				in_use = FALSE
				return
			use_clay(possible_results[creation_choice], user)
		if("Remove")
			if(!do_after(user, spinning_speed, target = src))
				in_use = FALSE
				return
			var/atom/movable/new_clay = new /obj/item/stack/clay(get_turf(src))
			user.put_in_active_hand(new_clay)
			has_clay = FALSE
			in_use = FALSE
			icon_state = "throw_wheel_empty"
	in_use = FALSE

#undef DEFAULT_SPIN
