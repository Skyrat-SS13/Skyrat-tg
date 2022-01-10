/*-----------------------
	Reagent Subtype
-----------------------*/
/*
Splashes reagents onto atoms in the cone

Vars in extradata list
	reagent:	What chem? Should be a /datum/reagent typepath
	volume:		Units of the chemical to splash, per tile, per second
*/
/datum/extension/spray/reagent
	var/obj/item/chem_atom
	var/datum/reagents/chem_holder
	var/volume_tick
	var/reagent_type

/datum/extension/spray/reagent/handle_extra_data(var/list/data)
	.=..()
	src.reagent_type = data["reagent"]
	src.volume_tick = data["volume"] * 0.2

/datum/extension/spray/reagent/stop()
	.=..()
	QDEL_NULL(chem_holder)
	QDEL_NULL(chem_atom)


/datum/extension/spray/reagent/Process()
	for (var/t in affected_turfs)
		var/turf/T = t
		chem_holder.trans_to(T, volume_tick)
		for (var/atom/A in T)
			chem_holder.trans_to(A, volume_tick)
	.=..()


/datum/extension/spray/reagent/start()
	if (!started_at)
		chem_atom = new(source)
		chem_holder = new (2**24, chem_atom)
		var/datum/reagent/R = chem_holder.add_reagent(reagent_type, chem_holder.maximum_volume, safety = TRUE)
		particle_color = R.color
		.=..()


