#define DEFAULT_TIMED 4 SECONDS

/obj/item/glassblowing
	icon = 'modular_skyrat/modules/primitive_fun/icons/prim_fun.dmi'

/obj/item/glassblowing/glass_globe
	name = "glass globe"
	desc = "A glass bowl that is capable of carrying things."
	icon_state = "glass_globe"

/datum/export/glassblowing
	cost = CARGO_CRATE_VALUE * 5
	unit_name = "glassblowing product"
	export_types = list(/obj/item/glassblowing/glass_lens,
						/obj/item/glassblowing/glass_globe,
						/obj/item/reagent_containers/glass/bowl/blowing_glass,
						/obj/item/reagent_containers/glass/beaker/large/blowing_glass,
						/obj/item/plate/blowing_glass)

/datum/export/glassblowing/sell_object(obj/O, datum/export_report/report, dry_run, apply_elastic = FALSE) //I really dont want them to feel gimped
	. = ..()

/obj/item/glassblowing/glass_lens
	name = "glass lens"
	desc = "A glass bowl that is capable of carrying things."
	icon_state = "glass_lens"

/obj/item/reagent_containers/glass/bowl/blowing_glass
	name = "glass bowl"
	desc = "A glass bowl that is capable of carrying things."
	icon = 'modular_skyrat/modules/primitive_fun/icons/prim_fun.dmi'
	icon_state = "glass_bowl"

/obj/item/reagent_containers/glass/beaker/large/blowing_glass
	name = "glass cup"
	desc = "A glass cup that is capable of carrying liquids."
	icon = 'modular_skyrat/modules/primitive_fun/icons/prim_fun.dmi'
	icon_state = "glass_cup"
	custom_materials = null

/obj/item/plate/blowing_glass
	name = "glass plate"
	desc = "A glass plate that is capable of carrying things."
	icon = 'modular_skyrat/modules/primitive_fun/icons/prim_fun.dmi'
	icon_state = "glass_plate"

/obj/item/glassblowing/molten_glass
	name = "molten glass"
	desc = "A glob of molten glass, ready to be shaped into art."
	icon_state = "molten_glass"
	//the cooldown if its still molten / requires heating up
	COOLDOWN_DECLARE(remaining_heat)
	///the list of required steps to produce the chosen_item: blowing, spinning, paddles, shears, jacks
	var/list/required_actions = list(0,0,0,0,0)
	///the list of current steps: blowing, spinning, paddles, shears, jacks
	var/list/current_actions = list(0,0,0,0,0)
	///the typepath of the item that will be produced when the required actions are met
	var/chosen_item

/obj/item/glassblowing/molten_glass/examine(mob/user)
	. = ..()
	if(COOLDOWN_FINISHED(src, remaining_heat))
		. += span_warning("[src] has cooled down and will require reheating to modify!")
	if(required_actions[1])
		. += "You require [required_actions[1]] blowing actions!"
		. += "You currently have [current_actions[1]] blowing actions!"
	if(required_actions[2])
		. += "You require [required_actions[2]] spinning actions!"
		. += "You currently have [current_actions[2]] spinning actions!"
	if(required_actions[3])
		. += "You require [required_actions[3]] paddling actions!"
		. += "You currently have [current_actions[3]] paddling actions!"
	if(required_actions[4])
		. += "You require [required_actions[4]] shearing actions!"
		. += "You currently have [current_actions[4]] shearing actions!"
	if(required_actions[5])
		. += "You require [required_actions[5]] jacking actions!"
		. += "You currently have [current_actions[5]] jacking actions!"

/obj/item/glassblowing/molten_glass/pickup(mob/user)
	if(!isliving(user))
		return ..()
	. = ..()
	var/mob/living/living_user = user
	if(!COOLDOWN_FINISHED(src, remaining_heat))
		to_chat(living_user, span_warning("You burn your hands trying to pick up [src]!"))
		living_user.adjustFireLoss(15)
		user.dropItemToGround(src)

