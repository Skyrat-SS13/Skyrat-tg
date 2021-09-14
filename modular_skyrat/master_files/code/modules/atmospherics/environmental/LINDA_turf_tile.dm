/turf/proc/HandleInitialGasString()
	//Set the key to the z level if it is a planetary atmos
	. = TRUE
	if(initial_gas_mix == PLANETARY_ATMOS)
		initial_gas_mix = "[z]"
		//If our z level does not have a mix set, default to normal atmos and un-planetarify
		if(!SSair.planetary[initial_gas_mix])
			initial_gas_mix = OPENTURF_DEFAULT_ATMOS
			. = FALSE

/turf/open/HandleInitialGasString()
	. = ..()
	if(!.)
		planetary_atmos = FALSE
