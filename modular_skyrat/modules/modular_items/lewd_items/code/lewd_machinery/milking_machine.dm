/*
/obj/structure/chair/milking_machine
	name = "milking machine"
	desc = "A stationary device for milking... things."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/milking_machine.dmi'
	icon_state = "milking_pink_off"
	max_buckled_mobs = 1
	item_chair = null
	flags_1 = NODECONSTRUCT_1
	max_integrity = 75
	var/color_changed = FALSE // Variable to track the color change of the machine by the user. So that you can change it once.
	var/static/list/milkingmachine_designs

/*
*	POWER MANAGEMENT
*/

	var/obj/item/stock_parts/cell/cell = null // Current cell in machine
	var/charge_rate = 200 // Power charge per tick devided by delta_time (always about ~2)
	var/power_draw_rate = 65 // Power draw per tick multiplied by delta_time (always about ~2)
	// Additional power consumption multiplier for different operating modes. Fractional value to reduce consumption
	var/power_draw_multiplier_list = list("off" = 0, "low" = 0.025, "medium" = 0.25, "hard" = 0.5)
	var/panel_open = FALSE // Сurrent maintenace panel state

/*
*	OPERATING MODES
*/

	var/pump_state_list = list("pump_off", "pump_on")
	var/pump_state
	var/mode_list = list("off", "low", "medium", "hard")
	var/current_mode


/*
*	SENSATION PARAMETERS
*/

	// Values are returned every tick, without additional modifiers
	var/arousal_amounts = list("off" = 0, "low" = 1, "medium" = 2, "hard" = 3)
	var/pleasure_amounts = list("off" = 0, "low" = 0.2, "medium" = 1, "hard" = 1.5)
	var/pain_amounts = list("off" = 0, "low" = 0, "medium" = 0.2, "hard" = 0.5)

/*
*	FLUID MANAGEMENT
*/

	// Liquids are taken every tick, no additional modifiers
	var/milk_retrive_amount = list("off" = 0, "low" = 1, "medium" = 2, "hard" = 3)
	var/girlcum_retrive_amount = list("off" = 0, "low" = 1, "medium" = 2, "hard" = 3)
	var/semen_retrive_amount = list("off" = 0, "low" = 1, "medium" = 2, "hard" = 3)
	var/climax_retrive_multiplier = 2 // Climax intake volume multiplier

/*
*	VESSELS
*/

	var/max_vessel_capacity = 100 // Limits a max capacity of any internal vessel in machine
	var/obj/item/reagent_containers/milk_vessel
	var/obj/item/reagent_containers/girlcum_vessel
	var/obj/item/reagent_containers/semen_vessel
	var/obj/item/reagent_containers/current_vessel // Vessel selected in UI

/*
*	WORKED OBJECT
*/

	var/obj/item/organ/genital/current_selected_organ = null // Organ selected in UI
	var/obj/item/reagent_containers/glass/beaker = null // Beaker inserted in machine
	var/mob/living/carbon/human/current_mob = null // Mob buckled to the machine
	var/obj/item/organ/genital/breasts/current_breasts = null // Buckled mob breasts
	var/obj/item/organ/genital/testicles/current_testicles = null // Buckled mob testicles
	var/obj/item/organ/genital/vagina/current_vagina = null // Buckled mob vagina

	// Variables for working with sizes and types of organs
	var/breasts_size = null
	var/breasts_count = null
	var/vagina_size = null
	var/testicles_size = null

	// Machine colors
	var/machine_color_list = list("pink", "teal")
	var/machine_color

/*
*	STATE MANAGEMENT
*/

	// Cell power capacity indicator
	var/indicator_state_list = list("indicator_off", "indicator_low", "indicator_medium", "indicator_high")
	var/indicator_state
	// Vessel capacity indicator
	var/vessel_state_list = list("liquid_empty", "liquid_low", "liquid_medium", "liquid_high", "liquid_full")
	var/vessel_state
	// Organ types and sizes
	var/organ_types = list()
	var/current_selected_organ_type = null
	var/current_selected_organ_size = null

	var/lock_state = "open"

/*
*	OVERLAYS
*/

	var/mutable_appearance/vessel_overlay
	var/mutable_appearance/indicator_overlay
	var/mutable_appearance/locks_overlay
	var/mutable_appearance/panel_overlay
	var/mutable_appearance/cell_overlay
	var/mutable_appearance/organ_overlay
	var/organ_overlay_new_icon_state = "" // Organ overlay update optimization

// Additional examine text
/obj/structure/chair/milking_machine/examine(mob/user)
	. = ..()
	. +=span_notice("What are these metal mounts on the armrests for...?")

/obj/structure/chair/milking_machine/Destroy()
	. = ..()
	if(current_mob)
		if(current_mob.handcuffed)
			current_mob.handcuffed.dropped(current_mob)
		current_mob.set_handcuffed(null)
		current_mob.update_abstract_handcuffed()
		current_mob.layer = initial(current_mob.layer)
	STOP_PROCESSING(SSobj, src)
	unbuckle_all_mobs()

