
/**
 * Enables an admin to upload a new titlescreen image.
 */
/client/proc/admin_change_title_screen()
	set category = "Admin.Fun"
	set name = "Title Screen: Change"

	if(!check_rights(R_FUN))
		return

	log_admin("[key_name(usr)] is changing the title screen.")
	message_admins("[key_name_admin(usr)] is changing the title screen.")

	switch(alert(usr, "Please select a new title screen.", "Title Screen", "Change", "Reset", "Cancel"))
		if("Change")
			var/file = input(usr) as icon|null
			if(!file)
				return
			change_title_screen(file)
		if("Reset")
			change_title_screen()
		if("Cancel")
			return

/**
 * Sets a titlescreen notice, a big red text on the main screen.
 */
/client/proc/change_title_screen_notice()
	set category = "Admin.Fun"
	set name = "Title Screen: Set Notice"

	if(!check_rights(R_FUN))
		return

	log_admin("[key_name(usr)] is setting the title screen notice.")
	message_admins("[key_name_admin(usr)] is setting the title screen notice.")

	var/new_notice = input(usr, "Please input a notice to be displayed on the title screen:", "Titlescreen Notice")
	if(!new_notice)
		set_title_screen_notice()
		return
	set_title_screen_notice(new_notice)
	for(var/mob/dead/new_player/new_player in GLOB.new_player_list)
		to_chat(new_player, span_boldannounce("TITLE NOTICE UPDATED: [new_notice]"))
		SEND_SOUND(new_player,  sound('modular_skyrat/modules/admin/sound/duckhonk.ogg'))

/**
 * Adds a startup message to the splashscreen.
 */
/proc/add_startup_message(msg)
	var/msg_dat = {"<p class="menu_b">[msg]</p>"}

	GLOB.startup_messages.Insert(1, msg_dat)

	for(var/mob/dead/new_player/iterating_new_player in GLOB.new_player_list)
		INVOKE_ASYNC(iterating_new_player, /mob/dead/new_player.proc/update_title_screen)

/**
 * Changes the title screen to a new image.
 */

/proc/change_title_screen(new_screen)
	if(new_screen)
		GLOB.current_title_screen = new_screen
	else
		if(LAZYLEN(GLOB.title_screens))
			GLOB.current_title_screen = pick(GLOB.title_screens)
		else
			GLOB.current_title_screen = DEFAULT_TITLE_SCREEN_IMAGE

	for(var/mob/dead/new_player/new_player in GLOB.new_player_list)
		INVOKE_ASYNC(new_player, /mob/dead/new_player.proc/show_title_screen)

/**
 * Adds a notice to the main title screen in the form of big red text!
 */
/proc/set_title_screen_notice(new_title)
	GLOB.current_title_screen_notice = new_title ? sanitize_text(new_title) : null

	for(var/mob/dead/new_player/new_player in GLOB.new_player_list)
		INVOKE_ASYNC(new_player, /mob/dead/new_player.proc/show_title_screen)

/**
 * Reloads the titlescreen if it is bugged for someone.
 */
/client/verb/fix_title_screen()
	set name = "Fix Lobby Screen"
	set desc = "Lobbyscreen broke? Press this."
	set category = "OOC"

	if(istype(mob, /mob/dead/new_player))
		var/mob/dead/new_player/new_player = mob
		new_player.show_title_screen()
	else
		winset(src, "title_browser", "is-disabled=true;is-visible=false")

/**
 * An admin debug command that enables you to change the HTML on the go.
 */
/client/proc/change_title_screen_html()
	set category = "Admin.Fun"
	set name = "Title Screen: Set HTML"

	if(!check_rights(R_DEBUG))
		return

	log_admin("[key_name(usr)] is setting the title screen HTML.")
	message_admins("[key_name_admin(usr)] is setting the title screen HTML.")

	var/new_html = input(usr, "Please enter your desired HTML(WARNING: YOU WILL BREAK SHIT)", "DANGER: TITLE HTML EDIT") as message|null

	if(!new_html)
		return

	GLOB.title_html = new_html

	for(var/mob/dead/new_player/new_player in GLOB.new_player_list)
		INVOKE_ASYNC(new_player, /mob/dead/new_player.proc/show_title_screen)

	message_admins("[key_name_admin(usr)] has changed the title screen HTML.")
