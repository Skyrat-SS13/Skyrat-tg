/datum/corrupted_flesh_controller
	/// A list of all of our currently controlled turf objects.
	var/list/controlled_turf_objects = list()
	/// A list of all of our currently controlled mobs.
	var/list/controlled_mobs = list()

/datum/corrupted_flesh_controller/proc/register_new_controlled_mob(mob/living/simple_animal/hostile/corrupted_flesh/new_mob)
	if(!istype(new_mob))
		return
	controlled_mobs += new_mob
	new_mob.our_controller = WEAKREF(src)
	RegisterSignal(new_mob, COMSIG_LIVING_DEATH, .proc/register_controlled_mob_death)


/**
 * This proc is used when a mob dies that was controlled by this controller.
 * When this happens, we need to remove it from our controlled list and change our stats accordingly.
 */
/datum/corrupted_flesh_controller/proc/register_controlled_mob_death(mob/living/simple_animal/hostile/corrupted_flesh/mob_that_died, gibbed)
	SIGNAL_HANDLER
	if(!istype(mob_that_died))
		return
	mob_that_died.our_controller = null

