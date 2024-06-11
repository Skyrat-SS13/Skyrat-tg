/// MODsuits, trade-off between armor and utility
/obj/item/mod
	name = "Base MOD"
	desc = "You should not see this, yell at a coder!"
	icon = 'icons/obj/clothing/modsuit/mod_clothing.dmi'
	worn_icon = 'icons/mob/clothing/modsuit/mod_clothing.dmi'

/obj/item/mod/control
	name = "MOD control unit"
	desc = "The control unit of a Modular Outerwear Device, a powered suit that protects against various environments."
	icon_state = "standard-control"
	inhand_icon_state = "mod_control"
	base_icon_state = "control"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	strip_delay = 10 SECONDS
	armor_type = /datum/armor/none
	actions_types = list(
		/datum/action/item_action/mod/deploy,
		/datum/action/item_action/mod/activate,
		/datum/action/item_action/mod/sprite_accessories, // SKYRAT EDIT - Hide mutant parts action
		/datum/action/item_action/mod/panel,
		/datum/action/item_action/mod/module,
		/datum/action/item_action/mod/deploy/ai,
		/datum/action/item_action/mod/activate/ai,
		/datum/action/item_action/mod/panel/ai,
		/datum/action/item_action/mod/module/ai,
	)
	resistance_flags = NONE
	max_heat_protection_temperature = SPACE_SUIT_MAX_TEMP_PROTECT
	min_cold_protection_temperature = SPACE_SUIT_MIN_TEMP_PROTECT
	siemens_coefficient = 0.5
	alternate_worn_layer = HANDS_LAYER+0.1 //we want it to go above generally everything, but not hands
	/// The MOD's theme, decides on some stuff like armor and statistics.
	var/datum/mod_theme/theme = /datum/mod_theme
	/// Looks of the MOD.
	var/skin = "standard"
	/// Theme of the MOD TGUI
	var/ui_theme = "ntos"
	/// If the suit is deployed and turned on.
	var/active = FALSE
	/// If the suit wire/module hatch is open.
	var/open = FALSE
	/// If the suit is ID locked.
	var/locked = FALSE
	/// If the suit is malfunctioning.
	var/malfunctioning = FALSE
	/// If the suit is currently activating/deactivating.
	var/activating = FALSE
	/// How long the MOD is electrified for.
	var/seconds_electrified = MACHINE_NOT_ELECTRIFIED
	/// If the suit interface is broken.
	var/interface_break = FALSE
	/// How much module complexity can this MOD carry.
	var/complexity_max = DEFAULT_MAX_COMPLEXITY
	/// How much module complexity this MOD is carrying.
	var/complexity = 0
	/// Power usage of the MOD.
	var/charge_drain = DEFAULT_CHARGE_DRAIN
	/// Slowdown of the MOD when not active.
	var/slowdown_inactive = 1.25
	/// Slowdown of the MOD when active.
	var/slowdown_active = 0.75
	/// How long this MOD takes each part to seal.
	var/activation_step_time = MOD_ACTIVATION_STEP_TIME
	/// Extended description of the theme.
	var/extended_desc
	/// MOD core.
	var/obj/item/mod/core/core
	/// List of MODsuit part datums.
	var/list/mod_parts = list()
	/// Modules the MOD currently possesses.
	var/list/modules = list()
	/// Currently used module.
	var/obj/item/mod/module/selected_module
	/// AI or pAI mob inhabiting the MOD.
	var/mob/living/silicon/ai_assistant
	/// The MODlink datum, letting us call people from the suit.
	var/datum/mod_link/mod_link
	/// The starting MODlink frequency, overridden on subtypes that want it to be something.
	var/starting_frequency = null
	/// Delay between moves as AI.
	var/static/movedelay = 0
	/// Cooldown for AI moves.
	COOLDOWN_DECLARE(cooldown_mod_move)
	/// Person wearing the MODsuit.
	var/mob/living/carbon/human/wearer

