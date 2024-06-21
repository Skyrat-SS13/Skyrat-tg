/**
 * Mutant Component
 *
 * This component is used to handle all of the intermediate processes for transforming someone from a human
 * into a zombie.
 */


#define CURE_TIME (10 SECONDS)
#define REVIVE_TIME_LOWER (2 MINUTES)
#define REVIVE_TIME_UPPER (3 MINUTES)
#define IMMUNITY_LOWER (5 MINUTES)
#define IMMUNITY_UPPER (10 MINUTES)
#define RNA_REFRESH_TIME (2 MINUTES) // How soon can we extract more RNA?

/datum/component/mutant_infection
	/// The reference to our host body.
	var/mob/living/carbon/human/host
	/// The previous species of the person infected. Used when they are uninfected.
	var/datum/species/old_species = /datum/species/human
	/// A list of possible mutant species we can choose from when someone is converted.
	var/list/mutant_species = list(/datum/species/mutant/infectious/fast, /datum/species/mutant/infectious/slow)
	/// The species we have selected after we have converted.
	var/datum/species/selected_type
	/// A list of phrases people are sent while they are being converted.
	var/list/insanity_phrases = list(
		"You feel too hot! Something isn't right!",
		"You can't think straight, please end the suffering!",
		"AAAAAAAAAAAAAAAGHHHHHHHH!"
		)
	/// Our timer ID used for seperate parts of the infection.
	var/timer_id
	/// Have we have our RNA extracted? If so, we can't have it extracted again.
	var/rna_extracted = FALSE
	/// How much toxin damage we take per tick. - Can probably be a define.
	var/tox_loss_mod = 0.5

/datum/component/mutant_infection/Initialize()
	. = ..()
	if(!ishuman(parent))
		return COMPONENT_INCOMPATIBLE
	host = parent

	if(host.stat == DEAD)
		var/revive_time = rand(REVIVE_TIME_LOWER, REVIVE_TIME_UPPER)
		timer_id = addtimer(CALLBACK(src, PROC_REF(transform_host)), revive_time, TIMER_STOPPABLE)
		to_chat(host, span_userdanger("You feel your veins throb as your body begins twitching..."))

	RegisterSignal(parent, COMSIG_MUTANT_CURED, PROC_REF(cure_host))

	START_PROCESSING(SSobj, src)

/datum/component/mutant_infection/Destroy(force, silent)
	STOP_PROCESSING(SSobj, src)
	UnregisterSignal(parent, list(COMSIG_MUTANT_CURED, COMSIG_LIVING_DEATH))
	if(timer_id)
		deltimer(timer_id)
		timer_id = null
	if(host)
		remove_infection()
		host = null
	return ..()

/datum/component/mutant_infection/proc/remove_infection()
	if(ismutant(host) && old_species)
		host.set_species(old_species)
	host.grab_ghost()
	host.revive(TRUE, TRUE)
	to_chat(host, span_greentext("You feel like you're free of that foul disease!"))
	ADD_TRAIT(host, TRAIT_MUTANT_IMMUNE, "mutant_virus")
	host.mind?.remove_antag_datum(/datum/antagonist/mutant)
	host.remove_filter("infection_glow")
	host.update_appearance()
	addtimer(CALLBACK(host, /mob/living/carbon/human/proc/remove_mutant_immunity), rand(IMMUNITY_LOWER, IMMUNITY_UPPER), TIMER_STOPPABLE)

/datum/component/mutant_infection/proc/extract_rna()
	if(rna_extracted)
		return FALSE
	to_chat(host, span_userdanger("You feel your genes being altered!"))
	rna_extracted = TRUE
	addtimer(CALLBACK(src, PROC_REF(refresh_rna)), RNA_REFRESH_TIME, TIMER_STOPPABLE)
	return TRUE

/datum/component/mutant_infection/proc/refresh_rna()
	rna_extracted = FALSE

/mob/living/carbon/human/proc/remove_mutant_immunity()
	REMOVE_TRAIT(src, TRAIT_MUTANT_IMMUNE, "mutant_virus")

