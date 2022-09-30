/obj/structure/reagent_crafting_bench
	name = "forging workbench"
	desc = "A crafting bench fitted with tools, securing mechanisms, and a steady surface for blacksmithing."
	icon = 'modular_skyrat/modules/reagent_forging/icons/obj/forge_structures.dmi'
	icon_state = "crafting_bench_empty"

	anchored = TRUE
	density = TRUE

	///the current goal item that is obtainable
	var/goal_item_path
	///the name of the goal item
	var/goal_name
	///what mats are allowed to be entered into the bench
	var/static/list/allowed_mats = list(
		/obj/item/stack/sheet/mineral/wood,
		/obj/item/forging/complete/plate,
		/obj/item/forging/complete/chain,
	)
	///what mats we currently have entered in the bench
	var/list/current_mats = list(
		/obj/item/stack/sheet/mineral/wood = 0,
		/obj/item/forging/complete/plate = 0,
		/obj/item/forging/complete/chain = 0,
	)
	///what mats we need to current the goal item
	var/list/required_mats = list(
		/obj/item/stack/sheet/mineral/wood = 0,
		/obj/item/forging/complete/plate = 0,
		/obj/item/forging/complete/chain = 0,
	)
	///the amount of hits required to complete the item
	var/required_hits = 0
	///the current amount of hits
	var/current_hits = 0
	///the last stored material
	var/matdatum_ref
	//so we can't just keep being hit without cooldown
	COOLDOWN_DECLARE(hit_cooldown)
	///the choices allowed in crafting
	var/static/list/allowed_choices = list(
		"Chain Helmet" = /obj/item/clothing/head/helmet/reagent_clothing,
		"Chain Armor" = /obj/item/clothing/suit/armor/reagent_clothing,
		"Chain Gloves" = /obj/item/clothing/gloves/reagent_clothing,
		"Chain Boots" = /obj/item/clothing/shoes/chain_boots,
		"Plated Boots" = /obj/item/clothing/shoes/plated_boots,
		"Horseshoes" = /obj/item/clothing/shoes/horseshoe,
		"Ring" = /obj/item/clothing/gloves/ring/reagent_clothing,
		"Collar" = /obj/item/clothing/neck/collar/reagent_clothing,
		"Handcuffs" = /obj/item/restraints/handcuffs/reagent_clothing,
		"Borer Cage" = /obj/item/cortical_cage,
		"Pavise Shield" = /obj/item/shield/riot/buckler/reagent_weapon/pavise,
		"Buckler Shield" = /obj/item/shield/riot/buckler/reagent_weapon,
		"Coil" = /obj/item/forging/coil,
		"Seed Mesh" = /obj/item/seed_mesh,
		"Primitive Centrifuge" = /obj/item/reagent_containers/cup/primitive_centrifuge,
		"Bokken" = /obj/item/forging/reagent_weapon/bokken,
		"Bow" = /obj/item/forging/incomplete_bow,
	)

/obj/structure/reagent_crafting_bench/examine(mob/user)
	. = ..()
	if(current_mats[/obj/item/forging/complete/chain])
		. += span_notice("[current_mats[/obj/item/forging/complete/chain]] chains stored.")
	if(current_mats[/obj/item/forging/complete/plate])
		. += span_notice("[current_mats[/obj/item/forging/complete/plate]] plates stored.")
	if(current_mats[/obj/item/stack/sheet/mineral/wood])
		. += span_notice("[current_mats[/obj/item/stack/sheet/mineral/wood]] wood stored.<br>")
	if(goal_name)
		. += span_notice("Goal Item: [goal_name]")
		. += span_notice("When you have the necessary materials, begin hammering!<br>")
		if(required_mats[/obj/item/forging/complete/chain])
			. += span_warning("[required_mats[/obj/item/forging/complete/chain]] chains required.")
		if(required_mats[/obj/item/forging/complete/plate])
			. += span_warning("[required_mats[/obj/item/forging/complete/plate]] plates required.")
		if(required_mats[/obj/item/stack/sheet/mineral/wood])
			. += span_warning("[required_mats[/obj/item/stack/sheet/mineral/wood]] wood required.")
	if(length(contents))
		. += span_notice("<br>Held Item: [contents[1]]")