// Object initialization
/obj/structure/chair/milking_machine/Initialize()
	. = ..()
	machine_color = machine_color_list[1]

	pump_state = pump_state_list[1]
	current_mode = mode_list[1]
	indicator_state = indicator_state_list[1]
	vessel_state = vessel_state_list[1]

	milk_vessel = new()
	milk_vessel.name = "MilkContainer"
	milk_vessel.reagents.maximum_volume = max_vessel_capacity
	girlcum_vessel = new()
	girlcum_vessel.name = "GirlcumContainer"
	girlcum_vessel.reagents.maximum_volume = max_vessel_capacity
	semen_vessel = new()
	semen_vessel.name = "SemenContainer"
	semen_vessel.reagents.maximum_volume = max_vessel_capacity
	current_vessel = milk_vessel

	vessel_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/milking_machine.dmi', "liquid_empty", LYING_MOB_LAYER)
	vessel_overlay.name = "vessel_overlay"
	indicator_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/milking_machine.dmi', "indicator_empty", ABOVE_MOB_LAYER + 0.1)
	indicator_overlay.name = "indicator_overlay"
	locks_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/milking_machine.dmi', "locks_open", BELOW_MOB_LAYER)
	locks_overlay.name = "locks_overlay"
	panel_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/milking_machine.dmi', "milking_panel_closed", LYING_MOB_LAYER)
	panel_overlay.name = "panel_overlay"
	cell_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/milking_machine.dmi', "milking_cell_empty", ABOVE_MOB_LAYER)
	cell_overlay.name = "cell_overlay"
	organ_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/milking_machine.dmi', "none", ABOVE_MOB_LAYER)
	organ_overlay.name = "organ_overlay"

	add_overlay(locks_overlay)
	add_overlay(vessel_overlay)

	update_all_visuals()
	populate_milkingmachine_designs()
	START_PROCESSING(SSobj, src)

/*
*	APPEARANCE MANAGEMENT
*/

// Define color options for the menu
/obj/structure/chair/milking_machine/proc/populate_milkingmachine_designs()
	milkingmachine_designs = list(
		"pink" = image(icon = src.icon, icon_state = "milking_pink_off"),
		"teal" = image(icon = src.icon, icon_state = "milking_teal_off"))

// Radial menu handler for color selection by using multitool
/obj/structure/chair/milking_machine/multitool_act(mob/living/user, obj/item/used_item)
	. = ..()
	if(.)
		return FALSE
	var/choice = show_radial_menu(user, src, milkingmachine_designs, custom_check = CALLBACK(src, .proc/check_menu, user, used_item), radius = 36, require_near = TRUE)
	if(!choice)
		return TRUE
	machine_color = choice
	update_icon()
	color_changed = TRUE
	to_chat(user, span_notice("You change the color of the milking machine."))
	return TRUE

// Checking if we can use the menu
/obj/structure/chair/milking_machine/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

// Another plug to disable rotation
/obj/structure/chair/milking_machine/attack_tk(mob/user)
	return FALSE

// Get the organs of the mob and visualize the change in machine
/obj/structure/chair/milking_machine/post_buckle_mob(mob/living/affected_mob)
	current_mob = affected_mob

	current_breasts = affected_mob.getorganslot(ORGAN_SLOT_BREASTS)
	if(current_breasts)
		breasts_size = current_breasts.genital_size

	current_testicles = affected_mob.getorganslot(ORGAN_SLOT_TESTICLES)
	if(current_testicles)
		testicles_size = current_testicles.genital_size

	current_vagina = affected_mob.getorganslot(ORGAN_SLOT_VAGINA)
	if(current_vagina)
		vagina_size = current_vagina.genital_size

	cut_overlay(locks_overlay)
	locks_overlay.icon_state = "locks_closed"
	locks_overlay.layer = ABOVE_MOB_LAYER
	add_overlay(locks_overlay)
	if(ishuman(current_mob))
		var/mob/living/carbon/human/victim = current_mob
		if(current_mob.handcuffed)
			current_mob.handcuffed.forceMove(loc)
			current_mob.handcuffed.dropped(current_mob)
			current_mob.set_handcuffed(null)
			current_mob.update_handcuffed()
		current_mob.set_handcuffed(new /obj/item/restraints/handcuffs/milker(victim))
		current_mob.handcuffed.parented_struct = src
		current_mob.update_abstract_handcuffed()

	update_overlays()
	affected_mob.layer = BELOW_MOB_LAYER
	update_all_visuals()

	if(SStgui.try_update_ui(affected_mob, src))
		var/datum/tgui/ui = SStgui.try_update_ui(affected_mob, src)
		ui.close()
	return

// Clear the cache of the organs of the mob and update the state of the machine
/obj/structure/chair/milking_machine/post_unbuckle_mob(mob/living/affected_mob)
	cut_overlay(organ_overlay)
	organ_overlay.icon_state = "none"

	cut_overlay(locks_overlay)
	locks_overlay.icon_state = "locks_open"
	locks_overlay.layer = BELOW_MOB_LAYER
	add_overlay(locks_overlay)

	current_mode = mode_list[1]
	pump_state = pump_state_list[1]

	current_mob.layer = initial(current_mob.layer)
	update_all_visuals()

	if(current_mob.handcuffed)
		current_mob.handcuffed.dropped(current_mob)
		current_mob.set_handcuffed(null)
		current_mob.update_abstract_handcuffed()

	current_mob = null
	current_selected_organ = null
	current_breasts = null
	current_testicles = null
	current_vagina = null

	breasts_size = null
	breasts_count = null
	vagina_size = null
	testicles_size = null
	return

