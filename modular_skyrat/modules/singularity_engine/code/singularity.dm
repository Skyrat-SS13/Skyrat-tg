/**
 * Hawking Pulse
 *
 * Due to the fact radiation has changed massively, it is no longer a viable and reliable method of transferring energy from the singularty to the radiation collectors.
 *
 * Every singularity process an amount of hawking radiation will be emitted from the singularity that will be captured by hawking collectors.
 */

/obj/singularity/proc/hawking_pulse(delta_time)
	// Calculate the pulse strength based on the singularity's current size.
	var/base_pulse_strength = 100 // Base strength, can be adjusted
	var/strength_multiplier = 1.5 // Multiplier per size level above the base
	var/calculated_pulse_strength = base_pulse_strength * (current_size * strength_multiplier)

	// Calculate the pulse range based on pulse strength
	var/base_pulse_range = 5 // Base range, can be adjusted
	var/range_multiplier = 0.1 // Multiplier per 100 units of pulse strength
	var/calculated_pulse_range = base_pulse_range + (calculated_pulse_strength / 100) * range_multiplier

	// Emit the pulse
	for(var/atom/movable/affected_atom in circle_range(src, calculated_pulse_range))
		if(istype(affected_atom, /obj/machinery/power/energy_accumulator/rad_collector))
			var/obj/machinery/power/energy_accumulator/rad_collector/collector = affected_atom
			collector.hawking_pulse(src, calculated_pulse_strength)


/obj/effect/temp_visual/hawking_radiation
	icon_state = "electricity"

/obj/machinery/field/generator/singularity
	shield_floor = FALSE
