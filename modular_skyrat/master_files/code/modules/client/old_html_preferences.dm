/datum/preferences/proc/ShowLangMenu(mob/user)
	var/list/dat = list()
	dat += "<center><b>Choose your languages:</b></center><br>"
	dat += "Availability of the languages to choose from depends on your background. If you can't unlearn one, it means it is required for your background."
	dat += "<BR><center><a href='?_src_=prefs;task=close_language'>Done</a></center>"
	dat += "<hr>"
	var/current_ling_points = get_linguistic_points()
	dat += "<b>Linguistic Points remaining: [current_ling_points]</b>"
	dat += "<table width='100%' align='center'><tr>"
	dat += "<td width=10%></td>"
	dat += "<td width=60%></td>"
	dat += "<td width=10%></td>"
	dat += "<td width=10%></td>"
	dat += "<td width=10%></td>"
	dat += "</tr>"
	var/list/avail_langs = get_available_languages()
	var/list/req_langs = get_required_languages()
	var/even = TRUE
	var/background_cl
	for(var/lang_path in avail_langs)
		even = !even
		var/datum/language/lang_datum = lang_path
		var/required = (req_langs[lang_path] ? TRUE : FALSE)
		if(even)
			background_cl = (required ? "#7A5A00" : "#17191C")
		else
			background_cl = (required ? "#856200" : "#23273C")
		var/language_skill = 0
		if(languages[lang_path])
			language_skill = languages[lang_path]
		var/unlearn_button
		if(language_skill && !required)
			unlearn_button = "<a href='?_src_=prefs;lang=[lang_path];level=0;preference=language;task=input'>Unlearn</a>"
		else
			unlearn_button = "<span class='linkOff'>Unlearn</span>"
		var/understood_button
		if(languages[lang_path])
			//Has a href in case you want to downgrade from spoken to understood
			understood_button = "<a class='linkOn' href='?_src_=prefs;lang=[lang_path];level=1;preference=language;task=input'>Understood</a>"
		else if(can_buy_language(lang_path, LANGUAGE_UNDERSTOOD))
			understood_button = "<a href='?_src_=prefs;lang=[lang_path];level=1;preference=language;task=input'>Understood</a>"
		else
			understood_button = "<span class='linkOff'>Understood</span>"
		var/spoken_button
		if(languages[lang_path] >= LANGUAGE_SPOKEN)
			spoken_button = "<a class='linkOn' href='?_src_=prefs;lang=[lang_path];level=2;preference=language;task=input'>Spoken</a>"
		else if(can_buy_language(lang_path, LANGUAGE_SPOKEN))
			spoken_button = "<a href='?_src_=prefs;lang=[lang_path];level=2;preference=language;task=input'>Spoken</a>"
		else
			spoken_button = "<span class='linkOff'>Spoken</span>"
		dat += "<tr style='background-color: [background_cl]'>"
		dat += "<td><b>[initial(lang_datum.name)]</b></td>"
		dat += "<td><i>[initial(lang_datum.desc)]</i></td>"
		dat += "<td>[unlearn_button]</td>"
		dat += "<td>[understood_button]</td>"
		dat += "<td>[spoken_button]</td>"
		dat += "</tr>"
	dat += "<table>"
	var/datum/browser/popup = new(user, "culture_lang", "<div align='center'>Language Choice</div>", 900, 600)
	popup.set_window_options("can_close=0")
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/Topic(href, list/href_list)
	. = ..()
	switch(href_list["task"])
		if("close_language")
			usr << browse(null, "window=culture_lang")

		if("language")
			var/target_lang = text2path(href_list["lang"])
			var/level = text2num(href_list["level"])
			var/required_lang = get_required_languages()
			if(required_lang[target_lang]) //Can't do anything to a required language
				return TRUE
			var/opt_langs = get_optional_languages()
			if(!opt_langs[target_lang])
				return TRUE
			if(!level)
				languages -= target_lang
			else if(can_buy_language(target_lang, level))
				languages[target_lang] = level
			ShowLangMenu(usr)
			return TRUE

		if("language_button")
			ShowLangMenu(usr)
			return TRUE
