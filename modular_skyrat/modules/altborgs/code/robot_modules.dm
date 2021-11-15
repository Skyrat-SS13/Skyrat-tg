/obj/item/robot_model/proc/dogborg_equip()
	cyborg_pixel_offset = -16
	hat_offset = INFINITY
	var/mob/living/silicon/robot/cyborg = loc
	add_verb(cyborg , /mob/living/silicon/robot/proc/robot_lay_down)
	add_verb(cyborg , /mob/living/silicon/robot/proc/rest_style)
	rebuild_modules()

//ROBOT ADDITIONAL MODULES

//STANDARD
/obj/item/robot_model/standard/be_transformed_to(obj/item/robot_model/old_model)
	var/mob/living/silicon/robot/cyborg = loc
	var/static/list/standard_icons = list(
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "robot"),
		"Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "marinasd"),
		"Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "heavysd"),
		"Eyebot" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "eyebotsd"),
		"Robot" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "robot_old"),
		"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "bootysd"),
		"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "male_bootysd"),
		"Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "protectron_standard"),
		"Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "missm_sd")
		)
	var/list/L = list("Partyhound" = "k69")
	for(var/a in L)
		var/image/wide = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi', icon_state = L[a])
		wide.pixel_x = -16
		standard_icons[a] = wide
	standard_icons = sort_list(standard_icons)
	var/standard_borg_icon = show_radial_menu(cyborg, cyborg , standard_icons, custom_check = CALLBACK(src, .proc/check_menu, cyborg, old_model), radius = 42, require_near = TRUE)
	switch(standard_borg_icon)
		if("Default")
			cyborg_base_icon = "robot"
			model_features = list(R_TRAIT_SMALL)
		if("Marina")
			cyborg_base_icon = "marinasd"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK)
		if("Heavy")
			cyborg_base_icon = "heavysd"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK)
		if("Eyebot")
			cyborg_base_icon = "eyebotsd"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
		if("Robot")
			cyborg_base_icon = "robot_old"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK)
		if("Bootyborg")
			cyborg_base_icon = "bootysd"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
		if("Male Bootyborg")
			cyborg_base_icon = "male_bootysd"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
		if("Protectron")
			cyborg_base_icon = "protectron_standard"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
		if("Miss M")
			cyborg_base_icon = "missm_sd"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
		//Dogborgs
		if("Partyhound")
			cyborg_base_icon = "k69"
			sleeper_overlay = "k9sleeper"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		else
			return FALSE
	return ..()

