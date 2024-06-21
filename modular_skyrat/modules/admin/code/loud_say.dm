ADMIN_VERB(cmd_loud_admin_say, R_NONE, "loudAsay", "Send a message to other admins (loudly).", ADMIN_CATEGORY_MAIN, msg as text)
	msg = emoji_parse(copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN))
	if(!msg)
		return

	msg = emoji_parse(msg)
	user.mob.log_talk(msg, LOG_ASAY)

	send_asay_to_other_server(user.ckey, span_command_headset(msg))

	msg = keywords_lookup(msg)
	var/custom_asay_color = (CONFIG_GET(flag/allow_admin_asaycolor) && user.mob.client?.prefs?.read_preference(/datum/preference/color/asay_color)) ? "<font color=[user.mob.client?.prefs?.read_preference(/datum/preference/color/asay_color)]>" : "<font color='#FF4500'>"
	msg = span_command_headset("<span class='adminsay'><span class='prefix'>ADMIN:</span> <EM>[key_name(user, 1)]</EM> [ADMIN_FLW(user.mob)]: [custom_asay_color]<span class='message linkify'>[msg]</span></span></span>[custom_asay_color ? "</font>":null]")

	to_chat(GLOB.admins,
		type = MESSAGE_TYPE_ADMINCHAT,
		html = msg,
		confidential = TRUE)

	for(var/client/admin_client in GLOB.admins)
		if(admin_client?.prefs?.toggles & SOUND_ADMINHELP)
			SEND_SOUND(admin_client, sound('modular_skyrat/modules/admin/sound/duckhonk.ogg')) //Stop using loud mode if you don't need to.
		window_flash(admin_client, ignorepref = TRUE)

	SSblackbox.record_feedback("tally", "admin_verb", 1, "loudAsay") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!
