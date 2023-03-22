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

	var/datum/force_event/ui = new(usr)
	ui.ui_interact(usr)

/// Force Event Panel
/datum/intensity_credits_panel

/datum/force_event/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "IntensityCredits")
		ui.open()