//ENGINEERING
/obj/item/robot_model/engineering/be_transformed_to(obj/item/robot_model/old_model)
	var/mob/living/silicon/robot/cyborg = loc
	var/static/list/engi_icons
	if(!engi_icons)
		engi_icons = list(
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "engineer"),
		"Default - Treads" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "engi-tread"),
		"Loader" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "loaderborg"),
		"Handy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "handyeng"),
		"Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "sleekeng"),
		"Can" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "caneng"),
		"Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "marinaeng"),
		"Spider" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "spidereng"),
		"Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "heavyeng"),
		"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "bootyeng"),
		"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "male_bootyeng"),
		"Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "protectron_eng"),
		"Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "missm_eng"),
		"Zoomba" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "zoomba_engi"),
		"Eyebot" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "eyeboteng"),
		"Mech" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "conagher"),
		"Wide" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "wide-engi"),
		"Drake" = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi', icon_state = "drakeengbox")
		)
		var/list/L = list("Pup Dozer" = "pupdozer", "Vale" = "valeeng", "Hound" = "engihound", "Darkhound" = "engihounddark", "Borgi" = "borgi-eng", "Otie" = "otiee")
		for(var/a in L)
			var/image/wide = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi', icon_state = L[a])
			wide.pixel_x = -16
			engi_icons[a] = wide
		engi_icons = sort_list(engi_icons)
	var/engi_borg_icon = show_radial_menu(cyborg, cyborg , engi_icons, custom_check = CALLBACK(src, .proc/check_menu, cyborg, old_model), radius = 42, require_near = TRUE)
	switch(engi_borg_icon)
		if("Default")
			cyborg_base_icon = "engineer"
			model_features = list(R_TRAIT_SMALL)
		if("Zoomba")
			cyborg_base_icon = "zoomba_engi"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
		if("Default - Treads")
			cyborg_base_icon = "engi-tread"
			special_light_key = "engineer"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
		if("Loader")
			cyborg_base_icon = "loaderborg"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK)
		if("Handy")
			cyborg_base_icon = "handyeng"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
		if("Sleek")
			cyborg_base_icon = "sleekeng"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
		if("Can")
			cyborg_base_icon = "caneng"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
		if("Marina")
			cyborg_base_icon = "marinaeng"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
		if("Spider")
			cyborg_base_icon = "spidereng"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
		if("Heavy")
			cyborg_base_icon = "heavyeng"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
		if("Bootyborg")
			cyborg_base_icon = "bootyeng"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
		if("Male Bootyborg")
			cyborg_base_icon = "male_bootyeng"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
		if("Protectron")
			cyborg_base_icon = "protectron_eng"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
		if("Miss M")
			cyborg_base_icon = "missm_eng"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
		if("Mech")
			cyborg_base_icon = "conagher"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
		if("Wide")
			cyborg_base_icon = "wide-engi"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
		if("Eyebot")
			cyborg_base_icon = "eyeboteng"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
		//Dogborgs
		if("Pup Dozer")
			cyborg_base_icon = "pupdozer"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
			sleeper_overlay = "dozersleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Vale")
			cyborg_base_icon = "valeeng"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
			sleeper_overlay = "valeengsleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Hound")
			cyborg_base_icon = "engihound"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
			sleeper_overlay = "engihoundsleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Darkhound")
			cyborg_base_icon = "engihounddark"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
			sleeper_overlay = "engihounddarksleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Alina")
			cyborg_base_icon = "alina-eng"
			special_light_key = "alina"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
			sleeper_overlay = "alinasleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Drake")
			cyborg_base_icon = "drakeeng"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
			sleeper_overlay = "drakesecsleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Borgi")
			cyborg_base_icon = "borgi-eng"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
			sleeper_overlay = "borgi-eng-sleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL)
		if("Otie")
			cyborg_base_icon = "otiee"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
			sleeper_overlay = "otiee-sleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		else
			return FALSE
	return ..()

