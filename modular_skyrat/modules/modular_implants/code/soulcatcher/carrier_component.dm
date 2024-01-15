///Global list containing any and all soulcatchers
GLOBAL_LIST_EMPTY(soulcatchers)

#define SOULCATCHER_DEFAULT_COLOR "#75D5E1"
#define SOULCATCHER_WARNING_MESSAGE "You have entered a soulcatcher, do not share any information you have received while a ghost. If you have died within the round, you do not know your identity until your body has been scanned, standard blackout policy also applies."

/**
 * Carrier Component
 *
 * This component functions as a bridge between the `carrier_room` attached to itself and the parented datum.
 * It handles the creation of new carrier rooms, TGUI, and relaying messages to the parent datum.
 * If the component is deleted, any carrier rooms inside of `carrier_rooms` will be deleted.
 */
/datum/component/carrier
	/// What is the name of the carrier?
	var/name = "carrier"
	/// What rooms are linked to this carrier
	var/list/carrier_rooms = list()
	/// What carrier room are verbs sending messages to?
	var/datum/carrier_room/targeted_carrier_room
	/// What theme are we using for our carrier UI?
	var/ui_theme = "default"
	/// Do we want to ask the user permission before the mob enters?
	var/require_approval = TRUE
	/// Are are the mobs inside able to emote/speak as the parent?
	var/communicate_as_parent = FALSE

	/// What is the max number of people we can keep in this carrier? If this is set to `FALSE` we don't have a limit
	var/max_mobs = FALSE
	/// What is the path of user component do we want to give to our mob? This needs to be `/datum/component/carrier_user` or a subtype.
	var/component_to_give = /datum/component/carrier_user
	/// What 16x16 chat icon do we want our carrier to display in chat messages?
	var/chat_icon = "nif-soulcatcher"

/datum/component/carrier/New()
	. = ..()
	if(!parent)
		return COMPONENT_INCOMPATIBLE

	create_room()
	targeted_carrier_room = carrier_rooms[1]

	var/obj/item/carrier_holder/holder = parent
	if(istype(holder) && ismob(holder.loc))
		var/mob/living/soulcatcher_owner = holder.loc
		add_verb(soulcatcher_owner, list(
			/mob/living/proc/carrier_say,
			/mob/living/proc/carrier_emote,
		))

/datum/component/carrier/Destroy(force, ...)
	targeted_carrier_room = null
	for(var/datum/carrier_room as anything in carrier_rooms)
		carrier_rooms -= carrier_room
		qdel(carrier_room)

	var/mob/living/carrier_owner = parent
	var/obj/item/organ/internal/cyberimp/brain/nif/parent_nif = parent
	if(istype(parent_nif))
		carrier_owner = parent_nif.linked_mob

	if(istype(carrier_owner))
		remove_verb(carrier_owner, list(
			/mob/living/proc/carrier_say,
			/mob/living/proc/carrier_emote,
		))

	return ..()

/**
 * Creates a `/datum/carrier_room` and adds it to the `carrier_rooms` list.
 *
 * Arguments
 * * target_name - The name that we want to assign to the created room.
 * * target_desc - The description that we want to assign to the created room.
 */
/datum/component/carrier/proc/create_room(target_name, target_desc)
	var/datum/carrier_room/created_room = new(src)
	if(target_name)
		created_room.name = target_name
	if(target_desc)
		created_room.room_description = target_desc

	carrier_rooms += created_room
	created_room.master_carrier = WEAKREF(src)

/// Tries to find out who is currently using the carrier, returns the holder. If no holder can be found, returns FALSE
/datum/component/carrier/proc/get_current_holder()
	var/mob/living/holder

	if(!istype(parent, /obj/item))
		return FALSE

	var/obj/item/parent_item = parent
	holder = parent_item.loc

	if(!istype(holder))
		return FALSE

	return holder

/// Recieves a message from a carrier room.
/datum/component/carrier/proc/recieve_message(message_to_recieve)
	if(!message_to_recieve)
		return FALSE

	var/mob/living/carrier_owner = get_current_holder()
	if(!carrier_owner)
		return FALSE

	to_chat(carrier_owner, message_to_recieve)
	return TRUE

/// Attempts to ping the current user of the carrier, asking them if `joiner_name` is allowed in. If they are, the proc returns `TRUE`, otherwise returns FALSE
/datum/component/carrier/proc/get_approval(joiner_name)
	if(!require_approval)
		return TRUE

	var/mob/living/carrier_owner = get_current_holder()
	if(!carrier_owner)
		return FALSE

	if(tgui_alert(carrier_owner, "Do you wish to allow [joiner_name] into your soulcatcher?", name, list("Yes", "No"), autofocus = FALSE) != "Yes")
		return FALSE

	return TRUE