/obj/structure/chair/milking_machine/is_buckle_possible(mob/living/target, force, check_loc)
	// Make sure target is mob/living
	if(!istype(target))
		return FALSE

	// No bucking you to yourself.
	if(target == src)
		return FALSE

	// Check if the target to buckle isn't INSIDE OF A WALL
	if(!isopenturf(loc) || !isopenturf(target.loc))
		return FALSE

	// Check if this atom can have things buckled to it.
	if(!can_buckle && !force)
		return FALSE

	// If we're checking the loc, make sure the target is on the thing we're bucking them to.
	if(check_loc && !target.Adjacent(src))
		return FALSE

	// Make sure the target isn't already buckled to something.
	if(target.buckled)
		return FALSE

	// Make sure this atom can still have more things buckled to it.
	if(LAZYLEN(buckled_mobs) >= max_buckled_mobs)
		return FALSE

	// Stacking buckling leads to lots of jank and issues, better to just nix it entirely
	if(target.has_buckled_mobs())
		return FALSE

	// If the buckle requires restraints, make sure the target is actually restrained.
	if(buckle_requires_restraints && !HAS_TRAIT(target, TRAIT_RESTRAINED))
		return FALSE

	//If buckling is forbidden for the target, cancel
	if(!target.can_buckle_to && !force)
		return FALSE

	//If buckling is not human, cancel. fuck you
	if(!ishuman(target))
		return FALSE

	return TRUE


//for chair handcuffs, no alerts
/mob/living/carbon/proc/update_abstract_handcuffed()
	if(handcuffed)
		drop_all_held_items()
		stop_pulling()
		SEND_SIGNAL(src, COMSIG_ADD_MOOD_EVENT, "handcuffed", /datum/mood_event/handcuffed)
	else
		SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "handcuffed")
	update_action_buttons_icon() //some of our action buttons might be unusable when we're handcuffed.
	update_inv_handcuffed()
	update_hud_handcuffed()

/obj/item
	var/obj/structure/parented_struct = null

/obj/item/restraints/handcuffs/milker
	name = "chair cuffs"
	desc = "A thick metal cuff for restraining hands."
	lefthand_file = null
	righthand_file = null
	breakouttime = 45 SECONDS
	flags_1 = NONE
	item_flags = DROPDEL | ABSTRACT

/obj/item/restraints/handcuffs/milker/Destroy()
	. = ..()
	unbuckle_parent()
	parented_struct = null

/obj/item/restraints/handcuffs/milker/proc/unbuckle_parent()
	if(parented_struct)
		parented_struct.unbuckle_all_mobs()

/obj/structure/chair/milking_machine/user_unbuckle_mob(mob/living/carbon/human/affected_mob, mob/user)

	if(affected_mob)
		if(affected_mob == user)
			// Have difficulty unbuckling if overly aroused
			if(affected_mob.arousal >= 60)
				if((current_mode != mode_list[1]) && (current_mode != mode_list[2]))
					to_chat(affected_mob, span_purple("You are too horny to try to get out!"))
					return
				else
					affected_mob.visible_message(span_notice("[affected_mob] unbuckles [affected_mob.p_them()]self from [src]."),\
						span_notice("You unbuckle yourself from [src]."),\
						span_hear("You hear metal clanking."))
					unbuckle_mob(affected_mob)
					return
			else
				affected_mob.visible_message(span_notice("[affected_mob] unbuckles [affected_mob.p_them()]self from [src]."),\
					span_notice("You unbuckle yourself from [src]."),\
					span_hear("You hear metal clanking."))
				unbuckle_mob(affected_mob)
				return
	else
		. = ..()
		return


/*
*	MAIN LOGIC
*/

// Empty Hand Attack Handler
/obj/structure/chair/milking_machine/attack_hand(mob/user)
	// If the panel is open and the hand is empty, then we take out the battery, otherwise standard processing
	if(panel_open && cell)
		user.put_in_hands(cell)
		cell.add_fingerprint(user)
		user.visible_message(span_notice("[user] removes [cell] from [src]."), span_notice("You remove [cell] from [src]."))
		removecell()
		update_all_visuals()
		return
	// Block the ability to open the interface of the machine if we are attached to it
	if(LAZYLEN(buckled_mobs))
		if(user == buckled_mobs[1])
			user_unbuckle_mob(user, user)
			return
	// Standard processing, open the machine interface
	. = ..()
	if(.)
		return
	return

