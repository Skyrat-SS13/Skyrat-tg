/mob/living/carbon/human/Topic(href, href_list)
	. = ..()
	if(href_list["lookup_info"])
		switch(href_list["lookup_info"])
			if("flavor_text")
				if(length(dna.features["flavor_text"]))
					var/datum/browser/popup = new(usr, "[name]'s flavor text", "[name]'s Flavor Text", 500, 200)
					popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s flavor text", replacetext(dna.features["flavor_text"], "\n", "<BR>")))
					popup.open()
					return

			if("ooc_prefs")
				if(client)
					var/str = "[src]'s OOC Notes : <br> <b>ERP :</b> [client.prefs.erp_pref] <b>| Non-Con :</b> [client.prefs.noncon_pref] <b>| Vore :</b> [client.prefs.vore_pref]"
					str += "<br>[html_encode(client.prefs.ooc_prefs)]"
					var/datum/browser/popup = new(usr, "[name]'s ooc info", "[name]'s OOC Information", 500, 200)
					popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s OOC information", replacetext(str, "\n", "<BR>")))
					popup.open()
					return

			if("general_record")
				if(client && usr.client.holder)
					var/datum/browser/popup = new(usr, "[name]'s gen rec", "[name]'s General Record", 500, 200)
					popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s general record", replacetext(client.prefs.general_record, "\n", "<BR>")))
					popup.open()
					return

			if("security_record")
				if(client && usr.client.holder)
					var/datum/browser/popup = new(usr, "[name]'s sec rec", "[name]'s Security Record", 500, 200)
					popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s security record", replacetext(client.prefs.security_record, "\n", "<BR>")))
					popup.open()
					return

			if("medical_record")
				if(client && usr.client.holder)
					var/datum/browser/popup = new(usr, "[name]'s med rec", "[name]'s Medical Record", 500, 200)
					popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s medical record", replacetext(client.prefs.medical_record, "\n", "<BR>")))
					popup.open()
					return

			if("background_info")
				if(client && usr.client.holder)
					var/datum/browser/popup = new(usr, "[name]'s flav bg", "[name]'s Background", 500, 200)
					popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s background flavor", replacetext(client.prefs.background_info, "\n", "<BR>")))
					popup.open()
					return

			if("exploitable_info")
				if(client && usr.client.holder)
					var/datum/browser/popup = new(usr, "[name]'s exp info", "[name]'s Exploitable Info", 500, 200)
					popup.set_content(text("<HTML><HEAD><TITLE>[]</TITLE></HEAD><BODY><TT>[]</TT></BODY></HTML>", "[name]'s exploitable information", replacetext(client.prefs.exploitable_info, "\n", "<BR>")))
					popup.open()
					return
