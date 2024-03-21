/datum/component/carrier/soulcatcher
	able_to_transfer_to_another_carrier = TRUE
	/// Are ghosts currently able to join this soulcatcher?
	var/ghost_joinable = TRUE
	/// Is the soulcatcher removable from the parent object?
	var/removable = FALSE

	type_of_room_to_create = /datum/carrier_room/soulcatcher

/datum/component/carrier/soulcatcher/New()
	. = ..()
	GLOB.soulcatchers += src

/datum/component/carrier/soulcatcher/Destroy(force, ...)
	GLOB.soulcatchers -= src
	return ..()

/datum/component/carrier/soulcatcher/nifsoft
	single_owner = TRUE

/// Attempts to remove the carrier from the attached object
/datum/component/carrier/soulcatcher/proc/remove_self()
	if(!removable)
		return FALSE

	qdel(src)

/// Returns a list of all of the rooms that a soul can join/transfer into. `ghost_join` checks if the room is accessible to ghosts.
/datum/component/carrier/soulcatcher/get_open_rooms(ghost_join = FALSE)
	var/list/datum/carrier_room/room_list = list()
	for(var/datum/carrier_room/room as anything in carrier_rooms)
		if((ghost_join && !room.joinable) || !check_for_vacancy())
			continue

		room_list += room

	return room_list

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

/datum/carrier_room/soulcatcher
	/// What is the name of the room?
	name = "Default Room"
	/// What is the description of the room?
	room_description = "An orange platform suspended in space orbited by reflective cubes of various sizes. There really isn't much here at the moment."

/// Attemps to add a ghost to the soulcatcher room.
/datum/carrier_room/soulcatcher/proc/add_soul_from_ghost(mob/dead/observer/ghost)
	if(!ghost || !ghost.ckey)
		return FALSE

	if(!ghost.mind)
		ghost.mind = new /datum/mind(ghost.key)
		ghost.mind.name = ghost.name
		ghost.mind.active = TRUE

	if(!add_soul_from_mind(ghost.mind))
		return FALSE

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

	set_overlay_for_mob(new_soul)
	return TRUE
