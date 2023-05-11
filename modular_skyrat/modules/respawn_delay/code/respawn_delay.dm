// Respawn delay in minutes
/datum/config_entry/number/respawn_delay
	default = 0

/mob/dead/observer
	var/timeofdeath = 0

/mob/dead/observer/Login()
	. = ..()
	if(. && client)
		timeofdeath = world.time

/mob/proc/check_respawn_delay(override_delay = 0)
	if(!override_delay && !CONFIG_GET(number/respawn_delay))
		return TRUE

	var/required_delay = override_delay
	if(!required_delay)
		required_delay = CONFIG_GET(number/respawn_delay) MINUTES

	var/deathtime = 0
	if(mind?.current)
		deathtime = world.time - mind.current.timeofdeath
	if(!deathtime && isobserver(src))
		var/mob/dead/observer/user = src
		deathtime = world.time - user.timeofdeath
	if(deathtime && deathtime < required_delay)
		if(!check_rights_for(usr.client, R_ADMIN))
			to_chat(usr, "You have been dead for [round(deathtime / (1 SECONDS), 1)] seconds.")
			to_chat(usr, span_warning("You must wait [round(required_delay / (1 MINUTES), 0.1)] minutes to respawn!"))
			return FALSE
		if(tgui_alert(usr, "You have been dead for [round(deathtime / (1 SECONDS), 1)] seconds out of required [round(required_delay / (1 MINUTES), 0.1)] minutes. Do you want to use your permissions to circumvent it?", "Respawn", list("Yes", "No")) != "Yes")
			return FALSE
	return TRUE
