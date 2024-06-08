// So, vomit cleanup kits use sawdust
// We don't really have sawdust, and adding another reagent would be needless bloat
// Hence, cellulose can clean up liquids, I also put it in cleaner grenades, for your convenience~
/datum/reagent/cellulose/expose_turf(turf/exposed_turf, reac_volume)
	. = ..()
	if(reac_volume < 0.6)
		return
	exposed_turf.wash(CLEAN_TYPE_LIQUIDS)
