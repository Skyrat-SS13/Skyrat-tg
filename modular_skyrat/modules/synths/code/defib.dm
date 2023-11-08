/**
 * Global timer proc used in defib.dm. Removes the temporary trauma caused by being defibbed as a synth.
 *
 * Args:
 * * obj/item/organ/internal/brain/synth_brain: The brain with the trauma on it. Non-nullable.
 * * datum/brain_trauma/trauma: The trauma itself. Non-nullable.
 */
/proc/remove_synth_defib_trauma(obj/item/organ/internal/brain/synth_brain, datum/brain_trauma/trauma)
	if (QDELETED(synth_brain) || QDELETED(trauma))
		return

	QDEL_NULL(trauma)