/obj/item/mod/control/Initialize(mapload, datum/mod_theme/new_theme, new_skin, obj/item/mod/core/new_core)
	. = ..()
	if(!movedelay)
		movedelay = CONFIG_GET(number/movedelay/run_delay)
	if(new_theme)
		theme = new_theme
	theme = GLOB.mod_themes[theme]
	theme.set_up_parts(src, new_skin)
	for(var/obj/item/part as anything in get_parts())
		RegisterSignal(part, COMSIG_ATOM_DESTRUCTION, PROC_REF(on_part_destruction))
		RegisterSignal(part, COMSIG_QDELETING, PROC_REF(on_part_deletion))
	set_wires(new /datum/wires/mod(src))
	if(length(req_access))
		locked = TRUE
	new_core?.install(src)
	update_speed()
	RegisterSignal(src, COMSIG_ATOM_EXITED, PROC_REF(on_exit))
	RegisterSignal(src, COMSIG_SPEED_POTION_APPLIED, PROC_REF(on_potion))
	for(var/obj/item/mod/module/module as anything in theme.inbuilt_modules)
		module = new module(src)
		install(module)
	START_PROCESSING(SSobj, src)

/obj/item/mod/control/Destroy()
	STOP_PROCESSING(SSobj, src)
	for(var/obj/item/mod/module/module as anything in modules)
		uninstall(module, deleting = TRUE)
	if(core)
		QDEL_NULL(core)
	QDEL_NULL(wires)
	QDEL_NULL(mod_link)
	for(var/datum/mod_part/part_datum as anything in get_part_datums(all = TRUE))
		part_datum.part_item = null
		part_datum.overslotting = null
	return ..()

/obj/item/mod/control/atom_destruction(damage_flag)
	if(wearer)
		wearer.visible_message(span_danger("[src] fall[p_s()] apart, completely destroyed!"), vision_distance = COMBAT_MESSAGE_RANGE)
		clean_up()
	for(var/obj/item/mod/module/module as anything in modules)
		for(var/obj/item/item in module)
			item.forceMove(drop_location())
		uninstall(module)
	if(ai_assistant)
		if(ispAI(ai_assistant))
			INVOKE_ASYNC(src, PROC_REF(remove_pai), /* user = */ null, /* forced = */ TRUE) // async to appease spaceman DMM because the branch we don't run has a do_after
		else
			for(var/datum/action/action as anything in actions)
				if(action.owner == ai_assistant)
					action.Remove(ai_assistant)
			new /obj/item/mod/ai_minicard(drop_location(), ai_assistant)
	return ..()

/obj/item/mod/control/examine(mob/user)
	. = ..()
	if(active)
		. += span_notice("Charge: [core ? "[get_charge_percent()]%" : "No core"].")
		. += span_notice("Selected module: [selected_module || "None"].")
	if(!open && !active)
		if(!wearer)
			. += span_notice("You could equip it to turn it on.")
		. += span_notice("You could open the cover with a <b>screwdriver</b>.")
	else if(open)
		. += span_notice("You could close the cover with a <b>screwdriver</b>.")
		. += span_notice("You could use <b>modules</b> on it to install them.")
		. += span_notice("You could remove modules with a <b>crowbar</b>.")
		. += span_notice("You could update the access lock with an <b>ID</b>.")
		. += span_notice("You could access the wire panel with a <b>wire tool</b>.")
		if(core)
			. += span_notice("You could remove [core] with a <b>wrench</b>.")
		else
			. += span_notice("You could use a <b>MOD core</b> on it to install one.")
		if(isnull(ai_assistant))
			. += span_notice("You could install a pAI with a <b>pAI card</b>.") // SKYRAT EDIT CHANGE - ORIGINAL: . += span_notice("You could install an AI or pAI using their <b>storage card</b>.")
		else if(isAI(ai_assistant))
			. += span_notice("You could remove [ai_assistant] with an <b>intellicard</b>.")
	. += span_notice("You could copy/set link frequency with a <b>multitool</b>.")
	. += span_notice("<i>You could examine it more thoroughly...</i>")

/obj/item/mod/control/examine_more(mob/user)
	. = ..()
	. += "<i>[extended_desc]</i>"

