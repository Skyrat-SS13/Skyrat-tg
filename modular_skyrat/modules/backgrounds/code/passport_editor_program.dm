// Basically a copy-paste of "card_mod"

/datum/computer_file/program/passport_mod
	filename = "plexagonpassportwriter"
	filedesc = "Plexagon Passport Management"
	category = PROGRAM_CATEGORY_CREW
	program_icon_state = "id"
	extended_desc = "Program for programming employee ID cards to access parts of the station."
	transfer_access = list(ACCESS_COMMAND)
	requires_ntnet = 0
	size = 8
	tgui_id = "NtosPassport"
	program_icon = "id-card"

	/// The name/assignment combo of the ID card used to authenticate.
	var/authenticated_card
	/// The name of the registered user, related to `authenticated_card`.
	var/authenticated_user

/**
 * Authenticates the program based on the specific ID card.
 *
 * If the card has ACCESS_CHANGE_IDs, it authenticates.
 * * user - Program's user.
 * * id_card - The ID card to attempt to authenticate under.
 */
/datum/computer_file/program/passport_mod/proc/authenticate(mob/user, obj/item/card/id/id_card)
	if(!id_card)
		return FALSE

	if(ACCESS_CHANGE_IDS in id_card.access)
		authenticated_user = id_card.name
		authenticated_card = id_card.name
		return TRUE

	return FALSE

/datum/computer_file/program/passport_mod/ui_act(action, params)
	. = ..()
	if(.)
		return


	var/mob/user = usr
	var/obj/item/card/id/inserted_auth_card = computer.computer_id_slot
	var/obj/item/passport/target_passport = computer.passport_slot

	switch(action)
		// Log in.
		if("PRG_authenticate")
			if(!computer || !inserted_auth_card)
				playsound(computer, 'sound/machines/terminal_prompt_deny.ogg', 50, FALSE)
				return TRUE
			if(authenticate(user, inserted_auth_card))
				playsound(computer, 'sound/machines/terminal_on.ogg', 50, FALSE)
				return TRUE
		// Log out.
		if("PRG_logout")
			authenticated_card = null
			authenticated_user = null
			playsound(computer, 'sound/machines/terminal_off.ogg', 50, FALSE)
			return TRUE
		// Eject the ID used to log in to the ID app.
		if("PRG_ejectauthid")
			if(inserted_auth_card)
				return computer.RemoveID(user)
			else
				var/obj/item/I = user.get_active_held_item()
				if(isidcard(I))
					return computer.InsertID(I, user)
		// Eject the passport being modified.
		if("PRG_ejectpassport")
			if(!computer)
				return TRUE
			if(target_passport)
				return computer.remove_passport(user)
			else
				var/obj/item/item = user.get_active_held_item()
				if(ispassport(item))
					return computer.insert_passport(item, user)
			return TRUE
		// Used to reclaim passports from bodies. Helpful for forgery.
		if("PRG_wipe")
			if(!computer || !authenticated_card)
				return TRUE

			// Yeet all data!
			target_passport.wipe()

			playsound(computer, 'sound/machines/printer.ogg', 50, FALSE)
			return TRUE
		// Change passport holder's name.
		if("PRG_name")
			if(!computer || !authenticated_card || !target_passport)
				return TRUE

			// Sanitize the name first. We're not using the full sanitize_name proc as ID cards can have a wider variety of things on them that
			// would not pass as a formal character name, but would still be valid on an ID card created by a player.
			var/new_name = sanitize(params["name"])

			// However, we are going to reject bad names overall including names with invalid characters in them, while allowing numbers.
			new_name = reject_bad_name(new_name, allow_numbers = TRUE)

			if(!new_name && params["name"])
				to_chat(usr, span_notice("Software error: Rejected the new passport holder name as it contains prohibited characters."))

			target_passport.holder_name = new_name
			playsound(computer, SFX_TERMINAL_TYPE, 50, FALSE)
			target_passport.update_data()
			target_passport.update_label()
			return TRUE
		// Change age
		if("PRG_age")
			if(!computer || !authenticated_card || !target_passport)
				return TRUE

			var/new_age = params["age"]
			if(!isnum(new_age))
				stack_trace("[key_name(usr)] ([usr]) attempted to set invalid age \[[new_age]] to [target_passport]")
				return TRUE

			target_passport.holder_age = new_age
			playsound(computer, SFX_TERMINAL_TYPE, 50, FALSE)
			target_passport.update_data()
			return TRUE
		// Change the background tied to the passport.
		if("PRG_changebackground")
			var/datum/background_info/background_info = text2path(params["target"])
			if(!background_info)
				return TRUE

			if(ispath(background_info, /datum/background_info/social_background))
				target_passport.holder_faction = background_info

			if(ispath(background_info, /datum/background_info/employment))
				target_passport.holder_employment = background_info

			target_passport.update_data()

			return TRUE

/datum/computer_file/program/passport_mod/ui_static_data(mob/user)
	return list(
		"backgrounds" = GLOB.passport_editor_tabs,
	)

/datum/computer_file/program/passport_mod/ui_data(mob/user)
	var/list/data = get_header_data()

	var/obj/item/card/id/inserted_id = computer.computer_id_slot
	var/obj/item/passport/inserted_passport = computer.passport_slot
	data["authIDName"] = inserted_id ? inserted_id.name : "-----"
	data["authenticatedUser"] = authenticated_card

	data["has_id"] = !!inserted_id
	data["has_passport"] = !!inserted_passport
	data["id_name"] = inserted_id ? inserted_id.name : "-----"

	if(inserted_id)
		data["id_rank"] = inserted_id.assignment ? inserted_id.assignment : "Unassigned"
		data["id_owner"] = inserted_id.registered_name ? inserted_id.registered_name : "-----"

	// Passport stuff.
	data["name"] = inserted_passport ? inserted_passport.holder_name : "-----"
	if(inserted_passport)
		data["age"] = inserted_passport.holder_age
		// The capitals are intentional.
		data["selected"] = list(
			"Faction" = "[inserted_passport.holder_faction]",
			"Employment" = "[inserted_passport.holder_employment]",
		)

	return data
