
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
			<a class="menu_a" href='?src=\ref[src];character_setup=1'>SETUP ([uppertext(client.prefs.read_preference(/datum/preference/name/real_name))])</a>
		"}

		dat += {"<a class="menu_a" href='?src=\ref[src];game_options=1'>GAME OPTIONS</a>
		"}

		if(!SSticker || SSticker.current_state <= GAME_STATE_PREGAME)
			dat += {"<a id="ready" class="menu_a" href='?src=\ref[src];toggle_ready=1'>[ready == PLAYER_READY_TO_PLAY ? "READY ☑" : "READY ☒"]</a>
		"}
		else
			dat += {"<a class="menu_a" href='?src=\ref[src];late_join=1'>JOIN</a>
		"}
			dat += {"<a class="menu_a" href='?src=\ref[src];view_manifest=1'>CREW</a>
		"}

		dat += {"<a id="be_antag" class="menu_a" href='?src=\ref[src];toggle_antag=1'>[client.prefs.read_preference(/datum/preference/toggle/be_antag) ? "BE ANTAG ☑" : "BE ANTAG ☒"]</a>
		"}

		dat += {"<a class="menu_a" href='?src=\ref[src];observe=1'>OBSERVE</a>
		"}

		dat += {"
			<a class="menu_a" href='?src=\ref[src];server_swap=1'>SWAP SERVERS</a>
		"}

		if(!is_guest_key(src.key))
			dat += playerpolls()

		dat += "</div>"
		dat += {"
		<script language="JavaScript">
			var ready_int=0;
			var ready_mark=document.getElementById("ready");
			var ready_marks=new Array('READY ☒', 'READY ☑');
			function toggleready(setReady) {
				if(setReady) {
					ready_int = setReady;
					ready_mark.textContent = ready_marks\[ready_int\];
				}
				else {
					ready_int++;
					if (ready_int == ready_marks.length)
						ready_int = 0;
					ready_mark.textContent = ready_marks\[ready_int\];
				}
			}
			var antag_int=0;
			var antag_mark=document.getElementById("be_antag");
			var antag_marks=new Array('BE ANTAG ☑', 'BE ANTAG ☒');
			function beantag(setAntag) {
				if(setAntag) {
					antag_int = setAntag;
					antag_mark.textContent = antag_marks\[antag_int\];
				}
				else {
					antag_int++;
					if (antag_int == antag_marks.length)
						antag_int = 0;
					antag_mark.textContent = antag_marks\[antag_int\];
				}
			}
		</script>
		"}
	dat += "</body></html>"

	return dat

