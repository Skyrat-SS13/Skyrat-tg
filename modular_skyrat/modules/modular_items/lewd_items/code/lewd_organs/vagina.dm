/obj/item/organ/external/genital/vagina/build_from_dna(datum/dna/DNA, associated_key)
	. = ..()
	internal_fluids = new /datum/reagents(10)
