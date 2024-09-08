#define MILKING_PUMP_MODE_OFF "off"
#define MILKING_PUMP_MODE_LOW "low"
#define MILKING_PUMP_MODE_MEDIUM "medium"
#define MILKING_PUMP_MODE_HARD "hard"

#define MILKING_PUMP_STATE_OFF "off"
#define MILKING_PUMP_STATE_ON "on"

#define CLIMAX_RETRIEVE_MULTIPLIER 2
#define MILKING_PUMP_MAX_CAPACITY 100

/obj/structure/chair/milking_machine
	name = "milking machine"
	desc = "A stationary device for milking... things."
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/milking_machine.dmi'
	icon_state = "milking_pink_off"
	max_buckled_mobs = 1
	item_chair = null
	max_integrity = 75
	var/static/list/milkingmachine_designs

/*
*	OPERATING MODES
*/
	///What state is the pump currently on? This is either `MLIKING_PUMP_STATE_OFF` or `MLIKING_PUMP_STATE_ON`
	var/pump_state = MILKING_PUMP_STATE_OFF
	///What mode is the pump currently on?
	var/current_mode = MILKING_PUMP_MODE_OFF

/*
*	VESSELS
*/

	var/obj/item/reagent_containers/milk_vessel
	var/obj/item/reagent_containers/girlcum_vessel
	var/obj/item/reagent_containers/semen_vessel
	var/obj/item/reagent_containers/current_vessel // Vessel selected in UI

/*
*	WORKED OBJECT
*/

	/// What organ is fluid being extracted from?
	var/obj/item/organ/external/genital/current_selected_organ = null
	/// What beaker is liquid being outputted to?
	var/obj/item/reagent_containers/cup/beaker = null
	/// What human mob is currently buckled to the machine?
	var/mob/living/carbon/human/current_mob = null
	/// What is the current breast organ of the buckled mob?
	var/obj/item/organ/external/genital/breasts/current_breasts = null
	/// What is the current testicles organ of the buckled mob?
	var/obj/item/organ/external/genital/testicles/current_testicles = null
	/// What is the current vagina organ of the buckled mob?
	var/obj/item/organ/external/genital/vagina/current_vagina = null

	/// What color is the machine currently set to?
	var/machine_color = "pink"

/*
*	OVERLAYS
*/

	var/mutable_appearance/vessel_overlay
	var/mutable_appearance/indicator_overlay
	var/mutable_appearance/locks_overlay
	var/mutable_appearance/organ_overlay
	var/organ_overlay_new_icon_state = "" // Organ overlay update optimization

// Object initialization
/obj/structure/chair/milking_machine/Initialize(mapload)
	. = ..()
	milk_vessel = new()
	milk_vessel.name = "MilkContainer"
	milk_vessel.reagents.maximum_volume = MILKING_PUMP_MAX_CAPACITY
	girlcum_vessel = new()
	girlcum_vessel.name = "GirlcumContainer"
	girlcum_vessel.reagents.maximum_volume = MILKING_PUMP_MAX_CAPACITY
	semen_vessel = new()
	semen_vessel.name = "SemenContainer"
	semen_vessel.reagents.maximum_volume = MILKING_PUMP_MAX_CAPACITY
	current_vessel = milk_vessel

	vessel_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/milking_machine.dmi', "liquid_empty", LYING_MOB_LAYER)
	vessel_overlay.name = "vessel_overlay"
	indicator_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/milking_machine.dmi', "indicator_empty", ABOVE_MOB_LAYER + 0.1)
	indicator_overlay.name = "indicator_overlay"
	locks_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/milking_machine.dmi', "locks_open", BELOW_MOB_LAYER)
	locks_overlay.name = "locks_overlay"
	organ_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_structures/milking_machine.dmi', "none", ABOVE_MOB_LAYER)
	organ_overlay.name = "organ_overlay"

	add_overlay(locks_overlay)
	add_overlay(vessel_overlay)

	update_all_visuals()
	populate_milkingmachine_designs()
	START_PROCESSING(SSobj, src)

