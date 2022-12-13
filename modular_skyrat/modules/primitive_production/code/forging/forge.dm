/// The baseline time to take for doing actions with the forge, like heating glass, setting ceramics, etc.
#define BASELINE_ACTION_TIME 4 SECONDS

/// The basline for how long an item such as molten glass will be kept workable after heating
#define BASELINE_HEATING_DURATION 1 MINUTES

/// Defines for the different levels of smoke coming out of the forge, (good, neutral, bad) are all used for baking, (not cooking) is used for when there is no tray in the forge
#define SMOKE_STATE_NONE 0
#define SMOKE_STATE_GOOD 1
#define SMOKE_STATE_NEUTRAL 2
#define SMOKE_STATE_BAD 3
#define SMOKE_STATE_NOT_COOKING 4

/obj/structure/forge
	name = "forge"
	desc = "A structure built out of bricks, for heating up metal, or glass, or ceramic, or food, or anything really."
	icon = 'modular_skyrat/modules/primitive_production/icons/forge_structures.dmi'
	icon_state = "forge_inactive"

	anchored = TRUE
	density = TRUE

	/// How much time left until the forge stops burning
	var/forge_fuel = 0
	/// Cooldown time for processing on the forge
	COOLDOWN_DECLARE(forging_cooldown)
	/// Is the forge in use or not? If true, prevents most interactions with the forge
	var/in_use = FALSE
	/// What smoke particles should be coming out of the forge
	var/smoke_state = SMOKE_STATE_NONE
	/// Tracks any oven tray placed inside of the forge
	var/obj/item/plate/oven_tray/used_tray
	/// The list of possible things to make with materials used on the forge
	var/static/list/choice_list = list(
		"Chain" = /obj/item/forging/incomplete/chain,
		"Plate" = /obj/item/forging/incomplete/plate,
		"Sword" = /obj/item/forging/incomplete/sword,
		"Dagger" = /obj/item/forging/incomplete/dagger,
		"Staff" = /obj/item/forging/incomplete/staff,
		"Spear" = /obj/item/forging/incomplete/spear,
		"Axe" = /obj/item/forging/incomplete/axe,
		"Hammer" = /obj/item/forging/incomplete/hammer,
		"Pickaxe" = /obj/item/forging/incomplete/pickaxe,
		"Shovel" = /obj/item/forging/incomplete/shovel,
		"Arrowhead" = /obj/item/forging/incomplete/arrowhead,
		"Rail Nail" = /obj/item/forging/incomplete/rail_nail,
		"Rail Cart" = /obj/item/forging/incomplete/rail_cart,
	)
	/// List of possible choices for the selection radial
	var/list/radial_choice_list = list()
	/// What items are valid for being used as a fuel in the forge? Includes subtypes!
	var/static/list/valid_fuel_types = typecacheof(list(
		/obj/item/stack/sheet/mineral/wood,
		/obj/item/stack/sheet/mineral/coal,
	))

/obj/structure/forge/examine(mob/user)
	. = ..()

	if(used_tray)
		. += span_notice("It has [used_tray] in it, which can be removed with an <b>empty hand</b>.")
	else
		. += span_notice("You can place an <b>oven tray</b> in this to <b>bake</b> any items on it.")

	return .

/obj/structure/forge/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	populate_radial_choice_list()

/// Fills out the radial choice list with everything in the choice_list's contents
/obj/structure/forge/proc/populate_radial_choice_list()
	if(!length(choice_list))
		return

	if(length(radial_choice_list))
		return

	for(var/forge_option in choice_list)
		var/obj/resulting_item = choice_list[forge_option]
		radial_choice_list[forge_option] = image(icon = initial(resulting_item.icon), icon_state = initial(resulting_item.icon_state))

/obj/structure/forge/Destroy()
	STOP_PROCESSING(SSobj, src)
	QDEL_NULL(particles)
	if(used_tray)
		QDEL_NULL(used_tray)
	. = ..()

/obj/structure/forge/update_appearance(updates)
	. = ..()
	cut_overlays()

	if(used_tray) // If we have a tray inside, check if the forge is on or not, then give the corresponding tray overlay
		var/image/tray_overlay = image(icon = icon, icon_state = "forge_tray_[check_fuel(just_checking = TRUE) ? "active" : "inactive"]")
		add_overlay(tray_overlay)

