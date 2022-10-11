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

	var/obj/item/computer_hardware/card_slot/card_slot
	var/obj/item/computer_hardware/card_slot/card_slot2
	var/obj/item/computer_hardware/passport_slot/passport_slot
	if(computer)
		card_slot = computer.all_components[MC_CARD]
		card_slot2 = computer.all_components[MC_CARD2]
		passport_slot = computer.all_components[MC_PASSPORT]
		if(!card_slot || !card_slot2 || !passport_slot)
			return

	var/mob/user = usr
	var/obj/item/card/id/user_id_card = card_slot.stored_card
	var/obj/item/card/id/target_id_card = card_slot2.stored_card
	var/obj/item/passport/target_passport = passport_slot.stored_passport

	switch(action)
		// Log in.
		if("PRG_authenticate")
			if(!computer || !user_id_card)
				playsound(computer, 'sound/machines/terminal_prompt_deny.ogg', 50, FALSE)
				return TRUE
			if(authenticate(user, user_id_card))
				playsound(computer, 'sound/machines/terminal_on.ogg', 50, FALSE)
				return TRUE
		// Log out.
		if("PRG_logout")
			authenticated_card = null
			authenticated_user = null
			playsound(computer, 'sound/machines/terminal_off.ogg', 50, FALSE)
			return TRUE
		// Eject the ID used to log on to the ID app.
		if("PRG_ejectauthid")
			if(!computer || !card_slot)
				return TRUE
			if(user_id_card)
				return card_slot.try_eject(user)
			else
				var/obj/item/item = user.get_active_held_item()
				if(isidcard(item))
					return card_slot.try_insert(item, user)
		// Eject the ID being modified.
		if("PRG_ejectpassport")
			if(!computer || !passport_slot)
				return TRUE
			if(target_passport && target_id_card)
				GLOB.data_core.manifest_modify(target_passport.holder_name, target_id_card.assignment, target_id_card.get_trim_assignment())
				return passport_slot.try_eject(user)
			else
				var/obj/item/item = user.get_active_held_item()
				if(ispassport(item))
					return passport_slot.try_insert(item, user)
			return TRUE
		// Used to fire someone. Wipes all access from their card and modifies their assignment.
		if("PRG_wipe")
			if(!computer || !authenticated_card)
				return TRUE

			// Set the new assignment then remove the trim.
			target_passport.wipe()

			playsound(computer, 'sound/machines/printer.ogg', 50, FALSE)
			return TRUE
		// Change ID card assigned name.
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
				stack_trace("[key_name(usr)] ([usr]) attempted to set invalid age \[[new_age]\] to [target_passport]")
				return TRUE

			target_passport.holder_age = new_age
			playsound(computer, SFX_TERMINAL_TYPE, 50, FALSE)
			target_passport.update_data()
			return TRUE
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

	data["station_name"] = station_name()

	var/obj/item/computer_hardware/card_slot/card_slot
	var/obj/item/computer_hardware/card_slot/card_slot2
	var/obj/item/computer_hardware/passport_slot/passport_slot

	if(computer)
		card_slot = computer.all_components[MC_CARD]
		card_slot2 = computer.all_components[MC_CARD2]
		passport_slot = computer.all_components[MC_PASSPORT]
		data["have_auth_card"] = !!(card_slot)
		data["have_id_slot"] = !!(card_slot2)
		data["has_passport_slot"] = !!(passport_slot)
	else
		data["has_passport_slot"] = FALSE

	if(!passport_slot)
		return data //We're just gonna error out on the js side at this point anyway

	var/obj/item/card/id/auth_card = card_slot.stored_card
	data["authIDName"] = auth_card ? auth_card.name : "-----"

	data["authenticatedUser"] = authenticated_card

	var/obj/item/passport/passport = passport_slot.stored_passport
	data["has_passport"] = !!passport
	data["name"] = passport ? passport.holder_name : "-----"
	if(passport)
		data["age"] = passport.holder_age
		// The capitals are intentional.
		data["selected"] = list(
			"Faction" = "[passport.holder_faction]",
			"Employment" = "[passport.holder_employment]",
		)

	return data

/obj/machinery/modular_computer/console/preset/id/install_programs()
	. = ..()
	var/obj/item/computer_hardware/hard_drive/hard_drive = cpu.all_components[MC_HDD]
	hard_drive.store_file(new /datum/computer_file/program/passport_mod)

/obj/machinery/modular_computer/console/preset/id/centcom/install_programs()
	. = ..()
	var/obj/item/computer_hardware/hard_drive/hard_drive = cpu.all_components[MC_HDD]
	hard_drive.store_file(new /datum/computer_file/program/passport_mod)

/obj/machinery/modular_computer/console/preset/id/Initialize(mapload)
	if(!cpu)
		return

	cpu.install_component(new /obj/item/computer_hardware/passport_slot)
