/datum/element/dusts_on_catatonia
	element_flags = ELEMENT_DETACH_ON_HOST_DESTROY

	/// Set of all attached mobs.
	var/list/attached_mobs = list()

/datum/element/dusts_on_catatonia/Attach(datum/target)
	. = ..()

	if(!isliving(target))
		return ELEMENT_INCOMPATIBLE

	attached_mobs[target] = TRUE

	START_PROCESSING(SSprocessing, src)

/datum/element/dusts_on_catatonia/Detach(datum/target)
	. = ..()

	attached_mobs -= target

	if(!attached_mobs.len)
		STOP_PROCESSING(SSprocessing, src)

/datum/element/dusts_on_catatonia/process()
	for(var/mob/living/attached as anything in attached_mobs)
		if(attached.key || attached.get_ghost())
			continue

		attached.investigate_log("was dusted due to no longer being linked to a player or ghost.", INVESTIGATE_DEATHS)
		attached.dust(TRUE, force = TRUE)
		Detach(attached)
