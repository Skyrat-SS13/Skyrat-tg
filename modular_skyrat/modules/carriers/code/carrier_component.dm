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
	/// Is this carrier going to stay within the possesion of one mob within it's lifespan?
	var/single_owner = FALSE
	/// Is there a limit on the number of rooms that you can make?
	var/room_limit = FALSE

	/// What is the max number of people we can keep in this carrier? If this is set to `FALSE` we don't have a limit
	var/max_mobs = FALSE
	/// Do we want to prevent someone with the same type of carrier from being inside of our carrier?
	var/no_dolling = FALSE
	/// Are you able to move mobs out of this carrier?
	var/able_to_transfer_to_another_carrier = FALSE
	/// If we transfer a mob to another carrier, does it need to be the same type?
	var/same_type_only_transfer = TRUE
	/// What is the path of user component do we want to give to our mob? This needs to be `/datum/component/carrier_user` or a subtype.
	var/component_to_give = /datum/component/carrier_user
	/// What 16x16 chat icon do we want our carrier to display in chat messages?
	var/chat_icon = "nif-soulcatcher"
	/// What is the type of room that we want to create?
	var/type_of_room_to_create = /datum/carrier_room

/datum/component/carrier/New()
	. = ..()
	if(!parent)
		return COMPONENT_INCOMPATIBLE

	create_room()
	targeted_carrier_room = carrier_rooms[1]

	if(!single_owner)
		return TRUE

	update_targeted_carrier() // Give them the verbs if the soulcatcher is unlikely to change hands

/datum/component/carrier/Destroy(force, ...)
	targeted_carrier_room = null
	for(var/datum/carrier_room as anything in carrier_rooms)
		carrier_rooms -= carrier_room
		qdel(carrier_room)

	if(!single_owner)
		return ..()

	var/mob/living/holder = get_current_holder()
	if(!holder)
		return FALSE

	return ..()

/// Updates the target carrier component for the carrier me/emote verb to send messages to.
/datum/component/carrier/proc/update_targeted_carrier(mob/living/target_mob, inside_carrier = FALSE)
	var/mob/living/holder = get_current_holder()
	if(istype(target_mob))
		holder = target_mob

	if(!holder)
		return FALSE

	var/datum/component/carrier_communicator/communicator_component = holder.GetComponent(/datum/component/carrier_communicator)
	if(!istype(communicator_component))
		communicator_component = holder.AddComponent(/datum/component/carrier_communicator)

	communicator_component.target_carrier = WEAKREF(src)
	return communicator_component

/**
 * Creates a `/datum/carrier_room` and adds it to the `carrier_rooms` list.
 *
 * Arguments
 * * target_name - The name that we want to assign to the created room.
 * * target_desc - The description that we want to assign to the created room.
 */
/datum/component/carrier/proc/create_room(target_name, target_desc)
	if(room_limit && (length(carrier_rooms) >= room_limit))
		return FALSE

	var/datum/carrier_room/created_room = new type_of_room_to_create(src)
	if(target_name)
		created_room.name = target_name
	if(target_desc)
		created_room.room_description = target_desc

	carrier_rooms += created_room
	created_room.master_carrier = WEAKREF(src)

/// Tries to find out who is currently using the carrier, returns the holder. If no holder can be found, returns FALSE
/datum/component/carrier/proc/get_current_holder()
	var/mob/living/holder
	var/obj/item/parent_item = parent
	if(!istype(parent_item))
		return FALSE

	holder = parent_item.loc
	if(!istype(holder))
		return FALSE

	return holder

/// receives a message from a carrier room.
/datum/component/carrier/proc/receive_message(message_to_receive)
	if(!message_to_receive)
		return FALSE

	var/mob/living/carrier_owner = get_current_holder()
	if(!istype(carrier_owner))
		return FALSE

	to_chat(carrier_owner, message_to_receive)
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
		return FALSE

	else if(target_master_carrier != src)
		target_soul.forceMove(target_master_carrier.parent)

	var/datum/component/carrier_user/carrier_component = target_soul.GetComponent(/datum/component/carrier_user)
	var/datum/carrier_room/original_room = carrier_component?.current_room?.resolve()
	if(!istype(carrier_component) || !istype(original_room))
		return FALSE // Don't transfer someone that isn't already inside of a carrier.

	original_room.current_mobs -= target_soul
	var/datum/weakref/room_ref = WEAKREF(target_room)
	carrier_component.current_room = room_ref
	target_room.current_mobs += target_soul

	target_soul.clear_fullscreen("carrier", FALSE)
	to_chat(target_soul, span_cyan("you've been transferred to [target_room]!"))
	to_chat(target_soul, span_notice(target_room.room_description))

	return TRUE

