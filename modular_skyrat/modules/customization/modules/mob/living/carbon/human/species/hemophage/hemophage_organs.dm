/// Generic description for the corrupted organs that don't have one.
#define GENERIC_CORRUPTED_ORGAN_DESC "This shares the shape of a normal organ, but it's been covered and filled with some sort of midnight-black pulsing tissue, engorged with some sort of infectious mass."

/// The rate at which blood metabolizes in a Hemophage's stomach subtype.
#define BLOOD_METABOLIZATION_RATE (0.1 * REAGENTS_METABOLISM)
/// Defines the time for making a corrupted organ start off corrupted.
#define ORGAN_CORRUPTION_INSTANT 0


/obj/item/organ/internal/heart/hemophage
	name = "pulsating tumor"
	icon = 'modular_skyrat/modules/organs/icons/hemophage_organs.dmi'
	icon_state = "tumor-on"
	base_icon_state = "tumor"
	desc = "This pulsating organ nearly resembles a normal heart, but it's been twisted beyond any human appearance, having turned to the color of coal. The way it barely fits where the original organ was sends shivers down your spine... <i>The fact that it's what keeps them alive makes it all the more terrifying.</i>"
	actions_types = list(/datum/action/cooldown/hemophage/toggle_dormant_state)
	/// Are we currently dormant? Defaults to PULSATING_TUMOR_ACTIVE (so FALSE).
	var/is_dormant = PULSATING_TUMOR_ACTIVE


/obj/item/organ/internal/heart/hemophage/Insert(mob/living/carbon/reciever, special, drop_if_replaced)
	. = ..()
	if(!ishemophage(reciever))
		return

	var/mob/living/carbon/human/tumorful_hemophage = reciever
	var/datum/species/hemophage/tumorful_species = tumorful_hemophage.dna.species

	tumorful_species.tumor_status = is_dormant

	// We make sure to account for dormant tumor vulnerabilities, so that we don't achieve states that shouldn't be possible.
	if(is_dormant)
		tumorful_species.toggle_dormant_tumor_vulnerabilities(tumorful_hemophage)
		tumorful_hemophage.add_movespeed_modifier(/datum/movespeed_modifier/hemophage_dormant_state)


/obj/item/organ/internal/heart/hemophage/Remove(mob/living/carbon/tumorless, special = FALSE)
	. = ..()

	SEND_SIGNAL(tumorless, COMSIG_PULSATING_TUMOR_REMOVED)

	if(!ishemophage(tumorless))
		return

	var/mob/living/carbon/human/tumorless_hemophage = tumorless
	var/datum/species/hemophage/tumorless_species = tumorless_hemophage.dna.species

	tumorless_species.tumor_status = PULSATING_TUMOR_MISSING

	// We make sure to account for dormant tumor vulnerabilities, so that we don't achieve states that shouldn't be possible.
	if(is_dormant)
		tumorless_species.toggle_dormant_tumor_vulnerabilities(tumorless_hemophage)
		tumorless_hemophage.remove_movespeed_modifier(/datum/movespeed_modifier/hemophage_dormant_state)


/// Simple helper proc that toggles the dormant state of the tumor, which also switches its appearance to reflect said change.
/obj/item/organ/internal/heart/hemophage/proc/toggle_dormant_state()
	is_dormant = !is_dormant
	base_icon_state = is_dormant ? "[base_icon_state]-dormant" : initial(base_icon_state)
	update_appearance()


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
	var/datum/reagent/blood/blood = reagents.get_reagent(/datum/reagent/blood)
	if(blood)
		blood.metabolization_rate = BLOOD_METABOLIZATION_RATE

	return ..()


/obj/item/organ/internal/tongue/hemophage
	name = "tongue" // Name change is handled by /datum/component/organ_corruption/corrupt_organ()
	desc = GENERIC_CORRUPTED_ORGAN_DESC
	icon = 'modular_skyrat/modules/organs/icons/hemophage_organs.dmi'
	organ_flags = ORGAN_EDIBLE | ORGAN_TUMOR_CORRUPTED
	liked_foodtypes = BLOODY


/obj/item/organ/internal/tongue/hemophage/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/organ_corruption/tongue, time_to_corrupt = ORGAN_CORRUPTION_INSTANT)


#undef GENERIC_CORRUPTED_ORGAN_DESC
#undef BLOOD_METABOLIZATION_RATE
#undef ORGAN_CORRUPTION_INSTANT
