GLOBAL_VAR(current_lobby_screen)

GLOBAL_VAR(current_lobbyscreen_notice)

GLOBAL_VAR(lobby_html)

GLOBAL_LIST_EMPTY(lobby_screens)

SUBSYSTEM_DEF(title)
	name = "Title Screen"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_TITLE

	var/file_path
	var/icon/startup_splash

/datum/controller/subsystem/title/Initialize()
	var/dat
	if(!fexists("[global.config.directory]/skyrat/lobby_html.txt"))
		to_chat(world, "<span class='boldwarning'>CRITICAL ERROR: Unable to read lobby_html.txt, reverting to backup lobby html, please check your server config and ensure this file exists.")
		dat = {"
			<html>
				<head>
					<meta http-equiv="X-UA-Compatible" content="IE=edge">
					<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
					<style type='text/css'>
						@font-face {
							font-family: "Fixedsys";
							src: url("FixedsysExcelsior3.01Regular.ttf");
						}
						body,
						html {
							margin: 0;
							overflow: hidden;
							text-align: center;
							background-color: black;
							padding-top: 5vmin;
							-ms-user-select: none;
						}

						img {
							border-style:none;
						}

						.fone{
							position: absolute;
							width: auto;
							height: 100vmin;
							min-width: 100vmin;
							min-height: 100vmin;
							top: 50%;
							left:50%;
							transform: translate(-50%, -50%);
							z-index: 0;
						}

						.container_nav {
							position: absolute;
							width: auto;
							min-width: 100vmin;
							min-height: 10vmin;
							padding-left: 0vmin;
							padding-top: 45vmin;
							box-sizing: border-box;
							top: 50%;
							left:50%;
							transform: translate(-50%, -50%);
							z-index: 1;
						}

						.container_terminal {
							position: absolute;
							width: auto;
							box-sizing: border-box;
							padding-top: 3vmin;
							top: 0%;
							left:0%;
							z-index: 1;
						}

						.container_notice {
							position: absolute;
							width: auto;
							box-sizing: border-box;
							padding-top: 1vmin;
							top: 0%;
							left:0%;
							z-index: 1;
						}

						.menu_a {
							display: inline-block;
							font-family: "Fixedsys";
							font-weight: lighter;
							text-decoration: none;
							width: 100%;
							text-align: left;
							color: #add8e6;
							margin-right: 100%;
							margin-top: 5px;
							padding-left: 6px;
							font-size: 6vmin;
							line-height: 6vmin;
							height: 6vmin;
							letter-spacing: 1px;
							border: 2px solid white;
							background-color: #0080ff;
							opacity: 0.5;
						}

						.menu_a:hover {
							border-left: 3px solid red;
							border-right: 3px solid red;
							font-weight: bolder;
							padding-left: 3px;
						}

						@keyframes pollsmove {
						50% {opacity: 0;}
						}

						.menu_ab {
							display: inline-block;
							font-family: "Fixedsys";
							font-weight: lighter;
							text-decoration: none;
							width: 100%;
							text-align: left;
							color: #add8e6;
							margin-right: 100%;
							margin-top: 5px;
							padding-left: 6px;
							font-size: 6vmin;
							line-height: 6vmin;
							height: 6vmin;
							letter-spacing: 1px;
							border: 2px solid white;
							background-color: #0080ff;
							opacity: 0.5;
							animation: pollsmove 5s infinite;
						}

						.menu_b {
							display: inline-block;
							font-family: "Terminal";
							font-weight: lighter;
							text-decoration: none;
							width: 100%;
							text-align: right;
							color:green;
							margin-right: 0%;
							margin-top: 0px;
							font-size: 2vmin;
							line-height: 1vmin;
							letter-spacing: 1px;
						}

						.menu_c {
							display: inline-block;
							font-weight: lighter;
							text-decoration: none;
							width: 100%;
							text-align: left;
							color: red;
							margin-right: 0%;
							margin-top: 0px;
							font-size: 3vmin;
							line-height: 2vmin;
						}

					</style>
				</head>
				<body>
			"}

	else
		dat = file2text("[global.config.directory]/skyrat/lobby_html.txt")

	GLOB.lobby_html = dat

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

/proc/set_titlescreen_notice(new_title)
	if(new_title)
		GLOB.current_lobbyscreen_notice = sanitize_text(new_title)
	else
		GLOB.current_lobbyscreen_notice = null

	for(var/mob/dead/new_player/N in GLOB.new_player_list)
		INVOKE_ASYNC(N, /mob/dead/new_player.proc/show_titlescreen)

/client/verb/fix_lobbyscreen()
	set name = "Fix Lobbyscreen"
	set desc = "Lobbyscreen broke? Press this."
	set category = "OOC"

	if(istype(mob, /mob/dead/new_player))
		var/mob/dead/new_player/NP = mob
		NP.show_titlescreen()
	else
		winset(src, "lobbybrowser", "is-disabled=true;is-visible=false")

/client/proc/change_title_screen_html()
	set category = "Admin.Fun"
	set name = "Title Screen: Set HTML"

	if(!check_rights(R_FUN))
		return

	log_admin("[key_name(usr)] is setting the titlescreen HTML.")
	message_admins("[key_name_admin(usr)] is setting the titlescreen HTML.")

	var/new_html = input(usr, "Please enter your desired HTML(WARNING: YOU WILL BREAK SHIT)", "DANGER: LOBBY HTML EDIT") as message|null

	GLOB.lobby_html = new_html

	for(var/mob/dead/new_player/N in GLOB.new_player_list)
		INVOKE_ASYNC(N, /mob/dead/new_player.proc/show_titlescreen)

	message_admins("[key_name_admin(usr)] has changed the titlescreen HTML.")