/obj/item/mod/control/process(seconds_per_tick)
	if(seconds_electrified > MACHINE_NOT_ELECTRIFIED)
		seconds_electrified--
	if(mod_link.link_call)
		subtract_charge(0.25 * DEFAULT_CHARGE_DRAIN * seconds_per_tick)
	if(!active)
		return
	if(!get_charge() && active && !activating)
		power_off()
		return
	var/malfunctioning_charge_drain = 0
	if(malfunctioning)
		malfunctioning_charge_drain = rand(0.2 * DEFAULT_CHARGE_DRAIN, 4 * DEFAULT_CHARGE_DRAIN) // About triple power usage on average.
	subtract_charge((charge_drain + malfunctioning_charge_drain) * seconds_per_tick)
	for(var/obj/item/mod/module/module as anything in modules)
		if(malfunctioning && module.active && SPT_PROB(5, seconds_per_tick))
			module.deactivate(display_message = TRUE)
		module.on_process(seconds_per_tick)

/obj/item/mod/control/visual_equipped(mob/user, slot, initial = FALSE) //needs to be visual because we wanna show it in select equipment
	if(slot & slot_flags)
		set_wearer(user)
	else if(wearer)
		unset_wearer()

/obj/item/mod/control/dropped(mob/user)
	. = ..()
	if(!wearer)
		return
	clean_up()

/obj/item/mod/control/item_action_slot_check(slot)
	if(slot & slot_flags)
		return TRUE

// Grant pinned actions to pin owners, gives AI pinned actions to the AI and not the wearer
/obj/item/mod/control/grant_action_to_bearer(datum/action/action)
	if (!istype(action, /datum/action/item_action/mod/pinnable))
		return ..()
	var/datum/action/item_action/mod/pinnable/pinned = action
	give_item_action(action, pinned.pinner, slot_flags)

/obj/item/mod/control/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	if(!wearer || old_loc != wearer || loc == wearer)
		return
	clean_up()

/obj/item/mod/control/allow_attack_hand_drop(mob/user)
	if(user != wearer)
		return ..()
	for(var/obj/item/part as anything in get_parts())
		if(part.loc != src)
			balloon_alert(user, "retract parts first!")
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, FALSE, SILENCED_SOUND_EXTRARANGE)
			return FALSE

/obj/item/mod/control/MouseDrop(atom/over_object)
	if(usr != wearer || !istype(over_object, /atom/movable/screen/inventory/hand))
		return ..()
	for(var/obj/item/part as anything in get_parts())
		if(part.loc != src)
			balloon_alert(wearer, "retract parts first!")
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, FALSE, SILENCED_SOUND_EXTRARANGE)
			return

	// SKYRAT EDIT ADDITION START - Can't remove your MODsuit from your back when it's still active (as it can cause runtimes and even the MODsuit control unit to delete itself)
	if(active)
		if(!wearer.incapacitated())
			balloon_alert(wearer, "deactivate first!")
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, FALSE, SILENCED_SOUND_EXTRARANGE)

		return
	// SKYRAT EDIT ADDITION END

	if(!wearer.incapacitated())
		var/atom/movable/screen/inventory/hand/ui_hand = over_object
		if(wearer.putItemFromInventoryInHandIfPossible(src, ui_hand.held_index))
			add_fingerprint(usr)
			return ..()

/obj/item/mod/control/wrench_act(mob/living/user, obj/item/wrench)
	if(..())
		return TRUE
	if(seconds_electrified && get_charge() && shock(user))
		return TRUE
	if(open)
		if(!core)
			balloon_alert(user, "no core!")
			return TRUE
		balloon_alert(user, "removing core...")
		wrench.play_tool_sound(src, 100)
		if(!wrench.use_tool(src, user, 3 SECONDS) || !open)
			balloon_alert(user, "interrupted!")
			return TRUE
		wrench.play_tool_sound(src, 100)
		balloon_alert(user, "core removed")
		core.forceMove(drop_location())
		return TRUE
	return ..()

