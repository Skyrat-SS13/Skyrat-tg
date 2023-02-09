/mob/living/silicon/Topic(href, href_list)
	. = ..()
	if(href_list["lookup_info"] == "open_examine_panel")
		tgui.holder = src
		tgui.ui_interact(usr) //datum has a tgui component, here we open the window
