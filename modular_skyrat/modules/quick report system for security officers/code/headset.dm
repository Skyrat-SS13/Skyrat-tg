/datum/action/item_action/headset/say_sec_report
	name = "Security report"
	desc = "Opens a menu of quick crime reports with your location."

//Unfortunately, you have to prescribe these variables in the parent earpiece so that you don't have to do identical procedures for each guard earpiece
/obj/item/radio/headset
	var/report_cooldown = 15 SECONDS
	var/last_report = 0

/obj/item/radio/headset/ui_action_click(mob/user, action)
	if(istype(action, /datum/action/item_action/headset/say_sec_report))
		if(HAS_TRAIT(user, TRAIT_KNOW_SECURITY_REPORTS))
			security_report(user, src)
		else
			to_chat(usr, span_warning("Oh no! To radiate a security report, you need to know its form."))

/obj/item/radio/headset/headset_sec
	actions_types = list(/datum/action/item_action/headset/say_sec_report)

/obj/item/radio/headset/headset_sec/alt
	actions_types = list(/datum/action/item_action/headset/say_sec_report)

/obj/item/radio/headset/heads/hos
	actions_types = list(/datum/action/item_action/headset/say_sec_report)

/obj/item/radio/headset/heads/hos/alt
	actions_types = list(/datum/action/item_action/headset/say_sec_report)

/obj/item/radio/headset/proc/security_report(mob/user, obj/item/radio/headset/radio)
	if(world.time < radio.last_report + radio.report_cooldown)
		var/remaining_time = radio.last_report + radio.report_cooldown - world.time
		to_chat(user, "<span class='notice'>The report processing system prohibits reporting this often to avoid contaminating the channel. Wait [remaining_time] ms.</span>")
		return FALSE
	var/icon_path = 'modular_skyrat/modules/quick report system for security officers/icon/action_security.dmi'
	var/list/options = sort_list(list(
			"Combat Actions" = image(icon = icon_path, icon_state = "combat"),
			"Detecting" = image(icon = icon_path, icon_state = "detecting"),
			"Status" = image(icon = icon_path, icon_state = "status"),
			"Support Request" = image(icon = icon_path, icon_state = "request")
		))
	var/option = show_radial_menu(user, user, options)
	if(!option)
		return FALSE
	switch(option)
		if("Combat Actions")
			options = list(
				"Pursuing the perpetrator" = image(icon = icon_path, icon_state = "pursuing"),
				"I'm fighting" = image(icon = icon_path, icon_state = "fighting"),
				"I'm hurt" = image(icon = icon_path, icon_state = "hurt"),
				"Taking combat losses" = image(icon = icon_path, icon_state = "losses"),
				"Retreat" = image(icon = icon_path, icon_state = "retreat")
			)
		if("Detecting")
			options = list(
				"Station damage" = image(icon = icon_path, icon_state = "station_damage"),
				"Fire" = image(icon = icon_path, icon_state = "fire"),
				"Depressurization" = image(icon = icon_path, icon_state = "depressurization"),
				"Criminal trail" = image(icon = icon_path, icon_state = "criminal_trail"),
				"Corpse" = image(icon = icon_path, icon_state = "corpse"),
				"Perpetrator" = image(icon = icon_path, icon_state = "perpetrator"),
				"Dangerous perpetrator" = image(icon = icon_path, icon_state = "dangerous_perpetrator")
			)
		if("Status")
			options = list(
				"Positive" = image(icon = icon_path, icon_state = "positive"),
				"Negative" = image(icon = icon_path, icon_state = "negative"),
				"My location" = image(icon = icon_path, icon_state = "my_loc"),
				"Busy" = image(icon = icon_path, icon_state = "busy"),
				"Available" = image(icon = icon_path, icon_state = "available")
			)
		if("Support Request")
			options = list(
				"Requesting a detective" = image(icon = icon_path, icon_state = "detective_support"),
				"Requesting combat support" = image(icon = icon_path, icon_state = "combat_support"),
				"Requesting Engineering assistance" = image(icon = icon_path, icon_state = "engineering_assistance"),
				"Requesting Medical assistance" = image(icon = icon_path, icon_state = "medical_assistance")
			)
	var/message = show_radial_menu(user, user, options)
	if(!message)
		return FALSE
	message = "[message]. [get_area(user)]."
	radio.talk_into(user, "[message]", "Security")
	user.say("[message]")
	last_report = world.time
