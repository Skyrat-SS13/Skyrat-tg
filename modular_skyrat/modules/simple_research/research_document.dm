/datum/crafting_recipe/research_paper
	name = "Reseach Paper"
	result = /obj/item/research_paper
	time = 4 SECONDS
	reqs = list(
		/obj/item/stack/sheet/cloth = 4,
	)
	category = CAT_TOOLS

/obj/item/research_paper
	name = "research paper"
	desc = "Some people want to return to simpler technology, and some want to only begin researching those simple technologies."
	icon = 'modular_skyrat/modules/simple_research/researching.dmi'
	icon_state = "scroll"
	///the list of discovered items
	var/list/discovered_items = list()
	///list of the shapes we use
	var/static/list/shape_list = list("pyramid", "cube", "sphere")
	///the list that is used when we wonder about the shapes
	var/static/list/shape_parts = list("faces", "edges", "vertices")
	///the list that is used when we wonder about the shape parts
	var/static/list/thinking_list = list("wonder", "think", "ponder", "reason", "meditate", "reflect")
	///Contains images of all radial icons
	var/static/list/radial_icons_cache = list()

/obj/item/research_paper/Initialize(mapload)
	. = ..()
	if(!length(GLOB.simple_research))
		var/list/possible_combinations = list()
		for(var/shape_one in shape_list)
			for(var/shape_two in shape_list)
				for(var/shape_three in shape_list)
					possible_combinations += "[shape_one][shape_two][shape_three]"

		//lets assign the research items to the patterns
		for(var/datum_path in subtypesof(/datum/simple_research))
			var/shape_pattern = pick_n_take(possible_combinations)
			GLOB.simple_research += list("[shape_pattern]" = datum_path)

	radial_icons_cache = list(
		"pyramid" = image(icon = 'modular_skyrat/modules/simple_research/researching.dmi', icon_state = "pyramid"),
		"cube" = image(icon = 'modular_skyrat/modules/simple_research/researching.dmi', icon_state = "cube"),
		"sphere" = image(icon = 'modular_skyrat/modules/simple_research/researching.dmi', icon_state = "sphere"),
	)

/obj/item/research_paper/attack_self(mob/user, modifiers)
	. = ..()
	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/research, SKILL_SPEED_MODIFIER)
	var/shape_one = show_radial_menu(user, src, radial_icons_cache, require_near = TRUE)
	to_chat(user, span_notice("You begin to [pick(thinking_list)] about the [shape_one]... and then [pick(thinking_list)] about their [pick(shape_parts)]..."))
	if(!do_after(user, 5 SECONDS * skill_modifier, src))
		to_chat(user, span_warning("You stopped researching."))
		return

	user.mind.adjust_experience(/datum/skill/research, 5)

	var/shape_two = show_radial_menu(user, src, radial_icons_cache, require_near = TRUE)
	to_chat(user, span_notice("You begin to [pick(thinking_list)] about the [shape_two]... and then [pick(thinking_list)] about their [pick(shape_parts)]..."))
	if(!do_after(user, 5 SECONDS * skill_modifier, src))
		to_chat(user, span_warning("You stopped researching."))
		return

	user.mind.adjust_experience(/datum/skill/research, 5)

	var/shape_three = show_radial_menu(user, src, radial_icons_cache, require_near = TRUE)
	to_chat(user, span_notice("You begin to [pick(thinking_list)] about the [shape_three]... and then [pick(thinking_list)] about their [pick(shape_parts)]..."))
	if(!do_after(user, 5 SECONDS * skill_modifier, src))
		to_chat(user, span_warning("You stopped researching."))
		return

	user.mind.adjust_experience(/datum/skill/research, 5)

	var/datum/simple_research/find_research = GLOB.simple_research["[shape_one][shape_two][shape_three]"]
	if(!find_research)
		to_chat(user, span_warning("You were researching a dead end!"))
		return

	find_research = new find_research()

	var/failure_amount = length(find_research.required_items)
	for(var/check_required in find_research.required_items)
		for(var/check_discovered in discovered_items)
			if(check_required == check_discovered)
				--failure_amount

	if(failure_amount > 0)
		to_chat(user, span_warning("You are unable to research this! You are missing [failure_amount] pre-requisite items!"))
		return

	if(!locate(find_research.type) in discovered_items)
		discovered_items += find_research.type

	var/obj/item/research_scrap/spawned_scrap = new(get_turf(src))
	var/prob_modifier = user.mind.get_skill_modifier(/datum/skill/research, SKILL_PROBS_MODIFIER)
	if(find_research.skilled_item && prob(prob_modifier))
		spawned_scrap.spawning_item = find_research.skilled_item

	else
		spawned_scrap.spawning_item = find_research.research_item

	user.mind.adjust_experience(/datum/skill/research, 10)
	qdel(find_research)

/obj/item/research_scrap
	name = "research scrap"
	desc = "Small sketches of an item are drawn on the scrap-- if you use the materials, you might be able to craft the item on the scrap!"
	icon = 'modular_skyrat/modules/simple_research/researching.dmi'
	icon_state = "scrap"
	///what will be spawned
	var/obj/spawning_item
	///has both glass and metal been used to build the item?
	var/material_satisfied = list(FALSE, FALSE)

/obj/item/research_scrap/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/stack/sheet/iron))
		research_use(attacking_item, user, 2)
		return

	if(istype(attacking_item, /obj/item/stack/sheet/glass))
		research_use(attacking_item, user, 1)
		return

	return ..()

/obj/item/research_scrap/proc/research_use(obj/item/stack/attacking_stack, mob/user, number = 1)
	if(!attacking_stack || !istype(attacking_stack))
		return

	if(material_satisfied[number])
		to_chat(user, span_warning("You have already used [attacking_stack] on this scrap!"))
		return

	if(!attacking_stack.use(1))
		to_chat(user, span_warning("You were unable to use [attacking_stack]!"))
		return

	to_chat(user, span_notice("You use [attacking_stack] on [src]."))

	material_satisfied[number] = TRUE

	if(material_satisfied[1] && material_satisfied[2])
		new spawning_item(get_turf(src))
		to_chat(user, span_notice("You completed [src]."))
		user.mind.adjust_experience(/datum/skill/research, 5)
		qdel(src)
