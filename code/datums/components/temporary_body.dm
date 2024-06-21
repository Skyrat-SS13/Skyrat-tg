/**
 * ##temporary_body
 *
 * Used on living mobs when they are meant to be a 'temporary body'
 * Holds a reference to an old mind & body, to put them back in
 * once the body this component is attached to, is being deleted.
 */
/datum/component/temporary_body
	///The old mind we will be put back into when parent is being deleted.
	var/datum/weakref/old_mind_ref
	///The old body we will be put back into when parent is being deleted.
	var/datum/weakref/old_body_ref

/datum/component/temporary_body/Initialize(datum/mind/old_mind, mob/living/old_body)
	if(!isliving(parent) || !isliving(old_body))
		return COMPONENT_INCOMPATIBLE
	ADD_TRAIT(old_body, TRAIT_MIND_TEMPORARILY_GONE, REF(src))
	src.old_mind_ref = WEAKREF(old_mind)
	src.old_body_ref = WEAKREF(old_body)

/datum/component/temporary_body/RegisterWithParent()
	RegisterSignal(parent, COMSIG_QDELETING, PROC_REF(on_parent_destroy))

/datum/component/temporary_body/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_QDELETING)

/**
 * Sends the mind of the temporary body back into their previous host
 * If the previous host is alive, we'll force them into the body.
 * Otherwise we'll let them hang out as a ghost still.
 */
/datum/component/temporary_body/proc/on_parent_destroy()
	SIGNAL_HANDLER
	var/datum/mind/old_mind = old_mind_ref?.resolve()
	var/mob/living/old_body = old_body_ref?.resolve()

	if(!old_mind || !old_body)
		return

	var/mob/living/living_parent = parent
	var/mob/dead/observer/ghost = living_parent.ghostize()
	if(!ghost)
		ghost = living_parent.get_ghost()
	if(!ghost)
		CRASH("[src] belonging to [parent] was completely unable to find a ghost to put back into a body!")
	ghost.mind = old_mind
	if(old_body.stat != DEAD)
		old_mind.transfer_to(old_body, force_key_move = TRUE)
	else
		old_mind.set_current(old_body)

	REMOVE_TRAIT(old_body, TRAIT_MIND_TEMPORARILY_GONE, REF(src))

	old_mind = null
	old_body = null
