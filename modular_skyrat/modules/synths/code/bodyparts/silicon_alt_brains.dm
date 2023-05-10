// Don't know of a better place to put these. They're technically related to synths, so they're going here.

/obj/item/mmi/posibrain/circuit
	name = "compact AI circuit"
	desc = "A compact circuit, perfectly dimensioned to fit in the same slot as a cyborg's positronic brain."
	icon = 'modular_skyrat/master_files/icons/obj/alt_silicon_brains.dmi'
	icon_state = "circuit"
	base_icon_state = "circuit"
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'

	// It pains me to copy-paste so much, but I can't do it any other way
	begin_activation_message = span_notice("You carefully locate the manual activation switch and start the compact AI circuit's boot process.")
	success_message = span_notice("The compact AI circuit pings, and its lights start flashing. Success!")
	fail_message = span_notice("The compact AI circuit buzzes quietly, and the golden lights fade away. Perhaps you could try again?")
	new_mob_message = span_notice("The compact AI circuit chimes quietly.")
	recharge_message = span_warning("The compact AI circuit isn't ready to activate again yet! Give it some time to recharge.")

// CODE THAT ACTUALLY APPLIES THE BRAINS.
// See modular_skyrat/master_files/code/modules/client/preferences/brain.dm for Synth/IPC application.

/// Returns a type to use based off of a given preference value (ORGAN_PREF_POSI_BRAIN, ORGAN_PREF_MMI_BRAIN and ORGAN_PREF_CIRCUIT_BRAIN), and if they're a cyborg or not.
/mob/living/proc/prefs_get_brain_to_use(value, is_cyborg = FALSE)
	switch(value)
		if(ORGAN_PREF_POSI_BRAIN)
			return is_cyborg ? /obj/item/mmi/posibrain : /obj/item/organ/internal/brain/synth

		if(ORGAN_PREF_MMI_BRAIN)
			return is_cyborg ? /obj/item/mmi : /obj/item/organ/internal/brain/synth/mmi

		if(ORGAN_PREF_CIRCUIT_BRAIN)
			return is_cyborg ? /obj/item/mmi/posibrain/circuit : /obj/item/organ/internal/brain/synth/circuit

/mob/living/silicon/robot/Initialize(mapload)
	. = ..()
	// Intentionally set like this, because people have different lore for their cyborgs, and there's no real non-invasive way to print posibrains that match.
	RegisterSignal(src, COMSIG_MOB_MIND_TRANSFERRED_INTO, PROC_REF(update_brain_type))

/// Sets the MMI type for a cyborg, if applicable.
/mob/living/silicon/robot/proc/update_brain_type()
	var/obj/item/mmi/new_mmi = prefs_get_brain_to_use(client?.prefs?.read_preference(/datum/preference/choiced/brain_type), TRUE)
	if(!mmi || !new_mmi || new_mmi == mmi.type)
		return

	new_mmi = new new_mmi()

	// Probably shitcode, but silicon code is spaghetti as fuck.
	new_mmi.brain = new /obj/item/organ/internal/brain(new_mmi)
	new_mmi.brain.organ_flags |= ORGAN_FROZEN
	new_mmi.brain.name = "[real_name]'s brain"
	new_mmi.name = "[initial(new_mmi.name)]: [real_name]"
	new_mmi.set_brainmob(new /mob/living/brain(new_mmi))
	new_mmi.brainmob.name = src.real_name
	new_mmi.brainmob.real_name = src.real_name
	new_mmi.brainmob.container = new_mmi
	new_mmi.update_appearance()

	QDEL_NULL(mmi)

	mmi = new_mmi
