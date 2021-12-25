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

	var/target_holograph = tgui_alert(usr, "Do you want to target a holograph?", "Target holograph?", list("Yes", "No"))

	priority_announce("BLUESPACE TARGETING PARAMETERS SET, PREIGNITION STARTING... FIRING IN T-20 SECONDS!", "BLUESPACE ARTILLERY", ANNOUNCER_BLUESPACEARTY_2)
	alert_sound_to_playing('modular_skyrat/modules/bsa_overhaul/sound/superlaser_prefire.ogg', override_volume = TRUE)

	message_admins("[ADMIN_LOOKUPFLW(usr)] has fired bluespace artillery! Firing at: [ADMIN_VERBOSEJMP(turf_to_fire_at)]")

	if(target_holograph == "Yes")
		new /obj/effect/bsa_target(turf_to_fire_at)

	addtimer(CALLBACK(GLOBAL_PROC, .proc/fire_bluespace_artillery, turf_to_fire_at, power), 20 SECONDS, TIMER_CLIENT_TIME)

/proc/fire_bluespace_artillery(turf/bullseye, ex_power = 5)
	if(!bullseye)
		return
	minor_announce("BLUESPACE ARTILLERY FIRE SUCCESSFUL!", "BLUESPACE ARTILLERY", TRUE)
	explosion(bullseye, ex_power, ex_power*2, ex_power*4)
	alert_sound_to_playing('modular_skyrat/modules/bsa_overhaul/sound/superlaser_firing.ogg', override_volume = TRUE)

/obj/effect/bsa_target
	name = "Target Zone Indicator"
	desc = "A holographic targeting indicator for bluespace artillery. You should run."
	icon = 'icons/effects/mouse_pointers/supplypod_down_target.dmi'
	icon_state = "all"
	pixel_x = -16
	pixel_y = -16
	layer = PROJECTILE_HIT_THRESHHOLD_LAYER
	light_range = 2
	anchored = TRUE

/obj/effect/bsa_target/Initialize(mapload)
	. = ..()
	addtimer(CALLBACK(src, .proc/timer_destroy), 20 SECONDS, TIMER_CLIENT_TIME)

/obj/effect/bsa_target/proc/timer_destroy()
	if(QDELETED(src))
		return
	qdel(src)