/obj/item/mod/control/screwdriver_act(mob/living/user, obj/item/screwdriver)
	. = ..()
	if(.)
		return TRUE
	if(active || activating || ai_controller)
		balloon_alert(user, "deactivate suit first!")
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return FALSE
	balloon_alert(user, "[open ? "closing" : "opening"] cover...")
	screwdriver.play_tool_sound(src, 100)
	if(screwdriver.use_tool(src, user, 1 SECONDS))
		if(active || activating)
			balloon_alert(user, "deactivate suit first!")
		screwdriver.play_tool_sound(src, 100)
		balloon_alert(user, "cover [open ? "closed" : "opened"]")
		open = !open
	else
		balloon_alert(user, "interrupted!")
	return TRUE

/obj/item/mod/control/crowbar_act(mob/living/user, obj/item/crowbar)
	. = ..()
	if(!open)
		balloon_alert(user, "open the cover first!")
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return FALSE
	if(!allowed(user))
		balloon_alert(user, "insufficient access!")
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return
	if(SEND_SIGNAL(src, COMSIG_MOD_MODULE_REMOVAL, user) & MOD_CANCEL_REMOVAL)
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return FALSE
	if(length(modules))
		var/list/removable_modules = list()
		for(var/obj/item/mod/module/module as anything in modules)
			if(!module.removable)
				continue
			removable_modules += module
		var/obj/item/mod/module/module_to_remove = tgui_input_list(user, "Which module to remove?", "Module Removal", removable_modules)
		if(!module_to_remove?.mod)
			return FALSE
		uninstall(module_to_remove)
		module_to_remove.forceMove(drop_location())
		crowbar.play_tool_sound(src, 100)
		SEND_SIGNAL(src, COMSIG_MOD_MODULE_REMOVED, user)
		return TRUE
	balloon_alert(user, "no modules!")
	playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
	return FALSE

/obj/item/mod/control/attackby(obj/item/attacking_item, mob/living/user, params)
	if(istype(attacking_item, /obj/item/pai_card))
		if(!open)
			balloon_alert(user, "open the cover first!")
			return FALSE
		insert_pai(user, attacking_item)
		return TRUE
	if(istype(attacking_item, /obj/item/mod/module))
		if(!open)
			balloon_alert(user, "open the cover first!")
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
			return FALSE
		install(attacking_item, user)
		SEND_SIGNAL(src, COMSIG_MOD_MODULE_ADDED, user)
		return TRUE
	else if(istype(attacking_item, /obj/item/mod/core))
		if(!open)
			balloon_alert(user, "open the cover first!")
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
			return FALSE
		if(core)
			balloon_alert(user, "core already installed!")
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
			return FALSE
		var/obj/item/mod/core/attacking_core = attacking_item
		attacking_core.install(src)
		balloon_alert(user, "core installed")
		playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)
		return TRUE
	else if(is_wire_tool(attacking_item) && open)
		wires.interact(user)
		return TRUE
	else if(open && attacking_item.GetID())
		update_access(user, attacking_item.GetID())
		return TRUE
	return ..()

/obj/item/mod/control/get_cell()
	var/obj/item/stock_parts/cell/cell = get_charge_source()
	if(!istype(cell))
		return null
	return cell

/obj/item/mod/control/GetAccess()
	if(ai_controller)
		return req_access.Copy()
	else
		return ..()

/obj/item/mod/control/emag_act(mob/user, obj/item/card/emag/emag_card)
	locked = !locked
	balloon_alert(user, "suit access [locked ? "locked" : "unlocked"]")
	return TRUE

/obj/item/mod/control/emp_act(severity)
	. = ..()
	if(!active || !wearer)
		return
	to_chat(wearer, span_notice("[severity > 1 ? "Light" : "Strong"] electromagnetic pulse detected!"))
	if(. & EMP_PROTECT_CONTENTS)
		return
	selected_module?.deactivate(display_message = TRUE)
	wearer.apply_damage(5 / severity, BURN, spread_damage=TRUE)
	to_chat(wearer, span_danger("You feel [src] heat up from the EMP, burning you slightly."))
	if(wearer.stat < UNCONSCIOUS && prob(10))
		wearer.emote("scream")

/obj/item/mod/control/on_outfit_equip(mob/living/carbon/human/outfit_wearer, visuals_only, item_slot)
	. = ..()
	quick_activation()

