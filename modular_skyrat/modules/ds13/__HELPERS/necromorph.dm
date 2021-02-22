/proc/get_historic_major_vessel_total()
	var/total = 0
	for (var/typepath in SSnecromorph.spawned_necromorph_types)
		//Currently, only human subtypes are major vessels
		if (!ispath(typepath, /mob/living/carbon/human))
			continue

		total += SSnecromorph.spawned_necromorph_types[typepath]

	return total
