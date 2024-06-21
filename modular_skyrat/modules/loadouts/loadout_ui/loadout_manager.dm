/// -- The loadout manager and UI --
/// Tracking when a client has an open loadout manager, to prevent funky stuff.
/client
	/// A weakref to loadout_manager datum.
	var/datum/weakref/open_loadout_ui

/// Datum holder for the loadout manager UI.
/datum/loadout_manager
	/// The client of the person using the UI
	var/client/owner
	/// The current selected loadout list.
	var/list/loadout_on_open
	/// Our currently open greyscaling menu.
	var/datum/greyscale_modify_menu/menu

/datum/loadout_manager/Destroy(force, ...)
	if(menu)
		SStgui.close_uis(menu)
		menu = null
	owner?.open_loadout_ui = null
	owner = null
	QDEL_NULL(menu)
	return ..()

/datum/loadout_manager/New(user)
	owner = CLIENT_FROM_VAR(user)
	loadout_on_open = LAZYLISTDUPLICATE(owner.prefs.loadout_list)
	owner.open_loadout_ui = WEAKREF(src)

/datum/loadout_manager/ui_close(mob/user)
	owner?.prefs.save_character()
	if(menu)
		SStgui.close_uis(menu)
		menu = null
	owner?.open_loadout_ui = null
	qdel(src)

/datum/loadout_manager/ui_state(mob/user)
	return GLOB.always_state

/datum/loadout_manager/ui_interact(mob/user, datum/tgui/ui)

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "LoadoutManager")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/loadout_manager/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/datum/loadout_item/interacted_item
	if(params["path"])
		interacted_item = GLOB.all_loadout_datums[text2path(params["path"])]
		if(!interacted_item)
			stack_trace("Failed to locate desired loadout item (path: [params["path"]]) in the global list of loadout datums!")
			return

	switch(action)
		// Closes the UI, reverting our loadout to before edits if params["revert"] is set
		if("close_ui")
			if(params["revert"])
				owner.prefs.loadout_list = loadout_on_open
			SStgui.close_uis(src)
			return

		if("select_item")
			//Here we will perform basic checks to ensure there are no exploits happening
			if(interacted_item.donator_only && !GLOB.donator_list[owner.ckey] && !is_admin(owner))
				message_admins("LOADOUT SYSTEM: Possible exploit detected, non-donator [owner.ckey] tried loading [interacted_item.item_path], but this is donator only.")
				return

			if(interacted_item.ckeywhitelist && !(owner.ckey in interacted_item.ckeywhitelist))
				message_admins("LOADOUT SYSTEM: Possible exploit detected, non-donator [owner.ckey] tried loading [interacted_item.item_path], but this is ckey locked.")
				return
			if(params["deselect"])
				deselect_item(interacted_item)
				owner?.prefs?.character_preview_view.update_body()
			else
				select_item(interacted_item)
				owner?.prefs?.character_preview_view.update_body()

		if("select_color")
			select_item_color(interacted_item)

		if("set_name")
			set_item_name(interacted_item)

		if("display_restrictions")
			display_job_restrictions(interacted_item)
			display_job_blacklists(interacted_item)
			display_species_restrictions(interacted_item)

		// Clears the loadout list entirely.
		if("clear_all_items")
			LAZYNULL(owner.prefs.loadout_list)
			owner?.prefs?.character_preview_view.update_body()

		if("donator_explain")
			if(GLOB.donator_list[owner.ckey])
				to_chat(owner, examine_block("<b><font color='#f566d6'>Thank you for donating, this item is for you <3!</font></b>"))
			else
				to_chat(owner, examine_block(span_boldnotice("This item is restricted to donators only, for more information, please check the discord(#server-info) for more information!")))

		if("ckey_explain")
			to_chat(owner, examine_block(span_green("This item is restricted to your ckey only. Thank you!")))

	return TRUE