// Attack handler for various item
/obj/structure/chair/milking_machine/attackby(obj/item/used_item, mob/user)
	// Beaker attack check
	if(istype(used_item, /obj/item/reagent_containers) && !(used_item.item_flags & ABSTRACT) && used_item.is_open_container())
		. = TRUE // No afterattack
		if(panel_open)
			to_chat(user, span_warning("You can't use [src] while its panel is opened!"))
			return
		var/obj/item/reagent_containers/used_container = used_item
		. = TRUE // No afterattack
		if(!user.transferItemToLoc(used_container, src))
			return
		replace_beaker(user, used_container)
		updateUsrDialog()
		return
	// Cell attack check
	if(istype(used_item, /obj/item/stock_parts/cell))
		if(panel_open)
			if(!anchored)
				to_chat(user, span_warning("[src] isn't attached to the ground!"))
				return
			if(cell)
				to_chat(user, span_warning("There is already a cell in [src]!"))
				return
			else
				var/area/current_area = loc.loc // Gets our locations location, like a dream within a dream
				if(!isarea(current_area))
					return
				if(!user.transferItemToLoc(used_item, src))
					cut_overlay(cell_overlay)
					cell_overlay.icon_state = "milking_cell_empty"
					update_all_visuals()
					return

				cell = used_item
				cut_overlay(cell_overlay)
				cell_overlay.icon_state = "milking_cell"
				add_overlay(cell_overlay)
				user.visible_message(span_notice("[user] inserts a cell into [src]."), span_notice("You insert a cell into [src]."))
				update_all_visuals()
				return
		else
			to_chat(user, span_warning("[src]'s maintenance panel isn't opened!"))
			return
	else
		if(screwdriver_action(user, icon_state, icon_state, used_item))
			return
		if(crowbar_action(used_item))
			return
		if(!cell && wrench_act(user, used_item))
			return
		return ..()

// Battery removal handler
/obj/structure/chair/milking_machine/proc/removecell()
	cell.update_icon()
	cell = null
	cut_overlay(cell_overlay)
	cut_overlay(indicator_overlay)
	cell_overlay.icon_state = "milking_cell_empty"
	current_mode = mode_list[1]
	pump_state = pump_state_list[1]
	update_all_visuals()

// Beaker change handler
/obj/structure/chair/milking_machine/proc/replace_beaker(mob/living/user, obj/item/reagent_containers/new_beaker)
	if(!user)
		return FALSE
	if(beaker)
		try_put_in_hand(beaker, user)
		beaker = null
		to_chat(user, span_notice("You take the beaker out of [src]"))
	if(new_beaker)
		beaker = new_beaker
		to_chat(user, span_notice("You put the beaker in [src]"))
	return TRUE

// We will try to take the item in our hand, if it doesn’t work, then drop it into the car tile
/obj/structure/chair/milking_machine/proc/try_put_in_hand(obj/object, mob/living/user)
	if(!issilicon(user) && in_range(src, user))
		user.put_in_hands(object)
	else
		object.forceMove(drop_location())

// Handler for opening the panel with a screwdriver for maintenance
/obj/structure/chair/milking_machine/proc/screwdriver_action(mob/user, icon_state_open, icon_state_closed, obj/item/used_item)
	if(used_item.tool_behaviour == TOOL_SCREWDRIVER)
		used_item.play_tool_sound(src, 50)
		if(!panel_open)
			panel_open = TRUE
			cut_overlay(indicator_overlay)
			if(cell != null)
				cut_overlay(cell_overlay)
				cell_overlay.icon_state = "milking_cell"
				add_overlay(cell_overlay)
				update_all_visuals()
			cut_overlay(panel_overlay)
			panel_overlay.icon_state = "milking_panel"
			add_overlay(panel_overlay)
			to_chat(user, span_notice("You open the maintenance hatch of [src]."))
		else
			panel_open = FALSE
			cut_overlay(panel_overlay)
			panel_overlay.icon_state = "milking_panel_closed"
			update_all_visuals()
			add_overlay(indicator_overlay)
			cut_overlay(cell_overlay)
			cell_overlay.icon_state = "milking_cell_empty"

			to_chat(user, span_notice("You close the maintenance hatch of [src]."))

		return TRUE
	return FALSE

// Object disassembly handler by crowbar
/obj/structure/chair/milking_machine/proc/crowbar_action(obj/item/used_item, ignore_panel = 0)

	. = (panel_open || ignore_panel) && !(flags_1 & NODECONSTRUCT_1) && used_item.tool_behaviour == TOOL_CROWBAR
	if(.)
		used_item.play_tool_sound(src, 50)
		deconstruct(TRUE)

// // Object disassembly handler by wrench
// /obj/structure/chair/milking_machine/default_unfasten_wrench(mob/user, obj/item/used_item, time = 20)
// 	. = !(flags_1 & NODECONSTRUCT_1) && used_item.tool_behaviour == TOOL_WRENCH
// 	if(.)
// 		used_item.play_tool_sound(src, 50)
// 		deconstruct(TRUE)

// Machine Workflow Processor
/obj/structure/chair/milking_machine/process(delta_time)

	// Battery self-charging process processing
	if (cell == null)
		current_mode = mode_list[1]
		pump_state = pump_state_list[1]
		update_all_visuals()
		return
