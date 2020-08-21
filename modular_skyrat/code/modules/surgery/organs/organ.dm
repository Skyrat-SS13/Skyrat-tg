/obj/item/organ
	///This is for associating an organ with a mutant bodypart. Look at tails for examples
	var/mutantpart_key
	var/list/mutantpart_info

/obj/item/organ/Initialize()
	. = ..()
	if(mutantpart_key)
		color = mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]

/obj/item/organ/Insert(mob/living/carbon/C, special = 0, drop_if_replaced = TRUE)
	var/mob/living/carbon/human/H = C
	if(mutantpart_key && H)
		H.dna.species.mutant_bodyparts[mutantpart_key] = mutantpart_info.Copy()
		H.update_body()
	. = ..()

/obj/item/organ/Remove(mob/living/carbon/C, special = 0, drop_if_replaced = TRUE)
	var/mob/living/carbon/human/H = C
	if(mutantpart_key && H)
		if(H.dna.species.mutant_bodyparts[mutantpart_key])
			mutantpart_info = H.dna.species.mutant_bodyparts[mutantpart_key].Copy() //Update the info in case it was changed on the person
		color = mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]
		H.dna.species.mutant_bodyparts -= mutantpart_key
		H.update_body()
	. = ..()