// Additional examine text
/obj/structure/chair/milking_machine/examine(mob/user)
	. = ..()
	. += span_notice("What are these metal mounts on the armrests for...?")

/obj/structure/chair/milking_machine/Destroy()
	if(current_mob)
		if(current_mob.handcuffed)
			current_mob.handcuffed.dropped(current_mob)
		current_mob.set_handcuffed(null)
		current_mob.update_abstract_handcuffed()
		current_mob.layer = initial(current_mob.layer)

	if(beaker)
		qdel(beaker)
		beaker = null

	current_selected_organ = null
	current_mob = null
	current_breasts = null
	current_testicles = null
	current_vagina = null

	STOP_PROCESSING(SSobj, src)
	unbuckle_all_mobs()
	return ..()

// previously NO_DECONSTRUCTION
/obj/structure/chair/milking_machine/wrench_act_secondary(mob/living/user, obj/item/weapon)
	return NONE

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
	var/choice = show_radial_menu(user, src, milkingmachine_designs, custom_check = CALLBACK(src, PROC_REF(check_menu), user, used_item), radius = 36, require_near = TRUE)
	if(!choice)
		return TRUE
	machine_color = choice
	update_icon()
	to_chat(user, span_notice("You change the color of the milking machine."))
	return TRUE

// Checking if we can use the menu
/obj/structure/chair/milking_machine/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated)
		return FALSE
	return TRUE

// Another plug to disable rotation
/obj/structure/chair/milking_machine/attack_tk(mob/user)
	return FALSE

// Get the organs of the mob and visualize the change in machine
/obj/structure/chair/milking_machine/post_buckle_mob(mob/living/affected_mob)
	current_mob = affected_mob

	current_breasts = affected_mob.get_organ_slot(ORGAN_SLOT_BREASTS)
	current_testicles = affected_mob.get_organ_slot(ORGAN_SLOT_TESTICLES)
	current_vagina = affected_mob.get_organ_slot(ORGAN_SLOT_VAGINA)

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

		var/obj/item/restraints/handcuffs/milker/cuffs = new (victim)
		current_mob.set_handcuffed(cuffs)
		cuffs.parent_chair = WEAKREF(src)
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

	current_mode = MILKING_PUMP_MODE_OFF
	pump_state = MILKING_PUMP_STATE_OFF

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

	return

/obj/structure/chair/milking_machine/is_buckle_possible(mob/living/target, force, check_loc)
	. = ..()

	if(!. || !ishuman(target))
		return FALSE

	return TRUE


//for chair handcuffs, no alerts
/mob/living/carbon/proc/update_abstract_handcuffed()
	if(handcuffed)
		drop_all_held_items()
		stop_pulling()
		add_mood_event("handcuffed", /datum/mood_event/handcuffed)
	else
		clear_mood_event("handcuffed")

	update_mob_action_buttons() //some of our action buttons might be unusable when we're handcuffed.
	update_worn_handcuffs()
	update_hud_handcuffed()

/obj/item/restraints/handcuffs/milker
	name = "chair cuffs"
	desc = "A thick metal cuff for restraining hands."
	lefthand_file = null
	righthand_file = null
	breakouttime = 45 SECONDS
	flags_1 = NONE
	item_flags = DROPDEL | ABSTRACT
	///The chair that the handcuffs are parented to.
	var/datum/weakref/parent_chair

/obj/item/restraints/handcuffs/milker/Destroy()
	unbuckle_parent()
	parent_chair = null
	return ..()

/obj/item/restraints/handcuffs/milker/proc/unbuckle_parent()
	if(!parent_chair)
		return FALSE

	var/obj/structure/chair = parent_chair.resolve()
	if(!chair)
		return FALSE

	chair.unbuckle_all_mobs()
	return TRUE