/// Select [path] item to [category_slot] slot.
/datum/loadout_manager/proc/select_item(datum/loadout_item/selected_item)
	var/num_misc_items = 0
	var/datum/loadout_item/first_misc_found
	for(var/datum/loadout_item/item as anything in loadout_list_to_datums(owner.prefs.loadout_list))
		if(item.category == selected_item.category)
			if((item.category == LOADOUT_ITEM_MISC || item.category == LOADOUT_ITEM_TOYS) && ++num_misc_items < MAX_ALLOWED_MISC_ITEMS)
				if(!first_misc_found)
					first_misc_found = item
				continue

			deselect_item(first_misc_found || item)
			continue

	LAZYSET(owner.prefs.loadout_list, selected_item.item_path, list())

/// Deselect [deselected_item].
/datum/loadout_manager/proc/deselect_item(datum/loadout_item/deselected_item)
	LAZYREMOVE(owner.prefs.loadout_list, deselected_item.item_path)

/// Select [path] item to [category_slot] slot, and open up the greyscale UI to customize [path] in [category] slot.
/datum/loadout_manager/proc/select_item_color(datum/loadout_item/item)
	if(menu)
		to_chat(owner, span_warning("You already have a greyscaling window open!"))
		return

	var/obj/item/colored_item = item.item_path

	var/list/allowed_configs = list()
	if(initial(colored_item.greyscale_config))
		allowed_configs += "[initial(colored_item.greyscale_config)]"
	if(initial(colored_item.greyscale_config_worn))
		allowed_configs += "[initial(colored_item.greyscale_config_worn)]"
	if(initial(colored_item.greyscale_config_inhand_left))
		allowed_configs += "[initial(colored_item.greyscale_config_inhand_left)]"
	if(initial(colored_item.greyscale_config_inhand_right))
		allowed_configs += "[initial(colored_item.greyscale_config_inhand_right)]"

	var/slot_starting_colors = initial(colored_item.greyscale_colors)
	if((colored_item in owner.prefs.loadout_list) && (INFO_GREYSCALE in owner.prefs.loadout_list[colored_item]))
		slot_starting_colors = owner.prefs.loadout_list[colored_item][INFO_GREYSCALE]

	menu = new(
		src,
		usr,
		allowed_configs,
		CALLBACK(src, PROC_REF(set_slot_greyscale), colored_item),
		starting_icon_state = initial(colored_item.icon_state),
		starting_config = initial(colored_item.greyscale_config),
		starting_colors = slot_starting_colors,
		unlocked = TRUE,
	)
	RegisterSignal(menu, COMSIG_PREQDELETED, TYPE_PROC_REF(/datum/loadout_manager, cleanup_greyscale_menu))
	menu.ui_interact(usr)

/// A proc to make sure our menu gets null'd properly when it's deleted.
/// If we delete the greyscale menu from the greyscale datum, we don't null it correctly here, it harddels.
/datum/loadout_manager/proc/cleanup_greyscale_menu(datum/source)
	SIGNAL_HANDLER

	menu = null

/// Sets [category_slot]'s greyscale colors to the colors in the currently opened [open_menu].
/datum/loadout_manager/proc/set_slot_greyscale(path, datum/greyscale_modify_menu/open_menu)
	if(!open_menu)
		CRASH("set_slot_greyscale called without a greyscale menu!")

	if(isnull(owner))
		CRASH("set_slot_greyscale called without an owner!")

	if(!(path in owner.prefs.loadout_list))
		to_chat(owner, span_warning("Select the item before attempting to apply greyscale to it!"))
		return

	var/list/colors = open_menu.split_colors
	if(colors)
		owner.prefs.loadout_list[path][INFO_GREYSCALE] = colors.Join("")
		owner.prefs?.character_preview_view.update_body()