/obj/structure/reagent_crafting_bench/update_appearance(updates)
	. = ..()
	cut_overlays()
	if(!length(contents))
		return
	var/image/overlayed_item = image(icon = contents[1].icon, icon_state = contents[1].icon_state)
	overlayed_item.transform = matrix(1.5, 0, 0, 0, 0.8, 0)
	add_overlay(overlayed_item)

//when picking a design or clearing a design
/obj/structure/reagent_crafting_bench/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	update_appearance()
	if(length(contents))
		var/obj/item/moving_item = contents[1]
		user.put_in_hands(moving_item)
		balloon_alert(user, "item retrieved!")
		update_appearance()
		return
	if(goal_item_path)
		clear_required()
		balloon_alert_to_viewers("table cleared!")
		update_appearance()
		return
	var/target_choice = tgui_input_list(user, "Which item would you like to craft?", "Crafting Choice", allowed_choices)
	if(!target_choice)
		balloon_alert(user, "no choice made!")
		return
	goal_name = target_choice
	goal_item_path = allowed_choices[target_choice]
	switch(target_choice)
		if("Chain Helmet")
			required_mats[/obj/item/forging/complete/chain] = 5
		if("Chain Armor")
			required_mats[/obj/item/forging/complete/chain] = 6
		if("Chain Gloves")
			required_mats[/obj/item/forging/complete/chain] = 4
		if("Chain Boots")
			required_mats[/obj/item/forging/complete/chain] = 4
		if("Plated Boots")
			required_mats[/obj/item/forging/complete/plate] = 4
		if("Horseshoes")
			required_mats[/obj/item/forging/complete/chain] = 4
		if("Ring")
			required_mats[/obj/item/forging/complete/chain] = 2
		if("Collar")
			required_mats[/obj/item/forging/complete/chain] = 3
		if("Handcuffs")
			required_mats[/obj/item/forging/complete/chain] = 5
		if("Borer Cage")
			required_mats[/obj/item/forging/complete/plate] = 6
		if("Pavise Shield")
			required_mats[/obj/item/forging/complete/plate] = 8
		if("Buckler Shield")
			required_mats[/obj/item/forging/complete/plate] = 5
		if("Coil")
			required_mats[/obj/item/forging/complete/chain] = 2
		if("Seed Mesh")
			required_mats[/obj/item/forging/complete/chain] = 4
			required_mats[/obj/item/forging/complete/plate] = 1
		if("Primitive Centrifuge")
			required_mats[/obj/item/forging/complete/plate] = 1
		if("Bokken")
			required_mats[/obj/item/stack/sheet/mineral/wood] = 4
		if("Bow")
			required_mats[/obj/item/stack/sheet/mineral/wood] = 4
	if(!required_hits)
		required_hits = (required_mats[/obj/item/forging/complete/chain] * 2) + (required_mats[/obj/item/forging/complete/plate] * 2) + (required_mats[/obj/item/stack/sheet/mineral/wood] * 2)
	balloon_alert(user, "choice made!")
	update_appearance()

/obj/structure/reagent_crafting_bench/proc/clear_required()
	required_hits = 0
	current_hits = 0
	goal_item_path = null
	goal_name = null
	required_mats[/obj/item/forging/complete/chain] = 0
	required_mats[/obj/item/forging/complete/plate] = 0
	required_mats[/obj/item/stack/sheet/mineral/wood] = 0

/obj/structure/reagent_crafting_bench/proc/check_required_materials(mob/living/user)
	if(current_mats[/obj/item/forging/complete/chain] < required_mats[/obj/item/forging/complete/chain])
		balloon_alert(user, "not enough materials!")
		return FALSE
	if(current_mats[/obj/item/forging/complete/plate] < required_mats[/obj/item/forging/complete/plate])
		balloon_alert(user, "not enough materials!")
		return FALSE
	if(current_mats[/obj/item/stack/sheet/mineral/wood] < required_mats[/obj/item/stack/sheet/mineral/wood])
		balloon_alert(user, "not enough materials!")
		return FALSE
	return TRUE

