///Global list containing any and all soulcatchers
GLOBAL_LIST_EMPTY(soulcatchers)

/datum/nifsoft/soulcatcher
	name = "Soulcatcher"
	program_desc = "Holds souls"
	/// What is the linked soulcatcher datum used by this NIFSoft?
	var/datum/linked_soulcatcher

/obj/item/soulcatcher_item
	name = "soulcatcher item"
	icon = 'icons/obj/wizard.dmi'
	icon_state = "soulstone"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	/// What soulcatcher datum is associated with this item?
	var/datum/soulcatcher/linked_soulcatcher

/obj/item/soulcatcher_item/New(loc, ...)
	. = ..()
	linked_soulcatcher = new (src)

/datum/soulcatcher
	/// What is the room we are sending messages to?
	var/datum/soulcatcher_room/current_room
	/// What rooms are linked to this soulcatcher
	var/list/soulcatcher_rooms = list()
	/// Are ghosts currently able to join this soulcatcher?
	var/ghost_joinable = TRUE

/datum/soulcatcher/New()
	. = ..()
	create_room()
	current_room = soulcatcher_rooms[1]
	GLOB.soulcatchers += src

/datum/soulcatcher/Destroy(force, ...)
	GLOB.soulcatchers -= src
	current_room = null
	for(var/datum/soulcatcher_room in soulcatcher_rooms)
		soulcatcher_rooms -= soulcatcher_room
		qdel(soulcatcher_room)


	return ..()

/**
 * Creates a `/datum/soulcatcher_room` and adds it to the `soulcatcher_rooms` list.
 *
 * Arguments
 * * target_name - The name that we want to assign to the created room.
 * * target_desc - The description that we want to assign to the created room.
 */
/datum/soulcatcher/proc/create_room(target_name = "default room", target_desc = "it's a room")
	var/datum/soulcatcher_room/created_room = new (src)
	created_room.name = target_name
	created_room.room_description = target_desc
	soulcatcher_rooms += created_room

	created_room.master_soulcatcher = WEAKREF(src)

/datum/soulcatcher_room
	/// What is the name of the room?
	var/name = "Test Room"
	/// What is the description of the room?
	var/room_description = "It sure is a room."
	/// What souls are currently inside of the room?
	var/list/current_souls = list()
	/// Weakref for the master soulcatcher datum
	var/datum/weakref/master_soulcatcher

/// Attemps to add a ghost to the soulcatcher room.
/datum/soulcatcher_room/proc/add_soul_from_ghost(mob/dead/observer/ghost)
	if(!ghost || !ghost.ckey)
		return FALSE

	if(!ghost.mind)
		ghost.mind = new /datum/mind(ghost.key)
		ghost.mind.name = name
		ghost.mind.active = TRUE

	if(!add_soul(ghost.mind))
		return FALSE

	return TRUE

/// Converts a mind into a soul and adds the resulting soul to the room.
/datum/soulcatcher_room/proc/add_soul(datum/mind/mind_to_add)
	if(!mind_to_add)
		return FALSE

	var/mob/living/soulcatcher_soul/new_soul = new (src)
	if(mind_to_add.current)
		new_soul.previous_body = WEAKREF(mind_to_add.current)

	mind_to_add.transfer_to(new_soul)
	current_souls += new_soul

	to_chat(new_soul, span_warning(name))
	to_chat(new_soul, span_notice(room_description))

	return TRUE

/// Removes a soul from a soulcatcher room, leaving it as a ghost.
/datum/soulcatcher_room/proc/remove_soul(mob/living/soulcatcher_soul/soul_to_remove)
	if(!soul_to_remove || !(soul_to_remove in current_souls))
		return FALSE

	qdel(soul_to_remove)

/datum/soulcatcher_room/Destroy(force, ...)
	for(var/mob/living/soulcatcher_soul in current_souls)
		qdel(soulcatcher_soul)
		current_souls -= soulcatcher_soul

	return ..()

/mob/living/soulcatcher_soul
	/// What is the true name of our soul? This is mostly here incase we have someone that has died in a round that we need to obfuscate the name for.
	var/true_name
	/// Assuming we died inside of the round? What is our previous body?
	var/datum/weakref/previous_body

/mob/living/soulcatcher_soul/Destroy()
	if(previous_body && mind)
		var/mob/target_body = previous_body.resolve()
		mind.transfer_to(target_body)
		var/datum/component/previous_body/body_component = target_body.GetComponent(/datum/component/previous_body) //Is the soul currently within a soulcatcher?
		if(body_component)
			body_component.restore_mind = FALSE
			qdel(body_component)

		if(target_body.stat != DEAD)
			target_body.grab_ghost()

	return ..()

/datum/component/previous_body
	/// What soulcatcher soul do we need to return to the body?
	var/datum/weakref/soulcatcher_soul
	/// Do we want to try and restore the mind when this is destroyed?
	var/restore_mind = TRUE

/datum/component/previous_body/Initialize(...)
	. = ..()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE


// Attemps to transfer the mind of the soul back to the original body.
/datum/component/previous_body/Destroy(force, silent)
	if(restore_mind)
		var/mob/living/original_body = parent
		var/mob/living/soulcatcher_soul/soul = soulcatcher_soul.resolve()
		if(original_body && soul && !original_body.mind)
			var/datum/mind/mind_to_tranfer = soul.mind
			if(mind_to_tranfer)
				mind_to_tranfer.transfer_to(original_body)

	return ..()

/mob/dead/observer/verb/join_soulcatcher()
	set name = "Enter soulcatcher"
	set category = "Ghost"

	var/list/joinable_soulcatchers = GLOB.soulcatchers.Copy()
	for(var/datum/soulcatcher/soulcatcher in joinable_soulcatchers)
		if(soulcatcher.ghost_joinable)
			continue
		joinable_soulcatchers -= (soulcatcher)

	if(!length(joinable_soulcatchers))
		to_chat(src, span_warning("No soulcatchers are joinable."))
		return FALSE

	var/datum/soulcatcher/soulcatcher_to_join = tgui_input_list(src, "Chose a soulcatcher to join", "Enter a soulcatcher", joinable_soulcatchers)
	if(!soulcatcher_to_join || !(soulcatcher_to_join in joinable_soulcatchers))
		return FALSE

	soulcatcher_to_join.current_room.add_soul_from_ghost(src)

/mob/grab_ghost(force)
	var/datum/component/previous_body/old_body = GetComponent(/datum/component/previous_body) //Is the soul currently within a soulcatcher?
	if(old_body)
		qdel(old_body)

	return ..()
