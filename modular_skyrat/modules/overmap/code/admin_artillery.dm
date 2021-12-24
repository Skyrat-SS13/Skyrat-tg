/client/proc/fire_bsa()
	set category = "Admin.Fun"
	set name = "Fire Bluespace Artillery"
	set desc = "Fires an artillery shell at your current location."

	var/choice = tgui_alert(usr, "Fire an artillery shell at your current location?", "Fire Bluespace Artillery", list("Yes", "No"))

	if(!choice == "Yes")
		return

	var/power = 5

	var/power_choice = tgui_alert(usr, "Do you want to override the explosion power? (Default 5)", "Override power?", list("Yes", "No"))

	if(power_choice == "Yes")
		power = clamp(tgui_input_number(usr, "Explosion power override", "Explosion power override", 5, 1, 10), 1, 10)

	var/turf/turf_to_fire_at = get_turf(usr)

	if(!turf_to_fire_at || !isturf(turf_to_fire_at))
		return

	priority_announce("BLUESPACE TARGETING PARAMETERS SET, PREIGNITION STARTING... FIRING IN T-20 SECONDS!", "BLUESPACE ARTILLERY", ANNOUNCER_BLUESPACEARTY_2)
	alert_sound_to_playing('modular_skyrat/modules/bsa_overhaul/sound/superlaser_prefire.ogg', override_volume = TRUE)

	message_admins("[ADMIN_LOOKUPFLW(usr)] has fired bluespace artillery! Firing at: [ADMIN_VERBOSEJMP(turf_to_fire_at)]")

	addtimer(CALLBACK(GLOBAL_PROC, .proc/fire_bluespace_artillery, turf_to_fire_at, power), 20 SECONDS, TIMER_CLIENT_TIME)

/proc/fire_bluespace_artillery(turf/bullseye, ex_power = 5)
	if(!bullseye)
		return
	minor_announce("BLUESPACE ARTILLERY FIRE SUCCESSFUL!", "BLUESPACE ARTILLERY", TRUE)
	explosion(bullseye, ex_power, ex_power*2, ex_power*4)
	alert_sound_to_playing('modular_skyrat/modules/bsa_overhaul/sound/superlaser_firing.ogg', override_volume = TRUE)
