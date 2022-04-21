
#define ANNOUNCEMENT_COOLDOWN (10 MINUTES)

/obj/machinery/computer/centcom_announcement
	name = "fleet announcement console"
	desc = "A console used for making priority Nanotrasen Command Reports."
	icon_screen = "comm"
	icon_keyboard = "tech_key"
	req_access = list(ACCESS_CENT_CAPTAIN)
	circuit = /obj/item/circuitboard/computer/communications
	light_color = LIGHT_COLOR_BLUE

	/// The name of central command that will accompany our report
	var/command_name = "Nanotrasen Fleet Command Update"
	/// The actual contents of the report we're going to send.
	var/command_report_content
	/// The title of our report, if anything.
	var/command_report_title
	/// Whether the report's contents are announced.
	var/announce_contents = TRUE
	/// The error we encountered while trying to send a report.
	var/error = ""

	/// Cooldown for sending messages
	COOLDOWN_DECLARE(static/announcement_cooldown)

/obj/machinery/computer/centcom_announcement/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CommandReportConsole")
		ui.open()

/obj/machinery/computer/centcom_announcement/ui_data(mob/user)
	var/list/data = list()
	data["command_report_content"] = command_report_content
	data["announce_contents"] = announce_contents
	data["error"] = error
	data["command_report_title"] = command_report_title
	return data

/obj/machinery/computer/centcom_announcement/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("update_report_contents")
			command_report_content = params["updated_contents"]
		if("update_report_title")
			command_report_title = params["updated_title"]
		if("toggle_announce")
			announce_contents = !announce_contents
		if("submit_report")
			error = ""
			if(!command_report_content)
				error = "ERROR, NO CONTENTS"
				return
			if (!COOLDOWN_FINISHED(src, announcement_cooldown))
				error = "ERROR, SYSTEM IS RECHARGING, ETA: [announcement_cooldown - world.time]"
				return
			send_announcement()
	return TRUE

/*
 * The actual proc that sends the priority announcement and reports
 */
/obj/machinery/computer/centcom_announcement/proc/send_announcement()
	if (!COOLDOWN_FINISHED(src, announcement_cooldown))
		return
	/// The sound we're going to play on report.
	var/report_sound = SSstation.announcer.get_rand_report_sound()

	if(announce_contents)
		priority_announce(command_report_content, command_report_title, report_sound, sender_override = command_name, has_important_message = TRUE)
	print_command_report(command_report_content, "[announce_contents ? "" : "Classified "][command_name] Update", !announce_contents)

	log_admin("[key_name(usr)] has created a command report: \"[command_report_content]\", sent from \"[command_name]\".")
	message_admins("[key_name_admin(usr)] has created a command report, sent from \"[command_name]\".")

	COOLDOWN_START(src, announcement_cooldown, ANNOUNCEMENT_COOLDOWN)

/obj/item/circuitboard/computer/centcom_announcement
	name = "Fleet Announcement (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/centcom_announcement

#undef ANNOUNCEMENT_COOLDOWN
