/*
*	SINGULARITY SPAWNER
*/

/obj/machinery/the_singularitygen
	name = "gravitational singularity generator"
	desc = "An odd device which produces a Gravitational Singularity when set up."
	icon = 'modular_skyrat/modules/singularity_engine/icons/sing_gen.dmi'
	icon_state = "TheSingGen"
	anchored = FALSE
	density = TRUE
	use_power = NO_POWER_USE
	resistance_flags = FIRE_PROOF

	// You can buckle someone to the singularity generator, then start the engine. Fun!
	can_buckle = TRUE
	buckle_lying = FALSE
	buckle_requires_restraints = TRUE

	var/energy = 0
	var/creation_type = /obj/singularity

/obj/machinery/the_singularitygen/attackby(obj/item/W, mob/user, params)
	if(W.tool_behaviour == TOOL_WRENCH)
		default_unfasten_wrench(user, W, 0)
	else
		return ..()

/obj/machinery/the_singularitygen/process()
	if(energy > 0)
		if(energy >= 200)
			var/turf/T = get_turf(src)
			SSblackbox.record_feedback("tally", "engine_started", 1, type)
			var/obj/singularity/S = new creation_type(T, 50)
			transfer_fingerprints_to(S)
			qdel(src)
		else
			energy -= 1

/obj/machinery/the_singularitygen/tesla
	name = "energy ball generator"
	desc = "Makes the wardenclyffe look like a child's plaything when shot with a particle accelerator."
	icon = 'icons/obj/tesla_engine/tesla_generator.dmi'
	icon_state = "TheSingGen"
	creation_type = /obj/energy_ball

/obj/machinery/the_singularitygen/tesla/zap_act(power, zap_flags)
	if(zap_flags & ZAP_MACHINE_EXPLOSIVE)
		energy += power
	zap_flags &= ~(ZAP_MACHINE_EXPLOSIVE | ZAP_OBJ_DAMAGE) // Don't blow yourself up yeah?
	return ..()
