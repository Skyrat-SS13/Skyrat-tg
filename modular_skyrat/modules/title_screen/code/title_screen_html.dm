
GLOBAL_LIST_EMPTY(startup_messages)
// FOR MOR INFO ON HTML CUSTOMISATION, SEE: https://github.com/Skyrat-SS13/Skyrat-tg/pull/4783

#define MAX_STARTUP_MESSAGES 27

/mob/dead/new_player/proc/get_title_html()
	var/dat = SStitle.title_html
	if(SSticker.current_state == GAME_STATE_STARTUP)
		dat += {"<img src="loading_screen.gif" class="bg" alt="">"}
		dat += {"<div class="container_terminal" id="terminal"></div>"}
		dat += {"<div class="container_progress" id="progress_container"><div class="progress_bar" id="progress"></div></div>"}

		dat += {"
		<script language="JavaScript">
			var terminal = document.getElementById("terminal");
			var terminal_lines = \[
				"<p class='terminal_text'>SYSTEMS INITIALIZING:</p>",
		"}

		for(var/message in GLOB.startup_messages)
			dat += {""[replacetext(message, "\"", "\\\"")]","}

		dat += {"
			\];

			function append_terminal_text(text) {
				if(text) {
					terminal_lines.push(text);
				}
				while(terminal_lines.length > [MAX_STARTUP_MESSAGES]) {
					terminal_lines.shift();
				}

				terminal.innerHTML = terminal_lines.join("");
			}

			append_terminal_text();

			var progress_bar = document.getElementById("progress");
			var progress_container = document.getElementById("progress_container");
			// Times are all in 10ths of a second, like byond.
			var progress_current_time = [world.timeofday - SStitle.progress_reference_time];
			var progress_current_position = 0;
			var progress_completion_time = [SStitle.average_completion_time];
			var previous_tick = new Date().getTime();

			setInterval(function() {
				// Compensate for shakey execution.
				if(progress_current_time < progress_completion_time) {
					var current_tick = new Date().getTime();
					progress_current_time += (current_tick - previous_tick) / 100;
					previous_tick = current_tick;
				}

				var new_position = Math.min(progress_current_time / progress_completion_time * 100, 100);

				// Only go forward
				if(new_position < progress_current_position) {
					return;
				}
				progress_current_position = new_position;

				progress_bar.style.width = "" + progress_current_position + "%";

				if(progress_current_position === 100) {
					// fade out
					progress_container.classList.add("fade_out");
				}
			}, 50);

			function update_loading_progress(current_time, total_time) {
				progress_current_time = parseFloat(current_time);
				progress_completion_time = parseFloat(total_time);
			}

			function update_current_character() {}
		</script>
		"}

	else
		dat += {"<img src="loading_screen.gif" class="bg" alt="">"}

		if(SStitle.current_notice)
			dat += {"
			<div class="container_notice">
				<p class="menu_notice">[SStitle.current_notice]</p>
			</div>
		"}

		dat += {"<div class="container_nav">"}

		if(!SSticker || SSticker.current_state <= GAME_STATE_PREGAME)
			dat += {"<a id="ready" class="menu_button" href='?src=\ref[src];toggle_ready=1'>[ready == PLAYER_READY_TO_PLAY ? "<span class='checked'>☑</span> READY" : "<span class='unchecked'>☒</span> READY"]</a>"}
		else
			dat += {"
				<a class="menu_button" href='?src=\ref[src];late_join=1'>JOIN GAME</a>
				<a class="menu_button" href='?src=\ref[src];view_manifest=1'>CREW MANIFEST</a>
			"}

		dat += {"<a class="menu_button" href='?src=\ref[src];observe=1'>OBSERVE</a>"}

		dat += {"
			<hr>
			<a class="menu_button" href='?src=\ref[src];character_setup=1'>SETUP CHARACTER (<span id="character_slot">[uppertext(client.prefs.read_preference(/datum/preference/name/real_name))]</span>)</a>
			<a class="menu_button" href='?src=\ref[src];game_options=1'>GAME OPTIONS</a>
			<a id="be_antag" class="menu_button" href='?src=\ref[src];toggle_antag=1'>[client.prefs.read_preference(/datum/preference/toggle/be_antag) ? "<span class='checked'>☑</span> BE ANTAGONIST" : "<span class='unchecked'>☒</span> BE ANTAGONIST"]</a>
			<hr>
			<a class="menu_button" href='?src=\ref[src];server_swap=1'>SWAP SERVERS</a>
		"}

		if(!is_guest_key(src.key))
			dat += playerpolls()

		dat += "</div>"
		dat += {"
		<script language="JavaScript">
			var ready_int = 0;
			var ready_mark = document.getElementById("ready");
			var ready_marks = \[ "<span class='unchecked'>☒</span> READY", "<span class='checked'>☑</span> READY" \];
			function toggle_ready(setReady) {
				if(setReady) {
					ready_int = setReady;
					ready_mark.innerHTML = ready_marks\[ready_int\];
				}
				else {
					ready_int++;
					if (ready_int === ready_marks.length)
						ready_int = 0;
					ready_mark.innerHTML = ready_marks\[ready_int\];
				}
			}
			var antag_int = 0;
			var antag_mark = document.getElementById("be_antag");
			var antag_marks = \[ "<span class='unchecked'>☒</span> BE ANTAGONIST", "<span class='checked'>☑</span> BE ANTAGONIST" \];
			function toggle_antag(setAntag) {
				if(setAntag) {
					antag_int = setAntag;
					antag_mark.innerHTML = antag_marks\[antag_int\];
				}
				else {
					antag_int++;
					if (antag_int === antag_marks.length)
						antag_int = 0;
					antag_mark.innerHTML = antag_marks\[antag_int\];
				}
			}

			var character_name_slot = document.getElementById("character_slot");
			function update_current_character(name) {
				character_name_slot.textContent = name.toUpperCase();
			}

			function append_terminal_text() {}
			function update_loading_progress() {}
		</script>
		"}
	dat += "</body></html>"

	return dat