/obj/structure/chair/milking_machine/user_unbuckle_mob(mob/living/carbon/human/affected_mob, mob/user)
	if(!affected_mob || affected_mob != user)
		return ..()

	if(affected_mob.arousal >= 60 && (current_mode != MILKING_PUMP_MODE_OFF) && (current_mode != MILKING_PUMP_MODE_LOW))
		to_chat(affected_mob, span_purple("You are too horny to try to get out!"))
		return FALSE

	affected_mob.visible_message(span_notice("[affected_mob] unbuckles [affected_mob.p_them()]self from [src]."),\
		span_notice("You unbuckle yourself from [src]."),\
		span_hear("You hear metal clanking."))
	unbuckle_mob(affected_mob)
	return TRUE

/*
*	MAIN LOGIC
*/

// Empty Hand Attack Handler
/obj/structure/chair/milking_machine/attack_hand(mob/user)
	if(!LAZYLEN(buckled_mobs) || !(user in buckled_mobs))
		return ..()

	user_unbuckle_mob(user, user)
	return FALSE

// Attack handler for various item
/obj/structure/chair/milking_machine/attackby(obj/item/used_item, mob/user)
	if(!istype(used_item, /obj/item/reagent_containers) || (used_item.item_flags & ABSTRACT) || !used_item.is_open_container())
		return ..()

	var/obj/item/reagent_containers/used_container = used_item
	if(!user.transferItemToLoc(used_container, src))
		return FALSE

	replace_beaker(user, used_container)
	SStgui.update_uis(src)
	return TRUE

// Beaker change handler
/obj/structure/chair/milking_machine/proc/replace_beaker(mob/living/user, obj/item/reagent_containers/new_beaker)
	if(!user || (!beaker && !new_beaker))
		return FALSE

	if(beaker && new_beaker)
		try_put_in_hand(beaker, user)
		beaker = new_beaker
		to_chat(user, span_notice("You swap out the current beaker with a new one in a single uninterrupted motion."))
		return TRUE

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
	if(issilicon(user) || !in_range(src, user))
		object.forceMove(drop_location())
		return FALSE

	user.put_in_hands(object)
	return TRUE

// Machine Workflow Processor
/obj/structure/chair/milking_machine/process(seconds_per_tick)
	if(!current_mob || !current_selected_organ || current_mode == MILKING_PUMP_MODE_OFF)
		if(pump_state != MILKING_PUMP_STATE_OFF)
			pump_state = MILKING_PUMP_STATE_OFF

		update_all_visuals()
		return FALSE

	if((istype(current_selected_organ, /obj/item/organ/external/genital/testicles) && (semen_vessel.reagents.total_volume == MILKING_PUMP_MAX_CAPACITY)) || (istype(current_selected_organ, /obj/item/organ/external/genital/vagina) && (girlcum_vessel.reagents.total_volume == MILKING_PUMP_MAX_CAPACITY)) || (istype(current_selected_organ, /obj/item/organ/external/genital/breasts) && (milk_vessel.reagents.total_volume == MILKING_PUMP_MAX_CAPACITY)))
		current_mode = MILKING_PUMP_MODE_OFF
		pump_state = MILKING_PUMP_STATE_OFF
		update_all_visuals()
		return FALSE


	if(pump_state != MILKING_PUMP_STATE_ON)
		pump_state = MILKING_PUMP_STATE_ON

	retrieve_liquids_from_selected_organ(seconds_per_tick)
	increase_current_mob_arousal(seconds_per_tick)

	update_all_visuals()
	return TRUE

// Liquid intake handler

/obj/structure/chair/milking_machine/proc/retrieve_liquids_from_selected_organ(seconds_per_tick)
	if(!current_mob || !current_selected_organ)
		return FALSE

	var/fluid_multiplier = 1
	var/static/list/fluid_retrieve_amount = list("off" = 0, "low" = 1, "medium" = 2, "hard" = 3)

	if(current_mob.has_status_effect(/datum/status_effect/climax))
		fluid_multiplier = CLIMAX_RETRIEVE_MULTIPLIER

	var/obj/item/reagent_containers/target_container

	switch(current_selected_organ.type)
		if(/obj/item/organ/external/genital/breasts)
			target_container = milk_vessel
		if(/obj/item/organ/external/genital/vagina)
			target_container = girlcum_vessel
		if(/obj/item/organ/external/genital/testicles)
			target_container = semen_vessel

	if(!target_container || current_selected_organ.internal_fluid_count <= 0)
		return FALSE

	current_selected_organ.transfer_internal_fluid(target_container.reagents, fluid_retrieve_amount[current_mode] * fluid_multiplier * seconds_per_tick)
	return TRUE