/obj/item/mod/control/doStrip(mob/stripper, mob/owner)
	if(active && !toggle_activate(stripper, force_deactivate = TRUE))
		return
	for(var/obj/item/part as anything in get_parts())
		if(part.loc == src)
			continue
		retract(null, part)
	return ..()

/obj/item/mod/control/update_icon_state()
	icon_state = "[skin]-[base_icon_state][active ? "-sealed" : ""]"
	return ..()

/obj/item/mod/control/proc/get_parts(all = FALSE)
	. = list()
	for(var/key in mod_parts)
		var/datum/mod_part/part = mod_parts[key]
		if(!all && part.part_item == src)
			continue
		. += part.part_item

/obj/item/mod/control/proc/get_part_datums(all = FALSE)
	. = list()
	for(var/key in mod_parts)
		var/datum/mod_part/part = mod_parts[key]
		if(!all && part.part_item == src)
			continue
		. += part

/obj/item/mod/control/proc/get_part_datum(obj/item/part)
	RETURN_TYPE(/datum/mod_part)
	var/datum/mod_part/potential_part = mod_parts["[part.slot_flags]"]
	if(potential_part?.part_item == part)
		return potential_part
	for(var/datum/mod_part/mod_part in get_part_datums())
		if(mod_part.part_item == part)
			return mod_part
	CRASH("get_part_datum called with incorrect item [part] passed.")

/obj/item/mod/control/proc/get_part_from_slot(slot)
	slot = "[slot]"
	for(var/part_slot in mod_parts)
		if(slot != part_slot)
			continue
		var/datum/mod_part/part = mod_parts[part_slot]
		return part.part_item

/obj/item/mod/control/proc/set_wearer(mob/living/carbon/human/user)
	if(wearer == user)
		CRASH("set_wearer() was called with the new wearer being the current wearer: [wearer]")
	else if(!isnull(wearer))
		stack_trace("set_wearer() was called with a new wearer without unset_wearer() being called")

	wearer = user
	SEND_SIGNAL(src, COMSIG_MOD_WEARER_SET, wearer)
	RegisterSignal(wearer, COMSIG_ATOM_EXITED, PROC_REF(on_exit))
	RegisterSignal(wearer, COMSIG_SPECIES_GAIN, PROC_REF(on_species_gain))
	update_charge_alert()
	for(var/obj/item/mod/module/module as anything in modules)
		module.on_equip()

/obj/item/mod/control/proc/unset_wearer()
	for(var/obj/item/mod/module/module as anything in modules)
		module.on_unequip()
	UnregisterSignal(wearer, list(COMSIG_ATOM_EXITED, COMSIG_SPECIES_GAIN))
	SEND_SIGNAL(src, COMSIG_MOD_WEARER_UNSET, wearer)
	wearer.update_spacesuit_hud_icon("0")
	wearer = null

/obj/item/mod/control/proc/clean_up()
	if(QDELING(src))
		unset_wearer()
		return
	if(active || activating)
		for(var/obj/item/mod/module/module as anything in modules)
			if(!module.active)
				continue
			module.deactivate(display_message = FALSE)
		for(var/obj/item/part as anything in get_parts())
			seal_part(part, is_sealed = FALSE)
	for(var/obj/item/part as anything in get_parts())
		retract(null, part)
	if(active)
		finish_activation(is_on = FALSE)
		mod_link?.end_call()
	var/mob/old_wearer = wearer
	unset_wearer()
	old_wearer.temporarilyRemoveItemFromInventory(src)

/obj/item/mod/control/proc/on_species_gain(datum/source, datum/species/new_species, datum/species/old_species)
	SIGNAL_HANDLER

	for(var/obj/item/part in get_parts(all = TRUE))
		if(!(new_species.no_equip_flags & part.slot_flags) || is_type_in_list(new_species, part.species_exception))
			continue
		forceMove(drop_location())
		return