//SECURITY
/obj/item/robot_model/security/be_transformed_to(obj/item/robot_model/old_model)
	var/mob/living/silicon/robot/cyborg = loc
	var/static/list/sec_icons
	if(!sec_icons)
		sec_icons = list(
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "sec"),
		"Default - Treads" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "sec-tread"),
		"Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "sleeksec"),
		"Can" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "cansec"),
		"Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "marinasec"),
		"Spider" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "spidersec"),
		"Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "heavysec"),
		"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "bootysecurity"),
		"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "male_bootysecurity"),
		"Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "protectron_security"),
		"Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "missm_security"),
		"Zoomba" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "zoomba_sec"),
		"Eyebot" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "eyebotsec"),
		"Insekt" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "insekt-Sec"),
		"Mech" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "woody"),
		"Drake" = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi', icon_state = "drakesecbox")
		)
		var/list/L = list("Hound" = "k9", "Vale" = "valesec", "Darkhound" = "k9dark", "Otie" = "oties", "Borgi" = "borgi-sec")
		for(var/a in L)
			var/image/wide = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi', icon_state = L[a])
			wide.pixel_x = -16
			sec_icons[a] = wide
		sec_icons = sort_list(sec_icons)
	var/sec_borg_icon = show_radial_menu(cyborg, cyborg , sec_icons, custom_check = CALLBACK(src, .proc/check_menu, cyborg, old_model), radius = 42, require_near = TRUE)
	switch(sec_borg_icon)
		if("Default")
			cyborg_base_icon = "sec"
		if("Zoomba")
			cyborg_base_icon = "zoomba_sec"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
		if("Default - Treads")
			cyborg_base_icon = "sec-tread"
			special_light_key = "sec"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
		if("Sleek")
			cyborg_base_icon = "sleeksec"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
		if("Marina")
			cyborg_base_icon = "marinasec"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
		if("Can")
			cyborg_base_icon = "cansec"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
		if("Spider")
			cyborg_base_icon = "spidersec"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
		if("Heavy")
			cyborg_base_icon = "heavysec"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
		if("Bootyborg")
			cyborg_base_icon = "bootysecurity"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
		if("Male Bootyborg")
			cyborg_base_icon = "male_bootysecurity"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
		if("Protectron")
			cyborg_base_icon = "protectron_security"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
		if("Miss M")
			cyborg_base_icon = "missm_security"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
		if("Eyebot")
			cyborg_base_icon = "eyebotsec"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
		if("Insekt")
			cyborg_base_icon = "insekt-Sec"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
		if("Mech")
			cyborg_base_icon = "woody"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
		//Dogborgs
		if("Hound")
			cyborg_base_icon = "k9"
			sleeper_overlay = "ksleeper"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Otie")
			cyborg_base_icon = "oties"
			sleeper_overlay = "otiessleeper"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Alina")
			cyborg_base_icon = "alina-sec"
			special_light_key = "alina"
			sleeper_overlay = "alinasleeper"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Darkhound")
			cyborg_base_icon = "k9dark"
			sleeper_overlay = "k9darksleeper"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Vale")
			cyborg_base_icon = "valesec"
			sleeper_overlay = "valesecsleeper"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Drake")
			cyborg_base_icon = "drakesec"
			sleeper_overlay = "drakesecsleeper"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Borgi")
			cyborg_base_icon = "borgi-sec"
			sleeper_overlay = "borgi-sec-sleeper"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL)
		else
			return FALSE
	return ..()

//PEACEKEEPER
/obj/item/robot_model/peacekeeper/be_transformed_to(obj/item/robot_model/old_model)
	var/mob/living/silicon/robot/cyborg = loc
	var/static/list/peace_icons
	if(!peace_icons)
		peace_icons = list(
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "peace"),
		"Spider" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "whitespider"),
		"Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "sleekpeace"),
		"Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "marinapeace"),
		"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "bootypeace"),
		"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "male_bootypeace"),
		"Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "protectron_peacekeeper"),
		"Omni" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "omoikane"),
		"Insekt" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "insekt-Default"),
		"Drake" = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_pk.dmi', icon_state = "drakepeacebox")
		)
		var/list/L = list("Borgi" = "borgi", "Vale" = "valepeace")
		for(var/a in L)
			var/image/wide = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_pk.dmi', icon_state = L[a])
			wide.pixel_x = -16
			peace_icons[a] = wide
		peace_icons = sort_list(peace_icons)
	var/peace_borg_icon = show_radial_menu(cyborg, cyborg , peace_icons, custom_check = CALLBACK(src, .proc/check_menu, cyborg, old_model), radius = 42, require_near = TRUE)
	switch(peace_borg_icon)
		if("Default")
			cyborg_base_icon = "peace"
		if("Sleek")
			cyborg_base_icon = "sleekpeace"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK)
		if("Spider")
			cyborg_base_icon = "whitespider"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
			model_features = list(R_TRAIT_SMALL)
		if("Marina")
			cyborg_base_icon = "marinapeace"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK)
		if("Bootyborg")
			cyborg_base_icon = "bootypeace"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
		if("Male Bootyborg")
			cyborg_base_icon = "male_bootypeace"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
		if("Protectron")
			cyborg_base_icon = "protectron_peacekeeper"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
		if("Insekt")
			cyborg_base_icon = "insekt-Default"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
		if("Omni")
			cyborg_base_icon = "omoikane"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
			model_features = list(R_TRAIT_SMALL) //No tennis-ball sized cyborgs.
		//Dogborgs
		if("Drake")
			cyborg_base_icon = "drakepeace"
			sleeper_overlay = "drakepeacesleeper"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_pk.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Borgi")
			cyborg_base_icon = "borgi"
			sleeper_overlay = "borgi-sleeper"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_pk.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL)
		if("Vale")
			cyborg_base_icon = "valepeace"
			sleeper_overlay = "valepeace-sleeper"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_pk.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		else
			return FALSE
	return ..()