//	if(current_mode == mode_list[1] && pump_state == pump_state_list[1])
//		cell.give(charge_rate * delta_time)

	// Check if the machine should work
	if(!current_mob)
		update_all_visuals()
		return // Doesn't work without a mob
	if(current_selected_organ == null || current_mode == mode_list[1])
		update_all_visuals()
		return // Does not work if an organ is not connected OR the machine is not switched to On
	if(istype(current_selected_organ, /obj/item/organ/genital/breasts))
		if(milk_vessel.reagents.total_volume == max_vessel_capacity)
			current_mode = mode_list[1]
			pump_state = pump_state_list[1]
			update_all_visuals()
			return
	if(istype(current_selected_organ, /obj/item/organ/genital/vagina))
		if(girlcum_vessel.reagents.total_volume == max_vessel_capacity)
			current_mode = mode_list[1]
			pump_state = pump_state_list[1]
			update_all_visuals()
			return
	if(istype(current_selected_organ, /obj/item/organ/genital/testicles))
		if(semen_vessel.reagents.total_volume == max_vessel_capacity)
			current_mode = mode_list[1]
			pump_state = pump_state_list[1]
			update_all_visuals()
			return
	if(current_mode == mode_list[1])
		pump_state = pump_state_list[1]
		update_all_visuals()
		return
	// The machine can work

	if(cell != null && current_mode != mode_list[1])
		pump_state = pump_state_list[2]
		retrive_liquids_from_selected_organ(delta_time)
		increase_current_mob_arousal(delta_time)
		draw_power_from_cell(delta_time)
	else
		current_mode = mode_list[1]
		pump_state = pump_state_list[1]
	update_all_visuals()

// Liquid intake handler
/obj/structure/chair/milking_machine/proc/retrive_liquids_from_selected_organ(delta_time)
	// Climax check
	var/fluid_multiplier = 1
	if(current_mob != null)
		if(current_mob.has_status_effect(/datum/status_effect/climax))
			fluid_multiplier = climax_retrive_multiplier

	if(istype(current_selected_organ, /obj/item/organ/genital/breasts))
		if(current_selected_organ.reagents.total_volume > 0)
			current_selected_organ.internal_fluids.trans_to(milk_vessel, milk_retrive_amount[current_mode] * fluid_multiplier * delta_time)
		else
			return
	else if (istype(current_selected_organ, /obj/item/organ/genital/vagina))
		if(current_selected_organ.reagents.total_volume > 0)
			current_selected_organ.internal_fluids.trans_to(girlcum_vessel, girlcum_retrive_amount[current_mode] * fluid_multiplier * delta_time)
		else
			return
	else if (istype(current_selected_organ, /obj/item/organ/genital/testicles))
		if(current_selected_organ.reagents.total_volume > 0)
			current_selected_organ.internal_fluids.trans_to(semen_vessel, semen_retrive_amount[current_mode] * fluid_multiplier * delta_time)
		else
			return
	else
		// A place for a handler for missing genitals
		return

// Handling the process of the impact of the machine on the organs of the mob
/obj/structure/chair/milking_machine/proc/increase_current_mob_arousal(delta_time)
	src.current_mob.adjustArousal(src.arousal_amounts[src.current_mode] * delta_time)
	src.current_mob.adjustPleasure(src.pleasure_amounts[src.current_mode] * delta_time)
	src.current_mob.adjustPain(src.pain_amounts[src.current_mode] * delta_time)

// Energy consumption processor
/obj/structure/chair/milking_machine/proc/draw_power_from_cell(delta_time)
	if(cell == null)
		current_mode = mode_list[1]
		pump_state = pump_state_list[1]
		return

	var/amount_power_draw = power_draw_rate * delta_time * power_draw_multiplier_list[current_mode]
	if (cell.charge > amount_power_draw) // There is enough charge
		cell.use(amount_power_draw) // Power consumption
		return
	else
		cell.charge = 0 // At this tick, the charge dropped to zero
		current_mode = mode_list[1]	// Turn off the machine
		pump_state = pump_state_list[1]
		return

// Drag and drop mob buckle handler into the machine
/obj/structure/chair/milking_machine/MouseDrop(over_object, src_location, over_location)
	. = ..()
	if(.)
		if(istype(src, /mob/living/) && istype(over_object, /obj/structure/chair/milking_machine))
			var/mob/living/affected_mob = src
			var/obj/structure/chair/milking_machine/milking_machine = over_object
			if(affected_mob.getorganslot(ORGAN_SLOT_TESTICLES))
				milking_machine.current_testicles = affected_mob.getorganslot(ORGAN_SLOT_TESTICLES)
			if(affected_mob.getorganslot(ORGAN_SLOT_VAGINA))
				milking_machine.current_vagina = affected_mob.getorganslot(ORGAN_SLOT_VAGINA)
			if(affected_mob.getorganslot(ORGAN_SLOT_BREASTS))
				milking_machine.current_breasts = affected_mob.getorganslot(ORGAN_SLOT_BREASTS)
			else
				// A place for the handler when the mob doesn't have the genitals it needs
				return
		else
			// A place to handle the case when a non-living mob was dragged
			return
	else
		// The mob for some reason did not get buckled, we do nothing
		return

/obj/structure/chair/milking_machine/wrench_act(mob/living/user, obj/item/used_item)
	if((flags_1 & NODECONSTRUCT_1) && used_item.tool_behaviour == TOOL_WRENCH)
		to_chat(user, span_notice("You being to deconstruct [src]..."))
		if(used_item.use_tool(src, user, 8 SECONDS, volume = 50))
			used_item.play_tool_sound(src, 50)
			deconstruct(TRUE)
			to_chat(user, span_notice("You disassemble [src]."))
		return TRUE
	return TRUE

