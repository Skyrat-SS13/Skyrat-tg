/obj/machinery/computer/centcom_announcement/nri_raider
	name = "police announcement console"
	desc = "A console used for making priority Internal Affairs Collegium dispatch reports."
	req_access = null
	circuit = null
	command_name = "NRI Enforcer-Class Starship Telegram"
	report_sound = ANNOUNCER_NRI_RAIDERS

/obj/machinery/suit_storage_unit/nri
	mod_type = /obj/item/mod/control/pre_equipped/policing
	storage_type = /obj/item/tank/internals/oxygen/yellow

/// A nerfed down variation of the pirates' shuttle scrambler thingy that locks down supply lines to a halt. Can be turned off, but does not siphon any money.
/// Muh arpee. Also yes I've literally copypasted the description because this is literally what it does there's no hidden meaning behind anything.
/obj/machinery/shuttle_scrambler/nri
	name = "system crasher"
	desc = "This heap of machinery locks down supply lines to a halt. Can be turned off, but does not siphon any money. Do that yourself, lazyass."
	siphon_per_tick = 0
	///Needed for GPS addition on first activation.
	var/first_toggle = FALSE
	///Somewhat self-descriptive variables for "command"'s activation-/deactivation-related messages.
	var/activation_report = "We're intercepting all of the current and future supply deliveries until you're more cooperative with the dispatch. \
	We're sincerely hoping for and expecting your assistance with the matter."
	var/deactivation_report = "We've received a signal to stop the supply blockade; you're once again free to perform your duties as before. \
	Due to the urgency and cost of the responding dispatch, no supply budget increase is to be issued."

/obj/machinery/shuttle_scrambler/nri/toggle_on(mob/user)
	SSshuttle.registerTradeBlockade(src)
	active = TRUE
	to_chat(user,span_notice("You toggle [src] [active ? "on":"off"]."))
	if(!first_toggle)
		AddComponent(/datum/component/gps, "NRI Starship")
		to_chat(user,span_warning("From now on, the ship's signature can be now tracked by GPS."))
		first_toggle = TRUE
	START_PROCESSING(SSobj,src)

/obj/machinery/shuttle_scrambler/nri/process()
	if(active)
		if(is_station_level(z))
			var/datum/bank_account/bank_account = SSeconomy.get_dep_account(ACCOUNT_CAR)
			if(bank_account)
				var/siphoned = min(bank_account.account_balance,siphon_per_tick)
				bank_account.adjust_money(-siphoned)
				credits_stored += siphoned
		else
			return
	else
		STOP_PROCESSING(SSobj,src)

/// idfk-idrc how to make this cleaner it works-it works-good
/obj/machinery/shuttle_scrambler/nri/interact(mob/user)
	if(active)
		var/deactivation_response = tgui_alert(user,"Turn the crasher off?", "Crasher", list("Yes", "Cancel"))

		if(deactivation_response != "Yes")
			return

		if(!active|| !user.can_perform_action(src))
			return

		toggle_off(user)
		update_appearance()
		send_notification()
		to_chat(user,span_notice("You toggle [src] [active ? "on":"off"]."))
		return

	var/scramble_response = tgui_alert(user, "Turning the crasher on might alienate the population and will make the shuttle trackable by GPS. Are you sure you want to do it?", "Crasher", list("Yes", "Cancel"))

	if(scramble_response != "Yes")
		return

	if(active || !user.can_perform_action(src))
		return

	toggle_on(user)
	update_appearance()
	send_notification()
	to_chat(user,span_notice("You toggle [src] [active ? "on":"off"]."))
	return

/obj/machinery/shuttle_scrambler/nri/send_notification()
	priority_announce(active ? activation_report : deactivation_report,
	"NRI IAC HQ",
	ANNOUNCER_NRI_RAIDERS,
	"Priority"
	)
