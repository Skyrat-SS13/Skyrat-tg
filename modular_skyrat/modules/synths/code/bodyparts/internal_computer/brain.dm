/obj/item/organ/internal/brain/synth
	var/obj/item/modular_computer/pda/synth/internal_computer
	actions_types = list(/datum/action/item_action/synth/open_internal_computer)

/obj/item/organ/internal/brain/synth/Initialize(mapload)
	. = ..()
	internal_computer = new(src)

/datum/action/item_action/synth/open_internal_computer
	name = "Open persocom emulation"
	desc = "Accesses your built-in virtual machine."
	check_flags = AB_CHECK_CONSCIOUS

/datum/action/item_action/synth/open_internal_computer/Trigger(trigger_flags)
	. = ..()
	var/obj/item/organ/internal/brain/synth/targetmachine = target
	targetmachine.internal_computer.interact(owner)

/obj/item/modular_computer/pda/synth/ui_state(mob/user)
	return GLOB.default_state

/obj/item/modular_computer/pda/synth/ui_status(mob/user)
	var/obj/item/organ/internal/brain/synth/brain_loc = loc
	if(!istype(brain_loc))
		return UI_CLOSE

	if(!QDELETED(brain_loc.owner))
		if(brain_loc.owner == user)
			return min(
				ui_status_user_is_abled(user, src),
				ui_status_only_living(user),
			)
		else return UI_CLOSE
	return ..()

/obj/item/organ/internal/brain/synth/Destroy()
	QDEL_NULL(internal_computer)
	return ..()
