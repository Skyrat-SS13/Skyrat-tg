//Extensions that can be interacted with via Topic
/datum/extension/interactive
	base_type = /datum/extension/interactive
	var/list/host_predicates
	var/list/user_predicates

	//UI values
	var/list/content_data = list()
	var/list/data  = list()
	var/template
	var/title
	var/vector2/dimensions

/datum/extension/interactive/New(var/datum/holder, var/host_predicates = list(), var/user_predicates = list())
	..()

	src.host_predicates = host_predicates ? host_predicates : list()
	src.user_predicates = user_predicates ? user_predicates : list()
	generate_content_data()

/datum/extension/interactive/Destroy()
	host_predicates.Cut()
	user_predicates.Cut()
	release_vector(dimensions)
	return ..()

/datum/extension/interactive/proc/extension_status(var/mob/user)
	if(!holder || !user)
		return STATUS_CLOSE
	if(!all_predicates_true(list(holder), host_predicates))
		return STATUS_CLOSE
	if(!all_predicates_true(list(user), user_predicates))
		return STATUS_CLOSE
	if(holder.CanUseTopic(user, GLOB.default_state) != STATUS_INTERACTIVE)
		return STATUS_CLOSE

	return STATUS_INTERACTIVE

/datum/extension/interactive/proc/extension_act(var/href, var/list/href_list, var/mob/user)
	return extension_status(user) == STATUS_CLOSE

/datum/extension/interactive/Topic(var/href, var/list/href_list)
	if(..())
		return TRUE
	return extension_act(href, href_list, usr)



/datum/extension/interactive/ui_interact(mob/user, ui_key = "main", var/datum/nanoui/ui = null, var/force_open = 1)

	data = content_data
	data += ui_data(user)
	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, template, title, dimensions.x, dimensions.y, state = GLOB.interactive_state)
		ui.set_initial_data(data)
		ui.set_auto_update(1)
		ui.open()





//Generate and cache the common data once
/datum/extension/interactive/proc/generate_content_data()
	return

/datum/extension/interactive/ui_data(var/mob/user)
	return list()