/// Checks the forge's fuel, if just_check is TRUE then we also subtract from the fuel's current time
/obj/structure/forge/proc/check_fuel(just_checking = FALSE)
	if(forge_fuel) // Check for strong fuel (coal) first, as it has more power over weaker fuels
		if(just_checking)
			return TRUE

		forge_fuel -= 5 SECONDS
		return TRUE

	return FALSE

/// Creates both a fail message balloon alert, and sets in_use to false
/obj/structure/forge/proc/fail_message(mob/living/user, message)
	balloon_alert(user, message)
	in_use = FALSE

/// If the forge is in use, checks if there is an oven tray, then if there are any mobs actually in use range. If not sets the forge to not be in use.
/obj/structure/forge/proc/check_in_use()
	if(!in_use)
		return

	if(used_tray) // We check if there's a tray because trays inside of the forge count as it being in use, even if nobody is around
		return

	for(var/mob/living/living_mob in range(1,src))
		if(!living_mob)
			in_use = FALSE

/obj/structure/forge/process(delta_time)
	if(!COOLDOWN_FINISHED(src, forging_cooldown))
		return

	COOLDOWN_START(src, forging_cooldown, 5 SECONDS)
	check_fuel()
	check_in_use() // This is here to ensure the forge doesn't remain in_use if it really isn't

	if(!used_tray && check_fuel(just_checking = TRUE))
		set_smoke_state(SMOKE_STATE_NOT_COOKING) // If there is no tray but we have fuel, use the not cooking smoke state
		return

	if(!check_fuel(just_checking = TRUE)) // If there's no fuel, remove it all
		set_smoke_state(SMOKE_STATE_NONE)
		return

	handle_baking_things(delta_time)

/// Sends signals to bake and items on the used tray, setting the smoke state of the forge according to the most cooked item in it
/obj/structure/forge/proc/handle_baking_things(delta_time)
	/// The worst off item being baked in our forge right now, to ensure people know when gordon ramsay is gonna be upset at them
	var/worst_cooked_food_state = 0
	for(var/obj/item/baked_item as anything in used_tray.contents)

		var/signal_result = SEND_SIGNAL(baked_item, COMSIG_ITEM_BAKED, src, delta_time)

		if(signal_result & COMPONENT_HANDLED_BAKING)
			if(signal_result & COMPONENT_BAKING_GOOD_RESULT && worst_cooked_food_state < SMOKE_STATE_GOOD)
				worst_cooked_food_state = SMOKE_STATE_GOOD
			else if(signal_result & COMPONENT_BAKING_BAD_RESULT && worst_cooked_food_state < SMOKE_STATE_NEUTRAL)
				worst_cooked_food_state = SMOKE_STATE_NEUTRAL
			continue

		worst_cooked_food_state = SMOKE_STATE_BAD
		baked_item.fire_act(1000) // Overcooked food really does burn, hot hot hot!

		if(DT_PROB(10, delta_time))
			visible_message(span_danger("You smell a burnt smell coming from [src]!")) // Give indication that something is burning in the oven
	set_smoke_state(worst_cooked_food_state)

/// Sets the type of particles that the forge should be generating
/obj/structure/forge/proc/set_smoke_state(new_state)
	if(new_state == smoke_state)
		return

	smoke_state = new_state

	QDEL_NULL(particles)

	switch(smoke_state)
		if(SMOKE_STATE_NONE)
			icon_state = "forge_inactive"
			set_light(0, 0) // If we aren't heating up and thus not on fire, turn the fire light off
			return

		if(SMOKE_STATE_BAD)
			particles = new /particles/smoke()
			particles.position = list(6, 4, 0)

		if(SMOKE_STATE_NEUTRAL)
			particles = new /particles/smoke/steam()
			particles.position = list(6, 4, 0)

		if(SMOKE_STATE_GOOD)
			particles = new /particles/smoke/steam/mild()
			particles.position = list(6, 4, 0)

		if(SMOKE_STATE_NOT_COOKING)
			particles = new /particles/smoke/mild()
			particles.position = list(6, 4, 0)

	icon_state = "forge_active"
	set_light(3, 1, LIGHT_COLOR_FIRE)

