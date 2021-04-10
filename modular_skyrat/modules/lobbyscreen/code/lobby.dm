GLOBAL_LIST_EMPTY(startup_messages)
// FOR MOR INFO ON HTML CUSTOMISATION, SEE: https://github.com/Skyrat-SS13/Skyrat-tg/pull/4783
/mob/dead/new_player/proc/get_lobby_html()
	var/dat = GLOB.lobby_html
	if(SSticker.current_state == GAME_STATE_STARTUP)
		dat += {"<img src="titlescreen.gif" class="fone" alt="">"}
		dat += {"
		<div class="container_terminal">
			<p class="menu_b">SYSTEMS INITIALIZING:</p>
		"}
		var/loop_index = 0
		for(var/i in GLOB.startup_messages)
			if(loop_index >= 27)
				break
			dat += i
			loop_index++
		dat += "</div>"

	else
		dat += {"<img src="titlescreen.gif" class="fone" alt="">"}

		if(GLOB.current_lobbyscreen_notice)
			dat += {"
			<div class="container_notice">
				<p class="menu_c">[GLOB.current_lobbyscreen_notice]</p>
			</div>
		"}

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
		if(CONFIG_GET(flag/server_swap_enabled))
			dat += {"
			<a class="menu_a" href='?src=\ref[src];lobby_swap=1'>SWAP SERVERS</a>
		"}

		if(!IsGuestKey(src.key))
			dat += playerpolls()

		dat += "</div>"
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
