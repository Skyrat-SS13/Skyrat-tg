// Shows only if they have the exact same datum, no subtypes
/datum/atom_hud/alternate_appearance/basic/has_antagonist/exact/mobShouldSee(mob/M)
	return !!M.mind?.has_antag_datum(antag_datum_type, check_subtypes = FALSE)
