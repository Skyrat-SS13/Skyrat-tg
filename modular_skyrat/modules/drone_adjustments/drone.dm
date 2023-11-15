/obj/machinery/drone_dispenser/Initialize(mapload)
	//So that there are starting drone shells in the beginning of the shift
	if(mapload)
		starting_amount = 10000
	return ..()

/obj/item/card/id/advanced/simple_bot
	//So that the drones can actually access everywhere and fix it
	trim = /datum/id_trim/centcom

/obj/machinery/door/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/sliding_under)

//This is so we log all machinery interactions for drones
/obj/machinery/attack_drone(mob/living/basic/drone/user, list/modifiers)
	. = ..()
	user.log_message("[key_name(user)] interacted with [src] at [AREACOORD(src)]", LOG_GAME)

/mob/living/basic/drone
	//So that drones can do things without worrying about stuff
	shy = FALSE
	//So drones aren't forced to carry around a nodrop toolbox essentially
	default_storage = /obj/item/storage/backpack/drone_bag

/mob/living/basic/drone/Initialize(mapload)
	. = ..()
	name = "[initial(name)] [rand(0,9)]-[rand(100,999)]" //So that we can identify drones from each other
	AddComponent(/datum/component/personal_crafting)

/obj/item/storage/backpack/drone_bag
	name = "drone backpack"

/obj/item/storage/backpack/drone_bag/PopulateContents()
	. = ..()
	new /obj/item/crowbar(src)
	new /obj/item/wrench(src)
	new /obj/item/screwdriver(src)
	new /obj/item/weldingtool(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)
	new /obj/item/pipe_dispenser(src)
	new /obj/item/t_scanner(src)
	new /obj/item/analyzer(src)
	new /obj/item/stack/cable_coil(src)
