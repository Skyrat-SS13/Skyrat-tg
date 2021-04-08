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

	for(var/mob/dead/new_player/N in GLOB.new_player_list)
		N.show_titlescreen()