/obj/structure/forge/attack_hand(mob/living/user, list/modifiers)
	. = ..()

	if(used_tray)
		remove_tray_from_forge(user)
		return

/obj/structure/forge/attackby(obj/item/attacking_item, mob/living/user, params)
	if(!used_tray && istype(attacking_item, /obj/item/plate/oven_tray))
		add_tray_to_forge(attacking_item)
		return TRUE

	if(in_use) // If the forge is currently in use by someone (or there is a tray in it) then we cannot use it
		if(used_tray)
			balloon_alert(user, "remove [used_tray] first")
		balloon_alert(user, "forge busy")
		return TRUE

	if(is_type_in_typecache(attacking_item, valid_fuel_types))
		refuel(attacking_item, user)
		return TRUE

	if(istype(attacking_item, /obj/item/stack/ore))
		smelt_ore(attacking_item, user)
		return TRUE

	if(istype(attacking_item, /obj/item/in_progress_ceramic))
		handle_ceramics(attacking_item, user)
		return TRUE

	if(istype(attacking_item, /obj/item/stack/sheet/glass))
		handle_glass_sheet_melting(attacking_item, user)
		return TRUE

	return ..()

/// Take the given tray and place it inside the forge, updating everything relevant to that
/obj/structure/forge/proc/add_tray_to_forge(obj/item/plate/oven_tray/tray)
	if(used_tray) // This shouldn't be able to happen but just to be safe
		balloon_alert_to_viewers("already has tray")
		return

	tray.forceMove(src)
	balloon_alert_to_viewers("put [tray] in [src]")
	used_tray = tray
	in_use = TRUE // You can't use the forge if there's a tray sitting in it
	update_appearance()

/// Take the used_tray and spit it out, updating everything relevant to that
/obj/structure/forge/proc/remove_tray_from_forge(mob/living/carbon/user)
	if(!used_tray)
		if(user)
			balloon_alert_to_viewers("no tray")
		return

	if(user)
		user.put_in_hands(used_tray)
		balloon_alert_to_viewers("removed [used_tray]")
	else
		used_tray.forceMove(get_turf(src))
	used_tray = null
	in_use = FALSE

/// Adds to either the strong or weak fuel timers from the given stack
/obj/structure/forge/proc/refuel(obj/item/stack/refueling_stack, mob/living/user)
	in_use = TRUE

	if(forge_fuel >= 5 MINUTES)
		fail_message(user, "[src] is full on fuel")
		return

	balloon_alert_to_viewers("refueling...")

	var/obj/item/stack/sheet/stack_sheet = refueling_stack
	if(!do_after(user, 3 SECONDS, target = src) || !stack_sheet.use(1))
		fail_message(user, "stopped fueling")
		return

	forge_fuel += 2 MINUTES
	in_use = FALSE
	balloon_alert(user, "fueled [src]")
	user.mind.adjust_experience(/datum/skill/smithing, 5) // You gain small amounts of experience from useful fueling

/// Takes given ore and smelts it, possibly producing extra sheets if upgraded
/obj/structure/forge/proc/smelt_ore(obj/item/stack/ore/ore_item, mob/living/user)
	in_use = TRUE

	if(!check_fuel(just_checking = TRUE))
		fail_message(user, "forge lacks fuel")
		return

	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER)

	if(!ore_item.refined_type)
		fail_message(user, "cannot smelt [ore_item]")
		return

	balloon_alert_to_viewers("smelting...")

	if(!do_after(user, skill_modifier * 3 SECONDS, target = src))
		fail_message(user, "stopped smelting [ore_item]")
		return

	var/src_turf = get_turf(src)
	var/spawning_item = ore_item.refined_type
	var/ore_to_sheet_amount = ore_item.amount

	for(var/spawn_ore in 1 to ore_to_sheet_amount)
		new spawning_item(src_turf)

	in_use = FALSE
	qdel(ore_item)
	return