/// Set [item]'s name to input provided.
/datum/loadout_manager/proc/set_item_name(datum/loadout_item/item)
	var/current_name = ""
	var/current_desc = ""

	if(!(item.item_path in owner.prefs.loadout_list))
		to_chat(owner, span_warning("Select the item before attempting to name it!"))
		return

	if(INFO_NAMED in owner.prefs.loadout_list[item.item_path])
		current_name = owner.prefs.loadout_list[item.item_path][INFO_NAMED]
	if(INFO_DESCRIBED in owner.prefs.loadout_list[item.item_path])
		current_desc = owner.prefs.loadout_list[item.item_path][INFO_DESCRIBED]

	var/input_name = tgui_input_text(owner, "What name do you want to give [item.name]? Leave blank to clear.", "[item.name] name", current_name, MAX_NAME_LEN)
	var/input_desc = tgui_input_text(owner, "What description do you want to give [item.name]? 256 character max, leave blank to clear.", "[item.name] description", current_desc, 256, multiline = TRUE)
	if(QDELETED(src) || QDELETED(owner) || QDELETED(owner.prefs))
		return

	if(input_name)
		owner.prefs.loadout_list[item.item_path][INFO_NAMED] = input_name
	else
		if(INFO_NAMED in owner.prefs.loadout_list[item.item_path])
			owner.prefs.loadout_list[item.item_path] -= INFO_NAMED
	if(input_desc)
		owner.prefs.loadout_list[item.item_path][INFO_DESCRIBED] = input_desc
	else
		if(INFO_DESCRIBED in owner.prefs.loadout_list[item.item_path])
			owner.prefs.loadout_list[item.item_path] -= INFO_DESCRIBED

/// If only certain jobs are allowed to equip this loadout item, display which
/datum/loadout_manager/proc/display_job_restrictions(datum/loadout_item/item)
	if(!length(item.restricted_roles))
		return
	var/composed_message = span_boldnotice("The [initial(item.item_path.name)] is whitelisted to the following roles: <br>")
	for(var/job_type in item.restricted_roles)
		composed_message += span_green("[job_type] <br>")

	to_chat(owner, examine_block(composed_message))

/// If certain jobs aren't allowed to equip this loadout item, display which
/datum/loadout_manager/proc/display_job_blacklists(datum/loadout_item/item)
	if(!length(item.blacklisted_roles))
		return
	var/composed_message = span_boldnotice("The [initial(item.item_path.name)] is blacklisted from the following roles: <br>")
	for(var/job_type in item.blacklisted_roles)
		composed_message += span_red("[job_type] <br>")

	to_chat(owner, examine_block(composed_message))

/// If only a certain species is allowed to equip this loadout item, display which
/datum/loadout_manager/proc/display_species_restrictions(datum/loadout_item/item)
	if(!length(item.restricted_species))
		return
	var/composed_message = span_boldnotice("\The [initial(item.item_path.name)] is restricted to the following species: <br>")
	for(var/species_type in item.restricted_species)
		composed_message += span_grey("[species_type] <br>")

	to_chat(owner, examine_block(composed_message))

/datum/loadout_manager/ui_data(mob/user)
	var/list/data = list()

	var/list/all_selected_paths = list()
	for(var/path in owner?.prefs?.loadout_list)
		all_selected_paths += path
	data["selected_loadout"] = all_selected_paths
	data["user_is_donator"] = !!(GLOB.donator_list[owner.ckey] || is_admin(owner))

	return data

