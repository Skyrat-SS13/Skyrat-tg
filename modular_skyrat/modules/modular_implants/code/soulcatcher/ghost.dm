/datum/action/innate/join_soulcatcher
	name = "Enter Soulcatcher"
	background_icon = 'modular_skyrat/master_files/icons/mob/actions/action_backgrounds.dmi'
	background_icon_state = "android"
	button_icon = 'modular_skyrat/master_files/icons/mob/actions/actions_nif.dmi'
	button_icon_state = "soulcatcher_enter"

/datum/action/innate/join_soulcatcher/Activate()
	. = ..()
	var/mob/dead/observer/joining_soul = owner
	if(!joining_soul)
		return FALSE

	joining_soul.join_soulcatcher()

/mob/dead/observer/verb/join_soulcatcher()
	set name = "Enter Soulcatcher"
	set category = "Ghost"

	var/list/joinable_soulcatchers = list()
	var/list/rooms_to_join = list()

	for(var/datum/component/carrier/soulcatcher/soulcatcher in GLOB.soulcatchers)
		if(!soulcatcher.ghost_joinable || !isobj(soulcatcher.parent) || !soulcatcher.check_for_vacancy())
			continue

		var/list/carrier_rooms = soulcatcher.get_open_rooms(TRUE)
		if(!length(carrier_rooms))
			continue

		var/obj/item/soulcatcher_parent = soulcatcher.parent
		if(soulcatcher.name != soulcatcher_parent.name)
			soulcatcher.name = soulcatcher_parent.name

		joinable_soulcatchers += soulcatcher
		rooms_to_join += carrier_rooms

	if(!length(joinable_soulcatchers) || !length(rooms_to_join))
		to_chat(src, span_warning("No soulcatchers are joinable."))
		return FALSE

	var/datum/component/carrier/soulcatcher/soulcatcher_to_join = tgui_input_list(src, "Choose a soulcatcher to join", "Enter a soulcatcher", joinable_soulcatchers)
	if(!soulcatcher_to_join || !(soulcatcher_to_join in joinable_soulcatchers))
		return FALSE

	rooms_to_join = soulcatcher_to_join.get_open_rooms(TRUE)
	var/datum/carrier_room/soulcatcher/room_to_join = tgui_input_list(src, "Choose a room to enter", "Enter a room", rooms_to_join)
	if(!room_to_join)
		to_chat(src, span_warning("There no rooms that you can join."))
		return FALSE

	if(soulcatcher_to_join.require_approval)
		var/ghost_name = name
		if(mind?.current)
			ghost_name = "unknown"

		if(!soulcatcher_to_join.get_approval(ghost_name))
			to_chat(src, span_warning("The owner of [soulcatcher_to_join.name] declined your request to join."))
			return FALSE

	room_to_join.add_soul_from_ghost(src)
	return TRUE

/mob/grab_ghost(force)
	SEND_SIGNAL(src, COMSIG_SOULCATCHER_CHECK_SOUL)
	return ..()

/mob/get_ghost(even_if_they_cant_reenter, ghosts_with_clients)
	if(GetComponent(/datum/component/previous_body)) //Is the soul currently within a soulcatcher?
		return TRUE

	return ..()

/mob/dead/observer/Login()
	. = ..()
	var/datum/preferences/preferences = client?.prefs
	var/soulcatcher_action_given

	if(preferences)
		soulcatcher_action_given = preferences.read_preference(/datum/preference/toggle/soulcatcher_join_action)

	if(!soulcatcher_action_given)
		return

	if(locate(/datum/action/innate/join_soulcatcher) in actions)
		return

	var/datum/action/innate/join_soulcatcher/new_join_action = new(src)
	new_join_action.Grant(src)
