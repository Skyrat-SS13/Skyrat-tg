/**
 * Corrupt Machines
 *
 * Contains all of the structures that the corrupted flesh can use.
 *
 * All corrupt machines should derive from the parent type.
 */

/obj/structure/corrupted_flesh/corrupted_machine
	name = "strange machine"
	icon = 'modular_skyrat/modules/corrupted_flesh/icons/hivemind_machines.dmi'
	icon_state = "infected_machine"
	density = TRUE
	anchored = TRUE


/**
 * The CORE
 *
 * This is the central nervous system of this AI, the CPU if you will.
 *
 * This is simply the holder for the controller datum, however, has some cool interactions.
 *
 * There can be more than one core in the flesh.
 */
/obj/structure/corrupted_flesh/corrupted_machine/core
	name = "strange core"
	desc = "This monsterous machine is definitely watching you."
	max_integrity = 500
	icon_state = "core"

/obj/structure/corrupted_flesh/corrupted_machine/core/Initialize(mapload)
	. = ..()
	update_appearance()
	START_PROCESSING(SSobj, src)

/obj/structure/corrupted_flesh/corrupted_machine/core/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/structure/corrupted_flesh/corrupted_machine/core/process(delta_time)
	var/mob/living/carbon/human/target = locate() in view(5, src)
	if(target)
		if(get_dist(src, target) <= 1)
			icon_state = "core-fear"
		else
			icon_state = "core-see"
			dir = get_dir(src, target)
	else
		icon_state = initial(icon_state)

/obj/structure/corrupted_flesh/corrupted_machine/core/update_overlays()
	. = ..()
	. += "core-smirk"

/obj/machinery/porta_turret/corrupted_flesh
