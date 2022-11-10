/obj/item/organ/external/genital/vagina
	internal_fluid_datum = /datum/reagent/consumable/femcum

/obj/item/organ/external/genital/vagina/build_from_dna(datum/dna/DNA, associated_key)
	. = ..()
	internal_fluid_maximum = 10
