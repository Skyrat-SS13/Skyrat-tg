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

	var/passport_name = "passport papers"
	var/icon_state_base = "generic"
	var/icon_state_ext = PASSPORT_CLOSED
	var/has_closed_state = FALSE
	var/has_animation = FALSE
	var/tgui_style = "paper"

	var/holder_name
	var/holder_age
	var/holder_faction
	var/holder_employment

	var/list/cached_data
	var/imprinted = FALSE

/obj/item/passport/Initialize(mapload)
	. = ..()
	update_label()
	switch(has_closed_state)
		if(TRUE)
			icon_state = "[icon_state_base]_[icon_state_ext]"
		else
			icon_state = "[icon_state_base]_opened"

/obj/item/passport/get_passport()
	return src

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

	switch(icon_state_ext)
		if(PASSPORT_CLOSED)
			icon_state_ext = PASSPORT_OPENED
			if(has_animation)
				flick(icon(icon, "[icon_state_base]_[PASSPORT_OPENING]"), src)
		if(PASSPORT_OPENED)
			icon_state_ext = PASSPORT_CLOSED
			if(has_animation)
				flick(icon(icon, "[icon_state_base]_[PASSPORT_CLOSING]"), src)

	icon_state = "[icon_state_base]_[icon_state_ext]"
	balloon_alert(user, "[icon_state_ext] [src.name]")

/obj/item/passport/ShiftClick(mob/user)
	. = ..()
	ui_interact(user)

/obj/item/passport/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)

	if((has_closed_state && icon_state_ext == PASSPORT_CLOSED) || !cached_data)
		user.show_message(span_warningplain("You cannot see any information on [src]!"))
		if(ui)
			ui.close()
		return

	if(!ui)
		ui = new(user, src, "Passport", name, 400, 350)
		ui.open()

/obj/item/passport/ui_data(mob/user)
	return get_data()

/obj/item/passport/proc/get_headshot_from_datacore(name)
	var/list/datacore_entry = GLOB.name_to_datacore_entry[name]
	if(datacore_entry)
		var/datum/data/record/general_record = datacore_entry["general"]
		var/obj/item/photo/photo = general_record.get_front_photo()
		var/icon/headshot_crop = icon(photo.picture.picture_image)
		headshot_crop.Crop(9, 32, 24, 17)
		return headshot_crop

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

/obj/item/passport/proc/update_label()
	var/custom_name = passport_name
	name = holder_name ? "[holder_name]'s [custom_name]" : custom_name

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
