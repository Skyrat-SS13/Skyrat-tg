/obj/item/organ/external/genital
	/// The fluid count of the genital.
	var/internal_fluid_count = 0

	/// The maximum amount of fluid that can be stored in the genital.
	var/internal_fluid_maximum = 0

	/// The datum to be used for the tracked fluid, should it need to be added to a fluid container.
	var/internal_fluid_datum

	/// The currently inserted sex toy.
	var/obj/item/inserted_item

/// Helper proc for checking if internal fluids are full or not.
/obj/item/organ/external/genital/proc/internal_fluid_full()
	return internal_fluid_count >= internal_fluid_maximum

/// Adds the given amount to the internal fluid count, clamping it between 0 and internal_fluid_maximum.
/obj/item/organ/external/genital/proc/adjust_internal_fluid(amount)
	internal_fluid_count = clamp(internal_fluid_count + amount, 0, internal_fluid_maximum)

/// Tries to add the specified amount to the target reagent container, or removes it if none are available. Keeps in mind internal_fluid_count.
/obj/item/organ/external/genital/proc/transfer_internal_fluid(datum/reagents/reagent_container = null, attempt_amount)
	if(!internal_fluid_datum || !internal_fluid_count || !internal_fluid_maximum)
		return FALSE

	attempt_amount = clamp(attempt_amount, 0, internal_fluid_count)
	if(reagent_container)
		reagent_container.add_reagent(internal_fluid_datum, attempt_amount)
	internal_fluid_count -= attempt_amount