// Machine deconstruction process handler
/obj/structure/chair/milking_machine/deconstruct(disassembled)
	if(beaker)
		beaker.forceMove(drop_location())
		adjust_item_drop_location(beaker)
		beaker = null
		update_all_visuals()

	if(cell)
		cell.forceMove(drop_location())
		adjust_item_drop_location(cell)
		cell = null
		update_all_visuals()

	var/obj/item/milking_machine/constructionkit/construction_kit = new(src.loc)
	construction_kit.current_color = machine_color
	construction_kit.update_icon_state()
	construction_kit.update_icon()

	return ..()

// Handler of the process of dispensing a glass from a machine to a tile
/obj/structure/chair/milking_machine/proc/adjust_item_drop_location(atom/movable/AM)
	if (AM == beaker)
		AM.pixel_x = AM.base_pixel_x - 8
		AM.pixel_y = AM.base_pixel_y + 8
		return null
	else if (AM == cell)
		AM.pixel_x = AM.base_pixel_x - 8
		AM.pixel_y = AM.base_pixel_y - 8
		return null
	else
		var/md5 = md5(AM.name)
		for (var/i in 1 to 32)
			. += hex2num(md5[i])
		. = . % 9
		AM.pixel_x = AM.base_pixel_x + ((.%3)*6)
		AM.pixel_y = AM.base_pixel_y - 8 + (round( . / 3)*8)

// General handler for calling redrawing of the current state of the machine
/obj/structure/chair/milking_machine/proc/update_all_visuals()

	if(current_selected_organ != null)
		cut_overlay(organ_overlay)
		organ_overlay_new_icon_state = null
		if(istype(current_selected_organ, /obj/item/organ/genital/breasts))
			if(current_selected_organ.genital_type == "pair")
				current_selected_organ_type = "double_breast"
				current_selected_organ_size = current_selected_organ.genital_size
			if(current_selected_organ.genital_type == "quad")
				current_selected_organ_type = "quad_breast"
				// Optimization needed
				switch(current_selected_organ.genital_size)
					if(0 to 2)
						current_selected_organ_size = "0"
					if(3 to 4)
						current_selected_organ_size = "1"
					if(5 to 7)
						current_selected_organ_size = "2"
					if(8 to 10)
						current_selected_organ_size = "3"
					if(11 to 13)
						current_selected_organ_size = "4"
					else
						current_selected_organ_size = "5"
			if(current_selected_organ.genital_type == "sextuple")
				current_selected_organ_type = "six_breast"
				switch(current_selected_organ.genital_size)
					if(0 to 2)
						current_selected_organ_size = "0"
					if(3 to 4)
						current_selected_organ_size = "1"
					if(5 to 7)
						current_selected_organ_size = "2"
					if(8 to 10)
						current_selected_organ_size = "3"
					if(11 to 13)
						current_selected_organ_size = "4"
					else
						current_selected_organ_size = "5"
			if (current_mode == mode_list[1])
				pump_state = pump_state_list[1]
				organ_overlay_new_icon_state = "[current_selected_organ_type]_[pump_state]_[current_selected_organ_size]"
				if(organ_overlay.icon_state != organ_overlay_new_icon_state)
					organ_overlay.icon_state = organ_overlay_new_icon_state
			else
				pump_state = pump_state_list[2]
				organ_overlay_new_icon_state = "[current_selected_organ_type]_[pump_state]_[current_selected_organ_size]_[current_mode]"
				if(organ_overlay.icon_state != organ_overlay_new_icon_state)
					organ_overlay.icon_state = organ_overlay_new_icon_state

		if(istype(current_selected_organ, /obj/item/organ/genital/testicles))
			current_selected_organ_type = "penis"
			current_selected_organ_size = current_selected_organ.genital_size
			if(current_mode == mode_list[1])
				pump_state = pump_state_list[1]
				organ_overlay_new_icon_state = "[current_selected_organ_type]_[pump_state]"
				if(organ_overlay.icon_state != organ_overlay_new_icon_state)
					organ_overlay.icon_state = organ_overlay_new_icon_state
			else
				pump_state = pump_state_list[2]
				organ_overlay_new_icon_state = "[current_selected_organ_type]_[pump_state]_[current_mode]"
				if(organ_overlay.icon_state != organ_overlay_new_icon_state)
					organ_overlay.icon_state = organ_overlay_new_icon_state

		if(istype(current_selected_organ, /obj/item/organ/genital/vagina))
			current_selected_organ_type = "vagina"
			current_selected_organ_size = current_selected_organ.genital_size
			if(current_mode == mode_list[1])
				pump_state = pump_state_list[1]
				organ_overlay_new_icon_state = "[current_selected_organ_type]_[pump_state]"
				if(organ_overlay.icon_state != organ_overlay_new_icon_state)
					organ_overlay.icon_state = organ_overlay_new_icon_state
			else
				pump_state = pump_state_list[2]
				organ_overlay_new_icon_state = "[current_selected_organ_type]_[pump_state]_[current_mode]"
				if(organ_overlay.icon_state != organ_overlay_new_icon_state)
					organ_overlay.icon_state = organ_overlay_new_icon_state
		add_overlay(organ_overlay)
	else
		cut_overlay(organ_overlay)
		organ_overlay.icon_state = "none"

	// Processing changes in the capacity overlay
	cut_overlay(vessel_overlay)
	var/total_reagents_volume = (milk_vessel.reagents.total_volume + girlcum_vessel.reagents.total_volume + semen_vessel.reagents.total_volume)
	if(total_reagents_volume == 0 && total_reagents_volume < 1)
		if(vessel_state != vessel_state_list[1])
			vessel_overlay.icon_state = vessel_state_list[1]
			vessel_state = vessel_state_list[1]
	if((total_reagents_volume >= 1) && (total_reagents_volume < (max_vessel_capacity / 3)))
		if(vessel_state != vessel_state_list[2])
			vessel_overlay.icon_state = vessel_state_list[2]
			vessel_state = vessel_state_list[2]
	if((total_reagents_volume >= (max_vessel_capacity / 3)) && (total_reagents_volume < (2 * max_vessel_capacity / 3)))
		if(vessel_state != vessel_state_list[3])
			vessel_overlay.icon_state = vessel_state_list[3]
			vessel_state = vessel_state_list[3]
	if((total_reagents_volume >= (2 * max_vessel_capacity / 3)) && (total_reagents_volume < max_vessel_capacity))
		if(vessel_state != vessel_state_list[4])
			vessel_overlay.icon_state = vessel_state_list[4]
			vessel_state = vessel_state_list[4]
	if(total_reagents_volume == max_vessel_capacity)
		if(vessel_state != vessel_state_list[5])
			vessel_overlay.icon_state = vessel_state_list[5]
			vessel_state = vessel_state_list[5]
	add_overlay(vessel_overlay)

	// Indicator state control
	if(cell != null)
		var/charge_percentage = round(cell.charge / cell.maxcharge, 0.01)*100
		if(charge_percentage >= 0 && charge_percentage < 25)
			if(indicator_overlay.icon_state != indicator_state_list[2])
				cut_overlay(indicator_overlay)
				indicator_overlay.icon_state = indicator_state_list[2]
				if(!panel_open)
					add_overlay(indicator_overlay)
		if(charge_percentage >= 25 && charge_percentage < 75)
			if(indicator_overlay.icon_state != indicator_state_list[3])
				cut_overlay(indicator_overlay)
				indicator_overlay.icon_state = indicator_state_list[3]
				if(!panel_open)
					add_overlay(indicator_overlay)
		if(charge_percentage >= 75 && charge_percentage <= 100)
			if(indicator_overlay.icon_state != indicator_state_list[4])
				cut_overlay(indicator_overlay)
				indicator_overlay.icon_state = indicator_state_list[4]
				if(!panel_open)
					add_overlay(indicator_overlay)
	else
		cut_overlay(indicator_overlay)

	icon_state = "milking_[machine_color]_[current_mode]"

	update_overlays()
	update_icon_state()
	update_icon()

