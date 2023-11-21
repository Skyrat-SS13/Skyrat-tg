/obj/item/organ/internal/brain/synth
	var/obj/item/modular_computer/synth/internal_computer = new /obj/item/modular_computer/synth
	actions_types = list(/datum/action/item_action/synth/open_internal_computer)

/obj/item/organ/internal/brain/synth/Insert(mob/living/carbon/user, special, drop_if_replaced, no_id_transfer)
	. = ..()
	if(internal_computer)
		internal_computer.owner_brain = src
		internal_computer.physical = owner

/obj/item/organ/internal/brain/synth/Remove(mob/living/carbon/target, special, no_id_transfer)
	. = ..()
	if(internal_computer)
		internal_computer.physical = src

/datum/action/item_action/synth/open_internal_computer
	name = "Open persocom emulation"
	desc = "Accesses your built-in virtual machine."
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/synth/open_internal_computer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/internal/brain/synth/I = target
	I.internal_computer.interact(owner)

/obj/item/organ/internal/brain/synth/Destroy()
	QDEL_NULL(internal_computer)
	return ..()
