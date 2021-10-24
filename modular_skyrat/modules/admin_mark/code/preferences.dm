/datum/preferences
	/// The mark applied to this client; usually to denote information for ease of use
	var/admin_mark

/datum/preferences/proc/admin_mark_set(admin_mark)
	var/static/list/emoji
	if(!emoji)
		emoji = icon_states(icon(EMOJI_SET))
	if(!(admin_mark in emoji))
		tgui_alert(usr, "Invalid Mark")
		return
	src.admin_mark = admin_mark
	save_preferences()

/datum/preferences/proc/admin_mark_clear()
	admin_mark = null
	save_preferences()

/datum/preferences/proc/admin_mark_stat_who()
	if(!admin_mark)
		return ""
	return emoji_parse(":[admin_mark]:")

/datum/preferences/save_preferences()
	. = ..()
	if(!. || !admin_mark || !path)
		return
	var/savefile/sfile = new /savefile(path)
	if(!sfile)
		return
	sfile.cd = "/"
	WRITE_FILE(sfile["admin_mark"], admin_mark)

/datum/preferences/load_preferences()
	. = ..()
	if(!. || !path || !fexists(path))
		return
	var/savefile/sfile = new /savefile(path)
	if(!sfile)
		return
	sfile.cd = "/"
	READ_FILE(sfile["admin_mark"], admin_mark)
