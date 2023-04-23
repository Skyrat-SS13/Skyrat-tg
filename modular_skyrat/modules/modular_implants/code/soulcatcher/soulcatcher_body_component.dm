/// A component that is given to a body when the soul inside is inhabiting a soulcatcher. this is mostly here so that the bodies of souls can be revived.
/datum/component/previous_body
	/// What soulcatcher soul do we need to return to the body?
	var/datum/weakref/soulcatcher_soul
	/// Do we want to try and restore the mind when this is destroyed?
	var/restore_mind = TRUE

/datum/component/previous_body/Initialize(...)
	. = ..()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE

	RegisterSignal(parent, COMSIG_SOULCATCHER_RETURN_SOUL, .proc/signal_destroy)

/// Destroys the source component through a signal. `mind_restored` controls whether or not the mind will be grabbed upon deletion.
/datum/component/previous_body/proc/signal_destroy(mob/source_mob, mind_restored = TRUE)
	SIGNAL_HANDLER
	qdel(src)

	return TRUE

/// Attempts to destroy the component. If `restore_mind` is true, it will attempt to place the mind back inside of the body and delete the soulcatcher soul.
/datum/component/previous_body/Destroy(force, silent)
	UnregisterSignal(parent, COMSIG_SOULCATCHER_RETURN_SOUL)

	if(restore_mind)
		var/mob/living/original_body = parent
		var/mob/living/soulcatcher_soul/soul = soulcatcher_soul.resolve()
		if(original_body && soul && !original_body.mind)
			var/datum/mind/mind_to_tranfer = soul.mind
			if(mind_to_tranfer)
				mind_to_tranfer.transfer_to(original_body)

			soul.previous_body = FALSE
			qdel(soul)

	return ..()
