// Jumpsuit.
/obj/item/clothing/under/circuitry
	name = "electronic jumpsuit"
	desc = "It's a wearable case for electronics. This on is a black jumpsuit with wiring weaved into the fabric."
	can_adjust = FALSE
	icon = 'modular_skyrat/modules/integrated_circuits/icons/obj/clothing/circuit_under.dmi'
	icon_state = "circuitry"
	worn_icon_state = "circuitry" // Needed since icon_state gets updated by the assembly
	worn_icon = 'modular_skyrat/modules/integrated_circuits/icons/mob/clothing/under/circuit_under.dmi'
	actions_types = list(/datum/action/item_action/toggle_circuit)

/obj/item/clothing/under/circuitry/Initialize()
	setup_integrated_circuit(/obj/item/electronic_assembly/clothing)
	integrated_circuit.update_icon()
	return ..()

/obj/item/clothing/under/circuitry/examine(mob/user)
	. = ..()
	if(integrated_circuit)
		. += integrated_circuit.examine(user)

/obj/item/clothing/under/circuitry/emp_act(severity)
	if(integrated_circuit)
		integrated_circuit.emp_act(severity)
	..()

/obj/item/clothing/under/circuitry/attackby(obj/item/I, mob/user, params)
	if(I.tool_behaviour == TOOL_SCREWDRIVER && integrated_circuit.screwdriver_act(user, I))
		return TRUE
	if(integrated_circuit.attackby(I, user, params))
		return TRUE
	..()

/obj/item/clothing/under/circuitry/attack_self(mob/user)
	if(integrated_circuit)
		if(integrated_circuit.opened)
			integrated_circuit.attack_self(user)
		else
			action_circuit.do_work()
	else
		..()

/obj/item/clothing/under/circuitry/Destroy()
	if(integrated_circuit)
		integrated_circuit.clothing = null
		action_circuit = null // Will get deleted by qdel-ing the integrated_circuit assembly.
		qdel(integrated_circuit)
	return ..()
