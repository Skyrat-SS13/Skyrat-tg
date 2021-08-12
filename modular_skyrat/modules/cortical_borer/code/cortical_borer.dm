/mob/living/simple_animal/cortical_borer
	name = "cortical borer"
	desc = "A slimy creature that is known to go into the ear canal of unsuspecting victims."
	maxHealth = 50
	health = 50
	//they need to be able to pass tables and mobs
	pass_flags = PASSTABLE | PASSMOB
	//they are below mobs, or below tables
	layer = BELOW_MOB_LAYER
	///what chemicals borers know, starting with none
	var/list/known_chemicals = list()
	var/list/potential_chemicals = list(/datum/reagent/medicine/spaceacillin,
										/datum/reagent/medicine/potass_iodide,
										/datum/reagent/medicine/diphenhydramine,
										/datum/reagent/medicine/epinephrine,
										/datum/reagent/medicine/antihol,
										/datum/reagent/medicine/haloperidol,
										/datum/reagent/consumable/nutriment,
										/datum/reagent/consumable/hell_ramen,
										/datum/reagent/consumable/tearjuice,
										/datum/reagent/drug/thc,
										/datum/reagent/drug/quaalude,
										/datum/reagent/drug/happiness,
										/datum/reagent/consumable/tea,
										/datum/reagent/consumable/hot_coco,
										/datum/reagent/toxin/formaldehyde,
										/datum/reagent/impurity/libitoil,
										/datum/reagent/impurity/mannitol,
										/datum/reagent/medicine/c2/libital,
										/datum/reagent/medicine/c2/lenturi,
										/datum/reagent/medicine/c2/convermol,
										/datum/reagent/medicine/c2/seiver,
										/datum/reagent/lithium,
										/datum/reagent/consumable/orangejuice,
										/datum/reagent/consumable/tomatojuice,
										/datum/reagent/consumable/limejuice,
										/datum/reagent/consumable/carrotjuice,
										/datum/reagent/consumable/milk,
										/datum/reagent/medicine/salglu_solution,
										/datum/reagent/medicine/mutadone,
	)
	///how old the borer is, starting from zero. Goes up only when inside a host
	var/maturity_age = 0
	///the amount of "evolution" points a borer has for chemicals
	var/chemical_evolution = 0
	///the amount of "evolution" points a borer has for stats
	var/stat_evolution = 0
	///how many chemical points the borer can have. Can be upgraded
	var/max_chemical_storage = 50
	///how many chemical points the borer has
	var/chemical_storage = 50
	///how fast chemicals are gained. Goes up only when inside a host
	var/chemical_regen = 1
	///the list of actions that the borer has
	var/list/known_abilities = list(/datum/action/cooldown/toggle_hiding,
									/datum/action/cooldown/choosing_host,
									/datum/action/cooldown/produce_offspring,

	)
	///the host
	var/mob/living/carbon/human/human_host
	var/timed_maturity = 0

/mob/living/simple_animal/cortical_borer/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT) //they need to be able to move around

/mob/living/simple_animal/cortical_borer/Life(delta_time, times_fired)
	. = ..()

	if(!inside_human())
		return

	if(chemical_storage < max_chemical_storage)
		chemical_storage = min(chemical_storage + chemical_regen, max_chemical_storage)

	if(health < maxHealth)
		health = min(health * 1.01, maxHealth)

	if(timed_maturity < world.time)
		timed_maturity = world.time + 1 SECONDS
		maturity_age++

	switch(maturity_age)
		if(180) //every three minutes, which basically turns into 9 minutes
			chemical_evolution++
		if(360)
			stat_evolution++
		if(540)
			maturity_age = 0

/mob/living/simple_animal/cortical_borer/attack_ghost(mob/dead/observer/user)
	. = ..()
	if(mind)
		return
	var/choice = tgui_input_list(usr, "Do you want to control [src]?", "Confirmation", list("Yes", "No"))
	if(choice != "Yes")
		return
	to_chat(user, span_warning("As a borer, you have the option to be friendly or not. Note that how you act will determine how a host responds!"))
	key = user.key
	mind = user.mind

