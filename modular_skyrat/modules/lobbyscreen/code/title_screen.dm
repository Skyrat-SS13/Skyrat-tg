GLOBAL_VAR(current_lobby_screen)

GLOBAL_LIST_EMPTY(lobby_screens)

SUBSYSTEM_DEF(title)
	name = "Title Screen"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_TITLE

	var/file_path
	var/icon/startup_splash

/datum/controller/subsystem/title/Initialize()
	if(file_path)
		return

	var/list/provisional_title_screens = flist("[global.config.directory]/title_screens/images/")
	var/list/title_screens = list()

	for(var/S in provisional_title_screens)
		var/list/L = splittext(S,"+")
		if((L.len == 1 && (L[1] != "exclude" && L[1] != "blank.png" && L[1] != "startup_splash")))
			title_screens += S

		if(L.len > 1 && lowertext(L[1]) == "startup_splash")
			var/file_path = "[global.config.directory]/title_screens/images/[S]"
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


/proc/change_lobbyscreen(new_screen)
	if(new_screen)
		GLOB.current_lobby_screen = new_screen
	else
		if(GLOB.lobby_screens.len)
			GLOB.current_lobby_screen = pick(GLOB.lobby_screens)
		else
			GLOB.current_lobby_screen = 'modular_skyrat/modules/lobbyscreen/icons/skyrat_lobbyscreen.png'

	for(var/mob/dead/new_player/N in GLOB.new_player_list)
		INVOKE_ASYNC(N, /mob/dead/new_player.proc/show_titlescreen)
