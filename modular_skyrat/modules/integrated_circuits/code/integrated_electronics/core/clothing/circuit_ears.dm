// Ear
/obj/item/clothing/ears/circuitry
	name = "electronic earwear"
	desc = "It's a wearable case for electronics. This one appears to be a technical-looking headset."
	icon = 'modular_skyrat/modules/integrated_circuits/icons/obj/clothing/circuit_ears.dmi'
	icon_state = "circuitry"
	worn_icon_state = "circuitry" // Needed since icon_state gets updated by the assembly
	worn_icon = 'modular_skyrat/modules/integrated_circuits/icons/mob/clothing/circuit_ears.dmi'
	actions_types = list(/datum/action/item_action/toggle_circuit)

/obj/item/clothing/ears/circuitry/Initialize()
	setup_integrated_circuit(/obj/item/electronic_assembly/clothing/small)
	integrated_circuit.update_icon()
	return ..()

/obj/item/clothing/ears/circuitry/examine(mob/user)
	. = ..()
	if(integrated_circuit)
		. += integrated_circuit.examine(user)

/obj/item/clothing/ears/circuitry/emp_act(severity)
	if(integrated_circuit)
		integrated_circuit.emp_act(severity)
	..()

/obj/item/clothing/ears/circuitry/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_SCREWDRIVER && integrated_circuit.screwdriver_act(user, I))
		return TRUE
	if(integrated_circuit.attackby(I, user, params))
		return TRUE
	..()

/obj/item/clothing/ears/circuitry/attack_self(mob/user)
	if(integrated_circuit)
		if(integrated_circuit.opened)
			integrated_circuit.attack_self(user)
		else
			action_circuit.do_work()
	else
		..()

/obj/item/clothing/ears/circuitry/Destroy()
	if(integrated_circuit)
		integrated_circuit.clothing = null
		action_circuit = null // Will get deleted by qdel-ing the integrated_circuit assembly.
		qdel(integrated_circuit)
	return ..()