/datum/action/cooldown/upgrade_chemical
	name = "Toggle Hiding"
	cooldown_time = 1 SECONDS

//go between either hiding behind tables or behind mobs
/datum/action/cooldown/toggle_hiding
	name = "Toggle Hiding"
	cooldown_time = 1 SECONDS

/datum/action/cooldown/toggle_hiding/Trigger()
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	if(owner.layer == PROJECTILE_HIT_THRESHHOLD_LAYER)
		to_chat(owner, span_notice("You stop hiding."))
		owner.layer = BELOW_MOB_LAYER
		StartCooldown()
		return
	to_chat(owner, span_notice("You start hiding."))
	owner.layer = PROJECTILE_HIT_THRESHHOLD_LAYER
	StartCooldown()

//to either get inside, or out, of a host
/datum/action/cooldown/choosing_host
	name = "Inhabit/Uninhabit Host"
	cooldown_time = 1 SECONDS

/datum/action/cooldown/choosing_host/Trigger()
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(cortical_owner.human_host)
		to_chat(cortical_owner, span_notice("You forcefully detach from the host."))
		cortical_owner.forceMove(get_turf(cortical_owner.human_host))
		cortical_owner.human_host = null
		StartCooldown()
		return
	var/list/usable_hosts = list()
	for(var/mob/living/carbon/human/listed_human in range(1, cortical_owner))
		if(!ishuman(listed_human)) //no nonhuman hosts
			continue
		if(listed_human.stat == DEAD) //no dead hosts
			continue
		if(considered_afk(listed_human.mind)) //no afk hosts
			continue
		usable_hosts += listed_human
	var/choose_host = input(cortical_owner, "Choose your host!", "Host Choice") as null|anything in usable_hosts
	if(!choose_host)
		to_chat(cortical_owner, span_warning("You failed to choose a host."))
		return
	if(get_dist(choose_host, cortical_owner) > 1)
		to_chat(cortical_owner, span_warning("The host is too far away."))
		return
	if(!do_after(cortical_owner, 5 SECONDS, target = choose_host))
		to_chat(cortical_owner, span_warning("You and the host must be still."))
		return
	cortical_owner.human_host = choose_host
	StartCooldown()

//we need a way to produce offspring
/datum/action/cooldown/produce_offspring
	name = "Inhabit/Uninhabit Host (100 chemicals)"
	cooldown_time = 10 SECONDS

/datum/action/cooldown/produce_offspring/Trigger()
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!ishuman(cortical_owner.loc))
		to_chat(cortical_owner, span_warning("You must be inside a human in order to do this!"))
		return
	if(cortical_owner.chemical_storage < 100)
		to_chat(cortical_owner, span_warning("You require at least 100 chemical units before you can reproduce!"))
		return
	cortical_owner.chemical_storage -= 100
	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you want to spawn as a cortical borer?", ROLE_PAI, FALSE, 100, POLL_IGNORE_CORTICAL_BORER)
	if(!LAZYLEN(candidates))
		to_chat(cortical_owner, span_notice("No available borers in the hivemind."))
		cortical_owner.chemical_storage = min(cortical_owner.max_chemical_storage, cortical_owner.chemical_storage + 100)
		return
	var/mob/dead/observer/pick_candidate = pick(candidates)
	var/mob/living/simple_animal/cortical_borer/spawn_borer = new /mob/living/simple_animal/cortical_borer
	spawn_borer.key = pick_candidate.key
	spawn_borer.mind = pick_candidate.mind

//check if we are inside a human
/mob/living/simple_animal/cortical_borer/proc/inside_human()
	if(!ishuman(loc))
		return FALSE
	return TRUE

//borers should not be emoting
/mob/living/simple_animal/cortical_borer/emote(act, m_type, message, intentional, force_silence)
	to_chat(src, span_warning("You are not able to emote!"))
	return FALSE

//borers should not be talking without a host at least
/mob/living/simple_animal/cortical_borer/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced)
	if(!inside_human())
		to_chat(src, span_warning("You are not able to speak without a host!"))
		return
	return ..()
