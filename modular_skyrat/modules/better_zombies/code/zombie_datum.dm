#define DEAD_TO_ZOMBIE_TIME 15 SECONDS
#define STAGE_INCREASE_TIME 30 SECONDS
#define CURE_TIME 15 SECONDS
#define REVIVE_TIME 2 MINUTES

/datum/component/zombie_infection
	var/mob/living/carbon/human/host
	var/datum/species/old_species = /datum/species/human
	/// The stage of infection
	var/control_timer
	var/list/insanity_phrases = list("You feel too hot! Something isn't right!", "You can't think straight, please end the suffering!", "AAAAAAAAAAAAAAAGHHHHHHHH!")

/datum/component/zombie_infection/Initialize()
	. = ..()
	if(!iscarbon(parent))
		return COMPONENT_INCOMPATIBLE
	host = parent

	GLOB.zombie_infection_list += src

	if(host.stat == DEAD)
		control_timer = addtimer(CALLBACK(src, .proc/transform_host), DEAD_TO_ZOMBIE_TIME, TIMER_STOPPABLE)
		to_chat(host, "<span class='userdanger'>You feel your veins throb as your body begins twitching...</span>")
		return

	RegisterSignal(parent, COMSIG_ZOMBIE_CURED, .proc/cure_host)

	START_PROCESSING(SSobj, src)

/datum/component/zombie_infection/Destroy(force, silent)
	GLOB.zombie_infection_list -= src
	if(control_timer)
		deltimer(control_timer)
		control_timer = null
	STOP_PROCESSING(SSobj, src)
	UnregisterSignal(parent, list(COMSIG_ZOMBIE_CURED, COMSIG_LIVING_DEATH))
	if(host)
		if(iszombie(host) && old_species)
			host.set_species(old_species)
		to_chat(host, "<span class='greentext'>You feel like you're free of that foul disease!</span>")
		host = null
	return ..()

/datum/component/zombie_infection/process(delta_time)
	. = ..()
	if(host.stat == DEAD)
		if(control_timer)
			deltimer(control_timer)
			control_timer = null
		control_timer = addtimer(CALLBACK(src, .proc/transform_host), DEAD_TO_ZOMBIE_TIME, TIMER_STOPPABLE)
		STOP_PROCESSING(SSobj, src)
		return
	if(iszombie(host))
		STOP_PROCESSING(SSobj, src)
		return
	host.adjustToxLoss(0.5 * delta_time)
	if(DT_PROB(5, delta_time))
		to_chat(host, "<span class='danger'>[pick(insanity_phrases)]</span>")

/datum/component/zombie_infection/proc/revive_host(instant = FALSE)
	if(instant)
		transform_host()
		return
	control_timer = addtimer(CALLBACK(src, .proc/transform_host), REVIVE_TIME, TIMER_STOPPABLE)

/datum/component/zombie_infection/proc/cure_host()
	if(!host.stat == DEAD)
		to_chat(host, "<span class='notice'>You start to feel refreshed and invigorated!</span>")
	if(control_timer)
		deltimer(control_timer)
		control_timer = null
	STOP_PROCESSING(SSobj, src)
	control_timer = addtimer(CALLBACK(src, .proc/Destroy), CURE_TIME, TIMER_STOPPABLE)

/datum/component/zombie_infection/proc/transform_host()
	if(control_timer)
		deltimer(control_timer)
		control_timer = null
	STOP_PROCESSING(SSobj, src)

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
	host.do_jitter_animation(30)
	to_chat(host, "<span class='alertalien'>You are now a zombie! Do not seek to be cured, do not help any non-zombies in any way, do not harm your zombie brethren and spread the disease by killing others. You are a creature of hunger and violence.</span>")

	RegisterSignal(src, COMSIG_LIVING_DEATH, .proc/zombie_death)

/datum/component/zombie_infection/proc/zombie_death()
	if(!iszombie(host))
		return
	if(control_timer)
		deltimer(control_timer)
		control_timer = null
	control_timer = addtimer(CALLBACK(src, .proc/regenerate), REVIVE_TIME, TIMER_STOPPABLE)

/datum/component/zombie_infection/proc/regenerate()
	if(!iszombie(host))
		return
	to_chat(host, "<span class='notice'>You feel an itching, both inside and \
		outside as your tissues knit and reknit.</span>")
	var/list/missing = host.get_missing_limbs()
	if(missing.len)
		playsound(host, 'sound/magic/demon_consume.ogg', 50, TRUE)
		host.visible_message("<span class='warning'>[host]'s missing limbs \
			reform, making a loud, grotesque sound!</span>",
			"<span class='userdanger'>Your limbs regrow, making a \
			loud, crunchy sound and giving you great pain!</span>",
			"<span class='hear'>You hear organic matter ripping \
			and tearing!</span>")
		host.emote("scream")
		host.regenerate_limbs(1)
	if(!host.getorganslot(ORGAN_SLOT_BRAIN))
		var/obj/item/organ/brain/B
		if(host.has_dna() && host.dna.species.mutantbrain)
			B = new host.dna.species.mutantbrain()
		else
			B = new()
		B.organ_flags &= ~ORGAN_VITAL
		B.decoy_override = TRUE
		B.Insert(host)
	host.regenerate_organs()
	for(var/i in host.all_wounds)
		var/datum/wound/iter_wound = i
		iter_wound.remove_wound()
	host.restore_blood()
	host.remove_all_embedded_objects()
	host.revive()
