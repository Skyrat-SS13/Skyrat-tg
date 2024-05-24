/obj/item/organ
	/// Do we drop when organs are spilling?
	var/drop_when_organ_spilling = TRUE
	/// Special flags that need to be passed over from the sprite_accessory to the organ (but not the opposite).
	var/sprite_accessory_flags = NONE
	/// Relevant layer flags, as set by the organ's associated sprite_accessory, should there be one.
	var/relevant_layers

/obj/item/organ/external
	///This is for associating an organ with a mutant bodypart. Look at tails for examples
	var/mutantpart_key
	var/list/list/mutantpart_info

/obj/item/organ/external/Initialize(mapload)
	. = ..()
	if(mutantpart_key)
		color = mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]

/// Copies the organ's mutantpart_info to the owner's mutant_bodyparts
/obj/item/organ/external/proc/copy_to_mutant_bodyparts(mob/living/carbon/organ_owner, special)
	var/mob/living/carbon/human/human_owner = organ_owner
	if(!istype(human_owner))
		return

	human_owner.dna.species.mutant_bodyparts[mutantpart_key] = mutantpart_info.Copy()
	if(!special)
		human_owner.update_body()

/// Copies the mob's mutant_bodyparts data to an organ's mutantpart_info for consistency e.g. on organ removal
/obj/item/organ/external/proc/transfer_mutantpart_info(mob/living/carbon/organ_owner, special)
	var/mob/living/carbon/human/human_owner = organ_owner
	if(!istype(human_owner))
		return

	if(human_owner.dna.species.mutant_bodyparts[mutantpart_key])
		mutantpart_info = human_owner.dna.species.mutant_bodyparts[mutantpart_key].Copy() //Update the info in case it was changed on the person

	color = mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]
	human_owner.dna.species.mutant_bodyparts -= mutantpart_key
	if(!special)
		human_owner.update_body()

/obj/item/organ/proc/build_from_dna(datum/dna/DNA, associated_key)
	return

/obj/item/organ/external/build_from_dna(datum/dna/DNA, associated_key)
	mutantpart_key = associated_key
	mutantpart_info = DNA.mutant_bodyparts[associated_key].Copy()
	color = mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]
