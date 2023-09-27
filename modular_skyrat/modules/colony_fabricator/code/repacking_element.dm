/// An element that allows objects to be right clicked and turned into another item after a delay
/datum/element/repackable
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 2

	/// The path to spawn when the repacking operation is complete
	var/item_to_pack_into
	/// How long will repacking the attachee take
	var/repacking_time
	/// Do we tell objects destroyed that we disassembled them?
	var/disassemble_objects

/datum/element/repackable/Attach(datum/target, item_to_pack_into = /obj/item, repacking_time = 1 SECONDS, disassemble_objects = TRUE)
	. = ..()
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE

	src.item_to_pack_into = item_to_pack_into
	src.repacking_time = repacking_time
	src.disassemble_objects = disassemble_objects

	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(examine))
	RegisterSignal(target, COMSIG_ATOM_ATTACK_HAND_SECONDARY, PROC_REF(on_right_click))

/datum/element/repackable/Detach(datum/target)
	. = ..()
	UnregisterSignal(target, COMSIG_ATOM_EXAMINE)
	UnregisterSignal(target, COMSIG_ATOM_ATTACK_HAND_SECONDARY)

/datum/element/repackable/proc/examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER

	examine_list += span_notice("It can be <b>repacked</b> with <b>right click</b>.")

/// Checks if the user can actually interact with the structures in question, then invokes the proc to make it repack
/datum/element/repackable/proc/on_right_click(atom/source, mob/user)
	SIGNAL_HANDLER

	if(!source.can_interact(user) || !user.can_perform_action(source))
		return

	INVOKE_ASYNC(src, PROC_REF(repack), source, user)

/// Removes the element target and spawns a new one of whatever item_to_pack_into is
/datum/element/repackable/proc/repack(atom/source, mob/user)
	source.balloon_alert_to_viewers("repacking...")
	if(!do_after(user, 3 SECONDS, target = source))
		return
	new item_to_pack_into(source.drop_location())
	source.playsound(src, 'sound/items/ratchet.ogg', 50, TRUE)
	if(istype(source, /obj))
		source.deconstruct(disassembled = TRUE)
	else
		qdel(source)
