/datum/signal_ability/flicker
	name = "Flicker"
	id = "flicker"
	desc = "Causes a targeted light to flicker"
	target_string = "A wall light"
	energy_cost = 10

	target_types = list(/obj/machinery/light)

	targeting_method	=	TARGET_CLICK


/datum/signal_ability/flicker/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/obj/machinery/light/L = target
	L.flicker()


/datum/signal_ability/flicker/mass
	name = "Flicker, Mass"
	id = "flickermass"
	desc = "Causes all lights in an area to flicker"
	target_string = "A tile in the target area"
	energy_cost = 50
	cooldown = 10 SECONDS
	target_types = list(/turf)

	targeting_method	=	TARGET_CLICK

/datum/signal_ability/flicker/mass/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/list/lights = list()
	for (var/obj/machinery/light/L in view(world.view, target))
		lights |= L

	var/area/A = get_area(target)
	for (var/obj/machinery/light/L in A)
		lights |= L


	for (var/obj/machinery/light/L as anything in lights)
		L.flicker()