/*
*	INTERFACE
*/

// Handler for clicking an empty hand on a machine
/obj/structure/chair/milking_machine/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)

	/* Standard behavior. Uncomment for UI debugging
	if(!ui)
		ui = new(user, src, "MilkingMachine", name)
		ui.open()
	*/

	//Block the interface if we are in the machine. Use in production
	if(LAZYLEN(buckled_mobs))
		if(user != src.buckled_mobs[1])
			if(!ui)
				ui = new(user, src, "MilkingMachine", name)
				ui.open()
				return
		else if(ui)
			ui.close()
			return
	else if(!ui)
		ui = new(user, src, "MilkingMachine", name)
		ui.open()
		return

// Interface data filling handler
/obj/structure/chair/milking_machine/ui_data(mob/user)
	var/list/data = list()

	data["mobName"] = current_mob ? current_mob.name : null
	data["mobCanLactate"] = current_breasts ? current_breasts.lactates : null
	data["cellName"] = cell ? cell.name : null
	data["cellMaxCharge"] = cell ? cell.maxcharge : null
	data["cellCurrentCharge"] = cell ? cell.charge : null
	data["beaker"] = beaker ? beaker : null
	data["BeakerName"] = beaker ? beaker.name : null
	data["beakerMaxVolume"] = beaker ? beaker.volume : null
	data["beakerCurrentVolume"] = beaker ? beaker.reagents.total_volume : null
	data["mode"] = current_mode
	data["milkTankMaxVolume"] = max_vessel_capacity
	data["milkTankCurrentVolume"] = milk_vessel ? milk_vessel.reagents.total_volume : null
	data["girlcumTankMaxVolume"] = max_vessel_capacity
	data["girlcumTankCurrentVolume"] = girlcum_vessel ? girlcum_vessel.reagents.total_volume : null
	data["semenTankMaxVolume"] = max_vessel_capacity
	data["semenTankCurrentVolume"] = semen_vessel ? semen_vessel.reagents.total_volume : null
	data["current_vessel"] = current_vessel ? current_vessel : null
	data["current_selected_organ"] = current_selected_organ ? current_selected_organ : null
	data["current_selected_organ_name"] = current_selected_organ ? current_selected_organ.name : null
	if(current_mob?.is_topless() || current_breasts?.visibility_preference == GENITAL_ALWAYS_SHOW)
		data["current_breasts"] = current_breasts ? current_breasts : null
	else
		data["current_breasts"] = null

	if(current_mob?.is_bottomless() || current_testicles?.visibility_preference == GENITAL_ALWAYS_SHOW)
		data["current_testicles"] = current_testicles ? current_testicles : null
	else
		data["current_testicles"] = current_testicles = null

	if(current_mob?.is_bottomless() || current_vagina?.visibility_preference == GENITAL_ALWAYS_SHOW)
		data["current_vagina"] = current_vagina ? current_vagina : null
	else
		data["current_vagina"] = current_vagina = null

	data["machine_color"] = machine_color
	updateUsrDialog()
	return data

