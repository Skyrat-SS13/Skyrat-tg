//SKYRAT MODULE SHUTTLE_TOGGLE

//SHUTTLE CONTROL (SHUTTLE TOGGLE)
/client/proc/admin_disable_shuttle()
	set category = "Admin"
	set name = "Disable Shuttle"
	if(!check_rights(R_ADMIN))	return

	if(SSshuttle.emergency.mode == SHUTTLE_DISABLED)
		to_chat(usr, "<span class='warning'>Error, shuttle is already disabled.</span>")
		return

	if(alert(src, "You sure?", "Confirm", "Yes", "No") != "Yes") return

	message_admins("<span class='adminnotice'>[key_name_admin(usr)] disabled the shuttle.</span>")

	SSshuttle.lastMode = SSshuttle.emergency.mode
	SSshuttle.lastCallTime = SSshuttle.emergency.timeLeft(1)
	SSshuttle.adminEmergencyNoRecall = TRUE
	SSshuttle.emergency.setTimer(null)
	SSshuttle.emergency.mode = SHUTTLE_DISABLED
	priority_announce("Warning: Emergency Shuttle uplink failure, shuttle disabled until further notice.", "Emergency Shuttle Uplink Alert", 'sound/misc/announce_dig.ogg')

/client/proc/admin_enable_shuttle()
	set category = "Admin"
	set name = "Enable Shuttle"
	if(!check_rights(R_ADMIN))	return

	if(SSshuttle.emergency.mode != SHUTTLE_DISABLED)
		to_chat(usr, "<span class='warning'>Error, shuttle not disabled.</span>")
		return

	if(alert(src, "You sure?", "Confirm", "Yes", "No") != "Yes") return

	message_admins("<span class='adminnotice'>[key_name_admin(usr)] enabled the emergency shuttle.</span>")
	SSshuttle.adminEmergencyNoRecall = FALSE
	SSshuttle.emergencyNoRecall = FALSE
	if(SSshuttle.lastMode == SHUTTLE_DISABLED) //If everything goes to shit, fix it.
		SSshuttle.lastMode = SHUTTLE_IDLE

	SSshuttle.emergency.mode = SSshuttle.lastMode
	if(SSshuttle.lastCallTime < 100 && SSshuttle.lastMode != SHUTTLE_IDLE)
		SSshuttle.lastCallTime = 100 //Make sure no insta departures.
	SSshuttle.emergency.setTimer(SSshuttle.lastCallTime)
	priority_announce("Warning: Emergency Shuttle uplink reestablished, shuttle enabled.", "Emergency Shuttle Uplink Alert", 'sound/misc/announce_dig.ogg')

/client/proc/admin_call_shuttle()
	set category = "Admin"
	set name = "Call Shuttle"

	if(EMERGENCY_AT_LEAST_DOCKED)
		return

	if(!check_rights(R_ADMIN))	return

	var/confirm = alert(src, "You sure?", "Confirm", "Yes", "Yes (No Recall)", "No")
	if(confirm == "No")
		return

	if(confirm == "Yes (No Recall)")
		SSshuttle.adminEmergencyNoRecall = TRUE
		SSshuttle.emergency.mode = SHUTTLE_IDLE

	SSshuttle.emergency.request()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Call Shuttle") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	log_admin("[key_name(usr)] admin-called the emergency shuttle.")
	if(confirm == "Yes (No Recall)")
		message_admins("<span class='adminnotice'>[key_name_admin(usr)] admin-called the emergency shuttle (non-recallable).</span>")
	else
		message_admins("<span class='adminnotice'>[key_name_admin(usr)] admin-called the emergency shuttle.</span>")
	return

/client/proc/admin_cancel_shuttle()
	set category = "Admin"
	set name = "Cancel Shuttle"
	if(!check_rights(0))
		return
	if(alert(src, "You sure?", "Confirm", "Yes", "No") != "Yes")
		return

	if(SSshuttle.adminEmergencyNoRecall)
		SSshuttle.adminEmergencyNoRecall = FALSE

	if(EMERGENCY_AT_LEAST_DOCKED)
		return

	SSshuttle.emergency.cancel()
	SSblackbox.record_feedback("tally", "admin_verb", 1, "Cancel Shuttle") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
	log_admin("[key_name(usr)] admin-recalled the emergency shuttle.")
	message_admins("<span class='adminnotice'>[key_name_admin(usr)] admin-recalled the emergency shuttle.</span>")

//SHUTTLE CONTROL END