/// Adds `mob_to_add` into the parent carrier, giving them the carrier component and moving their mob into the room. Returns the component added, if successful
/datum/component/carrier/proc/add_mob(mob/living/mob_to_add, datum/carrier_room/target_room)
	if(!istype(mob_to_add))
		return FALSE

	if(no_dolling)
		var/obj/item/carrier_holder/holder = locate() in mob_to_add.contents
		if(holder)
			var/datum/component/carrier/holder_component = holder.GetComponent(/datum/component/carrier)
			if(istype(holder_component, src))
				return FALSE

	var/datum/component/carrier_user/carrier_component = mob_to_add.AddComponent(component_to_give)
	if(!carrier_component)
		return FALSE

	if(!istype(target_room))
		target_room = carrier_rooms[1] // Put them in the first room we can find if none is provided.

	carrier_component.current_room = target_room
	var/datum/component/carrier_communicator/communicator_component = update_targeted_carrier(mob_to_add)
	communicator_component.carried_mob = TRUE
	target_room.set_overlay_for_mob(mob_to_add)

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
	var/name = "Carrier room"
	/// What is the description of the room?
	var/room_description = "it feels roomy in here."
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

/// Adds a mob into the carrier
/datum/carrier_room/proc/add_mob(mob/living/mob_to_add)
	if(!mob_to_add)
		return FALSE

	var/datum/component/carrier/parent_carrier = master_carrier.resolve()
	var/datum/parent_object = parent_carrier.parent
	if(!parent_object)
		return FALSE

	var/datum/component/carrier_user/carrier_component = parent_carrier.add_mob(mob_to_add, src)
	if(!carrier_component)
		return FALSE
	current_mobs += mob_to_add
	carrier_component.current_room = WEAKREF(src)
	mob_to_add.forceMove(parent_carrier.parent)

	to_chat(mob_to_add, span_cyan("You find yourself now inside of: [name]"))
	to_chat(mob_to_add, span_notice(room_description))

	var/atom/parent_atom = parent_object
	if(istype(parent_atom))
		var/turf/carrier_turf = get_turf(parent_carrier.parent)
		var/message_to_log = "[key_name(mob_to_add)] entered [src] inside of [parent_atom] at [loc_name(carrier_turf)]"
		parent_atom.log_message(message_to_log, LOG_GAME)
		mob_to_add.log_message(message_to_log, LOG_GAME)

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

	var/datum/component/carrier/parent_carrier = master_carrier.resolve()
	if(!parent_carrier)
		master_carrier = null
		return FALSE
	else if(!parent_carrier.parent)
		return FALSE

	var/turf/current_tile = get_turf(parent_carrier.parent)
	mob_to_remove.forceMove(current_tile)
	soul_to_remove.clear_fullscreen("carrier", FALSE)

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

	var/datum/component/carrier/parent_carrier = master_resolved
	var/tag = sheet.icon_tag(parent_carrier.chat_icon)
	var/soulcatcher_icon = ""

	if(tag)
		soulcatcher_icon = tag

	var/datum/component/carrier_user/user_component
	if(sender_mob && istype(sender_mob))
		user_component = sender_mob.GetComponent(/datum/component/carrier_user)
		if(!istype(user_component))
			return FALSE
	else
		sender_mob = "soulcatcher host"

	if(istype(user_component) && user_component.communicating_externally)
		var/obj/item/parent_object = parent_carrier.parent
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
		owner_message = "<font color=[room_color]>\ <b>([first_room_name_word[1]])</b> [soulcatcher_icon] <b>[sender_name]</b> says, \"[message_to_send]\"</font>"
		log_say("[sender_mob] in [name] carrier room said: [message_to_send]")
	else
		message = "<font color=[room_color]>\ [soulcatcher_icon] <b>[sender_name]</b> [message_to_send]</font>"
		owner_message = "<font color=[room_color]>\ <b>([first_room_name_word[1]])</b> [soulcatcher_icon] <b>[sender_name]</b> [message_to_send]</font>"
		log_emote("[sender_mob] in [name] carrier room emoted: [message_to_send]")

	for(var/mob/living/soul as anything in current_mobs)
		var/message_eligible = SEND_SIGNAL(soul, COMSIG_CARRIER_MOB_CHECK_INTERNAL_SENSES, emote)
		if(!message_eligible)
			continue

		to_chat(soul, message)

	relay_message_to_carrier(owner_message)
	return TRUE

/// Relays a message sent from the send_message proc to the parent carrier datum
/datum/carrier_room/proc/relay_message_to_carrier(message)
	if(!message)
		return FALSE

	var/datum/component/carrier/recepient_carrier = master_carrier.resolve()
	if(!recepient_carrier)
		return FALSE // This really isn't good.

	recepient_carrier.receive_message(message)
	return TRUE

/datum/carrier_room/Destroy(force, ...)
	for(var/mob/living/occupant as anything in current_mobs)
		remove_mob(occupant)

	return ..()
