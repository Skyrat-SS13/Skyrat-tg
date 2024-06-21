///Allows an admin to open the panel
ADMIN_VERB(intensity_credits_panel, R_FUN, "ICES Events Panel", "Opens up the ICES panel.", ADMIN_CATEGORY_EVENTS)
	user.holder?.intensity_credits_panel()

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

/datum/intensity_credits_panel/ui_state(mob/user)
	return GLOB.fun_state

/datum/intensity_credits_panel/ui_data(mob/user)
	var/list/data = list()
	var/filter_threshold = get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE)

	data = list(
		"current_credits" = GLOB.intense_event_credits,
		"next_run" = DisplayTimeText(SSevents.scheduled - world.time, 1),
		"active_players" = filter_threshold,
		"active_multiplier" = SSevents.active_intensity_multiplier,
		"lowpop_players" = SSevents.intensity_low_players,
		"lowpop_multiplier" = SSevents.intensity_low_multiplier,
		"midpop_players" = SSevents.intensity_mid_players,
		"midpop_multiplier" = SSevents.intensity_mid_multiplier,
		"highpop_players" = SSevents.intensity_high_players,
		"highpop_multiplier" = SSevents.intensity_high_multiplier,
	)

	return data