/datum/component/mutant_infection/process(seconds_per_tick)
	if(!ismutant(host) && host.stat != DEAD)
		var/toxloss = host.getToxLoss()
		if(toxloss < 50)
			host.adjustToxLoss(tox_loss_mod * seconds_per_tick)
			if(SPT_PROB(5, seconds_per_tick))
				to_chat(host, span_userdanger("You feel your motor controls seize up for a moment!"))
				host.Paralyze(10)
		else
			host.adjustToxLoss((tox_loss_mod * 2) * seconds_per_tick)
			if(SPT_PROB(10, seconds_per_tick))
				var/obj/item/bodypart/wound_area = host.get_bodypart(BODY_ZONE_CHEST)
				if(wound_area)
					var/datum/wound/slash/flesh/moderate/rotting_wound = new
					rotting_wound.apply_wound(wound_area)
				host.emote(pick(list("cough", "sneeze", "scream")))
	if(timer_id)
		return
	if(host.stat != DEAD)
		return
	if(!ismutant(host))
		to_chat(host, span_cult_large("You can feel your heart stopping, but something isn't right... \
		life has not abandoned your broken form. You can only feel a deep and immutable hunger that \
		not even death can stop, you will rise again!"))
	var/revive_time = rand(REVIVE_TIME_LOWER, REVIVE_TIME_UPPER)
	to_chat(host, span_redtext("You will transform in approximately [revive_time/10] seconds."))
	timer_id = addtimer(CALLBACK(src, PROC_REF(transform_host)), revive_time, TIMER_STOPPABLE)

/datum/component/mutant_infection/proc/cure_host()
	SIGNAL_HANDLER
	if(!host.stat == DEAD)
		to_chat(host, span_notice("You start to feel refreshed and invigorated!"))
	STOP_PROCESSING(SSobj, src)
	addtimer(CALLBACK(src, PROC_REF(Destroy)), CURE_TIME)

/datum/component/mutant_infection/proc/transform_host()
	timer_id = null

	selected_type = pick(mutant_species)

	if(!ismutant(host))
		old_species = host.dna.species
		host.set_species(selected_type)

	var/stand_up = (host.stat == DEAD) || (host.stat == UNCONSCIOUS)

	//Fully heal the mutant's damage the first time they rise
	regenerate()

	host.do_jitter_animation(30)
	host.visible_message(span_danger("[host] suddenly convulses, as [host.p_they()][stand_up ? " stagger to [host.p_their()] feet and" : ""] gain a ravenous hunger in [host.p_their()] eyes!"), span_alien("You HUNGER!"))
	playsound(host.loc, 'sound/hallucinations/far_noise.ogg', 50, TRUE)
	if(is_species(host, /datum/species/mutant/infectious/fast))
		to_chat(host, span_redtext("You are a FAST zombie. You run fast and hit more quickly, beware however, you are much weaker and susceptible to damage."))
	else
		to_chat(host, span_redtext("You are a SLOW zombie. You walk slowly and hit more slowly and harder. However, you are far more resilient to most damage types."))
	to_chat(host, span_alertalien("You are now a mutant! Do not seek to be cured, do not help any non-mutants in any way, do not harm your mutant brethren. You retain some higher functions and can reason to an extent."))
	host.mind?.add_antag_datum(/datum/antagonist/mutant)
	create_glow()
	RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(mutant_death))

/datum/component/mutant_infection/proc/mutant_death()
	SIGNAL_HANDLER
	var/revive_time = rand(REVIVE_TIME_LOWER, REVIVE_TIME_UPPER)
	to_chat(host, span_cult_large("You can feel your heart stopping, but something isn't right... you will rise again!"))
	timer_id = addtimer(CALLBACK(src, PROC_REF(regenerate)), revive_time, TIMER_STOPPABLE)

/datum/component/mutant_infection/proc/regenerate()
	if(!host.mind)
		var/mob/canidate = SSpolling.poll_ghosts_for_target("Do you want to play as a mutant([host.name])?", checked_target = host)
		if(!istype(canidate))
			return
		host.key = canidate.key
	else
		host.grab_ghost()
	to_chat(host, span_notice("You feel an itching, both inside and \
		outside as your tissues knit and reknit."))
	playsound(host, 'sound/magic/demon_consume.ogg', 50, TRUE)
	host.revive(TRUE, TRUE)

/datum/component/mutant_infection/proc/create_glow()
	var/atom/movable/parent_movable = parent
	if(!istype(parent_movable))
		return

	parent_movable.add_filter("infection_glow", 2, list("type" = "outline", "color" = COLOR_RED, "size" = 2))
	addtimer(CALLBACK(src, PROC_REF(start_glow_loop), parent_movable), rand(0.1 SECONDS, 1.9 SECONDS))

/datum/component/mutant_infection/proc/start_glow_loop(atom/movable/parent_movable)
	var/filter = parent_movable.get_filter("infection_glow")
	if(!filter)
		return

	animate(filter, alpha = 110, time = 1.5 SECONDS, loop = -1)
	animate(alpha = 40, time = 2.5 SECONDS)