// Handling the process of the impact of the machine on the organs of the mob
/obj/structure/chair/milking_machine/proc/increase_current_mob_arousal(seconds_per_tick)
	var/static/list/arousal_amounts = list("off" = 0, "low" = 1, "medium" = 2, "hard" = 3)
	var/static/list/pleasure_amounts = list("off" = 0, "low" = 0.2, "medium" = 1, "hard" = 1.5)
	var/static/list/pain_amounts = list("off" = 0, "low" = 0, "medium" = 0.2, "hard" = 0.5)

	current_mob.adjust_arousal(arousal_amounts[current_mode] * seconds_per_tick)
	current_mob.adjust_pleasure(pleasure_amounts[current_mode] * seconds_per_tick)
	current_mob.adjust_pain(pain_amounts[current_mode] * seconds_per_tick)

/obj/structure/chair/milking_machine/click_ctrl_shift(mob/user)
	to_chat(user, span_notice("You begin to disassemble [src]..."))
	if(!do_after(user, 8 SECONDS, src))
		to_chat(user, span_warning("You fail to disassemble [src]!"))
		return

	deconstruct(TRUE)
	to_chat(user, span_notice("You disassemble [src]."))

// Machine deconstruction process handler
/obj/structure/chair/milking_machine/atom_deconstruct(disassembled)
	if(beaker)
		beaker.forceMove(drop_location())
		adjust_item_drop_location(beaker)
		beaker = null
		update_all_visuals()

	var/obj/item/construction_kit/milker/construction_kit = new(src.loc)
	construction_kit.current_color = machine_color
	construction_kit.update_icon_state()
	construction_kit.update_icon()

	return ..()

// Handler of the process of dispensing a glass from a machine to a tile
/obj/structure/chair/milking_machine/proc/adjust_item_drop_location(atom/movable/dropped_atom)
	if(dropped_atom != beaker)
		return FALSE

	dropped_atom.pixel_x = dropped_atom.base_pixel_x - 8
	dropped_atom.pixel_y = dropped_atom.base_pixel_y + 8
	return null

