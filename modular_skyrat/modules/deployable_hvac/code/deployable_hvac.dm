/obj/item/grenade/barrier/hvac
	name = "Deployable space heater"
	desc = "An adorable grenade shaped like a miniature space heater.  It has a pin to pull on the side."
	icon = 'icons/obj/weapons/grenade.dmi'
	icon_state = "heatbang"
	inhand_icon_state = "flashbang"
	//actions_types = list(/datum/action/item_action/toggle_barrier_spread)
	//var/mode = SINGLE


/obj/item/grenade/barrier/hvac/AltClick(mob/living/carbon/user)
	return TRUE //  Shitcode moment

/obj/item/grenade/barrier/hvac/detonate(mob/living/lanced_by)
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
	desc = "This space heater looks like it was made from cardboard!  The Space Amish would be disappointed."
	max_integrity = 75 //It's weak and not very good for combat use.
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, FIRE = 80, ACID = 10)
	circuit = /obj/item/circuitboard/machine/space_heater
	var/obj/item/stock_parts/cell/cell = /obj/item/stock_parts/cell //Comes with upgraded cell?
	var/on = TRUE // Starts on

	var/heating_power = 40000 // Default, but could change it?
	var/efficiency = 20000 // Default, but could change it?
