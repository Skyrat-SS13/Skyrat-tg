/mob/living/Topic(href, href_list)
	. = ..()
	if(href_list["temporary_flavor"])
		show_temp_ftext(usr)

/mob/living/proc/show_temp_ftext(mob/user)
	if(temporary_flavor_text)
		var/datum/browser/popup = new(user, "[name]'s temporary flavor text", "[name]'s Temporary Flavor Text", 500, 200)
		popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s temporary flavor text", replacetext(temporary_flavor_text, "\n", "<BR>")))
		popup.open()
		return
