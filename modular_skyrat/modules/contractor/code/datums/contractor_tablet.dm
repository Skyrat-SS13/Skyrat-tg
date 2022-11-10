/datum/computer_file/program/contract_uplink
	filename = "contractor uplink"
	filedesc = "Syndicate Contractor Uplink"
	category = PROGRAM_CATEGORY_MISC
	program_icon_state = "assign"
	extended_desc = "A standard, Syndicate issued system for handling important contracts while on the field."
	size = 10
	requires_ntnet = FALSE
	available_on_ntnet = FALSE
	undeletable = TRUE
	tgui_id = "SyndContractor"
	program_icon = "tasks"
	/// Error message if there is one
	var/error = ""
	/// If the info screen is displayed or not
	var/info_screen = TRUE
	/// If the contract uplink's been assigned to a person yet
	var/assigned = FALSE
	/// If this is the first opening of the tablet
	var/first_load = TRUE

/datum/computer_file/program/contract_uplink/on_start(mob/living/user)
	. = ..(user)

/datum/computer_file/program/contract_uplink/ui_act(action, params)
	. = ..()
	if(.)
		return

	var/mob/living/user = usr
	var/obj/item/modular_computer/tablet/syndicate_contract_uplink/preset/uplink/uplink_computer = computer

	if(!istype(uplink_computer))
		return

	switch(action)
		if("PRG_contract-accept")
			var/contract_id = text2num(params["contract_id"])

			// Set as the active contract
			uplink_computer.opfor_data.contractor_hub.assigned_contracts[contract_id].status = CONTRACT_STATUS_ACTIVE
			uplink_computer.opfor_data.contractor_hub.current_contract = uplink_computer.opfor_data.contractor_hub.assigned_contracts[contract_id]

			program_icon_state = "single_contract"
			return TRUE
		if("PRG_login")
			if(!user.mind.opposing_force)
				var/datum/opposing_force/opposing_force = new(user.mind)
				user.mind.opposing_force = opposing_force
				SSopposing_force.new_opfor(opposing_force)
			var/datum/opposing_force/opfor_data = user.mind.opposing_force

			if (!opfor_data) // Just in case
				return FALSE
			// Only play greet sound, and handle contractor hub when assigning for the first time.
			if (!opfor_data.contractor_hub)
				user.playsound_local(user, 'sound/effects/contractstartup.ogg', 100, FALSE)
				opfor_data.contractor_hub = new
				opfor_data.contractor_hub.create_hub_items()

			// Stops any topic exploits such as logging in multiple times on a single system.
			if (!assigned)
				opfor_data.contractor_hub.create_contracts(opfor_data.mind_reference)

				uplink_computer.opfor_data = opfor_data

				program_icon_state = "contracts"
				assigned = TRUE
			return TRUE
		if("PRG_call_extraction")
			if (uplink_computer.opfor_data.contractor_hub.current_contract.status != CONTRACT_STATUS_EXTRACTING)
				if (uplink_computer.opfor_data.contractor_hub.current_contract.handle_extraction(user))
					user.playsound_local(user, 'sound/effects/confirmdropoff.ogg', 100, TRUE)
					uplink_computer.opfor_data.contractor_hub.current_contract.status = CONTRACT_STATUS_EXTRACTING

					program_icon_state = "extracted"
				else
					user.playsound_local(user, 'sound/machines/uplinkerror.ogg', 50)
					error = "Either both you or your target aren't at the dropoff location, or the pod hasn't got a valid place to land. Clear space, or make sure you're both inside."
			else
				user.playsound_local(user, 'sound/machines/uplinkerror.ogg', 50)
				error = "Already extracting... Place the target into the pod. If the pod was destroyed, this contract is no longer possible."

			return TRUE
		if("PRG_contract_abort")
			var/contract_id = uplink_computer.opfor_data.contractor_hub.current_contract.id

			uplink_computer.opfor_data.contractor_hub.current_contract = null
			uplink_computer.opfor_data.contractor_hub.assigned_contracts[contract_id].status = CONTRACT_STATUS_ABORTED

			program_icon_state = "contracts"

			return TRUE
		if("PRG_redeem_TC")
			if (uplink_computer.opfor_data.contractor_hub.contract_TC_to_redeem)
				var/obj/item/stack/telecrystal/crystals = new /obj/item/stack/telecrystal(get_turf(user),
															uplink_computer.opfor_data.contractor_hub.contract_TC_to_redeem)
				if(ishuman(user))
					var/mob/living/carbon/human/H = user
					if(H.put_in_hands(crystals))
						to_chat(H, span_notice("Your payment materializes into your hands!"))
					else
						to_chat(user, span_notice("Your payment materializes onto the floor."))

				uplink_computer.opfor_data.contractor_hub.contract_paid_out += uplink_computer.opfor_data.contractor_hub.contract_TC_to_redeem
				uplink_computer.opfor_data.contractor_hub.contract_TC_to_redeem = 0
				return TRUE
			else
				user.playsound_local(user, 'sound/machines/uplinkerror.ogg', 50)
			return TRUE
		if ("PRG_clear_error")
			error = ""
			return TRUE
		if("PRG_set_first_load_finished")
			first_load = FALSE
			return TRUE
		if("PRG_toggle_info")
			info_screen = !info_screen
			return TRUE
		if ("buy_hub")
			if (uplink_computer.opfor_data.mind_reference.current == user)
				var/item = params["item"]

				for (var/datum/contractor_item/hub_item in uplink_computer.opfor_data.contractor_hub.hub_items)
					if (hub_item.name == item)
						hub_item.handle_purchase(uplink_computer.opfor_data.contractor_hub, user)
			else
				error = "Invalid user... You weren't recognised as the user of this system."

