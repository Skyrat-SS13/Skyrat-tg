#define ZOMBIE_STAGE_ONE 0
#define ZOMBIE_STAGE_TWO 1


/datum/component/zombie_infection
	var/mob/living/carbon/host
	/// The stage of infection
	var/stage = 0
	/// The time for each stage to complete
	var/infection_stage_time = 30 SECONDS
	var/control_timer


/datum/component/zombie_infection/Initialize(...)
	. = ..()
	if(!iscarbon(parent))
		return COMPONENT_INCOMPATIBLE
	host = parent
	GLOB.zombie_infection_list += src

	RegisterSignal(parent, COMSIG_LIVING_DEATH, .proc/transform_zombie)

	control_timer = addtimer(CALLBACK(src, .proc/process_stage), infection_stage_time)

/datum/component/zombie_infection/Destroy(force, silent)
	. = ..()
	GLOB.zombie_infection_list -= src
	control_timer = null

/datum/component/zombie_infection/proc/process_stage()
	SWITCH(stage)
		if(ZOMBIE_STAGE_ONE)
			stage = ZOMBIE_STAGE_TWO
			host.color = COLOR_PALE_GREEN_GRAY
			control_timer = addtimer(CALLBACK(src, .proc/process_stage), infection_stage_time)


/datum/component/zombie_infection/proc/transform_zombie()
	control_timer = null

	if(!iszombie(host))
		old_species = host.dna.species.type
		host.set_species(/datum/species/zombie/infectious)

	var/stand_up = (host.stat == DEAD) || (host.stat == UNCONSCIOUS)

	//Fully heal the zombie's damage the first time they rise
	host.setToxLoss(0, 0)
	host.setOxyLoss(0, 0)
	host.heal_overall_damage(INFINITY, INFINITY, INFINITY, null, TRUE)

	if(!host.revive(full_heal = FALSE, admin_revive = FALSE))
		return

	host.grab_ghost()
	host.visible_message("<span class='danger'>[host] suddenly convulses, as [host.p_they()][stand_up ? " stagger to [host.p_their()] feet and" : ""] gain a ravenous hunger in [host.p_their()] eyes!</span>", "<span class='alien'>You HUNGER!</span>")
	playsound(host.loc, 'sound/hallucinations/far_noise.ogg', 50, TRUE)
	host.do_jitter_animation(living_transformation_time)
	host.Stun(living_transformation_time)
	to_chat(host, "<span class='alertalien'>You are now a zombie! Do not seek to be cured, do not help any non-zombies in any way, do not harm your zombie brethren and spread the disease by killing others. You are a creature of hunger and violence.</span>")

	UnregisterSignaL()
