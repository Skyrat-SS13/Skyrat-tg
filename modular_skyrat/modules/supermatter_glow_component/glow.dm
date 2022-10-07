#define COMSIG_SM_PROCESS_ATMOS "atmos_process"
#define CASCADE_DELAMINATION "cascade"
#define SINGULARITY_DELAMINATION "singularity"
#define TESLA_DELAMINATION "tesla"

#define SUPERMATTER_COLOUR "#ffd04f"
#define SUPERMATTER_RED "#aa2c16"
#define SUPERMATTER_CASCADE_COLOUR "#333333"
#define SUPERMATTER_TESLA_COLOUR "#00ffff"
#define SUPERMATTER_SINGULARITY_RAYS_COLOUR "#750000"
#define SUPERMATTER_SINGULARITY_LIGHT_COLOUR "#400060"


/datum/component/supermatter_glow
	var/light_color = SUPERMATTER_COLOUR // Nice and yellow.
	var/obj/machinery/power/supermatter_crystal/our_supermatter // Typecasted reference to our supermatter(parent)

/datum/component/supermatter_glow/RegisterWithParent()
	RegisterSignal(parent, COMSIG_SM_PROCESS_ATMOS, .proc/update_effects) // When we are added, we listen for this signal and send the proc.
	our_supermatter = parent // typecast our parent

/datum/component/supermatter_glow/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_SM_PROCESS_ATMOS)
	our_supermatter = null // no hard del 4 u

/// This proc builds a list of effects to apply to the supermatter based on it's contexts.
/datum/component/supermatter_glow/proc/update_effects()
	SIGNAL_HANDLER
	var/list/filters_to_add = list() // List to apply later.
/*
You might be wondering what this does. We're building a list. Filters are an array, right. The first will over-write the first when reapplied..
However, they do not remove animate() from the entry in the array UNLESS it was deleted entirely.
So, our first filter is the rays. The second filter will APPLY to the rays, and so forth.
Sort of like photoshop. The loop will continue forever unless an accident happens.
*/
	if(our_supermatter.internal_energy || our_supermatter.damage && !our_supermatter.final_countdown)
		our_supermatter.set_light((initial(our_supermatter.light_range) + our_supermatter.internal_energy/200), initial(our_supermatter.light_power) + our_supermatter.internal_energy/1000, (our_supermatter.gas_heat_power_generation > 0.8 ? SUPERMATTER_RED : SUPERMATTER_COLOUR), TRUE)
		filters_to_add |= filter(type="rays", size = clamp(our_supermatter.internal_energy/30, 1, 125), color = (our_supermatter.gas_heat_power_generation > 0.8 ? SUPERMATTER_RED : SUPERMATTER_COLOUR), factor = clamp(our_supermatter.damage/600, 1, 10), density = clamp(our_supermatter.damage/10, 12, 100))

	switch(check_special_delamination())
		if(SINGULARITY_DELAMINATION)
			var/rays_filter = filter(type="rays", size = clamp((our_supermatter.damage/100)*our_supermatter.internal_energy, 50, 125), color = SUPERMATTER_SINGULARITY_RAYS_COLOUR, factor = clamp(our_supermatter.damage/300, 1, 30), density = clamp(our_supermatter.damage/5, 12, 200))
			var/outline_filter = filter(type = "outline", size = 1, color = SUPERMATTER_SINGULARITY_LIGHT_COLOUR)

			if(our_supermatter.final_countdown)
				var/icon/singulo = new/icon('icons/effects/96x96.dmi', "singularity_s3", frame = rand(1,8)) // Summon the icon as an object
				var/singulo_filter = filter(type="layer", icon = singulo, flags = FILTER_OVERLAY) // apply the icon object as a layer filter
				filters_to_add |= list(singulo_filter) // send it to the list

			filters_to_add |= list(rays_filter, outline_filter) // add rays AND outline after.
			our_supermatter.set_light(initial(our_supermatter.light_range) + clamp(our_supermatter.damage/2, 10, 50), 3, SUPERMATTER_SINGULARITY_LIGHT_COLOUR, TRUE)
		if(TESLA_DELAMINATION)
			var/rays_filter = filter(type="rays", size = clamp((our_supermatter.damage/100)*our_supermatter.internal_energy, 50, 125), color = SUPERMATTER_TESLA_COLOUR, factor = clamp(our_supermatter.damage/300, 1, 30), density = clamp(our_supermatter.damage/5, 12, 200))
			var/icon/ball = new/icon('icons/obj/engine/energy_ball.dmi', "energy_ball", frame = rand(1,12))
			var/tesla_filter = filter(type="layer", icon = ball, flags = FILTER_UNDERLAY)
			our_supermatter.set_light(initial(our_supermatter.light_range) + clamp(our_supermatter.damage*our_supermatter.internal_energy, 50, 500), 3, SUPERMATTER_TESLA_COLOUR, TRUE)
			filters_to_add |= list(rays_filter, tesla_filter)

	our_supermatter.filters = filters_to_add // Our master list. ex: singularity: Singulairty sprite at bottom[1], purple rays splintering[2], with a big stroke applied to rays[3].

	if(!our_supermatter.has_been_powered) // Spamming animate crashes us. We only need it once.
		if(!length(our_supermatter.filters)) // Avoid a runtime, in case we start the SM weird.
			our_supermatter.add_filter("rays", 1, list(type="rays", size = clamp(our_supermatter.internal_energy/30, 0, 125), color = SUPERMATTER_COLOUR, factor = 0.6, density = 12))
		animate(our_supermatter.filters[1], time = 10 SECONDS, offset = 10, loop=-1)
		animate(time = 10 SECONDS, offset = 0, loop=-1)
		animate(our_supermatter.filters[1], time = 2 SECONDS, size = 80, loop=-1, flags = ANIMATION_PARALLEL)
		animate(time = 2 SECONDS, size = 10, loop=-1, flags = ANIMATION_PARALLEL)

/datum/component/supermatter_glow/proc/check_special_delamination() // In priority of devastation.
	if(our_supermatter.absorbed_gasmix.total_moles() > MOLE_PENALTY_THRESHOLD)// Singularity
		return SINGULARITY_DELAMINATION
	if(our_supermatter.internal_energy > POWER_PENALTY_THRESHOLD) // Tesla delamination
		return TESLA_DELAMINATION
	else
		return

/obj/machinery/power/supermatter_crystal/Initialize(mapload) // call parent then add the effect.
	. = ..()
	AddComponent(/datum/component/supermatter_glow) // Add the effect.

/obj/machinery/power/supermatter_crystal/process_atmos() // overridden here to call parent then send the signal
	. = ..()
	SEND_SIGNAL(src, COMSIG_SM_PROCESS_ATMOS) // Call the update.

#undef COMSIG_SM_PROCESS_ATMOS
#undef CASCADE_DELAMINATION
#undef SINGULARITY_DELAMINATION
#undef TESLA_DELAMINATION

#undef SUPERMATTER_COLOUR
#undef SUPERMATTER_RED
#undef SUPERMATTER_CASCADE_COLOUR
#undef SUPERMATTER_TESLA_COLOUR
#undef SUPERMATTER_SINGULARITY_RAYS_COLOUR
#undef SUPERMATTER_SINGULARITY_LIGHT_COLOUR
