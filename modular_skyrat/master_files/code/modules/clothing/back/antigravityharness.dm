#define MODE_GRAVOFF "Off"
#define MODE_ANTIGRAVITY "Anti-Gravity Field"
#define MODE_EXTRAGRAVITY "Extra-Gravity Field"
#define GRAVITY_FIELD_COST 10

/obj/item/gravityharness
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	name = "gravity suspension harness"
	desc = "A derivative of common Skrellian construction equipment, these lower-tech variants are commonly seen in use by Deep Spacer tribes when visiting gravity wells."
	slot_flags = ITEM_SLOT_BACK
	icon_state = "gravityharness-off"
	worn_icon_state = "gravityharness-off"
	actions_types = list(/datum/action/item_action/toggle_mode)
	var/off_state = "gravityharness-off"
	var/list/modes = list(MODE_GRAVOFF, MODE_ANTIGRAVITY, MODE_EXTRAGRAVITY) //Off, Anti-Gravity, and Guaranteed Gravity™
	var/mode
	var/obj/item/stock_parts/cell/cell
	var/cell_cover_open = FALSE
	var/gravity_on = FALSE //If it's manipulating gravity at all.
	var/antigravity_state = "gravityharness-anti"
	var/extragravity_state = "gravityharness-extra"
	var/modeswitch_sound = 'sound/effects/pop.ogg'

/obj/item/gravityharness/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob, ITEM_SLOT_BACK)
	if(ispath(cell))
		cell = new cell(src)

	// Set our initial values
	mode = MODE_GRAVOFF

/obj/item/gravityharness/equipped(mob/living/user, slot, current_mode)
	. = ..()
	if(slot & ITEM_SLOT_BACK)
		START_PROCESSING(SSobj, src)
		RegisterSignal(user, COMSIG_MOB_GET_STATUS_TAB_ITEMS, PROC_REF(get_status_tab_item))

	if(!slot == ITEM_SLOT_BACK)
		switch(current_mode)
			return MODE_GRAVOFF

/obj/item/gravityharness/proc/toggle_mode(mob/user, voluntary)

	if(!istype(user) || user.incapacitated())
		return

	if(mode == modes[mode])
		return // If there is only really one mode to cycle through, early return

	if(!gravity_on && (!cell || cell.charge < GRAVITY_FIELD_COST))
		if(user)
			to_chat(user, span_warning("The gravitic engine on [src] has no charge."))
		return

	gravity_on = !gravity_on

	mode = get_next_mode(mode)

	switch(mode)
		if(MODE_ANTIGRAVITY)
			if(user.has_gravity())
				new /obj/effect/temp_visual/mook_dust(get_turf(src))
			user.AddElement(/datum/element/forced_gravity, 0)
			playsound(src, 'sound/effects/gravhit.ogg', 50)
			to_chat(user, span_notice("Your harness releases a metallic hum, projecting a local anti-gravity field."))
			gravity_on = TRUE
			icon_state = antigravity_state
			worn_icon_state = antigravity_state
			
		if(MODE_EXTRAGRAVITY)
			if(!user.has_gravity())
				new /obj/effect/temp_visual/mook_dust/robot(get_turf(src))
			user.RemoveElement(/datum/element/forced_gravity, 0)
			ADD_TRAIT(user, TRAIT_NEGATES_GRAVITY)
			playsound(src, 'modular_skyrat/master_files/sound/effects/robot_sit.ogg', 25)
			to_chat(user, span_notice("Your harness shudders and hisses, projecting a local extra-gravity field."))
			gravity_on = TRUE
			worn_icon_state = extragravity_state
			
		if(MODE_GRAVOFF)
			if(!user.has_gravity())
				new /obj/effect/temp_visual/mook_dust/robot(get_turf(src))
				playsound(src, 'modular_skyrat/master_files/sound/effects/robot_sit.ogg', 25)
				to_chat(user, span_notice("Your harness lets out a soft whine as your gravity field dissipates, your body free-floating once again."))
			
			else
				if(user.has_gravity())
					new /obj/effect/temp_visual/mook_dust(get_turf(src))
					playsound(src, 'sound/effects/gravhit.ogg', 50)
					to_chat(user, span_notice("Your harness lets out a soft whine as your gravity field dissipates, leaving your body grounded once again."))
			user.RemoveElement(/datum/element/forced_gravity, 0)
			REMOVE_TRAIT(user, TRAIT_NEGATES_GRAVITY)
			icon_state = off_state
			worn_icon_state = off_state
			gravity_on = FALSE

	playsound(src, modeswitch_sound, 50, TRUE)
	update_item_action_buttons()
	update_appearance()


