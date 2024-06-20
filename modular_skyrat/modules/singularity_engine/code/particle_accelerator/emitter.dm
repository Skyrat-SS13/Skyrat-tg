
/obj/structure/particle_accelerator/particle_emitter
	name = "EM containment grid"
	desc = "This launches the alpha particles, might not want to stand near this end."
	icon = 'modular_skyrat/modules/singularity_engine/icons/particle_accelerator.dmi'
	icon_state = "emitter_center"

	/// The delay between shooting a particle
	var/fire_delay = 5 SECONDS

	COOLDOWN_DECLARE(fire_delay_cooldown)

/obj/structure/particle_accelerator/particle_emitter/center
	icon_state = "emitter_center"
	icon_state_reference = "emitter_center"

/obj/structure/particle_accelerator/particle_emitter/left
	icon_state = "emitter_left"
	icon_state_reference = "emitter_left"

/obj/structure/particle_accelerator/particle_emitter/right
	icon_state = "emitter_right"
	icon_state_reference = "emitter_right"

/**
 * Sets the delay between shooting a particle.
 * @param delay The delay between shooting a particle.
 */
/obj/structure/particle_accelerator/particle_emitter/proc/set_delay(delay)
	if(delay)
		fire_delay = delay
		return TRUE
	return FALSE

/**
 * Shoots a particle in the given direction.
 * @param strength The strength of the particle to shoot.
 */
/obj/structure/particle_accelerator/particle_emitter/proc/emit_particle(strength)
	if(COOLDOWN_FINISHED(src, fire_delay_cooldown))
		var/turf/our_turf = get_turf(src)
		var/obj/effect/accelerated_particle/new_particle
		switch(strength)
			if(PARTICLE_STRENGTH_WEAK)
				new_particle = new/obj/effect/accelerated_particle/weak(our_turf)
				playsound(src, 'modular_skyrat/modules/singularity_engine/sound/cyclotron.ogg', 30, FALSE)
			if(PARTICLE_STRENGTH_NORMAL)
				new_particle = new/obj/effect/accelerated_particle(our_turf)
				playsound(src, 'modular_skyrat/modules/singularity_engine/sound/cyclotron.ogg', 70, FALSE)
			if(PARTICLE_STRENGTH_STRONG)
				new_particle = new/obj/effect/accelerated_particle/strong(our_turf)
				playsound(src, 'modular_skyrat/modules/singularity_engine/sound/cyclotron.ogg', 100, FALSE)
			if(PARTICLE_STRENGTH_MAX)
				new_particle = new/obj/effect/accelerated_particle/powerful(our_turf)
				playsound(src, 'modular_skyrat/modules/singularity_engine/sound/cyclotron.ogg', 100, FALSE)
				new /obj/effect/particle_effect/sparks/quantum (our_turf)
				radiation_pulse(src, max_range = 3, threshold = RAD_EXTREME_INSULATION)
		new_particle.setDir(dir)
		COOLDOWN_START(src, fire_delay_cooldown, fire_delay)
		return TRUE
	return FALSE