/// Sets ceramic items from their unusable state into their finished form
/obj/structure/forge/proc/handle_ceramics(obj/attacking_item, mob/living/user)
	in_use = TRUE

	if(!check_fuel(just_checking = TRUE))
		fail_message(user, "forge lacks fuel")
		return

	var/obj/item/in_progress_ceramic/ceramic_item = attacking_item
	var/ceramic_speed = user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER) * BASELINE_ACTION_TIME

	if(!ceramic_item.type_to_complete_into)
		fail_message(user, "cannot set [ceramic_item]")
		return

	balloon_alert_to_viewers("setting [ceramic_item]")

	if(!do_after(user, ceramic_speed, target = src))
		fail_message("stopped setting [ceramic_item]")
		return

	balloon_alert(user, "finished setting [ceramic_item]")
	new ceramic_item.type_to_complete_into(get_turf(src))
	user.mind.adjust_experience(/datum/skill/production, 50)
	qdel(ceramic_item)
	in_use = FALSE

/// Handles the creation of molten glass from glass sheets
/obj/structure/forge/proc/handle_glass_sheet_melting(obj/attacking_item, mob/living/user)
	in_use = TRUE

	if(!check_fuel(just_checking = TRUE))
		fail_message(user, "forge lacks fuel")
		return

	var/obj/item/stack/sheet/glass/glass_item = attacking_item
	var/glassblowing_speed = user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER) * BASELINE_ACTION_TIME
	var/glassblowing_amount = BASELINE_HEATING_DURATION / user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER)

	balloon_alert_to_viewers("heating...")

	if(!do_after(user, glassblowing_speed, target = src) || !glass_item.use(1))
		fail_message(user, "stopped heating [glass_item]")
		return

	in_use = FALSE
	var/obj/item/glassblowing/molten_glass/spawned_glass = new /obj/item/glassblowing/molten_glass(get_turf(src))
	user.mind.adjust_experience(/datum/skill/production, 10)
	COOLDOWN_START(spawned_glass, remaining_heat, glassblowing_amount)