//JANITOR
/obj/item/robot_model/janitor/be_transformed_to(obj/item/robot_model/old_model)
	var/mob/living/silicon/robot/cyborg = loc
	var/static/list/janitor_icons
	if(!janitor_icons)
		janitor_icons = list(
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "janitor"),
		"Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "marinajan"),
		"Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "sleekjan"),
		"Can" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "canjan"),
		"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "bootyjanitor"),
		"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "male_bootyjanitor"),
		"Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "protectron_janitor"),
		"Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "missm_janitor"),
		"Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "heavyres"),
		"Zoomba" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "zoomba_jani"),
		"Mech" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "flynn"),
		"Eyebot" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "eyebotjani"),
		"Insekt" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "insekt-Sci"),
		"Wide" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "wide-jani"),
		"Spider" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "spidersci"),
		"Drake" = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_jani.dmi', icon_state = "drakejanitbox")
		)
		var/list/L = list("Otie" = "otiej", "Scrubpuppy" = "scrubpup", "Vale" = "J9", "Borgi" = "borgi-jani")
		for(var/a in L)
			var/image/wide = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_jani.dmi', icon_state = L[a])
			wide.pixel_x = -16
			janitor_icons[a] = wide
		janitor_icons = sort_list(janitor_icons)
	var/janitor_robot_icon = show_radial_menu(cyborg, cyborg , janitor_icons, custom_check = CALLBACK(src, .proc/check_menu, cyborg, old_model), radius = 42, require_near = TRUE)
	switch(janitor_robot_icon)
		if("Default")
			cyborg_base_icon = "janitor"
		if("Zoomba")
			cyborg_base_icon = "zoomba_jani"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
		if("Marina")
			cyborg_base_icon = "marinajan"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi'
		if("Sleek")
			cyborg_base_icon = "sleekjan"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi'
		if("Can")
			cyborg_base_icon = "canjan"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi'
		if("Heavy")
			cyborg_base_icon = "heavyres"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi'
		if("Bootyborg")
			cyborg_base_icon = "bootyjanitor"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi'
		if("Male Bootyborg")
			cyborg_base_icon = "male_bootyjanitor"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi'
		if("Protectron")
			cyborg_base_icon = "protectron_janitor"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi'
		if("Miss M")
			cyborg_base_icon = "missm_janitor"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi'
		if("Mech")
			cyborg_base_icon = "flynn"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi'
		if("Eyebot")
			cyborg_base_icon = "eyebotjani"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
		if("Insekt")
			cyborg_base_icon = "insekt-Sci"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi'
		if("Wide")
			cyborg_base_icon = "wide-jani"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi'
		if("Spider")
			cyborg_base_icon = "spidersci"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi'
		//Dogborgs
		if("Scrubpuppy")
			cyborg_base_icon = "scrubpup"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_jani.dmi'
			sleeper_overlay = "jsleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Otie")
			cyborg_base_icon = "otiej"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_jani.dmi'
			sleeper_overlay = "otiejsleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Drake")
			cyborg_base_icon = "drakejanit"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_jani.dmi'
			sleeper_overlay = "drakesecsleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Vale")
			cyborg_base_icon = "J9"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_jani.dmi'
			sleeper_overlay = "J9-sleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Borgi")
			cyborg_base_icon = "borgi-jani"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_jani.dmi'
			sleeper_overlay = "borgi-jani-sleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL)
		else
			return FALSE
	return ..()

