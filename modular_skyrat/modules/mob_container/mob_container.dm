#define COMSIG_MOB_CONTAINER_ENTERED "mob_container_entered"
#define COMSIG_MOB_CONTAINER_EXITED "mob_container_left"
#define COMSIG_MOB_ENTER_CONTAINER "mob_enter_container"
#define COMSIG_MOB_EXIT_CONTAINER "mob_exit_container"

#define COMSIG_MOB_HAS_CONTAINER "mob_has_container"

#define COMSIG_CONTAINER_STORE_MOB "container_store_mob"
#define COMSIG_CONTAINER_REMOVE_MOB "container_remove_mob"
#define COMSIG_CONTAINER_DUMP_ALL "container_dump_all"

#define COMSIG_MOB_LEAVE_CONTAINER "mob_leave_container"

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

	RegisterSignal(mob_holder, COMSIG_CONTAINER_STORE_MOB, .proc/store_mob_handler)
	RegisterSignal(mob_holder, COMSIG_CONTAINER_REMOVE_MOB, .proc/remove_mob_handler)
	RegisterSignal(mob_holder, COMSIG_CONTAINER_DUMP_ALL, .proc/dump_all_mobs)

	RegisterSignal(mob_holder, COMSIG_MOB_LEAVE_CONTAINER, .proc/leave_container)

	RegisterSignal(mob_holder, COMSIG_MOB_HAS_CONTAINER, .proc/container_exist_check)

/datum/component/mob_container/Destroy()
	. = ..()

	for(var/mob/contained in mobs_held)
		remove_mob_explicitly(mobs_held)

	mob_holder = null
	mobs_held.Cut()

	UnregisterSignal(mob_holder, list(COMSIG_MOB_CONTAINER_ENTERED, COMSIG_MOB_CONTAINER_EXITED, COMSIG_MOB_ENTER_CONTAINER, COMSIG_MOB_EXIT_CONTAINER, COMSIG_CONTAINER_STORE_MOB, COMSIG_CONTAINER_REMOVE_MOB, COMSIG_CONTAINER_DUMP_ALL, COMSIG_MOB_LEAVE_CONTAINER))

/**
 * Used to check whether or not a mob has a container. We don't want to contain mobs that don't have containers.
 */
/datum/component/mob_container/proc/container_exist_check()
	return TRUE

/**
 * Proc to leave the container we're currently inside of.
 */
/datum/component/mob_container/proc/leave_container(datum/source)
	SIGNAL_HANDLER

	var/mob/our_container = mob_holder.loc

	if(!istype(our_container))
		return

	SEND_SIGNAL(our_container, COMSIG_CONTAINER_REMOVE_MOB, mob_holder)

/**
 * Signal handler for storing a mob.
 */
/datum/component/mob_container/proc/store_mob_handler(datum/source, mob/to_store)
	SIGNAL_HANDLER

	if(!to_store)
		return

	store_mob_explicitly(to_store)

/**
 * Signal handler for removing a mob.
 */
/datum/component/mob_container/proc/remove_mob_handler(datum/source, mob/to_remove)
	SIGNAL_HANDLER

	if(!to_remove)
		return

	remove_mob_explicitly(to_remove)

/**
 * Signal handler for dumping every mob inside of us.
 */
/datum/component/mob_container/proc/dump_all_mobs()
	SIGNAL_HANDLER

	for(var/mob/contained in mobs_held)
		remove_mob_explicitly(contained)

/**
 * Stores a mob inside of our parent mob.
 *
 * mob/to_store | the mob to store inside of us
 * force | if TRUE, we'll store a containerless mob
 */
/datum/component/mob_container/proc/store_mob_explicitly(mob/to_store, force = FALSE)
	if(!istype(to_store))
		return

	if(!SEND_SIGNAL(to_store, COMSIG_MOB_HAS_CONTAINER) && !force)
		return

	if(!SEND_SIGNAL(mob_holder, COMSIG_MOB_CONTAINER_ENTERED, to_store) || !SEND_SIGNAL(to_store, COMSIG_MOB_ENTER_CONTAINER, mob_holder))
		return

	to_store.forceMove(mob_holder)
	to_store.overlay_fullscreen("in_mob_container", fullscreen_overlay, 1)
	mobs_held |= to_store

/**
 * Removes a mob from inside our parent mob.
 *
 * mob/to_store | the mob to remove from us
 */
/datum/component/mob_container/proc/remove_mob_explicitly(mob/to_remove)
	if(!istype(to_remove) && !(to_remove in mob_holder || to_remove.loc == mob_holder))
		return

	if(!SEND_SIGNAL(mob_holder, COMSIG_MOB_CONTAINER_EXITED, to_remove) || !SEND_SIGNAL(to_remove, COMSIG_MOB_EXIT_CONTAINER, mob_holder))
		return

	to_remove.forceMove(get_turf(mob_holder))
	to_remove.clear_fullscreen("in_mob_container")
	mobs_held -= to_remove

/**
 * Called whenever we enter another mob. If our return value is FALSE, we won't enter the mob.
 *
 * mob/mob_were_entering | the mob we're being put inside of
 */
/datum/component/mob_container/proc/on_enter_container(datum/source, mob/mob_were_entering)
	SIGNAL_HANDLER

	return TRUE

/**
 * Called whenever we exit another mob. If our return value is FALSE, we won't exit the mob.
 *
 * mob/mob_were_exiting | the mob we're being taken out of
 */
/datum/component/mob_container/proc/on_exit_container(datum/source, mob/mob_were_exiting)
	SIGNAL_HANDLER

	return TRUE

/**
 * Called whenever a mob enters us. If our return value is FALSE, the mob won't enter us.
 *
 * mob/mob_entering | the mob entering us
 */
/datum/component/mob_container/proc/on_container_entered(datum/source, mob/mob_entering)
	SIGNAL_HANDLER

	return TRUE

/**
 * Called whenever a mob exits us. If our return value is FALSE, the mob won't exit us.
 *
 * mob/mob_exiting | the mob leaving us
 */
/datum/component/mob_container/proc/on_container_exited(datum/source, mob/mob_exiting)
	SIGNAL_HANDLER

	return TRUE
