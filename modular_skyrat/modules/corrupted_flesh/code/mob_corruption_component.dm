/datum/component/mob_corruption
	/// A list of factions to give the mob
	var/list/factions = list(FACTION_CORRUPTED_FLESH)

/datum/component/mob_corruption/Initialize(...)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	var/mob/living/parent_mob = parent

	if(parent_mob.stat != DEAD)
		RegisterSignal(parent_mob, COMSIG_LIVING_DEATH, .proc/ressurect)

	parent_mob.faction = LAZYCOPY(factions)



/datum/component/mob_corruption/proc/ressurect()
