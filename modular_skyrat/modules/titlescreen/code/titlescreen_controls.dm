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
	for(var/mob/dead/new_player/new_player in GLOB.new_player_list)
		to_chat(new_player, span_boldannounce("TITLE NOTICE UPDATED: [new_notice]"))
		SEND_SOUND(new_player,  sound('modular_skyrat/modules/admin/sound/duckhonk.ogg'))

/proc/add_startupmessage(msg)
	var/msg_dat = {"<p class="menu_b">[msg]</p>"}

	GLOB.startup_messages.Insert(1, msg_dat)

	for(var/mob/dead/new_player/iterating_new_player in GLOB.new_player_list)
		INVOKE_ASYNC(iterating_new_player, /mob/dead/new_player.proc/update_titlescreen)

/proc/change_lobbyscreen(new_screen)
	if(new_screen)
		GLOB.current_lobby_screen = new_screen
	else
		if(GLOB.lobby_screens.len)
			GLOB.current_lobby_screen = pick(GLOB.lobby_screens)
		else
			GLOB.current_lobby_screen = 'modular_skyrat/modules/lobbyscreen/icons/skyrat_lobbyscreen.png'

	for(var/mob/dead/new_player/new_player in GLOB.new_player_list)
		INVOKE_ASYNC(new_player, /mob/dead/new_player.proc/show_titlescreen)

/proc/set_titlescreen_notice(new_title)
	if(new_title)
		GLOB.current_lobbyscreen_notice = sanitize_text(new_title)
	else
		GLOB.current_lobbyscreen_notice = null

	for(var/mob/dead/new_player/new_player in GLOB.new_player_list)
		INVOKE_ASYNC(new_player, /mob/dead/new_player.proc/show_titlescreen)

/client/verb/fix_lobbyscreen()
	set name = "Fix Lobbyscreen"
	set desc = "Lobbyscreen broke? Press this."
	set category = "OOC"

	if(istype(mob, /mob/dead/new_player))
		var/mob/dead/new_player/new_player = mob
		new_player.show_titlescreen()
	else
		winset(src, "lobbybrowser", "is-disabled=true;is-visible=false")

/client/proc/change_title_screen_html()
	set category = "Admin.Fun"
	set name = "Title Screen: Set HTML"

	if(!check_rights(R_FUN))
		return

	log_admin("[key_name(usr)] is setting the titlescreen HTML.")
	message_admins("[key_name_admin(usr)] is setting the titlescreen HTML.")

	var/new_html = input(usr, "Please enter your desired HTML(WARNING: YOU WILL BREAK SHIT)", "DANGER: LOBBY HTML EDIT") as message|null

	if(!new_html)
		return

	GLOB.lobby_html = new_html

	for(var/mob/dead/new_player/new_player in GLOB.new_player_list)
		INVOKE_ASYNC(new_player, /mob/dead/new_player.proc/show_titlescreen)

	message_admins("[key_name_admin(usr)] has changed the titlescreen HTML.")
