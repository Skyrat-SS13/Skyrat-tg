/datum/species/robotic
    inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RESISTLOWPRESSURE,TRAIT_ADVANCEDTOOLUSER, TRAIT_RADIMMUNE,TRAIT_VIRUSIMMUNE,TRAIT_NOBREATH, TRAIT_TOXIMMUNE, TRAIT_NOCLONELOSS, TRAIT_GENELESS, TRAIT_STABLEHEART,TRAIT_LIMBATTACHMENT, TRAIT_NO_HUSK, TRAIT_OXYIMMUNE)


/datum/species/robotic/spec_life(mob/living/carbon/human/H)
    . = ..()
    if(H.bodytemperature > BODYTEMP_HEAT_DAMAGE_LIMIT + 150)//IPCs dont burn as quickly as humans... but once they get going
        H.adjustFireLoss(HEAT_DAMAGE_LEVEL_2)//Oofie ouchie, get out


/datum/species/robotic/handle_environment_pressure(datum/gas_mixture/environment, mob/living/carbon/human/H) // I really didnt want to do this.
    . = ..()
    var/pressure = environment.return_pressure()
    var/adjusted_pressure = H.calculate_affecting_pressure(pressure) //FUCK
    switch(adjusted_pressure)
        if(WARNING_LOW_PRESSURE)
            H.adjust_bodytemperature(10) //Cooling isnt as effective here..
            if(prob(1))
                to_chat(H, "<span class='warning'>Alert: Low Pressure Enviroment, Cooling At Risk of Failure. Seek shelter. </span>")
        if(HAZARD_LOW_PRESSURE)
            H.adjust_bodytemperature(60) //We're overheating RAPIDLY.
            if(prob(10))
                to_chat(H, "<span class='warning'>Alert: Extreme Low Pressure Enviroment, Cooling offline. Seek Pressure or Cooling Source Immediately!</span>")

/datum/species/robotic/body_temperature_skin(mob/living/carbon/human/humi)
    . = ..()
    var/datum/gas_mixture/environment = humi.loc.return_air()
    var/pressure = environment.return_pressure()
    var/adjusted_pressure = humi.calculate_affecting_pressure(pressure) //FUCK
    // change the core based on the skin temp
    var/skin_core_diff = humi.bodytemperature - humi.coretemperature
    // change rate of 0.08 to be slightly below area to skin change rate and still have a solid curve
    var/skin_core_change = get_temp_change_amount(skin_core_diff, 0.08)
    
    if(adjusted_pressure >= 40)
        humi.adjust_coretemperature(skin_core_change)

	// get the enviroment details of where the mob is standing
    if(!environment) // if there is no environment (nullspace) drop out here
        return

	// Get the temperature of the environment for area
    var/area_temp = humi.get_temperature(environment)

	// Get the insulation value based on the area's temp
    var/thermal_protection = humi.get_insulation_protection(area_temp)

	// Changes to the skin temperature based on the area
    var/area_skin_diff = area_temp - humi.bodytemperature
    if(!humi.on_fire || area_skin_diff > 0)
		// change rate of 0.1 as area temp has large impact on the surface
        var/area_skin_change = get_temp_change_amount(area_skin_diff, 0.1)

		// We need to apply the thermal protection of the clothing when applying area to surface change
		// If the core bodytemp goes over the normal body temp you are overheating and becom sweaty
		// This will cause the insulation value of any clothing to reduced in effect (70% normal rating)
		// we add 10 degree over normal body temp before triggering as thick insulation raises body temp
        if(humi.get_body_temp_normal(apply_change=FALSE) + 10 < humi.coretemperature)
			// we are overheating and sweaty insulation is not as good reducing thermal protection
            area_skin_change = (1 - (thermal_protection * 0.7)) * area_skin_change
        else
            area_skin_change = (1 - thermal_protection) * area_skin_change
        
        if(adjusted_pressure >= 40)
            humi.adjust_bodytemperature(area_skin_change) //Oops. No pressure!

	// Core to skin temp transfer, when not on fire
    if(!humi.on_fire)
		// Get the changes to the skin from the core temp
        var/core_skin_diff = humi.coretemperature - humi.bodytemperature
		// change rate of 0.09 to reflect temp back to the skin at the slight higher rate then core to skin
        var/core_skin_change = (1 + thermal_protection) * get_temp_change_amount(core_skin_diff, 0.09)

		// We do not want to over shoot after using protection
        if(core_skin_diff > 0)
            core_skin_change = min(core_skin_change, core_skin_diff)
        else
            core_skin_change = max(core_skin_change, core_skin_diff)
        
        if(adjusted_pressure >= 40) //Oops, No pressure!
            humi.adjust_bodytemperature(core_skin_change)