/obj/item/glassblowing/blowing_rod/examine(mob/user)
	. = ..()
	var/obj/item/glassblowing/molten_glass/find_glass = locate() in contents
	if(!find_glass)
		return
	if(COOLDOWN_FINISHED(find_glass, remaining_heat))
		. += span_warning("[src] has cooled down and will require reheating to modify!")
	if(find_glass.required_actions[1])
		. += "You require [find_glass.required_actions[1]] blowing actions!"
		. += "You currently have [find_glass.current_actions[1]] blowing actions!"
	if(find_glass.required_actions[2])
		. += "You require [find_glass.required_actions[2]] spinning actions!"
		. += "You currently have [find_glass.current_actions[2]] spinning actions!"
	if(find_glass.required_actions[3])
		. += "You require [find_glass.required_actions[3]] paddling actions!"
		. += "You currently have [find_glass.current_actions[3]] paddling actions!"
	if(find_glass.required_actions[4])
		. += "You require [find_glass.required_actions[4]] shearing actions!"
		. += "You currently have [find_glass.current_actions[4]] shearing actions!"
	if(find_glass.required_actions[5])
		. += "You require [find_glass.required_actions[5]] jacking actions!"
		. += "You currently have [find_glass.current_actions[5]] jacking actions!"

/obj/item/glassblowing/blowing_rod/proc/check_valid_table(mob/living/user)
	var/skill_level = user.mind.get_skill_level(/datum/skill/production)
	if(skill_level >= SKILL_LEVEL_MASTER) //as a master, you can skip tables
		return TRUE
	for(var/obj/structure/table/check_table in range(1, get_turf(src)))
		if(!(check_table.resistance_flags & FLAMMABLE))
			return TRUE //if you can find a table that is not flammable, good
	return FALSE

/obj/item/glassblowing/blowing_rod/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(!proximity_flag)
		return ..()
	if(istype(target, /obj/item/glassblowing/molten_glass))
		var/obj/item/glassblowing/molten_glass/attacking_glass = target
		var/obj/item/glassblowing/molten_glass/find_glass = locate() in contents
		if(find_glass)
			to_chat(user, span_warning("[src] already has some glass on it!"))
			return
		attacking_glass.forceMove(src)
		to_chat(user, span_notice("[src] picks up [target]."))
		icon_state = "blow_pipe_full"
		return
	return ..()

/obj/item/glassblowing/blowing_rod/attackby(obj/item/attacking_item, mob/living/user, params)
	var/actioning_speed = user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER) * DEFAULT_TIMED
	var/obj/item/glassblowing/molten_glass/find_glass = locate() in contents

	if(istype(attacking_item, /obj/item/glassblowing/molten_glass))
		if(find_glass)
			to_chat(user, span_warning("[src] already has some glass on it still!"))
			return
		attacking_item.forceMove(src)
		to_chat(user, span_notice("[src] picks up [attacking_item]."))
		icon_state = "blow_pipe_full"
		return

	if(istype(attacking_item, /obj/item/glassblowing/paddle))
		do_glass_step(3, user, "paddle", actioning_speed)
		return

	if(istype(attacking_item, /obj/item/glassblowing/shears))
		do_glass_step(4, user, "shear", actioning_speed)
		return

	if(istype(attacking_item, /obj/item/glassblowing/jacks))
		do_glass_step(5, user, "jack", actioning_speed)
		return

	return ..()

/obj/item/glassblowing/blowing_rod/attack_self(mob/user, modifiers)
	var/obj/item/glassblowing/molten_glass/find_glass = locate() in contents
	var/actioning_speed = user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER) * DEFAULT_TIMED

	if(find_glass)
		if(COOLDOWN_FINISHED(find_glass, remaining_heat))
			to_chat(user, span_warning("The glass has cooled down far too much to be handled..."))
			return
		if(in_use)
			to_chat(user, span_warning("[src] is busy being used!"))
			return
		in_use = TRUE
		if(!find_glass.chosen_item)
			var/choice = tgui_input_list(user, "What would you like to make?", "Choice Selection", list("Plate", "Bowl", "Globe", "Cup", "Lens"))
			if(!choice)
				in_use = FALSE
				return
			switch(choice)
				if("Plate")
					find_glass.chosen_item = /obj/item/plate/blowing_glass
					find_glass.required_actions = list(3,3,3,0,0) //blowing, spinning, paddling
				if("Bowl")
					find_glass.chosen_item = /obj/item/reagent_containers/glass/bowl/blowing_glass
					find_glass.required_actions = list(2,2,2,0,3) //blowing, spinning, paddling
				if("Globe")
					find_glass.chosen_item = /obj/item/glassblowing/glass_globe
					find_glass.required_actions = list(6,3,0,0,0) //blowing, spinning
				if("Cup")
					find_glass.chosen_item = /obj/item/reagent_containers/glass/beaker/large/blowing_glass
					find_glass.required_actions = list(3,3,3,0,0) //blowing, spinning, paddling
				if("Lens")
					find_glass.chosen_item = /obj/item/glassblowing/glass_lens
					find_glass.required_actions = list(0,0,3,3,3) //paddling, shearing, jacking
			in_use = FALSE
			return
		else
			in_use = FALSE
			var/action_choice = tgui_alert(user, "What would you like to do?", "Action Selection", list("Blow", "Spin", "Remove"))
			if(!action_choice)
				return
			switch(action_choice)
				if("Blow")
					do_glass_step(1, user, "blow", actioning_speed)
				if("Spin")
					do_glass_step(2, user, "spin", actioning_speed)
				if("Remove")
					for(var/iterate in 1 to 5)
						if(find_glass.current_actions[iterate] < find_glass.required_actions[iterate])
							remove_glass()
							return
					new find_glass.chosen_item(get_turf(src))
					user.mind.adjust_experience(/datum/skill/production, 30)
					qdel(find_glass)
					icon_state = "blow_pipe_empty"
					return
			return
	return ..()

