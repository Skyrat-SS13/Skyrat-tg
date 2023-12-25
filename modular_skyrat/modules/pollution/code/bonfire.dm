/obj/structure/bonfire
	/// Whether or not this bonfire can cause pollution.
	var/produces_smoke = FALSE

// We basically only want player-made bonfires to make smoke, so it's simpler.
/obj/structure/bonfire/player_made
	produces_smoke = TRUE


/obj/structure/bonfire/process(seconds_per_tick)
	. = ..()

	if(!burning || !produces_smoke)
		return

	var/turf/open/my_turf = get_turf(src)
	if(istype(my_turf) && !my_turf.planetary_atmos && !is_centcom_level(my_turf.z)) //Pollute, but only when we're not on planetary atmos or on CentCom
		my_turf.pollute_turf_list(list(/datum/pollutant/smoke = 15, /datum/pollutant/carbon_air_pollution = 5), POLLUTION_ACTIVE_EMITTER_CAP)