/obj/item/mod/control/proc/quick_module(mob/user)
	if(!length(modules))
		return
	var/list/display_names = list()
	var/list/items = list()
	for(var/obj/item/mod/module/module as anything in modules)
		if(module.module_type == MODULE_PASSIVE)
			continue
		display_names[module.name] = REF(module)
		var/image/module_image = image(icon = module.icon, icon_state = module.icon_state)
		if(module == selected_module)
			module_image.underlays += image(icon = 'icons/hud/radial.dmi', icon_state = "module_selected")
		else if(module.active)
			module_image.underlays += image(icon = 'icons/hud/radial.dmi', icon_state = "module_active")
		if(!COOLDOWN_FINISHED(module, cooldown_timer))
			module_image.add_overlay(image(icon = 'icons/hud/radial.dmi', icon_state = "module_cooldown"))
		items += list(module.name = module_image)
	if(!length(items))
		return
	var/radial_anchor = src
	if(istype(user.loc, /obj/effect/dummy/phased_mob))
		radial_anchor = get_turf(user.loc) //they're phased out via some module, anchor the radial on the turf so it may still display
	var/pick = show_radial_menu(user, radial_anchor, items, custom_check = FALSE, require_near = TRUE, tooltips = TRUE)
	if(!pick)
		return
	var/module_reference = display_names[pick]
	var/obj/item/mod/module/picked_module = locate(module_reference) in modules
	if(!istype(picked_module))
		return
	picked_module.on_select()

/obj/item/mod/control/proc/shock(mob/living/user)
	if(!istype(user) || get_charge() < 1)
		return FALSE
	do_sparks(5, TRUE, src)
	var/check_range = TRUE
	return electrocute_mob(user, get_charge_source(), src, 0.7, check_range)

/obj/item/mod/control/proc/install(obj/item/mod/module/new_module, mob/user)
	for(var/obj/item/mod/module/old_module as anything in modules)
		if(is_type_in_list(new_module, old_module.incompatible_modules) || is_type_in_list(old_module, new_module.incompatible_modules))
			if(user)
				balloon_alert(user, "[new_module] incompatible with [old_module]!")
				playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
			return
	var/complexity_with_module = complexity
	complexity_with_module += new_module.complexity
	if(complexity_with_module > complexity_max)
		if(user)
			balloon_alert(user, "[new_module] would make [src] too complex!")
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return
	if(!new_module.has_required_parts(mod_parts))
		if(user)
			balloon_alert(user, "[new_module] incompatible with [src]'s parts!")
			playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return
	new_module.forceMove(src)
	modules += new_module
	complexity += new_module.complexity
	new_module.mod = src
	new_module.RegisterSignal(src, COMSIG_ITEM_GET_WORN_OVERLAYS, TYPE_PROC_REF(/obj/item/mod/module, add_module_overlay))
	new_module.on_install()
	if(wearer)
		new_module.on_equip()
	if(active)
		new_module.on_suit_activation()
	if(user)
		balloon_alert(user, "[new_module] added")
		playsound(src, 'sound/machines/click.ogg', 50, TRUE, SILENCED_SOUND_EXTRARANGE)

/obj/item/mod/control/proc/uninstall(obj/item/mod/module/old_module, deleting = FALSE)
	modules -= old_module
	complexity -= old_module.complexity
	if(wearer)
		old_module.on_unequip()
	if(active)
		old_module.on_suit_deactivation(deleting = deleting)
		if(old_module.active)
			old_module.deactivate(display_message = !deleting, deleting = deleting)
	old_module.UnregisterSignal(src, COMSIG_ITEM_GET_WORN_OVERLAYS)
	old_module.on_uninstall(deleting = deleting)
	QDEL_LIST_ASSOC_VAL(old_module.pinned_to)
	old_module.mod = null

/// Intended for callbacks, don't use normally, just get wearer by itself.
/obj/item/mod/control/proc/get_wearer()
	return wearer