//CLOWN
/obj/item/robot_model/clown/be_transformed_to(obj/item/robot_model/old_model)
	var/mob/living/silicon/robot/cyborg = loc
	var/static/list/clown_icons = sort_list(list(
		"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "clown"),
		"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi', icon_state = "bootyclown"),
		"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi', icon_state = "male_bootyclown"),
		"Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi', icon_state = "marina_mommy"),
		"Garish" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi', icon_state = "garish"),
		"Robot" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi', icon_state = "clownbot"),
		"Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi', icon_state = "clownman")
		))
	var/clown_borg_icon = show_radial_menu(cyborg, cyborg , clown_icons, custom_check = CALLBACK(src, .proc/check_menu, cyborg, old_model), radius = 42, require_near = TRUE)
	switch(clown_borg_icon)
		if("Default")
			cyborg_base_icon = "clown"
		if("Bootyborg")
			cyborg_base_icon = "bootyclown"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi'
		if("Male Bootyborg")
			cyborg_base_icon = "male_bootyclown"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi'
		if("Marina")
			cyborg_base_icon = "marina_mommy"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK)
		if("Garish")
			cyborg_base_icon = "garish"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi'
		if("Robot")
			cyborg_base_icon = "clownbot"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi'
		if("Sleek")
			cyborg_base_icon = "clownman"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK)
		else
			return FALSE
	return ..()

//SERVICE
/obj/item/robot_model/service/skyrat/be_transformed_to(obj/item/robot_model/old_model)
	var/mob/living/silicon/robot/cyborg = loc
	var/static/list/service_icons
	if(!service_icons)
		service_icons = list(
		"Waitress" = image(icon = 'icons/mob/robots.dmi', icon_state = "service_f"),
		"Butler" = image(icon = 'icons/mob/robots.dmi', icon_state = "service_m"),
		"Bro" = image(icon = 'icons/mob/robots.dmi', icon_state = "brobot"),
		"Can" = image(icon = 'icons/mob/robots.dmi', icon_state = "kent"),
		"Tophat" = image(icon = 'icons/mob/robots.dmi', icon_state = "tophat"),
		"Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "sleekserv"),
		"Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "heavyserv"),
		"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "bootyservice"),
		"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "male_bootyservice"),
		"Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "protectron_service"),
		"Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "missm_service"),
		"Zoomba" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "zoomba_green"),
		"Mech" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "lloyd"),
		"Handy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "handy-service")
		)
		var/list/L = list("Darkhound" = "k50", "Vale" = "valeserv", "ValeDark" = "valeservdark", "Partyhound" = "k69", "Borgi" = "borgi-serv")
		for(var/a in L)
			var/image/wide = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi', icon_state = L[a])
			wide.pixel_x = -16
			service_icons[a] = wide
		service_icons = sort_list(service_icons)
	var/service_robot_icon = show_radial_menu(cyborg, cyborg , service_icons, custom_check = CALLBACK(src, .proc/check_menu, cyborg, old_model), radius = 42, require_near = TRUE)
	switch(service_robot_icon)
		if("Waitress")
			cyborg_base_icon = "service_f"
			special_light_key = "service"
		if("Butler")
			cyborg_base_icon = "service_m"
			special_light_key = "service"
		if("Bro")
			cyborg_base_icon = "brobot"
			special_light_key = "service"
		if("Can")
			cyborg_base_icon = "kent"
			special_light_key = "medical"
			hat_offset = 3
		if("Tophat")
			cyborg_base_icon = "tophat"
			special_light_key = null
			hat_offset = INFINITY
		if("Sleek")
			cyborg_base_icon = "sleekserv"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
		if("Heavy")
			cyborg_base_icon = "heavyserv"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
		if("Bootyborg")
			cyborg_base_icon = "bootyservice"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
		if("Male Bootyborg")
			cyborg_base_icon = "male_bootyservice"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
		if("Protectron")
			cyborg_base_icon = "protectron_service"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
		if("Miss M")
			cyborg_base_icon = "missm_service"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
		if("Zoomba")
			cyborg_base_icon = "zoomba_green"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
			model_features = list(model_features = R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
		if("Mech")
			cyborg_base_icon = "lloyd"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
		if("Handy")
			cyborg_base_icon = "handy-service"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
		//Dogborgs
		if("Darkhound")
			cyborg_base_icon = "k50"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi'
			sleeper_overlay = "ksleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Vale")
			cyborg_base_icon = "valeserv"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi'
			sleeper_overlay = "valeservsleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("ValeDark")
			cyborg_base_icon = "valeservdark"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi'
			sleeper_overlay = "valeservsleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Partyhound")
			cyborg_base_icon = "k69"
			sleeper_overlay = "k9sleeper"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Borgi")
			cyborg_base_icon = "borgi-serv"
			sleeper_overlay = "borgi-sleeper"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL)
		else
			return FALSE
	return TRUE