/obj/item/glassblowing/blowing_rod/proc/fail_message(message, mob/user)
	to_chat(user, span_warning(message))
	in_use = FALSE

/obj/item/glassblowing/blowing_rod/proc/do_glass_step(number, mob/user, message, actioning_speed)
	var/obj/item/glassblowing/molten_glass/find_glass = locate() in contents
	if(!find_glass)
		return
	if(in_use)
		return
	in_use = TRUE
	if(!check_valid_table(user))
		fail_message("You must be near a non-flammable table!", user)
		return
	to_chat(user, span_notice("You begin to [message] [src]."))
	if(!do_after(user, actioning_speed, target = src))
		fail_message("You interrupt an action!", user)
		return
	if(!check_valid_table(user))
		fail_message("You must be near a non-flammable table!", user)
		return
	find_glass.current_actions[number]++
	to_chat(user, span_notice("You finish trying to [message] [src]."))
	in_use = FALSE
	user.mind.adjust_experience(/datum/skill/production, 10)

/obj/item/glassblowing/blowing_rod/proc/remove_glass()
	var/obj/item/glassblowing/molten_glass/find_glass = locate() in contents
	if(!find_glass)
		return
	in_use = FALSE
	find_glass.forceMove(get_turf(src))
	icon_state = "blow_pipe_empty"

/datum/crafting_recipe/glassblowing_recipe
	reqs = list(/obj/item/stack/sheet/iron = 5)
	category = CAT_PRIMAL

/obj/item/glassblowing/blowing_rod
	name = "blowing rod"
	desc = "A tool that is used to hold the molten glass as well as help shape it."
	icon_state = "blow_pipe_empty"
	///whether the item is in use currently; will try to prevent many other actions on it
	var/in_use = FALSE
	tool_behaviour = TOOL_BLOWROD

/datum/crafting_recipe/glassblowing_recipe/glass_blowing_rod
	name = "Glass-blowing Blowing Rod"
	result = /obj/item/glassblowing/blowing_rod

/obj/item/glassblowing/jacks
	name = "jacks"
	desc = "A tool that helps shape glass during the art process."
	icon_state = "jacks"

/datum/crafting_recipe/glassblowing_recipe/glass_jack
	name = "Glass-blowing Jacks"
	result = /obj/item/glassblowing/jacks

/obj/item/glassblowing/paddle
	name = "paddle"
	desc = "A tool that helps shape glass during the art process."
	icon_state = "paddle"

/datum/crafting_recipe/glassblowing_recipe/glass_paddle
	name = "Glass-blowing Paddle"
	result = /obj/item/glassblowing/paddle

/obj/item/glassblowing/shears
	name = "shears"
	desc = "A tool that helps shape glass during the art process."
	icon_state = "shears"

/datum/crafting_recipe/glassblowing_recipe/glass_shears
	name = "Glass-blowing Shears"
	result = /obj/item/glassblowing/shears

/obj/item/glassblowing/metal_cup
	name = "metal cup"
	desc = "A tool that helps shape glass during the art process."
	icon_state = "metal_cup_empty"
	var/has_sand = FALSE

/datum/crafting_recipe/glassblowing_recipe/glass_metal_cup
	name = "Glass-blowing Metal Cup"
	result = /obj/item/glassblowing/metal_cup

/obj/item/glassblowing/metal_cup/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/stack/ore/glass))
		var/obj/item/stack/ore/glass/glass_obj = I
		if(!glass_obj.use(1))
			return
		has_sand = TRUE
		icon_state = "metal_cup_full"
	return ..()

#undef DEFAULT_TIMED
