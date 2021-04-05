#define CURE_TIME 15 SECONDS
#define REVIVE_TIME_LOWER 30 SECONDS
#define REVIVE_TIME_UPPER 1 MINUTES
#define IMMUNITY_LOWER 1 MINUTES
#define IMMUNITY_UPPER 3 MINUTES
#define RNA_REFRESH_TIME 4 MINUTES //How soon can we extract more RNA?

/datum/component/zombie_infection
	var/mob/living/carbon/human/host
	var/datum/species/old_species = /datum/species/human
	/// The stage of infection
	var/list/insanity_phrases = list("You feel too hot! Something isn't right!", "You can't think straight, please end the suffering!", "AAAAAAAAAAAAAAAGHHHHHHHH!")
	var/timer_id
	var/rna_extracted = FALSE

/datum/component/zombie_infection/Initialize()
	. = ..()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	host = parent

	GLOB.zombie_infection_list += src

	if(host.stat == DEAD)
		var/revive_time = rand(REVIVE_TIME_LOWER, REVIVE_TIME_UPPER)
		timer_id = addtimer(CALLBACK(src, .proc/transform_host), revive_time, TIMER_STOPPABLE)
		to_chat(host, "<span class='userdanger'>You feel your veins throb as your body begins twitching...</span>")

	RegisterSignal(parent, COMSIG_ZOMBIE_CURED, .proc/cure_host)

	START_PROCESSING(SSobj, src)

/datum/component/zombie_infection/Destroy(force, silent)
	GLOB.zombie_infection_list -= src
	STOP_PROCESSING(SSobj, src)
	UnregisterSignal(parent, list(COMSIG_ZOMBIE_CURED, COMSIG_LIVING_DEATH))
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	if(host)
		if(iszombie(host) && old_species)
			host.set_species(old_species)
		to_chat(host, "<span class='greentext'>You feel like you're free of that foul disease!</span>")
		ADD_TRAIT(host, TRAIT_ZOMBIE_IMMUNE, "zombie_virus")
		var/cure_time = rand(IMMUNITY_LOWER, IMMUNITY_UPPER)
		addtimer(CALLBACK(host, /mob/living/carbon/human/proc/remove_zombie_immunity), cure_time, TIMER_STOPPABLE)
		host = null
	return ..()

/datum/component/zombie_infection/proc/extract_rna()
	if(rna_extracted)
		return FALSE
	to_chat(host, "<span class='userdanger'>You feel your genes being altered!</span>")
	rna_extracted = TRUE
	addtimer(CALLBACK(src, .proc/refresh_rna), RNA_REFRESH_TIME, TIMER_STOPPABLE)
	return TRUE

/datum/component/zombie_infection/proc/refresh_rna()
	rna_extracted = FALSE

/mob/living/carbon/human/proc/remove_zombie_immunity()
	REMOVE_TRAIT(src, TRAIT_ZOMBIE_IMMUNE, "zombie_virus")

/datum/component/zombie_infection/process(delta_time)
	if(!iszombie(host) && host.stat != DEAD)
		host.adjustToxLoss(0.5 * delta_time)
		if(DT_PROB(10, delta_time))
			var/obj/item/bodypart/wound_area = host.get_bodypart(BODY_ZONE_CHEST)
			if(wound_area)
				var/datum/wound/slash/moderate/rotting_wound = new
				rotting_wound.apply_wound(wound_area)
			host.emote(pick(list("cough", "sneeze")))
			to_chat(host, "<span class='danger'>[pick(insanity_phrases)]</span>")
	if(timer_id)
		return
	if(host.stat != DEAD)
		return
	if(!iszombie(host))
		to_chat(host, "<span class='cultlarge'>You can feel your heart stopping, but something isn't right... \
		life has not abandoned your broken form. You can only feel a deep and immutable hunger that \
		not even death can stop, you will rise again!</span>")
	var/revive_time = rand(REVIVE_TIME_LOWER, REVIVE_TIME_UPPER)
	timer_id = addtimer(CALLBACK(src, .proc/transform_host), revive_time, TIMER_STOPPABLE)

/datum/component/zombie_infection/proc/cure_host()
	if(!host.stat == DEAD)
		to_chat(host, "<span class='notice'>You start to feel refreshed and invigorated!</span>")
	STOP_PROCESSING(SSobj, src)
	addtimer(CALLBACK(src, .proc/Destroy), CURE_TIME)

/datum/component/zombie_infection/proc/transform_host()
	timer_id = null

	if(!iszombie(host))
		old_species = host.dna.species.type
		host.set_species(/datum/species/zombie/infectious)

	var/stand_up = (host.stat == DEAD) || (host.stat == UNCONSCIOUS)

	//Fully heal the zombie's damage the first time they rise
	regenerate()

	host.do_jitter_animation(30)
	host.visible_message("<span class='danger'>[host] suddenly convulses, as [host.p_they()][stand_up ? " stagger to [host.p_their()] feet and" : ""] gain a ravenous hunger in [host.p_their()] eyes!</span>", "<span class='alien'>You HUNGER!</span>")
	playsound(host.loc, 'sound/hallucinations/far_noise.ogg', 50, TRUE)
	to_chat(host, "<span class='alertalien'>You are now a zombie! Do not seek to be cured, do not help any non-zombies in any way, do not harm your zombie brethren and spread the disease by killing others. You are a creature of hunger and violence.</span>")
	RegisterSignal(parent, COMSIG_LIVING_DEATH, .proc/zombie_death)

/datum/component/zombie_infection/proc/zombie_death()
	var/revive_time = rand(REVIVE_TIME_LOWER, REVIVE_TIME_UPPER)
	timer_id = addtimer(CALLBACK(src, .proc/regenerate), revive_time, TIMER_STOPPABLE)

/datum/component/zombie_infection/proc/regenerate()
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
	if(!host.mind)
		offer_control(host)
	else
		host.grab_ghost()
