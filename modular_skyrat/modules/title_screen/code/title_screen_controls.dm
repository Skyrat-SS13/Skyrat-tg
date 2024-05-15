
/**
 * Enables an admin to upload a new titlescreen image.
 */
ADMIN_VERB(admin_change_title_screen, R_FUN, "Title Screen: Change", "Upload a new titlescreen image.", ADMIN_CATEGORY_FUN)
	log_admin("[key_name(user)] is changing the title screen.")
	message_admins("[key_name_admin(user)] is changing the title screen.")

	switch(alert(usr, "Please select a new title screen.", "Title Screen", "Change", "Reset", "Cancel"))
		if("Change")
			var/file = input(user) as icon|null
			if(!file)
				return
			SStitle.change_title_screen(file)
		if("Reset")
			SStitle.change_title_screen()
		if("Cancel")
			return

/**
 * Sets a titlescreen notice, a big red text on the main screen.
 */
ADMIN_VERB(change_title_screen_notice, R_FUN, "Title Screen: Set Notice", "Sets a titlescreen notice, a big red text on the main screen.", ADMIN_CATEGORY_FUN)
	log_admin("[key_name(usr)] is setting the title screen notice.")
	message_admins("[key_name_admin(usr)] is setting the title screen notice.")

	var/new_notice = input(usr, "Please input a notice to be displayed on the title screen:", "Titlescreen Notice") as text|null
	SStitle.set_notice(new_notice)
	if(!new_notice)
		return
	for(var/mob/dead/new_player/new_player in GLOB.new_player_list)
		to_chat(new_player, span_boldannounce("TITLE NOTICE UPDATED: [new_notice]"))
		SEND_SOUND(new_player,  sound('modular_skyrat/modules/admin/sound/duckhonk.ogg'))

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
		winset(src, "status_bar", "is-visible=true")

/**
 * An admin debug command that enables you to change the HTML on the go.
 */
ADMIN_VERB(change_title_screen_html, R_DEBUG, "Title Screen: Set HTML", "Change lobby screen HTML on the go.", ADMIN_CATEGORY_FUN)
	log_admin("[key_name(user)] is setting the title screen HTML.")
	message_admins("[key_name_admin(user)] is setting the title screen HTML.")

	var/new_html = input(usr, "Please enter your desired HTML(WARNING: YOU WILL BREAK SHIT)", "DANGER: TITLE HTML EDIT") as message|null

	if(!new_html)
		return

	SStitle.title_html = new_html
	SStitle.show_title_screen()

	message_admins("[key_name_admin(user)] has changed the title screen HTML.")
