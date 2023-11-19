/// Generic description for the corrupted organs that don't have one.
#define GENERIC_CORRUPTED_ORGAN_DESC "This shares the shape of a normal organ, but it's been covered and filled with some sort of midnight-black pulsing tissue, engorged with some sort of infectious mass."

/// The rate at which blood metabolizes in a Hemophage's stomach subtype.
#define BLOOD_METABOLIZATION_RATE (0.1 * REAGENTS_METABOLISM)
/// Defines the time for making a corrupted organ start off corrupted.
#define ORGAN_CORRUPTION_INSTANT 0


/obj/item/organ/internal/liver/hemophage
	name = "liver" // Name change is handled by /datum/component/organ_corruption/corrupt_organ()
	desc = GENERIC_CORRUPTED_ORGAN_DESC
	icon = 'modular_skyrat/modules/organs/icons/hemophage_organs.dmi'
	organ_flags = ORGAN_EDIBLE | ORGAN_TUMOR_CORRUPTED


/obj/item/organ/internal/liver/hemophage/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/organ_corruption/liver, time_to_corrupt = ORGAN_CORRUPTION_INSTANT)


/obj/item/organ/internal/stomach/hemophage
	name = "stomach" // Name change is handled by /datum/component/organ_corruption/corrupt_organ()
	desc = GENERIC_CORRUPTED_ORGAN_DESC
	icon = 'modular_skyrat/modules/organs/icons/hemophage_organs.dmi'
	organ_flags = ORGAN_EDIBLE | ORGAN_TUMOR_CORRUPTED


/obj/item/organ/internal/stomach/hemophage/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/organ_corruption/stomach, time_to_corrupt = ORGAN_CORRUPTION_INSTANT)


// I didn't feel like moving this behavior onto the component, it was just too annoying to do.
/obj/item/organ/internal/stomach/hemophage/on_life(seconds_per_tick, times_fired)
	var/datum/reagent/blood/blood = reagents.has_reagent(/datum/reagent/blood)
	if(blood)
		blood.metabolization_rate = BLOOD_METABOLIZATION_RATE

	return ..()


/obj/item/organ/internal/tongue/hemophage
	name = "tongue" // Name change is handled by /datum/component/organ_corruption/corrupt_organ()
	desc = GENERIC_CORRUPTED_ORGAN_DESC
	icon = 'modular_skyrat/modules/organs/icons/hemophage_organs.dmi'
	organ_flags = ORGAN_EDIBLE | ORGAN_TUMOR_CORRUPTED
	liked_foodtypes = BLOODY
	disliked_foodtypes = NONE


/obj/item/organ/internal/tongue/hemophage/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/organ_corruption/tongue, time_to_corrupt = ORGAN_CORRUPTION_INSTANT)


#undef GENERIC_CORRUPTED_ORGAN_DESC
#undef BLOOD_METABOLIZATION_RATE
#undef ORGAN_CORRUPTION_INSTANT