//when inserting the materials
/obj/structure/reagent_crafting_bench/attackby(obj/item/attacking_item, mob/user, params)
	update_appearance()

	//the block of code where we add the amounts for each type
	if(is_type_in_list(attacking_item, allowed_mats))
		var/store_name = attacking_item.name
		matdatum_ref = attacking_item.custom_materials
		if(istype(attacking_item, /obj/item/stack))
			var/obj/item/stack/attacking_stack = attacking_item
			current_mats[attacking_stack.type] += attacking_stack.amount
			if(!attacking_stack.use(attacking_stack.amount)) //I know its weird, but to prevent a runtime, it needs to be in this order
				current_mats[attacking_stack.type] -= attacking_stack.amount
				return
		else
			current_mats[attacking_item.type]++
			qdel(attacking_item)
		balloon_alert(user, "[store_name] added!")
		return

	//inserting a thing
	if(istype(attacking_item, /obj/item/forging/complete))
		var/obj/item/forging/complete/attacking_complete = attacking_item
		if(length(contents))
			balloon_alert(user, "already full!")
			return
		attacking_complete.forceMove(src)
		balloon_alert(user, "item inserted!")
		update_appearance()
		return

	return ..()

/obj/structure/reagent_crafting_bench/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	var/turf/src_turf = get_turf(src)
	for(var/i in 1 to current_mats[/obj/item/forging/complete/chain])
		new /obj/item/forging/complete/chain(src_turf)
	for(var/i in 1 to current_mats[/obj/item/forging/complete/plate])
		new /obj/item/forging/complete/plate(src_turf)
	var/spawning_wood = current_mats[/obj/item/stack/sheet/mineral/wood] + 5
	for(var/i in 1 to spawning_wood)
		new /obj/item/stack/sheet/mineral/wood(src_turf)
	qdel(src)
	return TRUE

/obj/structure/reagent_crafting_bench/hammer_act(mob/living/user, obj/item/tool)
	playsound(src, 'modular_skyrat/modules/reagent_forging/sound/forge.ogg', 50, TRUE)
	if(length(contents))
		if(istype(contents[1], /obj/item/forging/complete))
			var/obj/item/forging/complete/complete_content = contents[1]
			if(!complete_content?.spawning_item)
				balloon_alert(user, "no craftable!")
				return FALSE
			if(current_mats[/obj/item/stack/sheet/mineral/wood] < 2)
				balloon_alert(user, "not enough wood!")
				return FALSE
			current_mats[/obj/item/stack/sheet/mineral/wood] -= 2
			var/obj/spawned_obj = new complete_content.spawning_item(src)
			if(complete_content.custom_materials)
				spawned_obj.set_custom_materials(complete_content.custom_materials, 1)
			qdel(complete_content)
			user.mind.adjust_experience(/datum/skill/smithing, 30) //creating grants you something
			balloon_alert(user, "item crafted!")
			update_appearance()
			return FALSE
	if(!goal_item_path)
		balloon_alert(user, "no choice made!")
		return FALSE
	if(!check_required_materials(user))
		return FALSE
	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER) * 1 SECONDS
	if(!COOLDOWN_FINISHED(src, hit_cooldown))
		current_hits -= 3
		balloon_alert(user, "bad hit!")
		if(current_hits <= -required_hits)
			clear_required()
		return FALSE
	COOLDOWN_START(src, hit_cooldown, skill_modifier)
	if(current_hits >= required_hits && !length(contents))
		var/obj/spawned_obj = new goal_item_path(src)
		if(matdatum_ref)
			spawned_obj.set_custom_materials(matdatum_ref)
		balloon_alert(user, "item crafted!")
		update_appearance()
		user.mind.adjust_experience(/datum/skill/smithing, 30) //creating grants you something
		current_mats[/obj/item/forging/complete/chain] -= required_mats[/obj/item/forging/complete/chain]
		current_mats[/obj/item/forging/complete/plate] -= required_mats[/obj/item/forging/complete/plate]
		current_mats[/obj/item/stack/sheet/mineral/wood] -= required_mats[/obj/item/stack/sheet/mineral/wood]
		clear_required()
		return FALSE
	current_hits++
	balloon_alert(user, "good hit!")
	user.mind.adjust_experience(/datum/skill/smithing, 2) //useful hammering means you get some experience
	return FALSE
