SUBSYSTEM_DEF(title)
	name = "Title Screen"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_TITLE

	var/file_path
	var/icon/startup_splash

/datum/controller/subsystem/title/Initialize()
	var/dat
	if(!fexists("[global.config.directory]/skyrat/lobby_html.txt"))
		to_chat(world, span_boldwarning("CRITICAL ERROR: Unable to read lobby_html.txt, reverting to backup lobby html, please check your server config and ensure this file exists."))
		dat = DEFAULT_TITLE_HTML
	else
		dat = file2text("[global.config.directory]/skyrat/lobby_html.txt")

	GLOB.lobby_html = dat

	var/list/provisional_title_screens = flist("[global.config.directory]/title_screens/images/")
	var/list/title_screens = list()

	for(var/screen in provisional_title_screens)
		var/list/formatted_list = splittext(screen, "+")
		if((formatted_list.len == 1 && (formatted_list[1] != "exclude" && formatted_list[1] != "blank.png" && formatted_list[1] != "startup_splash")))
			title_screens += screen

		if(formatted_list.len > 1 && lowertext(formatted_list[1]) == "startup_splash")
			var/file_path = "[global.config.directory]/title_screens/images/[screen]"
			ASSERT(fexists(file_path))
			startup_splash = new(fcopy_rsc(file_path))

	if(startup_splash)
		change_lobbyscreen(startup_splash)
	else
		change_lobbyscreen('modular_skyrat/modules/lobbyscreen/icons/loading_screen.gif')

	if(length(title_screens))
		for(var/i in title_screens)
			var/file_path = "[global.config.directory]/title_screens/images/[i]"
			ASSERT(fexists(file_path))
			var/icon/title2use = new(fcopy_rsc(file_path))
			GLOB.lobby_screens += title2use

	return ..()

/datum/controller/subsystem/title/Recover()
	startup_splash = SStitle.startup_splash
	file_path = SStitle.file_path
