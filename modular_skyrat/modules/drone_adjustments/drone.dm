/obj/machinery/drone_dispenser/Initialize(mapload)
	//So that there are starting drone shells in the beginning of the shift
	if(mapload)
		starting_amount = 10000
	return ..()

/obj/item/card/id/advanced/simple_bot
	//So that the drones can actually access everywhere and fix it
	trim = /datum/id_trim/centcom

//This is so we log all machinery interactions for drones
/obj/machinery/attack_drone(mob/living/simple_animal/drone/user, list/modifiers)
	. = ..()
	user.log_message("[key_name(user)] interacted with [src] at [AREACOORD(src)]", LOG_GAME)

/obj/machinery/door
	///The types of things that can slide under from bumping
	var/static/list/sliding_under_types = list(
		/mob/living/simple_animal/drone,
		/mob/living/simple_animal/cortical_borer,
	)

//This allows drones to slide under/through a door
/obj/machinery/door/Bumped(atom/movable/movable_atom)
	. = ..()
	addtimer(CALLBACK(src, .proc/sliding_under, movable_atom), 5)

/**
 * Called for when a movable atom tries to slide under the door
 */
/obj/machinery/door/proc/sliding_under(atom/movable/movable_atom)
	if(!is_type_in_list(movable_atom, sliding_under_types) || !density)
		return
	if(!do_after(movable_atom, 5 SECONDS, src))
		return
	movable_atom.forceMove(get_turf(src))
	to_chat(movable_atom, span_notice("You squeeze through [src]."))

/mob/living/simple_animal/drone
	//So that drones can do things without worrying about stuff
	shy = FALSE
	//So drones aren't forced to carry around a nodrop toolbox essentially
	default_storage = /obj/item/storage/backpack/drone_bag

/mob/living/simple_animal/drone/Initialize(mapload)
	. = ..()
	name = "[initial(name)] ([rand(100,999)])" //So that we can identify drones from each other

/obj/item/storage/backpack/drone_bag
	name = "drone backpack"
	desc = "For all your storing needs; it is possible to remove this."

/obj/item/storage/backpack/drone_bag/PopulateContents()
	. = ..()
	new /obj/item/crowbar(src)
	new /obj/item/wrench(src)
	new /obj/item/screwdriver(src)
	new /obj/item/weldingtool(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)
	new /obj/item/stack/cable_coil(src)
