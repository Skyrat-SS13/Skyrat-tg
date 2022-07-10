## A Notice on Mob Containers
Mob containers are for the express purpose of storing a mob inside of another mob. This is not for antagonistic nor further mechanical purposes, and should not be used for such things. This is not a solution for having atomic storage (see /datum/storage) inside of mobs: this is only for mob inside mob storage.
# Usage
## Adding a Mob to a Mob
Adding a mob to another mob is easy! Simply call the proc as following:
```dm
mob_storing_mob.store_mob(mob_were_storing)
```
## Removing a Mob from a Mob
Removing a mob from another mob is even easier!
```dm
mob_storing_mob.remove_mob(mob_were_removing)
```
If the mob is not found within the given mob, then `FALSE` will be returned.

# Custom Behaviors
Sometimes, you might want to give a specific behavior for when a mob enters or exits another mob, or when a mob enters or exits them. You can specify custom behaviors by doing the following:
```dm
/mob/some/mob/subtype/on_enter_container(mob/mob_were_entering)
	. = ..()
	
	[ . . . ]
```
```dm
/mob/some/mob/subtype/on_exit_container(mob/mob_were_exiting)
	. = ..()
	
	[ . . . ]
```
and ...
```dm
/mob/some/mob/subtype/on_container_entered(mob/mob_entering)
	. = ..()
	
	[ . . . ]
```
```dm
/mob/some/mob/subtype/on_container_exited(mob/mob_exiting)
	. = ..()
	
	[ . . . ]
```
`NOTICE:` There is zero reason to customize the behavior of `store_mob` and `remove_mob`. 

If you for some reason want to halt the entering or exiting process of the container, return `FALSE` inside of the respective proc, and the transfer will be halted.

# Signals
No. If you for some reason need something like `COMSIG_MOB_CONTAINER_ENTERED`, then you're doing something terribly wrong.
