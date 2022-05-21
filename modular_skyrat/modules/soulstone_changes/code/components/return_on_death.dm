//This component makes the ckey be moved to a target body on death
/datum/component/return_on_death
	var/mob/sourcemob
	var/deleting

/datum/component/return_on_death/Initialize(mob/source)
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_LIVING_DEATH, .proc/return_to_old_body)
	RegisterSignal(parent, COMSIG_PARENT_QDELETING, .proc/return_to_old_body)
	sourcemob = source

/datum/component/return_on_death/proc/return_to_old_body()
	SIGNAL_HANDLER
	var/mob/currentmob = parent
	if(currentmob && sourcemob && !(QDELETED(sourcemob)) && !(QDELETED(currentmob)))
		to_chat(currentmob, span_warning("Your current body no longer anchoring you, your soul returns to your original body."))
		sourcemob.ckey = currentmob.ckey
		if(HAS_TRAIT_FROM(sourcemob, TRAIT_SACRIFICED, "sacrificed"))
			REMOVE_TRAIT(sourcemob, TRAIT_SACRIFICED, "sacrificed")
	else
		to_chat(currentmob, span_warning("You were unable to return to your old body as it was destroyed."))
	if(!QDELETED(src) && !deleting)
		qdel(src)
		deleting = TRUE


/datum/component/return_on_death/Destroy(force, silent)
	if(!deleting)
		deleting = TRUE
		return_to_old_body()
	sourcemob = null
	. = ..()


/datum/component/return_on_death/UnregisterFromParent()
	UnregisterSignal(parent, list(COMSIG_LIVING_DEATH, COMSIG_PARENT_QDELETING))
