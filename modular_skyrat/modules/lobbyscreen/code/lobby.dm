GLOBAL_LIST_EMPTY(startup_messages)

/mob/dead/new_player/proc/get_lobby_html()
	var/dat = {"
	<html>
		<head>
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
			<style type='text/css'>
				@font-face {
					font-family: "Fixedsys";
					src: url("FixedsysExcelsior3.01Regular.ttf");
				}
				@font-face {
					font-family: "Terminal";
					src: url("TerminusTTFWindows-4.47.0.ttf");
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
					padding-left: 1vmin;
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
					padding-top: 5vmin;
					top: 0%;
					left:0%;
				}

				.container_polls {
					position: absolute;
					width: auto;
					box-sizing: border-box;
					padding-top: 5vmin;
					top: 0%;
					left:0%;
				}

				.menu_a {
					display: inline-block;
					font-family: "Fixedsys";
					font-weight: lighter;
					text-decoration: none;
					width: 100%;
					text-align: left;
					color: #0066cc;
					margin-right: 100%;
					margin-top: 5px;
					padding-left: 6px;
					font-size: 6vmin;
					line-height: 6vmin;
					height: 4vmin;
					letter-spacing: 1px;
				}

				.menu_a:hover {
					border-left: 3px solid #0080ff;
					font-weight: bolder;
					padding-left: 3px;
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
					font-family: "Fixedsys";
					font-weight: lighter;
					text-decoration: none;
					width: 100%;
					text-align: left;
					color:#0066cc;
					font-size: 6vmin;
					line-height: 1vmin;
					letter-spacing: 1px;
				}
				.menu_c:hover {
					border-left: 3px solid #0080ff;
					font-weight: bolder;
					padding-left: 3px;
				}
			</style>
		</head>
		<body>
	"}
	if(SSticker.current_state == GAME_STATE_STARTUP)
		dat += {"<img src="titlescreen.gif" class="fone" alt="">"}
		dat += {"
		<div class="container_terminal">
			<p class="menu_b">SYSTEMS INITIALIZING:</p>
		"}
		var/loop_index = 0
		for(var/i in GLOB.startup_messages)
			if(loop_index >= 25)
				break
			dat += i
			loop_index++
		dat += "</div>"

	else

		if(!IsGuestKey(src.key))
			dat += {"
			<div class="container_polls">
		"}
			dat += playerpolls()
			dat += "</div>"

		dat += {"
		<div class="container_nav">
				<a class="menu_a" href='?src=\ref[src];lobby_setup=1'>SETUP ([uppertext(client.prefs.real_name)])</a>
		"}
		if(!SSticker || SSticker.current_state <= GAME_STATE_PREGAME)
			dat += {"<a id="ready" class="menu_a" href='?src=\ref[src];lobby_ready=1'>[ready ? "READY ☑" : "READY ☒"]</a>
		"}
		else
			dat += {"<a class="menu_a" href='?src=\ref[src];lobby_join=1'>JOIN</a>
		"}
			dat += {"<a class="menu_a" href='?src=\ref[src];lobby_crew=1'>CREW</a>
		"}

		dat += {"<a class="menu_a" href='?src=\ref[src];lobby_antagtoggle=1'>[client.prefs.be_antag ? "BE ANTAG ☑" : "BE ANTAG ☒"]</a>
		"}

		dat += {"<a class="menu_a" href='?src=\ref[src];lobby_observe=1'>OBSERVE</a>
		"}
		dat += {"<br><br><a class="menu_a" href='?src=\ref[src];lobby_changelog=1'>CHANGELOG</a>
		"}

		dat += "</div>"
		dat += {"<img src="titlescreen.gif" class="fone" alt="">"}
		dat += {"
		<script language="JavaScript">
			var i=0;
			var mark=document.getElementById("ready");
			var marks=new Array('READY ☒', 'READY ☑');
			function imgsrc(setReady) {
				if(setReady) {
					i = setReady;
					mark.textContent = marks\[i\];
				}
				else {
					i++;
					if (i == marks.length)
						i = 0;
					mark.textContent = marks\[i\];
				}
			}
		</script>
		"}

	dat += "</body></html>"

	return dat

/proc/add_startupmessage(msg)
	var/msg_dat = {"<p class="menu_b">[msg]</p>"}

	GLOB.startup_messages.Insert(1, msg_dat)

	for(var/mob/dead/new_player/N in GLOB.new_player_list)
		INVOKE_ASYNC(N, /mob/dead/new_player.proc/update_titlescreen)
