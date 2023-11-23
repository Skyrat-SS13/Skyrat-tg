/obj/item/organ/internal/brain/synth
	var/obj/item/modular_computer/pda/synth/internal_computer = new /obj/item/modular_computer/pda/synth(src)
	actions_types = list(/datum/action/item_action/synth/open_internal_computer)



/datum/action/item_action/synth/open_internal_computer
	name = "Open persocom emulation"
	desc = "Accesses your built-in virtual machine."
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/synth/open_internal_computer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/internal/brain/synth/targetmachine = target
	targetmachine.internal_computer.interact(owner)

/obj/item/organ/internal/brain/synth/Destroy()
	QDEL_NULL(internal_computer)
	return ..()
