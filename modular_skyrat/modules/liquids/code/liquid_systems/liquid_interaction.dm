///This element allows for items to interact with liquids on turfs.
/datum/component/liquids_interaction
	///Callback interaction called when the turf has some liquids on it
	var/datum/callback/interaction_callback

/datum/component/liquids_interaction/Initialize(on_interaction_callback)
	. = ..()

	if(!istype(parent, /obj/item))
		return COMPONENT_INCOMPATIBLE

	interaction_callback = CALLBACK(parent, on_interaction_callback)

/datum/component/liquids_interaction/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ITEM_INTERACTING_WITH_ATOM, PROC_REF(item_interaction)) //The only signal allowing item -> turf interaction

/datum/component/liquids_interaction/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ITEM_INTERACTING_WITH_ATOM)

/datum/component/liquids_interaction/proc/item_interaction(datum/source, mob/living/user, atom/target, modifiers)
	SIGNAL_HANDLER

	var/turf/turf_target = target
	if(!isturf(target) || !turf_target.liquids)
		return NONE

	if(interaction_callback.Invoke(turf_target, user, turf_target.liquids))
		return ITEM_INTERACT_SUCCESS
