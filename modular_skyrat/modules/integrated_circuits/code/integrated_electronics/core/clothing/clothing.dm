
// The base subtype for assemblies that can be worn. Certain pieces will have more or less capabilities
// E.g. Glasses have less room than something worn over the chest.
// Note that the electronic assembly is INSIDE the object that actually gets worn, in a similar way to implants.

/obj/item/electronic_assembly/clothing
	name = "electronic clothing"
	icon_state = "circuitry"
	worn_icon_state = "circuitry" // Needed since icon_state gets updated by the assembly
 // Needs to match the clothing's base icon_state.
	desc = "It's a case, for building machines attached to clothing."
	w_class = WEIGHT_CLASS_SMALL
	max_components = IC_MAX_SIZE_BASE
	max_complexity = IC_COMPLEXITY_BASE
	var/obj/item/clothing/clothing = null

/* SKYRAT PORT - NanoUI stuff commented out, idk if it will cause issues
/obj/item/electronic_assembly/clothing/nano_host()
	return clothing

/obj/item/electronic_assembly/clothing/resolve_nano_host()
	return clothing
*/

/obj/item/electronic_assembly/clothing/update_icon()
	..()
	clothing.icon_state = icon_state
	// We don't need to update the mob sprite since it won't (and shouldn't) actually get changed.

// This is 'small' relative to the size of regular clothing assemblies.
/obj/item/electronic_assembly/clothing/small
	max_components = IC_MAX_SIZE_BASE / 2
	max_complexity = IC_COMPLEXITY_BASE / 2
	w_class = WEIGHT_CLASS_TINY

// Ditto.
/obj/item/electronic_assembly/clothing/large
	max_components = IC_MAX_SIZE_BASE * 2
	max_complexity = IC_COMPLEXITY_BASE * 2
	w_class = WEIGHT_CLASS_NORMAL

/*
// Integrated button for doing integrated button things
*/

/obj/item/integrated_circuit/built_in
	name = "integrated circuit"
	desc = "It's a tiny chip!  This one doesn't seem to do much, however."
	icon_state = "template"
	size = -1
	w_class = WEIGHT_CLASS_TINY
	removable = FALSE 			// Determines if a circuit is removable from the assembly.

// Triggered when clothing assembly's hud button is clicked (or used inhand).
/obj/item/integrated_circuit/built_in/action_button
	name = "external trigger circuit"
	desc = "A built in chip that outputs a pulse when an external control event occurs."
	extended_desc = "This outputs a pulse if the assembly's HUD button is clicked while the assembly is closed."
	complexity = 0
	activators = list("on activation" = IC_PINTYPE_PULSE_OUT)

/obj/item/integrated_circuit/built_in/action_button/do_work()
	activate_pin(1)

/*
// Extra vars for clothing here
*/
/obj/item/clothing/
	var/obj/item/electronic_assembly/clothing/integrated_circuit = null
	var/obj/item/integrated_circuit/built_in/action_button/action_circuit = null // This gets pulsed when someone clicks the button on the hud.

// Does most of the repeatative setup.
/obj/item/clothing/proc/setup_integrated_circuit(new_type)
	// Set up the internal circuit holder.
	integrated_circuit = new new_type(src)
	integrated_circuit.clothing = src
	integrated_circuit.name = name

	// Clothing assemblies can be triggered by clicking on the HUD. This allows that to occur.
	action_circuit = new(src.integrated_circuit)
	integrated_circuit.add_component(action_circuit)

/datum/action/item_action/toggle_circuit
	name = "Toggle Integrated Circuit"
