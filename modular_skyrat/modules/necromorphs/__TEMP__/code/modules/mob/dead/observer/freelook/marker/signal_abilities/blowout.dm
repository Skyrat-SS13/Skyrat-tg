/datum/signal_ability/blowout
	name = "Blowout"
	id = "blowout"
	desc = "Destroys a target wall light, with an explosion of sparks. Be careful with overusing this ability, necromorphs need light to see, too. destroying too many lights can harm your own team"
	target_string = "A wall light"
	energy_cost = 40
	cooldown = 3 SECONDS

	target_types = list(/obj/machinery/light)

	targeting_method	=	TARGET_CLICK


/datum/signal_ability/blowout/on_cast(var/mob/user, var/atom/target, var/list/data)
	var/obj/machinery/light/L = target
	L.broken(FALSE)