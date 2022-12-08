/obj/item/grenade/hvac
	name = "Deployable space heater"
	desc = "An adorable grenade shaped like a miniature space heater.  It has a pin to pull on the side."
	icon = 'modular_skyrat/modules/deployable_hvac/icons/deployable_hvac.dmi'
	icon_state = "heatbang"
	inhand_icon_state = "flashbang"



/obj/item/grenade/hvac/detonate(mob/living/lanced_by)
	. = ..()
	if(!.)
		return

	new /obj/machinery/space_heater/deployable(get_turf(src.loc))
	qdel(src)



/obj/machinery/space_heater/deployable
	anchored = FALSE
	density = TRUE
	interaction_flags_machine = INTERACT_MACHINE_WIRES_IF_OPEN | INTERACT_MACHINE_ALLOW_SILICON | INTERACT_MACHINE_OPEN
	icon = 'modular_skyrat/modules/deployable_hvac/icons/deployable_hvac.dmi'
	icon_state = "sheater-off"
	base_icon_state = "sheater"
	name = "deployable space heater"
	desc = "A deployed compressed space heater.  It looks like it's made out of cardboard.  The Space Amish would be disappointed."
	max_integrity = 75 //It's weak and not very good for combat use.
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 80, ACID = 10)
	circuit = /obj/item/circuitboard/machine/space_heater
	on = TRUE // Starts on
	heating_power = 40000 // Default
	efficiency = 20000 // Default
