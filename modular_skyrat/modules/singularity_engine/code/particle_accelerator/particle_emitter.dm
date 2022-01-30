/obj/structure/particle_accelerator/particle_emitter
	name = "EM containment grid"
	desc = "This launches the alpha particles, might not want to stand near this end."
	icon = 'modular_skyrat/modules/singularity_engine/icons/particle_accelerator.dmi'
	icon_state = "none"
	var/fire_delay = 50
	var/last_shot = 0

/obj/structure/particle_accelerator/particle_emitter/center
	icon_state = "emitter_center"
	reference = "emitter_center"

/obj/structure/particle_accelerator/particle_emitter/left
	icon_state = "emitter_left"
	reference = "emitter_left"

/obj/structure/particle_accelerator/particle_emitter/right
	icon_state = "emitter_right"
	reference = "emitter_right"

/obj/structure/particle_accelerator/particle_emitter/proc/set_delay(delay)
	if(delay >= 0)
		fire_delay = delay
		return 1
	return 0

/obj/structure/particle_accelerator/particle_emitter/proc/emit_particle(strength = 0)
	if((last_shot + fire_delay) <= world.time)
		last_shot = world.time
		var/turf/T = get_turf(src)
		var/obj/effect/accelerated_particle/P
		switch(strength)
			if(0)
				P = new/obj/effect/accelerated_particle/weak(T)
				playsound(src, 'modular_skyrat/modules/singularity_engine/sound/cyclotron.ogg', 30, FALSE)
			if(1)
				P = new/obj/effect/accelerated_particle(T)
				playsound(src, 'modular_skyrat/modules/singularity_engine/sound/cyclotron.ogg', 70, FALSE)
			if(2)
				P = new/obj/effect/accelerated_particle/strong(T)
				playsound(src, 'modular_skyrat/modules/singularity_engine/sound/cyclotron.ogg', 100, FALSE)
			if(3)
				P = new/obj/effect/accelerated_particle/powerful(T)
				playsound(src, 'modular_skyrat/modules/singularity_engine/sound/cyclotron.ogg', 100, FALSE)
		P.setDir(dir)
		return 1
	return 0
