GLOBAL_DATUM(server_control_panel, /datum/server_control_panel)

/datum/server_control_panel

/datum/server_control_panel/New()
	. = ..()

/datum/server_control_panel/ui_state(mob/user)
	return GLOB.always_state

/datum/server_control_panel/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "ServerControlPanel")
		ui.open()

/datum/server_control_panel/ui_data(mob/user)
	var/list/data = list()

	data["player_cap"] = CONFIG_GET(number/player_hard_cap)

	data["connections"] = TGS_CLIENT_COUNT

	data["overflow_server_name"] = "Overflow Server"

	data["servers"] = list()
	var/list/servers = CONFIG_GET(keyed_list/cross_server)
	for(var/server_name in servers)
		data["servers"] += list(list(
			"name" = server_name,
			"ip" = servers[server_name],
		))


/mob/dead/new_player/proc/show_connection_panel()
	if(!GLOB.server_control_panel)
		GLOB.server_control_panel = new /datum/server_control_panel(src)

	GLOB.server_control_panel.ui_interact(src)
