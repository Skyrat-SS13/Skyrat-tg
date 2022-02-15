 //OwOchem!!
//Fun chems for all the family

/datum/reagent/OwO
	name = "OwO" //This should never exist, but it does so that it can exist in the case of errors..
	taste_description	= "affection and love!"
	inverse_chem_val 		= 0.25		// If the impurity is below 0.5, replace ALL of the chem with inverse_chemupon metabolising
	var/cached_purity		= 1
	process_flags = REAGENT_ORGANIC | REAGENT_SYNTHETIC



//This should process OwOchems to find out how pure they are and what effect to do.
/datum/reagent/OwO/on_mob_add(mob/living/carbon/M, amount)
	. = ..()

//When merging two OwOchems, see above
/datum/reagent/OwO/on_merge(data, amount, mob/living/carbon/M, purity)//basically on_mob_add but for merging
	. = ..()


///////////////////////////////////////////////////////////////////////////////////////////////
//				MISC OwO CHEMS FOR SPECIFIC INTERACTIONS ONLY
///////////////////////////////////////////////////////////////////////////////////////////////

