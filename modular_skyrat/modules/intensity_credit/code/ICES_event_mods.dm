///Allows an admin to open the panel
/client/proc/intensity_credits_panel()
	set name = "ICES Events Panel"
	set category = "Admin.Events"

	if(!holder || !check_rights(R_FUN))
		return

	holder.intensity_credits_panel()

///Opens up the ICES panel
/datum/admins/proc/intensity_credits_panel()
	if(!check_rights(R_FUN))
		return

	var/datum/intensity_credits_panel/ui = new(usr)
	ui.ui_interact(usr)

/// ICES panel
/datum/intensity_credits_panel

/datum/intensity_credits_panel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "IntensityCredits")
		ui.open()

/datum/intensity_credits_panel/ui_data(mob/user)
	var/list/data = list()

	var/is_fun = check_rights_for(user.client, R_FUN)

	data["ICESData"] = list(
		"current_credits" = GLOB.intense_event_credits,
		"ckey" = user.client?.ckey,
		"is_fun" = is_fun,
	)

	return data