//MINING
/obj/item/robot_model/miner/skyrat/be_transformed_to(obj/item/robot_model/old_model)
	var/mob/living/silicon/robot/cyborg = loc
	var/static/list/mining_icons
	if(!mining_icons)
		mining_icons = list(
		"Lavaland" = image(icon = 'icons/mob/robots.dmi', icon_state = "miner"),
		"Asteroid" = image(icon = 'icons/mob/robots.dmi', icon_state = "minerOLD"),
		"Droid" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "miner"),
		"Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "sleekmin"),
		"Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "marinamin"),
		"Can" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "canmin"),
		"Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "heavymin"),
		"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "bootyminer"),
		"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "male_bootyminer"),
		"Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "protectron_miner"),
		"Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "missm_miner"),
		"Zoomba" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "zoomba_miner"),
		"Mech" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "ishimura"),
		"Drone" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "miningdrone"),
		"Drake" = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_mine.dmi', icon_state = "drakeminebox")
		)
		var/list/L = list("Blade" = "blade", "Vale" = "valemine", "Hound" = "cargohound", "Darkhound" = "cargohounddark", "Otie" = "otiec")
		for(var/a in L)
			var/image/wide = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_mine.dmi', icon_state = L[a])
			wide.pixel_x = -16
			mining_icons[a] = wide
		mining_icons = sort_list(mining_icons)
	var/mining_borg_icon = show_radial_menu(cyborg, cyborg , mining_icons, custom_check = CALLBACK(src, .proc/check_menu, cyborg, old_model), radius = 42, require_near = TRUE)
	switch(mining_borg_icon)
		if("Lavaland")
			cyborg_base_icon = "miner"
		if("Asteroid")
			cyborg_base_icon = "minerOLD"
			special_light_key = "miner"
		if("Droid")
			cyborg_base_icon = "miner"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
			hat_offset = 4
		if("Sleek")
			cyborg_base_icon = "sleekmin"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
		if("Can")
			cyborg_base_icon = "canmin"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
		if("Marina")
			cyborg_base_icon = "marinamin"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
		if("Spider")
			cyborg_base_icon = "spidermin"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
		if("Heavy")
			cyborg_base_icon = "heavymin"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
		if("Bootyborg")
			cyborg_base_icon = "bootyminer"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
		if("Male Bootyborg")
			cyborg_base_icon = "male_bootyminer"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
		if("Protectron")
			cyborg_base_icon = "protectron_miner"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
		if("Miss M")
			cyborg_base_icon = "missm_miner"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
		if("Mech")
			cyborg_base_icon = "ishimura"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
		if("Drone")
			cyborg_base_icon = "miningdrone"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
			model_features = list(R_TRAIT_SMALL)
		if("Zoomba")
			cyborg_base_icon = "zoomba_miner"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
		//Dogborgs
		if("Blade")
			cyborg_base_icon = "blade"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_mine.dmi'
			sleeper_overlay = "bladesleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Vale")
			cyborg_base_icon = "valemine"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_mine.dmi'
			sleeper_overlay = "valeminesleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Drake")
			cyborg_base_icon = "drakemine"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_mine.dmi'
			sleeper_overlay = "drakeminesleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Hound")
			cyborg_base_icon = "cargohound"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_mine.dmi'
			sleeper_overlay = "cargohound-sleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Darkhound")
			cyborg_base_icon = "cargohounddark"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_mine.dmi'
			sleeper_overlay = "cargohounddark-sleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		if("Otie")
			cyborg_base_icon = "otiec"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_mine.dmi'
			sleeper_overlay = "otiec_sleeper"
			model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
		else
			return FALSE
	return TRUE