/// Attempts to scan the body for the `previous_body component`, returns FALSE if the body is unable to be scanned, otherwise returns TRUE
/datum/component/carrier/soulcatcher/proc/scan_body(mob/living/parent_body, mob/living/user)
	if(!parent_body || !user)
		return FALSE

	var/signal_result = SEND_SIGNAL(parent_body, COMSIG_SOULCATCHER_SCAN_BODY, parent_body)
	if(!signal_result)
		to_chat(user, span_warning("[parent_body] has already been scanned!"))
		return FALSE

	if(istype(parent, /obj/item/handheld_soulcatcher))
		var/obj/item/handheld_soulcatcher/parent_device = parent
		playsound(parent_device, 'modular_skyrat/modules/modular_implants/sounds/default_good.ogg', 50, FALSE, ignore_walls = FALSE)
		parent_device.visible_message(span_notice("[parent_device] beeps: [parent_body] is now scanned."))

	return TRUE

/// Returns a list containing all of the mobs currently present within a carrier.
/datum/component/carrier/proc/get_current_mobs()
	var/list/current_inhabitants = list()
	for(var/datum/carrier_room/room as anything in carrier_rooms)
		for(var/mob/living/inhabitant as anything in room.current_mobs)
			current_inhabitants += inhabitant

	return current_inhabitants

/// Checks the total number of mobs present and compares it with `max_mobs` returns `TRUE` if there is room (or no limit), otherwise returns `FALSE`
/datum/component/carrier/proc/check_for_vacancy()
	if(!max_mobs)
		return TRUE

	if(length(get_current_mobs()) >= max_mobs)
		return FALSE

	return TRUE

/datum/component/carrier/proc/get_open_rooms()
	var/list/datum/carrier_room/room_list = list()
	for(var/datum/carrier_room/room as anything in carrier_rooms)
		if(!check_for_vacancy())
			continue

		room_list += room

	return room_list

/// Transfers a soul from a carrier room to another carrier room. Returns `FALSE` if the target room or target soul cannot be found.
/datum/component/carrier/proc/transfer_mob(mob/living/target_soul, datum/carrier_room/target_room)
	if(!(target_soul in get_current_mobs()) || !target_room)
		return FALSE

	var/datum/component/carrier/target_master_carrier = target_room.master_carrier.resolve()
	if(!target_master_carrier)
		target_room.master_carrier = null
	else if(target_master_carrier != src)
		target_soul.forceMove(target_master_carrier.parent)

	var/datum/component/carrier_user/carrier_component = target_soul.GetComponent(/datum/component/carrier_user)
	var/datum/carrier_room/original_room = carrier_component?.current_room.resolve()
	if(original_room)
		original_room.current_mobs -= target_soul
	else
		carrier_component?.current_room = null

	var/datum/weakref/room_ref = WEAKREF(target_room)
	SEND_SIGNAL(target_soul, COMSIG_CARRIER_MOB_CHANGE_ROOM, room_ref)
	target_room.current_mobs += target_soul

	to_chat(target_soul, span_cyan("you've been transferred to [target_room]!"))
	to_chat(target_soul, span_notice(target_room.room_description))

	return TRUE

/// Adds `mob_to_add` into the parent carrier, giving them the carrier component and moving their mob into the room. Returns the component added, if successful
/datum/component/carrier/proc/add_mob(mob/living/mob_to_add, datum/carrier_room/target_room)
	if(!istype(mob_to_add))
		return FALSE

	var/datum/component/carrier_user/carrier_component = mob_to_add.AddComponent(component_to_give)
	if(!carrier_component)
		return FALSE

	if(!istype(target_room))
		target_room = carrier_rooms[1] // Put them in the first room we can find if none is provided.

	carrier_component.current_room = target_room
	return carrier_component

/**
 * carrier Room
 *
 * This datum is where souls are sent to when joining soulcatchers.
 * It handles sending messages to souls from the outside along with adding new souls, transfering, and removing souls.
 *
 */
/datum/carrier_room
	/// What is the name of the room?
	var/name = "Default Room"
	/// What is the description of the room?
	var/room_description = "An orange platform suspended in space orbited by reflective cubes of various sizes. There really isn't much here at the moment."
	/// What souls are currently inside of the room?
	var/list/current_mobs = list()
	/// Weakref for the master carrier datum
	var/datum/weakref/master_carrier
	/// What is the name of the person sending the messages?
	var/outside_voice = "Host"
	/// Can the room be joined at all?
	var/joinable = TRUE
	/// What is the color of chat messages sent by the room?
	var/room_color = SOULCATCHER_DEFAULT_COLOR