// General handler for calling redrawing of the current state of the machine
/obj/structure/chair/milking_machine/proc/update_all_visuals()
	if(current_selected_organ != null)
		var/current_selected_organ_type = null
		var/current_selected_organ_size = current_selected_organ.genital_size
		cut_overlay(organ_overlay)

		if(istype(current_selected_organ, /obj/item/organ/external/genital/breasts))
			switch(current_selected_organ.genital_type)
				if("pair")
					current_selected_organ_type = "double_breast"
				if("quad")
					current_selected_organ_type = "quad_breast"
				if("sextuple")
					current_selected_organ_type = "six_breast"

			if((current_selected_organ.genital_type == "sextuple") || (current_selected_organ.genital_type == "quad"))
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

		if(istype(current_selected_organ, /obj/item/organ/external/genital/testicles))
			current_selected_organ_type = ORGAN_SLOT_PENIS

		if(istype(current_selected_organ, /obj/item/organ/external/genital/vagina))
			current_selected_organ_type = ORGAN_SLOT_VAGINA

		organ_overlay_new_icon_state = "[current_selected_organ_type]_pump_[pump_state]"
		if(istype(current_selected_organ, /obj/item/organ/external/genital/breasts))
			organ_overlay_new_icon_state += "_[current_selected_organ_size]"

		if(current_mode == MILKING_PUMP_MODE_OFF)
			pump_state = MILKING_PUMP_STATE_OFF
		else
			pump_state = MILKING_PUMP_STATE_ON
			organ_overlay_new_icon_state += "_[current_mode]"

		if(organ_overlay.icon_state != organ_overlay_new_icon_state)
			organ_overlay.icon_state = organ_overlay_new_icon_state

		add_overlay(organ_overlay)
	else
		cut_overlay(organ_overlay)
		organ_overlay.icon_state = "none"

	// Processing changes in the capacity overlay
	cut_overlay(vessel_overlay)
	var/total_reagents_volume = (milk_vessel.reagents.total_volume + girlcum_vessel.reagents.total_volume + semen_vessel.reagents.total_volume)
	var/static/list/vessel_state_list = list("liquid_empty", "liquid_low", "liquid_medium", "liquid_high", "liquid_full")

	var/state_to_use = 1
	switch(total_reagents_volume)
		if(MILKING_PUMP_MAX_CAPACITY)
			state_to_use = 5
		if((MILKING_PUMP_MAX_CAPACITY / 1.5) to MILKING_PUMP_MAX_CAPACITY)
			state_to_use = 4
		if((MILKING_PUMP_MAX_CAPACITY / 3) to (MILKING_PUMP_MAX_CAPACITY / 1.5))
			state_to_use = 3
		if(1 to (MILKING_PUMP_MAX_CAPACITY / 3))
			state_to_use = 2
		if(0 to 1)
			state_to_use = 1

	vessel_overlay.icon_state = vessel_state_list[state_to_use]
	add_overlay(vessel_overlay)

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
	data["beaker"] = beaker ? beaker : null
	data["BeakerName"] = beaker ? beaker.name : null
	data["beakerMaxVolume"] = beaker ? beaker.volume : null
	data["beakerCurrentVolume"] = beaker ? beaker.reagents.total_volume : null
	data["mode"] = current_mode
	data["milkTankMaxVolume"] = MILKING_PUMP_MAX_CAPACITY
	data["milkTankCurrentVolume"] = milk_vessel ? milk_vessel.reagents.total_volume : null
	data["girlcumTankMaxVolume"] = MILKING_PUMP_MAX_CAPACITY
	data["girlcumTankCurrentVolume"] = girlcum_vessel ? girlcum_vessel.reagents.total_volume : null
	data["semenTankMaxVolume"] = MILKING_PUMP_MAX_CAPACITY
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
		current_mode = MILKING_PUMP_MODE_OFF
		pump_state = MILKING_PUMP_STATE_OFF
		update_all_visuals()
		to_chat(usr, span_notice("You turn off [src]"))
		return TRUE

	if(action == "setLowMode")
		current_mode = MILKING_PUMP_MODE_LOW
		pump_state = MILKING_PUMP_STATE_ON
		update_all_visuals()
		to_chat(usr, span_notice("You switch [src] onto low mode"))
		return TRUE

	if(action == "setMediumMode")
		current_mode = MILKING_PUMP_MODE_MEDIUM
		pump_state = MILKING_PUMP_STATE_ON
		update_all_visuals()
		to_chat(usr, span_notice("You switch [src] onto medium mode"))
		return TRUE

	if(action == "setHardMode")
		current_mode = MILKING_PUMP_MODE_HARD
		pump_state = MILKING_PUMP_STATE_ON
		update_all_visuals()
		to_chat(usr, span_notice("You switch [src] onto hard mode"))
		return TRUE

	if(action == "unplug")
		cut_overlay(organ_overlay)
		current_mode = MILKING_PUMP_MODE_OFF
		pump_state = MILKING_PUMP_STATE_OFF
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

		if(!current_vessel.reagents?.reagent_list.len)
			return FALSE

		var/amount = text2num(params["amount"])
		current_vessel.reagents?.trans_to(beaker, amount)
		update_all_visuals()
		return TRUE

/obj/structure/chair/milking_machine/examine(mob/user)
	. = ..()
	. += span_purple("[src] can be disassembled by using Ctrl+Shift+Click")

#undef MILKING_PUMP_MODE_OFF
#undef MILKING_PUMP_MODE_LOW
#undef MILKING_PUMP_MODE_MEDIUM
#undef MILKING_PUMP_MODE_HARD

#undef MILKING_PUMP_STATE_OFF
#undef MILKING_PUMP_STATE_ON

#undef CLIMAX_RETRIEVE_MULTIPLIER
#undef MILKING_PUMP_MAX_CAPACITY