/datum/computer_file/program/contract_uplink/ui_data(mob/user)
	var/list/data = list()
	var/screen_to_be = null
	var/obj/item/modular_computer/tablet/syndicate_contract_uplink/preset/uplink/uplink_computer = computer

	data["first_load"] = first_load

	if (uplink_computer?.opfor_data)
		var/datum/opposing_force/opfor_data = uplink_computer.opfor_data
		data += get_header_data()

		if (opfor_data.contractor_hub.current_contract)
			data["ongoing_contract"] = TRUE
			screen_to_be = "single_contract"
			if (opfor_data.contractor_hub.current_contract.status == CONTRACT_STATUS_EXTRACTING)
				data["extraction_enroute"] = TRUE
				screen_to_be = "extracted"
			else
				data["extraction_enroute"] = FALSE
		else
			data["ongoing_contract"] = FALSE
			data["extraction_enroute"] = FALSE

		data["logged_in"] = TRUE
		data["station_name"] = GLOB.station_name
		data["redeemable_tc"] = opfor_data.contractor_hub.contract_TC_to_redeem
		data["earned_tc"] = opfor_data.contractor_hub.contract_paid_out
		data["contracts_completed"] = opfor_data.contractor_hub.contracts_completed
		data["contract_rep"] = opfor_data.contractor_hub.contract_rep

		data["info_screen"] = info_screen

		data["error"] = error

		for (var/datum/contractor_item/hub_item in opfor_data.contractor_hub.hub_items)
			data["contractor_hub_items"] += list(list(
				"name" = hub_item.name,
				"desc" = hub_item.desc,
				"cost" = hub_item.cost,
				"limited" = hub_item.limited,
				"item_icon" = hub_item.item_icon
			))

		for (var/datum/syndicate_contract/contract in opfor_data.contractor_hub.assigned_contracts)
			if(!contract.contract)
				stack_trace("Syndiate contract with null contract objective found in [opfor_data.mind_reference]'s contractor hub!")
				contract.status = CONTRACT_STATUS_ABORTED
				continue

			data["contracts"] += list(list(
				"target" = contract.contract.target,
				"target_rank" = contract.target_rank,
				"payout" = contract.contract.payout,
				"payout_bonus" = contract.contract.payout_bonus,
				"dropoff" = contract.contract.dropoff,
				"id" = contract.id,
				"status" = contract.status,
				"message" = contract.wanted_message
			))

		var/direction
		if (opfor_data.contractor_hub.current_contract)
			var/turf/curr = get_turf(user)
			var/turf/dropoff_turf
			data["current_location"] = "[get_area_name(curr, TRUE)]"

			for (var/turf/content in opfor_data.contractor_hub.current_contract.contract.dropoff.contents)
				if (isturf(content))
					dropoff_turf = content
					break

			if(curr.z == dropoff_turf.z) //Direction calculations for same z-level only
				direction = uppertext(dir2text(get_dir(curr, dropoff_turf))) //Direction text (East, etc). Not as precise, but still helpful.
				if(get_area(user) == opfor_data.contractor_hub.current_contract.contract.dropoff)
					direction = "LOCATION CONFIRMED"
			else
				direction = "???"

			data["dropoff_direction"] = direction

	else
		data["logged_in"] = FALSE

	if(screen_to_be)
		program_icon_state = screen_to_be
	update_computer_icon()
	return data