/datum/loadout_manager/ui_static_data()
	var/list/data = list()

	// [name] is the name of the tab that contains all the corresponding contents.
	// [title] is the name at the top of the list of corresponding contents.
	// [contents] is a formatted list of all the possible items for that slot.
	//  - [contents.path] is the path the singleton datum holds
	//  - [contents.name] is the name of the singleton datum
	//  - [contents.is_renamable], whether the item can be renamed in the UI
	//  - [contents.is_greyscale], whether the item can be greyscaled in the UI
	//  - [contents.tooltip_text], any additional tooltip text that hovers over the item's select button

	var/list/loadout_tabs = list()
	loadout_tabs += list(list("name" = "Belt", "title" = "Belt Slot Items", "contents" = list_to_data(GLOB.loadout_belts)))
	loadout_tabs += list(list("name" = "Ears", "title" = "Ear Slot Items", "contents" = list_to_data(GLOB.loadout_ears)))
	loadout_tabs += list(list("name" = "Glasses", "title" = "Glasses Slot Items", "contents" = list_to_data(GLOB.loadout_glasses)))
	loadout_tabs += list(list("name" = "Gloves", "title" = "Glove Slot Items", "contents" = list_to_data(GLOB.loadout_gloves)))
	loadout_tabs += list(list("name" = "Head", "title" = "Head Slot Items", "contents" = list_to_data(GLOB.loadout_helmets)))
	loadout_tabs += list(list("name" = "Mask", "title" = "Mask Slot Items", "contents" = list_to_data(GLOB.loadout_masks)))
	loadout_tabs += list(list("name" = "Neck", "title" = "Neck Slot Items", "contents" = list_to_data(GLOB.loadout_necks)))
	loadout_tabs += list(list("name" = "Shoes", "title" = "Shoe Slot Items", "contents" = list_to_data(GLOB.loadout_shoes)))
	loadout_tabs += list(list("name" = "Suit", "title" = "Suit Slot Items", "contents" = list_to_data(GLOB.loadout_exosuits)))
	loadout_tabs += list(list("name" = "Jumpsuit", "title" = "Uniform Slot Items", "contents" = list_to_data(GLOB.loadout_jumpsuits)))
	loadout_tabs += list(list("name" = "Formal", "title" = "Uniform Slot Items (cont)", "contents" = list_to_data(GLOB.loadout_undersuits)))
	loadout_tabs += list(list("name" = "Misc. Under", "title" = "Uniform Slot Items (cont)", "contents" = list_to_data(GLOB.loadout_miscunders)))
	loadout_tabs += list(list("name" = "Accessory", "title" = "Uniform Accessory Slot Items", "contents" = list_to_data(GLOB.loadout_accessory)))
	loadout_tabs += list(list("name" = "Inhand", "title" = "In-hand Items", "contents" = list_to_data(GLOB.loadout_inhand_items)))
	loadout_tabs += list(list("name" = "Toys", "title" = "Toys! ([MAX_ALLOWED_MISC_ITEMS] max)", "contents" = list_to_data(GLOB.loadout_toys)))
	loadout_tabs += list(list("name" = "Other", "title" = "Backpack Items ([MAX_ALLOWED_MISC_ITEMS] max)", "contents" = list_to_data(GLOB.loadout_pocket_items)))

	data["loadout_tabs"] = loadout_tabs

	return data

/*
 * Takes an assoc list of [typepath]s to [singleton datum]
 * And formats it into an object for TGUI.
 *
 * - list[name] is the name of the datum.
 * - list[path] is the typepath of the item.
 */
/datum/loadout_manager/proc/list_to_data(list_of_datums)
	if(!LAZYLEN(list_of_datums))
		return

	var/list/formatted_list = new(length(list_of_datums))

	var/array_index = 1
	for(var/datum/loadout_item/item as anything in list_of_datums)
		if(!isnull(item.ckeywhitelist)) //These checks are also performed in the backend.
			if(!(owner.ckey in item.ckeywhitelist))
				formatted_list.len--
				continue
		if(item.donator_only) //These checks are also performed in the backend.
			if(!GLOB.donator_list[owner.ckey] && !is_admin(owner))
				formatted_list.len--
				continue
		if(item.required_season && !check_holidays(item.required_season))
			formatted_list.len--
			continue

		var/atom/loadout_atom = item.item_path

		var/list/formatted_item = list()
		formatted_item["name"] = item.name
		formatted_item["path"] = item.item_path
		formatted_item["is_greyscale"] = !!(initial(loadout_atom.greyscale_config) && initial(loadout_atom.greyscale_colors) && (initial(loadout_atom.flags_1) & IS_PLAYER_COLORABLE_1))
		formatted_item["is_renameable"] = item.can_be_named
		formatted_item["is_job_restricted"] = !isnull(item.restricted_roles)
		formatted_item["is_job_blacklisted"] = !isnull(item.blacklisted_roles)
		formatted_item["is_species_restricted"] = !isnull(item.restricted_species)
		formatted_item["is_donator_only"] = !isnull(item.donator_only)
		formatted_item["is_ckey_whitelisted"] = !isnull(item.ckeywhitelist)
		if(LAZYLEN(item.additional_tooltip_contents))
			formatted_item["tooltip_text"] = item.additional_tooltip_contents.Join("\n")

		formatted_list[array_index++] = formatted_item

	return formatted_list


