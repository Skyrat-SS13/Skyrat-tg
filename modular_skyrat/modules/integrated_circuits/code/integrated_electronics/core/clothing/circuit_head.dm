// Head
/obj/item/clothing/head/circuitry
	name = "electronic headwear"
	desc = "It's a wearable case for electronics. This one appears to be a very technical-looking piece that \
	goes around the collar, with a heads-up-display attached on the right. \
	Control-shift-click on this with an item in hand to use it on the integrated circuit."
	icon = 'modular_skyrat/modules/integrated_circuits/icons/obj/clothing/circuit_head.dmi'
	icon_state = "circuitry"
	item_state = "circuitry"

/obj/item/clothing/head/circuitry/Initialize()
	setup_integrated_circuit(/obj/item/electronic_assembly/clothing/small)
	return ..()

/obj/item/clothing/head/circuitry/examine(mob/user)
	. = ..()
	if(integrated_circuit)
		. += integrated_circuit.examine(user)

/obj/item/clothing/head/circuitry/emp_act(severity)
	if(integrated_circuit)
		integrated_circuit.emp_act(severity)
	..()

/obj/item/clothing/head/circuitry/CtrlShiftClick(mob/user)
	var/turf/T = get_turf(src)
	if(!T.Adjacent(user)) // So people aren't messing with these from across the room
		return FALSE
	var/obj/item/I = user.get_active_hand() // ctrl-shift-click doesn't give us the item, we have to fetch it
	return integrated_circuit.attackby(I, user)

/obj/item/clothing/head/circuitry/attack_self(mob/user)
	if(integrated_circuit)
		if(integrated_circuit.opened)
			integrated_circuit.attack_self(user)
		else
			action_circuit.do_work()
	else
		..()

/obj/item/clothing/head/circuitry/Destroy()
	if(integrated_circuit)
		integrated_circuit.clothing = null
		action_circuit = null // Will get deleted by qdel-ing the integrated_circuit assembly.
		qdel(integrated_circuit)
	return ..()