/// Attemps to add a ghost to the soulcatcher room.
/datum/carrier_room/proc/add_soul_from_ghost(mob/dead/observer/ghost)
	if(!ghost || !ghost.ckey)
		return FALSE

	if(!ghost.mind)
		ghost.mind = new /datum/mind(ghost.key)
		ghost.mind.name = ghost.name
		ghost.mind.active = TRUE

	if(!add_soul_from_mind(ghost.mind))
		return FALSE

	return TRUE

/// Adds a mob into the carrier
/datum/carrier_room/proc/add_mob(mob/living/mob_to_add)
	if(!mob_to_add)
		return FALSE

	var/datum/component/carrier/parent_soulcatcher = master_carrier.resolve()
	var/datum/parent_object = parent_soulcatcher.parent
	if(!parent_object)
		return FALSE

	var/datum/component/carrier_user/carrier_component = parent_soulcatcher.add_mob(mob_to_add, src)
	if(!carrier_component)
		return FALSE
	current_mobs += mob_to_add
	carrier_component.current_room = WEAKREF(src)

	to_chat(mob_to_add, span_cyan("You find yourself now inside of: [name]"))
	to_chat(mob_to_add, span_notice(room_description))

	var/atom/parent_atom = parent_object
	if(istype(parent_atom))
		var/turf/soulcatcher_turf = get_turf(parent_soulcatcher.parent)
		var/message_to_log = "[key_name(mob_to_add)] entered [src] inside of [parent_atom] at [loc_name(soulcatcher_turf)]"
		parent_atom.log_message(message_to_log, LOG_GAME)
		mob_to_add.log_message(message_to_log, LOG_GAME)

	return TRUE

/// Converts a mind into a soul and adds the resulting soul to the room.
/datum/carrier_room/proc/add_soul_from_mind(datum/mind/mind_to_add, hide_participant_identity = TRUE)
	if(!mind_to_add)
		return FALSE

	var/datum/component/carrier/parent_soulcatcher = master_carrier.resolve()
	var/datum/parent_object = parent_soulcatcher.parent
	if(!parent_object)
		return FALSE

	var/mob/living/soulcatcher_soul/new_soul = new(parent_object)
	if(mind_to_add.current)
		var/datum/component/previous_body/body_component = mind_to_add.current.AddComponent(/datum/component/previous_body)
		body_component.soulcatcher_soul = WEAKREF(new_soul)

		new_soul.round_participant = TRUE
		new_soul.body_scan_needed = TRUE
		new_soul.previous_body = WEAKREF(mind_to_add.current)

	var/datum/component/carrier_user/soul_component = parent_soulcatcher.add_mob(new_soul, src)
	if(!soul_component)
		return FALSE

	if(hide_participant_identity && new_soul.round_participant)
		soul_component.name = pick(GLOB.last_names) //Until the body is discovered, the soul is a new person.
		soul_component.desc = "[new_soul] lacks a discernible form."

	mind_to_add.transfer_to(new_soul, TRUE)
	current_mobs += new_soul
	soul_component.current_room = WEAKREF(src)

	to_chat(new_soul, span_cyan("You find yourself now inside of: [name]"))
	to_chat(new_soul, span_notice(room_description))
	to_chat(new_soul, span_doyourjobidiot("You have entered a soulcatcher, do not share any information you have received while a ghost. If you have died within the round, you do not know your identity until your body has been scanned, standard blackout policy also applies."))
	to_chat(new_soul, span_notice("While inside of [src], you are able to speak and emote by using the normal hotkeys and verbs, unless disabled by the owner."))
	to_chat(new_soul, span_notice("You may use the leave soulcatcher verb to leave the soulcatcher and return to your body at any time."))

	var/atom/parent_atom = parent_object
	if(istype(parent_atom))
		var/turf/soulcatcher_turf = get_turf(parent_soulcatcher.parent)
		var/message_to_log = "[key_name(new_soul)] entered [src] inside of [parent_atom] at [loc_name(soulcatcher_turf)]"
		parent_atom.log_message(message_to_log, LOG_GAME)
		new_soul.log_message(message_to_log, LOG_GAME)

	return TRUE

