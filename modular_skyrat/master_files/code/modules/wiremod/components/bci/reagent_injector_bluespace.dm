/**
 * # Reagent Injector Component (Bluespace)
 *
 * Injects reagents into the user.
 * Requires a BCI shell.
 *
 * This file is based off of reagent_injector.dm
 * Any changes made to that file should be copied over with discretion
 */

/obj/item/circuit_component/reagent_injector_bluespace
	display_name = "Reagent Injector (Bluespace)"
	desc = "A component that can inject an specified amount of reagents from a BCI's bluespace reagent storage."
	category = "BCI"
	circuit_flags = CIRCUIT_NO_DUPLICATES|CIRCUIT_REAGENT_CONTAINER_TYPE

	required_shells = list(/obj/item/organ/internal/cyberimp/bci)

	/// The number of units to inject per trigger
	var/datum/port/input/inject_amount

	var/datum/port/input/inject
	var/datum/port/output/injected

	var/obj/item/organ/internal/cyberimp/bci/bci

/obj/item/circuit_component/reagent_injector_bluespace/Initialize(mapload)
	. = ..()
	create_reagents(100, OPENCONTAINER) //This is mostly used in the case of a BCI still having reagents in it when the component is removed.

/obj/item/circuit_component/reagent_injector_bluespace/populate_ports()
	. = ..()
	inject_amount = add_input_port("Units", PORT_TYPE_NUMBER, default = 15)
	inject = add_input_port("Inject", PORT_TYPE_SIGNAL, trigger = PROC_REF(trigger_inject))
	injected = add_output_port("Injected", PORT_TYPE_SIGNAL)

/obj/item/circuit_component/reagent_injector_bluespace/proc/trigger_inject()
	CIRCUIT_TRIGGER
	if(!bci.owner || inject_amount.value <= 0)
		return
	var/amount = clamp(inject_amount.value, 0, bci.reagents.total_volume)
	if(bci.owner.reagents.total_volume + amount > bci.owner.reagents.maximum_volume)
		return
	var/units = bci.reagents.trans_to(bci.owner.reagents, amount, methods = INJECT)
	if(units)
		injected.set_output(COMPONENT_SIGNAL)

/obj/item/circuit_component/reagent_injector_bluespace/register_shell(atom/movable/shell)
	. = ..()
	if(istype(shell, /obj/item/organ/internal/cyberimp/bci))
		bci = shell
		bci.create_reagents(100, OPENCONTAINER)
		if(reagents.total_volume)
			reagents.trans_to(bci, reagents.total_volume)

/obj/item/circuit_component/reagent_injector_bluespace/unregister_shell(atom/movable/shell)
	. = ..()
	if(bci?.reagents)
		if(bci.reagents.total_volume)
			bci.reagents.trans_to(src, bci.reagents.total_volume)
		QDEL_NULL(bci.reagents)
	bci = null
