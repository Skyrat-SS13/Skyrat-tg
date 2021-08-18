//This component makes the ckey return to a body on death
/datum/component/return_on_death
	var/mob/sourcemob
	var/mob/currentmob

/datum/component/return_on_death/Initialize(mob/source, mob/current)
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(current, COMSIG_LIVING_DEATH, .proc/return_to_old_body)
	sourcemob = source
	currentmob = current

/datum/component/return_on_death/proc/return_to_old_body()
	SIGNAL_HANDLER
	if(sourcemob && !(QDELETED(sourcemob)) && !sourcemob.client)
		to_chat(currentmob, span_warning("Your current body no longer anchoring you, your soul returns to your original body."))
		source.ckey = currentmob.ckey
	else
		to_chat(currentmob, span_warning("You were unable to return to your old body as it was destroyed."))

/datum/component/return_on_death/UnregisterFromParent()
	UnregisterSignal(currentmob, COMSIG_LIVING_DEATH)
