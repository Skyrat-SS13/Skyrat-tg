## A Notice on Mob Containers
Mob containers are for the express purpose of storing a mob inside of another mob. This is not for antagonistic nor further mechanical purposes, and should not be used for such things. This is not a solution for having atomic storage (see /datum/storage) inside of mobs: this is only for mob inside mob storage.
# Usage
## Adding a Mob to a Mob
Adding a mob to another mob is easy! Simply send the signal as following:
```dm
SEND_SIGNAL(mob_waiting_to_store, COMSIG_CONTAINER_STORE_MOB, mob_were_storing)
```
## Removing a Mob from a Mob
Removing a mob from another mob is even easier!
```dm
SEND_SIGNAL(mob_storing_said_mob, COMSIG_CONTAINER_REMOVE_MOB, mob_were_removing)
```
# Custom Behaviors
Sometimes, you might want to give a specific behavior for when a mob enters or exits another mob, or when a mob enters or exits them. You can specify custom behaviors by doing the following:
```dm
/datum/component/mob_container/subtype/on_enter_container(mob/mob_were_entering)
	. = ..()
	
	[ . . . ]
```
```dm
/datum/component/mob_container/subtype/on_exit_container(mob/mob_were_exiting)
	. = ..()
	
	[ . . . ]
```
and ...
```dm
/datum/component/mob_container/subtype/on_container_entered(mob/mob_entering)
	. = ..()
	
	[ . . . ]
```
```dm
/datum/component/mob_container/subtype/on_container_exited(mob/mob_exiting)
	. = ..()
	
	[ . . . ]
```
NOTICE: There is zero reason to customize the behavior of `store_mob_explicitly` and `remove_mob_explicitly`. 

If you for some reason want to halt the entering or exiting process of the container, return `FALSE` inside of the respective proc, and the transfer will be halted.
