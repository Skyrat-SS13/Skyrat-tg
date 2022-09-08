#define PASSPORT_CLOSED "closed"
#define PASSPORT_OPENED "opened"
#define PASSPORT_CLOSING "closing"
#define PASSPORT_OPENING "opening"

/obj/item/proc/get_passport()
	return

/obj/item/passport
	name = "Invalid Passport"
	icon = 'modular_skyrat/master_files/icons/obj/passports.dmi'
	desc = "An invalid passport. How did you get this?"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_ID

	var/icon_state_base = "invalid"
	var/icon_state_ext = "closed"
	var/has_animation = FALSE
	var/tgui_style = "retro"

	// User specific stuff
	var/datum/weakref/user_weakref

	var/cached_faction
	var/cached_locale
	var/list/cached_data
	var/imprinted = FALSE

/obj/item/passport/Initialize(mapload)
	. = ..()
	icon_state = "[icon_state_base]_[icon_state_ext]"

/obj/item/passport/CtrlClick(mob/living/carbon/human/user)
	. = ..()
	if (imprinted == FALSE)
		balloon_alert(user, "imprinting...")
		imprint_owner(user)
		return
	balloon_alert(user, "already imprinted!")
	return

/obj/item/passport/get_passport()
	return src

/obj/item/passport/proc/imprint_owner(mob/living/carbon/human/user)
	if(istype(user) && user.client)
		user_weakref = WEAKREF(user)
		var/datum/background_info/social_background = GLOB.culture_factions[user.client.prefs.culture_faction]
		cached_faction = social_background? social_background.name : null
		var/datum/background_info/locale = GLOB.culture_locations[user.client.prefs.culture_location]
		cached_locale = locale?.name
		cached_data = null
		imprinted = TRUE

/obj/item/passport/AltClick(mob/user)
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
	if(user_weakref?.resolve())
		ui_interact(user)

/obj/item/passport/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Passport", name, 400, 350)
		ui.open()

/obj/item/passport/ui_data(mob/user)
	return get_data()

/obj/item/passport/proc/get_headshot_from_datacore(name)
	var/list/datacore_entry = GLOB.name_to_datacore_entry[name]
	if(datacore_entry)
		var/datum/data/record/general_record = datacore_entry["general"]
		var/obj/item/photo/photo = general_record.fields["photo_front"]
		var/icon/headshot_crop = icon(photo.picture.picture_image)
		headshot_crop.Crop(9, 32, 24, 17)
		return headshot_crop

/obj/item/passport/proc/get_data()
	RETURN_TYPE(/list)
	if(!cached_data)
		var/mob/living/carbon/human/passport_holder = user_weakref.resolve()
		cached_data = list(
			"name" = passport_holder.real_name,
			"tgui_style" = tgui_style,
			"headshot_data" = icon2base64(get_headshot_from_datacore(passport_holder.real_name)),
			"empire" = cached_faction,
			"locale" = cached_locale,
			"age" = passport_holder.age,
			"current_wages" = 500,
			"space_faring" = TRUE,
		)
	return cached_data

#undef PASSPORT_CLOSED
#undef PASSPORT_OPENED
