//Datum to hold the spawnpoint selection menu, one is created for each user
/datum/necrospawn_selector
	var/datum/necroshop/host

/datum/necrospawn_selector/New(var/datum/necroshop/_host)
	host = _host

/datum/necrospawn_selector/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/list/data = list()
	for (var/datum/necrospawn/N in host.possible_spawnpoints)
		data["spawnpoints"] += list(list("name" = "[N.name]	[jumplink_public(user, N.spawnpoint)]", "color" = N.color,"id" = N.id))

	data["selected_id"] = host.selected_spawn.id



	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "necrospawn_selector.tmpl", "Spawning Menu", 800, 700, state = GLOB.interactive_state)
		ui.set_initial_data(data)
		ui.set_auto_update(0)
		ui.open()

/datum/necrospawn_selector/Topic(href, href_list)
	if(..())
		return

	if (href_list["select_spawn"])	//This will be an id of a spawnpoint. lets find it
		for (var/datum/necrospawn/N in host.possible_spawnpoints)
			if (N.id == href_list["select_spawn"])	//We found it!
				//Set it on the host
				host.selected_spawn = N

				//Close this window
				var/datum/nanoui/ui = SSnano.get_open_ui(usr, src, "main")
				ui.close()

				//And refresh the parent window
				SSnano.update_uis(host)
				return