/// Removes a mob from a carrier room, leaving it as a ghost. Returns `FALSE` if the `mob_to_remove` cannot be found, otherwise returns `TRUE` after a successful deletion.
/datum/carrier_room/proc/remove_mob(mob/living/mob_to_remove)
	if(!mob_to_remove || !(mob_to_remove in current_mobs))
		return FALSE

	var/datum/component/carrier_user/carrier_component = mob_to_remove.GetComponent(/datum/component/carrier_user)
	if(carrier_component)
		qdel(carrier_component)

	current_mobs -= mob_to_remove

	var/mob/living/soulcatcher_soul/soul_to_remove = mob_to_remove
	if(istype(soul_to_remove))
		soul_to_remove.return_to_body()
		qdel(soul_to_remove)

		return TRUE

	var/datum/component/carrier/parent_soulcatcher = master_carrier.resolve()
	if(!parent_soulcatcher)
		master_carrier = null
		return FALSE
	else if(!parent_soulcatcher.parent)
		return FALSE

	var/turf/current_tile = get_turf(parent_soulcatcher.parent)
	mob_to_remove.forceMove(current_tile)

	return TRUE

/**
 * Sends a message or emote to all of the souls currently located inside of the carrier room. Returns `FALSE` if a message cannot be sent, otherwise returns `TRUE`.
 *
 * Arguments
 * * message_to_send - The message we want to send to the occupants of the room
 * * sender_name - The person that is sending the message. This is not required.
 * * sender_mob - The person that is sending the message. This is not required.
 * * emote - Is the message sent an emote or not?
 */
/datum/carrier_room/proc/send_message(message_to_send, sender_name, mob/living/sender_mob, emote = FALSE)
	if(!message_to_send) //Why say nothing?
		return FALSE

	var/datum/asset/spritesheet/sheet = get_asset_datum(/datum/asset/spritesheet/chat)
	var/master_resolved = master_carrier.resolve()
	if(!master_resolved)
		master_carrier = null
		return FALSE

	var/datum/component/carrier/parent_soulcatcher = master_resolved
	var/tag = sheet.icon_tag(parent_soulcatcher.chat_icon)
	var/soulcatcher_icon = ""

	if(tag)
		soulcatcher_icon = tag

	var/datum/component/carrier_user/user_component
	if(istype(sender_mob))
		user_component = sender_mob.GetComponent(/datum/component/carrier_user)
		if(!istype(user_component))
			return FALSE

	if(istype(user_component) && user_component.communicating_externally)
		var/obj/item/parent_object = parent_soulcatcher.parent
		if(!istype(parent_object))
			return FALSE

		var/temp_name = parent_object.name
		parent_object.name = "[parent_object.name] [soulcatcher_icon]"

		if(emote)
			parent_object.manual_emote(html_decode(message_to_send))
			log_emote("[sender_mob] in [name] carrier room emoted: [message_to_send], as an external object")
		else
			parent_object.say(html_decode(message_to_send))
			log_say("[sender_mob] in [name] carrier room said: [message_to_send], as an external object")

		parent_object.name = temp_name
		return TRUE

	var/first_room_name_word = splittext(name, " ")
	var/message = ""
	var/owner_message = ""
	if(!emote)
		message = "<font color=[room_color]>\ [soulcatcher_icon] <b>[sender_name]</b> says, \"[message_to_send]\"</font>"
		owner_message = "<font color=[room_color]>\ <b>([first_room_name_word[1]])</b> [soulcatcher_icon] <b>[sender_name]</b>says, \"[message_to_send]\"</font>"
		log_say("[sender_mob] in [name] carrier room said: [message_to_send]")
	else
		message = "<font color=[room_color]>\ [soulcatcher_icon] <b>[sender_name]</b> [message_to_send]</font>"
		owner_message = "<font color=[room_color]>\ <b>([first_room_name_word[1]])</b> [soulcatcher_icon] <b>[sender_name]</b>[message_to_send]</font>"
		log_emote("[sender_mob] in [name] carrier room emoted: [message_to_send]")

	for(var/mob/living/soul as anything in current_mobs)
		var/message_eligible = SEND_SIGNAL(soul, COMSIG_CARRIER_MOB_CHECK_INTERNAL_SENSES, emote)
		if(!message_eligible)
			continue

		to_chat(soul, message)

	relay_message_to_soulcatcher(owner_message)
	return TRUE

/// Relays a message sent from the send_message proc to the parent carrier datum
/datum/carrier_room/proc/relay_message_to_soulcatcher(message)
	if(!message)
		return FALSE

	var/datum/component/carrier/recepient_soulcatcher = master_carrier.resolve()
	recepient_soulcatcher.recieve_message(message)
	return TRUE

/datum/carrier_room/Destroy(force, ...)
	for(var/mob/living/occupant as anything in current_mobs)
		remove_mob(occupant)

	return ..()

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

	var/datum/carrier_room/room_to_join = tgui_input_list(src, "Choose a room to enter", "Enter a room", rooms_to_join)
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
