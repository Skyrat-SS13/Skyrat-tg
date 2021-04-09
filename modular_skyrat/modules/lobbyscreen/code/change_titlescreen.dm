/client/proc/change_title_screen()
	set category = "Admin.Fun"
	set name = "Title Screen: Change"

	if(!check_rights(R_FUN))
		return

	log_admin("[key_name(usr)] is changing the titlescreen.")
	message_admins("[key_name_admin(usr)] is changing the titlescreen.")

	switch(alert(usr, "Please select a new titlescreen.", "Title Screen", "Change", "Reset", "Cancel"))
		if("Change")
			var/file = input(usr) as icon|null
			if(!file)
				return
			change_lobbyscreen(file)
		if("Reset")
			change_lobbyscreen()
		if("Cancel")
			return

/client/proc/change_title_screen_notice()
	set category = "Admin.Fun"
	set name = "Title Screen: Set Notice"

	if(!check_rights(R_FUN))
		return

	log_admin("[key_name(usr)] is setting the titlescreen notice.")
	message_admins("[key_name_admin(usr)] is setting the titlescreen notice.")

	var/new_notice = input(usr, "Please input a notice to be displayed on the titlescreen:", "Titlescreen Notice")
	if(!new_notice)
		set_titlescreen_notice()
		return
	set_titlescreen_notice(new_notice)