/obj/item/gravityharness/proc/get_next_mode(current_mode)
	switch(current_mode)
		if(MODE_GRAVOFF)
			return MODE_ANTIGRAVITY
		if(MODE_ANTIGRAVITY)
			return MODE_EXTRAGRAVITY
		if(MODE_EXTRAGRAVITY)
			return MODE_GRAVOFF

/obj/item/gravityharness/dropped(mob/user, current_mode)
	. = ..()
	STOP_PROCESSING(SSobj, src)
	UnregisterSignal(user, COMSIG_MOB_GET_STATUS_TAB_ITEMS)
	switch(current_mode)
		return MODE_GRAVOFF

/obj/item/gravityharness/attack_self(mob/user)
	toggle_mode(user, TRUE)

/obj/item/gravityharness/proc/get_status_tab_item(mob/living/source, list/items, current_mode)
	SIGNAL_HANDLER
	items += "Personal Gravitational Field: [mode]"
	items += "Cell Charge: [cell ? "[round(cell.percent(), 0.1)]%" : "No Cell!"]"

/obj/item/gravityharness/process(seconds_per_tick)
	var/mob/living/carbon/human/user = loc
	if(!user || !ishuman(user) || user.back != src)
		return

	// Do nothing if the harness isn't emitting gravity of any kind.area
	if(!gravity_on)
		return

	// If we got here, the gravity field is on. If there's no cell, turn that shit off
	if(!cell)
		switch(current_mode)
			return MODE_GRAVOFF

	// cell.use will return FALSE if charge is lower than GRAVITY_FIELD_COST
	if(!cell.use(GRAVITY_FIELD_COST))
		to_chat(user, span_warning("The gravitic engine cuts off as [cell] runs out of charge."))
		switch(current_mode)
			return MODE_GRAVOFF

/obj/item/gravityharness/Destroy()
	if(isatom(cell))
		QDEL_NULL(cell)
		
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/gravityharness/get_cell()
	if(cell_cover_open)
		return cell

/obj/item/gravityharness/handle_atom_del(atom/harnesscell)
	if(harnesscell == cell)
		cell = null
		gravity_on = FALSE
	return ..()

// Support for items that interact with the cell
/obj/item/gravityharness/get_cell()
	return cell

// Show the status of the harness and cell
/obj/item/gravityharness/examine(mob/user)
	. = ..()
	if(in_range(src,user) || isobserver(user))
		. += "The gravity harness is [gravity_on ? "on" : "off"] and the field is set to [mode]"
		. += "The power meter shows [cell ? "[round(cell.percent(), 0.1)]%" : "!invalid!"] charge remaining."
		if(cell_cover_open)
			. += "The cell cover is open, exposing the battery."
			if(!cell)
				. += "The cell slot is empty, showing bare connectors."
			else
				. += "\The [cell] is firmly in place."
		
	return .

/obj/item/gravityharness/screwdriver_act(mob/living/user, obj/item/screwdriver)
	balloon_alert(user, "[cell_cover_open ? "closing" : "opening"] cover...")
	screwdriver.play_tool_sound(src, 100)
	if(screwdriver.use_tool(src, user, 1 SECONDS))
		screwdriver.play_tool_sound(src, 100)
		balloon_alert(user, "cover [cell_cover_open ? "closed" : "opened"]")
		cell_cover_open = !cell_cover_open
	else
		balloon_alert(user, "interrupted!")
	return TRUE

/obj/item/gravityharness/attack_hand(mob/user)
	if(cell_cover_open && loc == user)
		if(!cell)
			balloon_alert(user, "no cell!")
			return
		balloon_alert(user, "removing cell...")
		if(!do_after(user, 1.5 SECONDS, target = src))
			balloon_alert(user, "interrupted!")
			return
		balloon_alert(user, "cell removed")
		playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
		if(!user.put_in_hands(cell))
			cell.forceMove(drop_location())
		return
	return ..()

/obj/item/gravityharness/attackby(obj/item/attacking_item, mob/living/user, params)
	if(istype(attacking_item, /obj/item/stock_parts/cell))
		if(!cell_cover_open)
			balloon_alert(user, "open the cell cover first!")
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
			return FALSE
		if(cell)
			balloon_alert(user, "cell already installed!")
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
			return FALSE
		attacking_item.forceMove(src)
		cell = attacking_item
		balloon_alert(user, "cell installed")
		playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
		return TRUE
		
	return ..()


#undef MODE_GRAVOFF
#undef MODE_ANTIGRAVITY
#undef MODE_EXTRAGRAVITY
#undef GRAVITY_FIELD_COST