//SYNDICATE
/obj/item/robot_model/syndicatejack
	name = "Syndicate"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/borg/sight/thermal,
		/obj/item/extinguisher,
		/obj/item/weldingtool/electric,
		/obj/item/screwdriver/nuke,
		/obj/item/wrench/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/wirecutters/cyborg,
		/obj/item/multitool/cyborg,
		/obj/item/lightreplacer/cyborg,
		/obj/item/stack/sheet/iron,
		/obj/item/stack/sheet/glass,
		/obj/item/stack/sheet/rglass/cyborg,
		/obj/item/stack/rods/cyborg,
		/obj/item/stack/tile/iron,
		/obj/item/stack/cable_coil,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/stack/medical/gauze,
		/obj/item/shockpaddles/cyborg,
		/obj/item/healthanalyzer/advanced,
		/obj/item/surgical_drapes,
		/obj/item/retractor/advanced,
		/obj/item/cautery/advanced,
		/obj/item/scalpel/advanced,
		/obj/item/gun/medbeam,
		/obj/item/reagent_containers/borghypo/syndicate,
		/obj/item/borg/lollipop,
		/obj/item/holosign_creator/cyborg,
		/obj/item/stamp/chameleon,
		/obj/item/borg_shapeshifter,
		)
	cyborg_base_icon = "synd_engi"
	model_select_icon = "malf"
	magpulsing = TRUE
	hat_offset = INFINITY
	canDispose = TRUE

/obj/item/robot_model/syndicatejack/be_transformed_to(obj/item/robot_model/old_model)
	var/mob/living/silicon/robot/cyborg = loc
	var/static/list/syndicatejack_icons = sort_list(list(
		"Saboteur" = image(icon = 'icons/mob/robots.dmi', icon_state = "synd_engi"),
		"Medical" = image(icon = 'icons/mob/robots.dmi', icon_state = "synd_medical"),
		"Assault" = image(icon = 'icons/mob/robots.dmi', icon_state = "synd_sec"),
		"Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "syndieheavy"),
		"Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "missm_syndie"),
		"Spider" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "spidersyndi"),
		"Booty Striker" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "bootynukie"),
		"Booty Syndicate" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "bootysyndie"),
		"Male Booty Striker" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "male_bootynukie"),
		"Male Booty Syndicate" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "male_bootysyndie"),
		"Mech" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "chesty")
		))
	var/syndiejack_icon = show_radial_menu(cyborg, cyborg , syndicatejack_icons, custom_check = CALLBACK(src, .proc/check_menu, cyborg, old_model), radius = 42, require_near = TRUE)
	switch(syndiejack_icon)
		if("Saboteur")
			cyborg_base_icon = "synd_engi"
			cyborg_icon_override = 'icons/mob/robots.dmi'
		if("Medical")
			cyborg_base_icon = "synd_medical"
			cyborg_icon_override = 'icons/mob/robots.dmi'
		if("Assault")
			cyborg_base_icon = "synd_sec"
			cyborg_icon_override = 'icons/mob/robots.dmi'
		if("Heavy")
			cyborg_base_icon = "syndieheavy"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
		if("Miss M")
			cyborg_base_icon = "missm_syndie"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
		if("Spider")
			cyborg_base_icon = "spidersyndi"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
		if("Booty Striker")
			cyborg_base_icon = "bootynukie"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
		if("Booty Syndicate")
			cyborg_base_icon = "bootysyndie"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
		if("Male Booty Striker")
			cyborg_base_icon = "male_bootynukie"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
		if("Male Booty Syndicate")
			cyborg_base_icon = "male_bootysyndie"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
		if("Mech")
			cyborg_base_icon = "chesty"
			cyborg_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
		//Dogborgs

		else
			return FALSE
	return ..()

//Stray dog