// User action handler in the interface
/obj/structure/chair/milking_machine/ui_act(action, params)
	. = ..()
	if(.)
		return
	if(action == "ejectCreature")
		unbuckle_mob(current_mob)
		to_chat(usr, span_notice("You eject [current_mob] from [src]"))
		return TRUE

	if(action == "ejectBeaker")
		replace_beaker(usr)
		update_all_visuals()
		return TRUE

	if(action == "setOffMode")
		current_mode = mode_list[1]
		pump_state = pump_state_list[1]
		update_all_visuals()
		to_chat(usr, span_notice("You turn off [src]"))
		return TRUE

	if(action == "setLowMode")
		current_mode = mode_list[2]
		pump_state = pump_state_list[2]
		update_all_visuals()
		to_chat(usr, span_notice("You switch [src] onto low mode"))
		return TRUE

	if(action == "setMediumMode")
		current_mode = mode_list[3]
		pump_state = pump_state_list[2]
		update_all_visuals()
		to_chat(usr, span_notice("You switch [src] onto medium mode"))
		return TRUE

	if(action == "setHardMode")
		current_mode = mode_list[4]
		pump_state = pump_state_list[2]
		update_all_visuals()
		to_chat(usr, span_notice("You switch [src] onto hard mode"))
		return TRUE

	if(action == "unplug")
		cut_overlay(organ_overlay)
		current_mode = mode_list[1]
		pump_state = pump_state_list[1]
		current_selected_organ = null
		update_all_visuals()
		to_chat(usr, span_notice("You detach the liner."))
		return TRUE

	if(action == "setBreasts")
		current_selected_organ = current_breasts
		update_all_visuals()
		to_chat(usr, span_notice("You attach the liner to [current_selected_organ]."))
		return TRUE

	if(action == "setVagina")
		current_selected_organ = current_vagina
		update_all_visuals()
		to_chat(usr, span_notice("You attach the liner to [current_selected_organ]."))
		return TRUE

	if(action == "setTesticles")
		current_selected_organ = current_testicles
		update_all_visuals()
		to_chat(usr, span_notice("You attach the liner to [current_selected_organ]."))
		return TRUE

	if(action == "setMilk")
		current_vessel = milk_vessel
		update_all_visuals()
		return TRUE

	if(action == "setGirlcum")
		current_vessel = girlcum_vessel
		update_all_visuals()
		return TRUE

	if(action == "setSemen")
		current_vessel = semen_vessel
		update_all_visuals()
		return TRUE

	if(action == "transfer")
		if (!beaker)
			return FALSE

		var/amount = text2num(params["amount"])
		current_vessel.reagents?.trans_to(beaker, amount)
		current_vessel.reagents?.reagent_list[1].name
		update_all_visuals()
		to_chat(usr, span_notice("You transfer [amount] of [current_vessel.reagents?.reagent_list[1].name] to [beaker.name]"))
		return TRUE

// Milking machine construction kit
/obj/item/milking_machine/constructionkit
	name = "milking machine construction parts"
	desc = "Construction parts for a milking machine. Assembly requires a wrench."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/milking_machine.dmi'
	icon_state = "milkbuild"
	var/current_color = "pink"

// Default initialization
/obj/item/milking_machine/constructionkit/Initialize()
	. = ..()
	update_icon_state()
	update_icon()

/obj/item/milking_machine/constructionkit/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]"

// Processor of the process of assembling a kit into a machine
/obj/item/milking_machine/constructionkit/attackby(obj/item/used_item, mob/living/carbon/user, params)
	if((item_flags & IN_INVENTORY) || (item_flags & IN_STORAGE))
		return
	if(used_item.tool_behaviour == TOOL_WRENCH)
		if(user.get_held_items_for_side(LEFT_HANDS) == src || user.get_held_items_for_side(RIGHT_HANDS) == src)
			return
		if(get_turf(user) == get_turf(src))
			return
		else if(used_item.use_tool(src, user, 8 SECONDS, volume = 50))
			var/obj/structure/chair/milking_machine/new_milker = new(get_turf(user))
			if(istype(src, /obj/item/milking_machine/constructionkit))
				if(current_color == "pink")
					new_milker.machine_color = new_milker.machine_color_list[1]
					new_milker.icon_state = "milking_pink_off"
				if(current_color == "teal")
					new_milker.machine_color = new_milker.machine_color_list[2]
					new_milker.icon_state = "milking_teal_off"
			qdel(src)
			to_chat(user, span_notice("You assemble the milking machine."))
			return
*/
