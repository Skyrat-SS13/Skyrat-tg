#define PASSPORT_CLOSED "closed"
#define PASSPORT_OPENED "opened"
#define PASSPORT_CLOSING "closing"
#define PASSPORT_OPENING "opening"

// This type should only ever be given to very poor backgrounds that aren't backed by an empire.
/obj/item/passport
	name = "passport papers"
	icon = 'modular_skyrat/modules/backgrounds/icons/passports.dmi'
	desc = "A bundle of papers indicating where you originated from, as well as who you are. Made from a non-flammable paper-like material."
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_PASSPORT

	/// The base icon state. You need at least an `_opened` state.
	var/icon_state_base = "generic"
	/// If this has a `_closed` icon state, if set to false, the passport will be always treated as open.
	var/has_closed_state = FALSE
	/// If this has an `_opening` and `_closing` icon state that is flicked to on alt+click. Both are required!
	var/has_animation = FALSE
	/// The TGUI style to use for the passport UI, see `tgui/packages/tgui/styles/themes`, just be aware that some themes don't display certain widgets properly.
	var/tgui_style = "paper"
	/// If TRUE, this will hide this passport from the chameleon menu. Should be reserved for special passports only!
	var/non_forgeable = FALSE

	/// Internal var for tracking current passport state. Don't edit.
	var/current_state = PASSPORT_CLOSED
	/// If set, `update_label` will use the name in here instead.
	var/name_override

	/// The name of the passport holder.
	var/holder_name
	/// The age of the passport holder.
	var/holder_age
	/// The faction typepath of the passport holder.
	var/holder_faction
	/// The employment typepath of the passport holder.
	var/holder_employment

	/// The cached data to be sent to TGUI, helps save a few cycles.
	var/list/cached_data

/obj/item/passport/Initialize(mapload)
	. = ..()
	update_label()
	switch(has_closed_state)
		if(TRUE)
			icon_state = "[icon_state_base]_[current_state]"
		else
			icon_state = "[icon_state_base]_[PASSPORT_OPENED]"

/obj/item/passport/get_passport()
	return src

/// Admin/chameleon proc to mass update a passport's vars and update all of it in one fell swoop. Uses the headshot from datacore if no override is given.
/obj/item/passport/proc/imprint_owner(name, age, datum/background_info/social_background/faction, datum/background_info/employment/employment, headshot_override = null)
	holder_name = name
	holder_age = age
	holder_faction = faction
	holder_employment = employment
	cached_data = null
	get_data(headshot_override)
	update_label()

/obj/item/passport/AltClick(mob/user)
	if(!has_closed_state)
		return

	switch(current_state)
		if(PASSPORT_CLOSED)
			current_state = PASSPORT_OPENED
			if(has_animation)
				flick(icon(icon, "[icon_state_base]_[PASSPORT_OPENING]"), src)
		if(PASSPORT_OPENED)
			current_state = PASSPORT_CLOSED
			if(has_animation)
				flick(icon(icon, "[icon_state_base]_[PASSPORT_CLOSING]"), src)

	icon_state = "[icon_state_base]_[current_state]"
	balloon_alert(user, "[current_state] [src.name]")

/obj/item/passport/ShiftClick(mob/user)
	. = ..()
	ui_interact(user)

/obj/item/passport/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)

	if((has_closed_state && current_state == PASSPORT_CLOSED) || !cached_data)
		user.show_message(span_warningplain("You cannot see any information on [src]!"))
		if(ui)
			ui.close()
		return

	if(!ui)
		ui = new(user, src, "Passport", name, 400, 350)
		ui.open()

/obj/item/passport/ui_data(mob/user)
	return get_data()

/// Pulls a headshot from datacore, and crops it to a good location for all races.
/obj/item/passport/proc/get_headshot_from_datacore(name)
	var/list/datacore_entry = GLOB.name_to_datacore_entry[name]
	if(datacore_entry)
		var/datum/data/record/general_record = datacore_entry["general"]
		var/obj/item/photo/photo = general_record.get_front_photo()
		var/icon/headshot_crop = icon(photo.picture.picture_image)
		headshot_crop.Crop(HEADSHOT_CROP_DIMENSIONS)
		return headshot_crop

/// Returns an assoc list of the current passport holder for TGUI. Cached.
/obj/item/passport/proc/get_data(headshot_override, is_base64 = FALSE, reset_data = FALSE)
	RETURN_TYPE(/list)
	if(!cached_data || reset_data)
		var/datum/background_info/employment/employment = holder_employment
		var/datum/background_info/social_background/social_background = holder_faction
		cached_data = list(
			"name" = holder_name,
			"tgui_style" = tgui_style,
			"headshot_data" = is_base64 ? headshot_override : icon2base64(headshot_override ? headshot_override : get_headshot_from_datacore(holder_name)),
			"empire" = initial(social_background.name),
			"employment" = initial(employment.name),
			"age" = holder_age,
		)
	return cached_data

/// This proc should be called any time the passport's `holder_` vars have been changed. Use `get_data` with `reset_data = TRUE` instead if you're replacing the image.
/obj/item/passport/proc/update_data()
	// Gotta squeeze out that performance!
	var/headshot = cached_data["headshot_data"]
	cached_data = null
	get_data(headshot, TRUE)
	update_label()

/// Similar to the proc IDs have, this is a one-stop-shop to make sure the passport's name is set right. Automatically called by `update_data`, `wipe` and `imprint_owner`.
/obj/item/passport/proc/update_label()
	var/custom_name = name_override? name_override : initial(name)
	name = holder_name ? "[holder_name]'s [custom_name]" : custom_name

/// Yeets all data into the void, and essentially factory-resets the passport. Good for admins in case a passport does a fucky-wucky.
/obj/item/passport/proc/wipe()
	// Oh boy
	holder_name = null
	holder_age = null
	holder_faction = null
	holder_employment = null
	cached_data = null
	update_label()

#undef PASSPORT_CLOSED
#undef PASSPORT_OPENED
