#define COMSIG_MOB_CONTAINER_ENTERED "mob_container_entered"
#define COMSIG_MOB_CONTAINER_EXITED "mob_container_left"
#define COMSIG_MOB_ENTER_CONTAINER "mob_enter_container"
#define COMSIG_MOB_EXIT_CONTAINER "mob_exit_container"

/datum/component/mob_container
	/// The mob we're attached to.
	var/mob/mob_holder
	/// The mobs we're currently holding in our container.
	var/list/mobs_held = list()

	/// The fullscreen overlay we'll add to any mob inside us. Set this to null to add no overlay.
	var/atom/movable/screen/fullscreen_overlay = /atom/movable/screen/fullscreen/impaired

/datum/component/mob_container/Initialize()
	if(!ismob(parent))
		return COMPONENT_INCOMPATIBLE

	mob_holder = parent

	RegisterSignal(mob_holder, COMSIG_MOB_CONTAINER_ENTERED, .proc/on_container_entered)
	RegisterSignal(mob_holder, COMSIG_MOB_CONTAINER_EXITED, .proc/on_container_exited)
	RegisterSignal(mob_holder, COMSIG_MOB_ENTER_CONTAINER, .proc/on_enter_container)
	RegisterSignal(mob_holder, COMSIG_MOB_EXIT_CONTAINER, .proc/on_exit_container)

/datum/component/mob_container/Destroy()
	. = ..()

	for(var/mob/contained in mobs_held)
		contained.forceMove(get_turf(mob_holder))
		contained.clear_fullscreen("in_mob_container")

	mob_holder = null
	mobs_held.Cut()

	UnregisterSignal(mob_holder, list(COMSIG_MOB_CONTAINER_ENTERED, COMSIG_MOB_CONTAINER_EXITED, COMSIG_MOB_ENTER_CONTAINER, COMSIG_MOB_EXIT_CONTAINER))

/datum/component/mob_container/proc/store_mob_explicitly(mob/to_store)
	if(!istype(to_store))
		return

	if(!SEND_SIGNAL(mob_holder, COMSIG_MOB_CONTAINER_ENTERED, to_store) || !SEND_SIGNAL(to_store, COMSIG_MOB_ENTER_CONTAINER, mob_holder))
		return

	to_store.forceMove(mob_holder)
	to_store.overlay_fullscreen("in_mob_container", fullscreen_overlay, 1)
	mobs_held |= to_store

/datum/component/mob_container/proc/remove_mob_explicitly(mob/to_remove)
	if(!istype(to_remove) && !(to_remove in mob_holder || to_remove.loc == mob_holder))
		return

	if(!SEND_SIGNAL(mob_holder, COMSIG_MOB_CONTAINER_EXITED, to_remove) || !SEND_SIGNAL(to_remove, COMSIG_MOB_EXIT_CONTAINER, mob_holder))
		return

	to_remove.forceMove(get_turf(mob_holder))
	to_remove.clear_fullscreen("in_mob_container")
	mobs_held -= to_remove

/datum/component/mob_container/proc/on_enter_container(mob/mob_were_entering)
	SIGNAL_HANDLER

	return TRUE

/datum/component/mob_container/proc/on_exit_container(mob/mob_were_exiting)
	SIGNAL_HANDLER

	return TRUE

/datum/component/mob_container/proc/on_container_entered(mob/mob_entering)
	SIGNAL_HANDLER

	return TRUE

/datum/component/mob_container/proc/on_container_exited(mob/mob_exiting)
	SIGNAL_HANDLER

	return TRUE