/obj/structure/forge/tong_act(mob/living/user, obj/item/tool)
	var/skill_modifier = user.mind.get_skill_modifier(/datum/skill/smithing, SKILL_SPEED_MODIFIER)
	var/obj/item/forging/forge_item = tool

	if(in_use || forge_item.in_use)
		fail_message(user, "forge busy")
		return TOOL_ACT_TOOLTYPE_SUCCESS

	in_use = TRUE
	forge_item.in_use = TRUE

	if(!check_fuel(just_checking = TRUE))
		fail_message(user, "forge lacks fuel")
		forge_item.in_use = FALSE
		return TOOL_ACT_TOOLTYPE_SUCCESS

	// Here we check the item used on us (tongs) for an incomplete forge item of some kind to heat
	var/obj/item/forging/incomplete/search_incomplete = locate(/obj/item/forging/incomplete) in forge_item.contents
	if(search_incomplete)
		balloon_alert_to_viewers("heating [search_incomplete]")

		if(!do_after(user, skill_modifier * forge_item.toolspeed, target = src))
			balloon_alert_to_viewers("stopped heating [search_incomplete]")
			forge_item.in_use = FALSE
			return TOOL_ACT_TOOLTYPE_SUCCESS

		COOLDOWN_START(search_incomplete, heating_remainder, BASELINE_HEATING_DURATION)
		in_use = FALSE
		forge_item.in_use = FALSE
		user.mind.adjust_experience(/datum/skill/smithing, 5) // Heating up forge items grants some experience
		balloon_alert(user, "successfully heated [search_incomplete]")
		return TOOL_ACT_TOOLTYPE_SUCCESS

	// Here we check the item used on us (tongs) for a stack of some kind to create an object from
	var/obj/item/stack/search_stack = locate(/obj/item/stack) in forge_item.contents
	if(search_stack)
		var/user_choice = show_radial_menu(user, src, radial_choice_list, radius = 38, require_near = TRUE, tooltips = TRUE)
		if(!user_choice)
			fail_message(user, "nothing chosen")
			forge_item.in_use = FALSE
			return TOOL_ACT_TOOLTYPE_SUCCESS

		// Sets up a list of the materials to give to the item later
		var/list/material_list = list()

		if(search_stack.material_type)
			material_list[GET_MATERIAL_REF(search_stack.material_type)] = MINERAL_MATERIAL_AMOUNT

		else
			for(var/material as anything in search_stack.custom_materials)
				material_list[material] = MINERAL_MATERIAL_AMOUNT

		if(!search_stack.use(1))
			fail_message(user, "not enough of [search_stack]")
			forge_item.in_use = FALSE
			return TOOL_ACT_TOOLTYPE_SUCCESS

		balloon_alert_to_viewers("heating [search_stack]")

		if(!do_after(user, skill_modifier * forge_item.toolspeed, target = src))
			balloon_alert_to_viewers("stopped heating [search_stack]")
			forge_item.in_use = FALSE
			return TOOL_ACT_TOOLTYPE_SUCCESS

		var/spawn_item = choice_list[user_choice]
		var/obj/item/forging/incomplete/incomplete_item = new spawn_item(get_turf(src))

		if(material_list)
			incomplete_item.set_custom_materials(material_list)

		COOLDOWN_START(incomplete_item, heating_remainder, BASELINE_HEATING_DURATION)
		in_use = FALSE
		forge_item.in_use = FALSE
		balloon_alert(user, "prepared [search_incomplete] into [user_choice]")
		search_stack = locate(/obj/item/stack) in forge_item.contents

		if(!search_stack)
			forge_item.icon_state = "tong_empty"
		return TOOL_ACT_TOOLTYPE_SUCCESS

	in_use = FALSE
	forge_item.in_use = FALSE
	return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/structure/forge/blowrod_act(mob/living/user, obj/item/tool)
	var/obj/item/glassblowing/blowing_rod/blowing_item = tool
	var/glassblowing_speed = user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER) * BASELINE_ACTION_TIME
	var/glassblowing_amount = BASELINE_HEATING_DURATION / user.mind.get_skill_modifier(/datum/skill/production, SKILL_SPEED_MODIFIER)

	if(in_use)
		to_chat(user, span_warning("You cannot do multiple things at the same time!"))
		return TOOL_ACT_TOOLTYPE_SUCCESS
	in_use = TRUE

	if(!check_fuel(just_checking = TRUE))
		fail_message(user, "forge lacks fuel")
		return TOOL_ACT_TOOLTYPE_SUCCESS

	var/obj/item/glassblowing/molten_glass/find_glass = locate() in blowing_item.contents
	if(!find_glass)
		fail_message(user, "[blowing_item] does not have any glass to heat up.")
		return TOOL_ACT_TOOLTYPE_SUCCESS

	if(!COOLDOWN_FINISHED(find_glass, remaining_heat))
		fail_message(user, "[find_glass] is still has remaining heat.")
		return TOOL_ACT_TOOLTYPE_SUCCESS

	to_chat(user, span_notice("You begin heating up [blowing_item]."))

	if(!do_after(user, glassblowing_speed, target = src))
		fail_message(user, "[blowing_item] is interrupted in its heating process.")
		return TOOL_ACT_TOOLTYPE_SUCCESS

	COOLDOWN_START(find_glass, remaining_heat, glassblowing_amount)
	to_chat(user, span_notice("You finish heating up [blowing_item]."))
	user.mind.adjust_experience(/datum/skill/smithing, 5)
	user.mind.adjust_experience(/datum/skill/production, 10)
	in_use = FALSE
	return TOOL_ACT_TOOLTYPE_SUCCESS

/obj/structure/forge/crowbar_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	deconstruct(TRUE)
	return TRUE

/obj/structure/forge/deconstruct(disassembled)
	new /obj/item/stack/sheet/iron/ten(get_turf(src))
	return ..()

/particles/smoke/mild
	spawning = 1
	velocity = list(0, 0.3, 0)
	friction = 0.25

#undef BASELINE_ACTION_TIME

#undef BASELINE_HEATING_DURATION

#undef SMOKE_STATE_NONE
#undef SMOKE_STATE_GOOD
#undef SMOKE_STATE_NEUTRAL
#undef SMOKE_STATE_BAD
#undef SMOKE_STATE_NOT_COOKING
