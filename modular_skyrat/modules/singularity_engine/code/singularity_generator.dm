/*
*	SINGULARITY SPAWNER
*/

/obj/machinery/singularity_generator
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

	/// How much energy we have recieved so far.
	var/energy = 0
	/// What we create when we reach the required amount of energy.
	var/creation_type = /obj/singularity
	/// How much energy we need to create a singularity.
	var/required_energy = ENERGY_REQ_SINGULARITY_CREATION

/obj/machinery/singularity_generator/attackby(obj/item/weapon, mob/user, params)
	if(weapon.tool_behaviour == TOOL_WRENCH)
		default_unfasten_wrench(user, weapon, 0)
	else
		return ..()

/obj/machinery/singularity_generator/process()
	if(energy)
		if(energy >= required_energy)
			var/turf/our_turf = get_turf(src)
			SSblackbox.record_feedback("tally", "engine_started", 1, type)
			var/obj/singularity/new_singularity = new creation_type(our_turf, 50)
			transfer_fingerprints_to(new_singularity)
			qdel(src)
		else
			energy--

/obj/machinery/singularity_generator/tesla
	name = "energy ball generator"
	desc = "Makes the wardenclyffe look like a child's plaything when shot with a particle accelerator."
	icon = 'icons/obj/machines/engine/tesla_generator.dmi'
	icon_state = "TheSingGen"
	creation_type = /obj/energy_ball

/obj/machinery/singularity_generator/tesla/zap_act(power, zap_flags)
	if(zap_flags & ZAP_MACHINE_EXPLOSIVE)
		energy += power
	zap_flags &= ~(ZAP_MACHINE_EXPLOSIVE | ZAP_OBJ_DAMAGE) // Don't blow yourself up yeah?
	return ..()
