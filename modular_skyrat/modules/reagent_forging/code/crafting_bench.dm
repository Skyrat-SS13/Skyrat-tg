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
	///the amount of chains within the bench
	var/current_chain = 0
	///the amount of chains required
	var/required_chain = 0
	///the amount of plates within the bench
	var/current_plate = 0
	///the amount of plates required
	var/required_plate = 0
	///the amount of coils within the bench
	var/current_coil = 0
	///the amount of coils required
	var/required_coil = 0
	///the amount of wood within the bench
	var/current_wood = 0
	///the amount of wood required
	var/required_wood = 0
	///the amount of hits required to complete the item
	var/required_hits = 0
	///the current amount of hits
	var/current_hits = 0
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
		"Collar" = /obj/item/clothing/neck/kink_collar/reagent_clothing,
		"Handcuffs" = /obj/item/restraints/handcuffs/reagent_clothing,
		"Borer Cage" = /obj/item/cortical_cage,
		"Pavise Shield" = /obj/item/shield/riot/buckler/reagent_weapon/pavise,
		"Buckler Shield" = /obj/item/shield/riot/buckler/reagent_weapon,
		"Coil" = /obj/item/forging/coil,
		"Seed Mesh" = /obj/item/seed_mesh,
		"Primitive Centrifuge" = /obj/item/reagent_containers/glass/primitive_centrifuge,
		"Bokken" = /obj/item/forging/reagent_weapon/bokken,
		"Bow" = /obj/item/forging/incomplete_bow,
	)

/obj/structure/reagent_crafting_bench/examine(mob/user)
	. = ..()
	if(current_chain)
		. += span_notice("[current_chain] chains stored.")
	if(current_plate)
		. += span_notice("[current_plate] plates stored.")
	if(current_coil)
		. += span_notice("[current_coil] coils stored.")
	if(current_wood)
		. += span_notice("[current_wood] wood stored.<br>")
	if(goal_name)
		. += span_notice("Goal Item: [goal_name]")
		. += span_notice("When you have the necessary materials, begin hammering!<br>")
		if(required_chain)
			. += span_warning("[required_chain] chains required.")
		if(required_plate)
			. += span_warning("[required_plate] plates required.")
		if(required_coil)
			. += span_warning("[required_coil] coils required.")
		if(required_wood)
			. += span_warning("[required_wood] wood required.")
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
			required_chain = 5
		if("Chain Armor")
			required_chain = 6
		if("Chain Gloves")
			required_chain = 4
		if("Chain Boots")
			required_chain = 4
		if("Plated Boots")
			required_plate = 4
		if("Horseshoes")
			required_chain = 4
		if("Ring")
			required_chain = 2
		if("Collar")
			required_chain = 3
		if("Handcuffs")
			required_chain = 10
		if("Borer Cage")
			required_plate = 6
		if("Pavise Shield")
			required_plate = 8
		if("Buckler Shield")
			required_plate = 5
		if("Coil")
			required_chain = 2
		if("Seed Mesh")
			required_chain = 4
			required_plate = 1
		if("Primitive Centrifuge")
			required_plate = 1
		if("Bokken")
			required_wood = 4
		if("Bow")
			required_wood = 4
	if(!required_hits)
		required_hits = (required_chain * 2) + (required_plate * 2) + (required_coil * 2) + (required_wood * 2)
	balloon_alert(user, "choice made!")
	update_appearance()

/obj/structure/reagent_crafting_bench/proc/clear_required()
	required_hits = 0
	current_hits = 0
	goal_item_path = null
	goal_name = null
	required_chain = 0
	required_plate = 0
	required_coil = 0
	required_wood = 0

/obj/structure/reagent_crafting_bench/proc/check_required_materials(mob/living/user)
	if(current_chain < required_chain)
		balloon_alert(user, "not enough materials!")
		return FALSE
	if(current_plate < required_plate)
		balloon_alert(user, "not enough materials!")
		return FALSE
	if(current_coil < required_coil)
		balloon_alert(user, "not enough materials!")
		return FALSE
	if(current_wood < required_wood)
		balloon_alert(user, "not enough materials!")
		return FALSE
	return TRUE

//when inserting the materials
/obj/structure/reagent_crafting_bench/attackby(obj/item/attacking_item, mob/user, params)
	update_appearance()

	//the block of code where we add the amounts for each type
	if(istype(attacking_item, /obj/item/stack/sheet/mineral/wood))
		var/obj/item/stack/sheet/mineral/wood/attacking_wood = attacking_item
		if(!attacking_wood.use(1))
			return
		current_wood++
		balloon_alert(user, "wood added!")
		return
	if(istype(attacking_item, /obj/item/forging/complete/plate))
		qdel(attacking_item)
		current_plate++
		balloon_alert(user, "plate added!")
		return
	if(istype(attacking_item, /obj/item/forging/complete/chain))
		qdel(attacking_item)
		current_chain++
		balloon_alert(user, "chain added!")
		return
	if(istype(attacking_item, /obj/item/forging/coil))
		qdel(attacking_item)
		current_coil++
		balloon_alert(user, "coil added!")
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
	for(var/i in 1 to current_chain)
		new /obj/item/forging/complete/chain(src_turf)
	for(var/i in 1 to current_plate)
		new /obj/item/forging/complete/plate(src_turf)
	for(var/i in 1 to current_coil)
		new /obj/item/forging/coil(src_turf)
	var/spawning_wood = current_wood + 5
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
			if(current_wood < 2)
				balloon_alert(user, "not enough wood!")
				return FALSE
			current_wood -= 2
			var/spawning_item = complete_content.spawning_item
			qdel(complete_content)
			new spawning_item(src)
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
		new goal_item_path(src)
		balloon_alert(user, "item crafted!")
		update_appearance()
		user.mind.adjust_experience(/datum/skill/smithing, 30) //creating grants you something
		current_chain -= required_chain
		current_plate -= required_plate
		current_coil -= required_coil
		current_wood -= required_wood
		clear_required()
		return FALSE
	current_hits++
	balloon_alert(user, "good hit!")
	user.mind.adjust_experience(/datum/skill/smithing, 2) //useful hammering means you get some experience
	return FALSE
