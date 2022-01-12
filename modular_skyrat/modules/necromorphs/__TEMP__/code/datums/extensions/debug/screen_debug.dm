/*
	This extension is used for runtime debugging of client screens

	given a target client, it presents to the user a list of elements on the client's screen, with names, typepaths, and links to delete or VV them
*/
/datum/extension/screen_debug
	base_type = /datum/extension/screen_debug
	expected_type = /client
	flags = EXTENSION_FLAG_IMMEDIATE
	var/client/C
	var/mob/living/user

/datum/extension/screen_debug/New(var/client/client, var/mob/living/user)
	C = client
	src.user = user

	.=..()
	ui_interact(user)



/datum/extension/screen_debug/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)
	var/list/screenobjects = list()
	for (var/obj/O in C.screen)
		screenobjects += list(list("name" = O.name, "ref" = "\ref[O]", "type" = O.type, "icon" = "[O.icon] | [O.icon_state]"))

	var/list/data = list()
	data["screenobjects"] = screenobjects

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "ui_debugging.tmpl", "Spawning Menu", 800, 700, state = GLOB.interactive_state)
		ui.set_initial_data(data)
		ui.set_auto_update(1)
		ui.open()

/datum/extension/screen_debug/Topic(href, href_list)
	if(..())
		return
	if (href_list["vv"])
		var/datum/thing = locate(href_list["vv"])
		if (thing && user && user.client)
			user.client.debug_variables(thing)



	if (href_list["delete"])
		var/obj/thing = locate(href_list["delete"])
		if (thing && C)
			C.screen -= thing
			qdel(thing)
			to_chat(user, "Deleted [thing.type] | [thing.name]")


	SSnano.update_uis(src)


/*
	Access
*/
/client/proc/debug_screen()
	set_extension(src, /datum/extension/screen_debug, usr)

/mob/proc/debug_screen()
	if (client)
		client.debug_screen()