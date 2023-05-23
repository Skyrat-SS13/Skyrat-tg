/// Whether or not this bodypart_overlay should have an emissive at that layer.
/// Intended to be used by `/datum/bodypart_overlay/mutant` and its subtypes.
/// If you use this, completely override it, don't call parent.
/datum/bodypart_overlay/proc/needs_emissive_at_layer(layer)
	SHOULD_CALL_PARENT(FALSE)

	return FALSE

/**
 * Returns the emissive appearance copy of the `base_overlay`, if it's meant to have one.
 * Assumes that you ran through `needs_emissive_at_layer()` beforehand. Mainly intended
 * for `/datum/bodypart_overlay/mutant` and its subtypes.
 */
/datum/bodypart_overlay/proc/get_emissive_overlay(mutable_appearance/base_overlay, atom/owner)
	return emissive_appearance_copy(base_overlay, owner)