/obj/item/mod/control/proc/update_access(mob/user, obj/item/card/id/card)
	if(!allowed(user))
		balloon_alert(user, "insufficient access!")
		playsound(src, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return
	req_access = card.access.Copy()
	balloon_alert(user, "access updated")

/obj/item/mod/control/proc/get_charge_source()
	return core?.charge_source()

/obj/item/mod/control/proc/get_charge()
	return core?.charge_amount() || 0

/obj/item/mod/control/proc/get_max_charge()
	return core?.max_charge_amount() || 1 //avoid dividing by 0

/obj/item/mod/control/proc/get_charge_percent()
	return ROUND_UP((get_charge() / get_max_charge()) * 100)

/obj/item/mod/control/proc/add_charge(amount)
	return core?.add_charge(amount) || FALSE

/obj/item/mod/control/proc/subtract_charge(amount)
	return core?.subtract_charge(amount) || FALSE

/obj/item/mod/control/proc/check_charge(amount)
	return core?.check_charge(amount) || FALSE

/**
 * Updates the wearer's hud according to the current state of the MODsuit
 */
/obj/item/mod/control/proc/update_charge_alert()
	if(isnull(wearer))
		return
	var/state_to_use
	if(!active)
		state_to_use = "0"
	else if(isnull(core))
		state_to_use = "coreless"
	else
		state_to_use = core.get_charge_icon_state()

	wearer.update_spacesuit_hud_icon(state_to_use || "0")

/obj/item/mod/control/proc/update_speed()
	for(var/obj/item/part as anything in get_parts(all = TRUE))
		part.slowdown = (active ? slowdown_active : slowdown_inactive) / length(mod_parts)
	wearer?.update_equipment_speed_mods()

/obj/item/mod/control/proc/power_off()
	balloon_alert(wearer, "no power!")
	toggle_activate(wearer, force_deactivate = TRUE)

/obj/item/mod/control/proc/set_mod_color(new_color)
	for(var/obj/item/part as anything in get_parts(all = TRUE))
		part.remove_atom_colour(WASHABLE_COLOUR_PRIORITY)
		part.add_atom_colour(new_color, FIXED_COLOUR_PRIORITY)
	wearer?.regenerate_icons()
/obj/item/mod/control/proc/on_exit(datum/source, atom/movable/part, direction)
	SIGNAL_HANDLER

	if(part.loc == src)
		return
	if(part == core)
		core.uninstall()
		return
	if(part.loc == wearer)
		return
	if(part in modules)
		uninstall(part)
		return
	if(part in get_parts())
		if(isnull(part.loc))
			return
		if(!wearer)
			part.forceMove(src)
			return
		retract(wearer, part)
		if(active)
			INVOKE_ASYNC(src, PROC_REF(toggle_activate), wearer, TRUE)

/obj/item/mod/control/proc/on_part_destruction(obj/item/part, damage_flag)
	SIGNAL_HANDLER

	if(QDELING(src))
		return
	atom_destruction(damage_flag)

/obj/item/mod/control/proc/on_part_deletion(obj/item/part)
	SIGNAL_HANDLER

	if(QDELING(src))
		return
	part.moveToNullspace()
	qdel(src)

/obj/item/mod/control/proc/on_overslot_exit(obj/item/part, atom/movable/overslot, direction)
	SIGNAL_HANDLER

	var/datum/mod_part/part_datum = get_part_datum(part)
	if(overslot != part_datum.overslotting)
		return
	part_datum.overslotting = null

/obj/item/mod/control/proc/on_potion(atom/movable/source, obj/item/slimepotion/speed/speed_potion, mob/living/user)
	SIGNAL_HANDLER

	if(slowdown_inactive <= 0)
		to_chat(user, span_warning("[src] has already been coated with red, that's as fast as it'll go!"))
		return SPEED_POTION_STOP
	if(active)
		to_chat(user, span_warning("It's too dangerous to smear [speed_potion] on [src] while it's active!"))
		return SPEED_POTION_STOP
	to_chat(user, span_notice("You slather the red gunk over [src], making it faster."))
	set_mod_color(COLOR_RED)
	slowdown_inactive = 0
	slowdown_active = 0
	update_speed()
	qdel(speed_potion)
	return SPEED_POTION_STOP

/// Disables the mod link frequency attached to this unit.
/obj/item/mod/control/proc/disable_modlink()
	if(isnull(mod_link))
		return

	mod_link.end_call()
	mod_link.frequency = null
