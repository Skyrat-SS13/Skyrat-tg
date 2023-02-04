<<<<<<< HEAD
/client/proc/cmd_admin_toggle_fov()
	set name = "Enable/Disable Field of View"
	set category = "Debug"

	if(!check_rights(R_ADMIN) || !check_rights(R_DEBUG))
		return

=======
ADMIN_VERB(debug, toggle_field_of_view, "Toggle Field of View", "", (R_ADMIN|R_DEBUG))
>>>>>>> fca90f5c78b (Redoes the admin verb define to require passing in an Admin Visible Name, and restores the usage of '-' for the verb bar when you want to call verbs from the command bar. Also cleans up and organizes the backend for drawing verbs to make it easier in the future for me to make it look better (#73214))
	var/on_off = CONFIG_GET(flag/native_fov)

	message_admins("[key_name_admin(usr)] has [on_off ? "disabled" : "enabled"] the Native Field of View configuration..")
	log_admin("[key_name(usr)] has [on_off ? "disabled" : "enabled"] the Native Field of View configuration.")
	CONFIG_SET(flag/native_fov, !on_off)

	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggled Field of View", "[on_off ? "Enabled" : "Disabled"]"))

	for(var/mob/living/mob in GLOB.player_list)
		mob.update_fov()
