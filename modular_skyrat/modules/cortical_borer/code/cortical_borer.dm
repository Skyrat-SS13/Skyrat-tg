GLOBAL_LIST_EMPTY(cortical_borers)

/mob/proc/has_borer()
	for(var/check_content in contents)
		if(iscorticalborer(check_content))
			return check_content
	return FALSE

/obj/machinery/door/Bumped(atom/movable/movable_atom)
	if(iscorticalborer(movable_atom) && density)
		if(!do_after(movable_atom, 5 SECONDS, src))
			return ..()
		movable_atom.forceMove(get_turf(src))
		to_chat(movable_atom, span_notice("You squeeze through [src]."))
		return
	return ..()

/obj/item/organ/brain/Remove(mob/living/carbon/target, special = 0, no_id_transfer = FALSE)
	. = ..()
	var/mob/living/simple_animal/cortical_borer/cb_inside = target.has_borer()
	if(cb_inside)
		cb_inside.leave_host()

/mob/living/simple_animal/cortical_borer
	name = "cortical borer"
	desc = "A slimy creature that is known to go into the ear canal of unsuspecting victims."
	icon = 'modular_skyrat/modules/cortical_borer/icons/animal.dmi'
	icon_state = "brainslug"
	icon_living = "brainslug"
	icon_dead = "brainslug_dead"
	maxHealth = 50
	health = 50
	//they need to be able to pass tables and mobs
	pass_flags = PASSTABLE | PASSMOB
	//they are below mobs, or below tables
	layer = BELOW_MOB_LAYER
	//corticals are tiny
	mob_size = MOB_SIZE_TINY
	//because they are small, why can't they be held?
	can_be_held = TRUE
	///what chemicals borers know, starting with none
	var/list/known_chemicals = list()
	///what chemicals the borer can learn
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
										/datum/reagent/toxin/heparin,
										/datum/reagent/consumable/ethanol/beer,
										/datum/reagent/medicine/mannitol,
										/datum/reagent/drug/methamphetamine,
										/datum/reagent/medicine/morphine,
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
									/datum/action/cooldown/inject_chemical,
									/datum/action/cooldown/upgrade_chemical,
									/datum/action/cooldown/upgrade_stat,
									/datum/action/cooldown/fear_human,
									/datum/action/cooldown/check_blood,
									/datum/action/cooldown/revive_host,
	)
	///the host
	var/mob/living/carbon/human/human_host
	//just a little "timer" to compare to world.time
	var/timed_maturity = 0
	///multiplies the current health up to the max health
	var/health_regen = 1.02
	//holds the chems right before injection
	var/obj/item/reagent_containers/reagent_holder
	//just a flavor kind of thing
	var/generation = 1

/mob/living/simple_animal/cortical_borer/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_VENTCRAWLER_ALWAYS, INNATE_TRAIT) //they need to be able to move around
	name = "[initial(name)] ([generation]-[rand(100,999)])"
	GLOB.cortical_borers += src
	reagent_holder = new /obj/item/reagent_containers(src)
	for(var/action_type in known_abilities)
		var/datum/action/attack_action = new action_type()
		attack_action.Grant(src)

/mob/living/simple_animal/cortical_borer/death(gibbed)
	if(inside_human())
		var/turf/human_turf = get_turf(human_host)
		forceMove(human_turf)
	GLOB.cortical_borers -= src
	for(var/borers in GLOB.cortical_borers)
		to_chat(borers, span_boldwarning("[src] has left the hivemind forcibly!"))
	mind.remove_all_antag_datums()
	qdel(reagent_holder)
	return ..()

/mob/living/simple_animal/cortical_borer/get_status_tab_items()
	. = ..()
	. += "Chemical Storage: [chemical_storage]/[max_chemical_storage]"
	. += "Chemical Evoltion Points: [chemical_evolution]"
	. += "Stat Evolution Points: [stat_evolution]"
	if(host_sugar())
		. += "Sugar detected! Unable to generate resources!"

/mob/living/simple_animal/cortical_borer/Life(delta_time, times_fired)
	. = ..()

	if(!inside_human())
		return

	if(host_sugar())
		return

	if(chemical_storage < max_chemical_storage)
		chemical_storage = min(chemical_storage + chemical_regen, max_chemical_storage)
		if(chemical_storage > max_chemical_storage)
			chemical_storage = max_chemical_storage

	if(health < maxHealth)
		health = min(health * health_regen, maxHealth)
		if(health > maxHealth)
			health = maxHealth

	if(timed_maturity < world.time)
		timed_maturity = world.time + 1 SECONDS
		maturity_age++

	switch(maturity_age)
		if(60) //every 1 minutes, which basically turns into 3 minutes
			chemical_evolution++
			to_chat(src, span_notice("You gain a chemical evolution point. Spend it to learn a new chemical!"))
		if(120)
			stat_evolution++
			to_chat(src, span_notice("You gain a stat evolution point. Spend it to become stronger!"))
		if(180)
			maturity_age = 0

//if it doesnt have a mind, let ghosts have it
/mob/living/simple_animal/cortical_borer/attack_ghost(mob/dead/observer/user)
	. = ..()
	if(ckey)
		return
	var/choice = tgui_input_list(usr, "Do you want to control [src]?", "Confirmation", list("Yes", "No"))
	if(choice != "Yes")
		return
	to_chat(user, span_warning("As a borer, you have the option to be friendly or not. Note that how you act will determine how a host responds!"))
	to_chat(user, span_warning("You are a cortical borer! You can fear someone to make them stop moving, but make sure to inhabit them! You only grow/heal/talk when inside a host!"))
	ckey = user.ckey
	mind.add_antag_datum(/datum/antagonist/cortical_borer)

//inject chemicals into your host
/datum/action/cooldown/inject_chemical
	name = "Inject 5u Chemical (10 chemicals)"
	cooldown_time = 1 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "chemical"

/datum/action/cooldown/inject_chemical/Trigger()
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.human_host)
		to_chat(cortical_owner, span_warning("You need a host in order to use this ability!"))
		return
	if(cortical_owner.host_sugar())
		to_chat(cortical_owner, span_warning("Sugar inhibits your abilities to function!"))
		return
	if(!cortical_owner.known_chemicals.len)
		to_chat(cortical_owner, span_warning("You need to learn chemicals first!"))
		return
	if(cortical_owner.chemical_storage < 10)
		to_chat(cortical_owner, span_warning("You require at least 10 chemical units to inject a chemical!"))
		return
	cortical_owner.chemical_storage -= 10
	var/choice = tgui_input_list(cortical_owner, "Choose a chemical to inject!", "Chemical Selection", cortical_owner.known_chemicals)
	if(!choice)
		to_chat(cortical_owner, span_warning("No selection made!"))
		cortical_owner.chemical_storage += 10
		return
	cortical_owner.reagent_holder.reagents.add_reagent(choice, 5)
	cortical_owner.reagent_holder.reagents.trans_to(cortical_owner.human_host, 30, methods = INGEST)
	StartCooldown()

//become stronger by learning new chemicals
/datum/action/cooldown/upgrade_chemical
	name = "Learn New Chemical"
	cooldown_time = 1 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "level"

/datum/action/cooldown/upgrade_chemical/Trigger()
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(cortical_owner.host_sugar())
		to_chat(owner, span_warning("Sugar inhibits your abilities to function!"))
		return
	if(cortical_owner.chemical_evolution < 1)
		to_chat(owner, span_warning("You do not have any upgrade points for chemicals!"))
		return
	if(!cortical_owner.potential_chemicals.len)
		to_chat(owner, span_warning("There are no more chemicals!"))
		return
	var/reagent_choice = tgui_input_list(cortical_owner, "Choose a chemical to learn.", "Chemical Selection", cortical_owner.potential_chemicals)
	if(!reagent_choice)
		to_chat(owner, span_warning("No selection made!"))
		return
	if(cortical_owner.chemical_evolution < 1)
		to_chat(owner, span_warning("You do not have any upgrade points for chemicals!"))
		return
	cortical_owner.known_chemicals += reagent_choice
	cortical_owner.potential_chemicals -= reagent_choice
	cortical_owner.chemical_evolution--
	var/datum/reagent/reagent_name = reagent_choice
	to_chat(owner, span_notice("You have learned [reagent_name.name]"))
	StartCooldown()

//become stronger by affecting the stats
/datum/action/cooldown/upgrade_stat
	name = "Become Stronger"
	cooldown_time = 1 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "level"

/datum/action/cooldown/upgrade_stat/Trigger()
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(cortical_owner.host_sugar())
		to_chat(owner, span_warning("Sugar inhibits your abilities to function!"))
		return
	if(cortical_owner.stat_evolution < 1)
		to_chat(owner, span_warning("You do not have any upgrade points for stats!"))
		return
	var/choice = tgui_input_list(cortical_owner, "Choose a stat to upgrade!", "Stat Choice", list("Health", "Health Regen", "Chemical Storage", "Chemical Regen"))
	if(!choice)
		to_chat(owner, span_warning("No selection made!"))
		return
	if(cortical_owner.stat_evolution < 1)
		to_chat(owner, span_warning("You do not have any upgrade points for stats!"))
		return
	switch(choice)
		if("Health")
			cortical_owner.maxHealth += 5
			to_chat(cortical_owner, span_notice("Your health increases slightly!"))
		if("Health Regen")
			cortical_owner.health_regen += 0.02
			to_chat(cortical_owner, span_notice("Your health regen increases slightly!"))
		if("Chemical Storage")
			cortical_owner.max_chemical_storage += 20
			to_chat(cortical_owner, span_notice("Your chemical storage increases slightly!"))
		if("Chemical Regen")
			cortical_owner.chemical_regen++
			to_chat(cortical_owner, span_notice("Your chemical regen increases slightly!"))
	cortical_owner.stat_evolution--
	StartCooldown()

//go between either hiding behind tables or behind mobs
/datum/action/cooldown/toggle_hiding
	name = "Toggle Hiding"
	cooldown_time = 1 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "hide"

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

//to paralyze people
/datum/action/cooldown/fear_human
	name = "Incite Fear"
	cooldown_time = 12 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "fear"

/datum/action/cooldown/fear_human/Trigger()
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(cortical_owner.host_sugar())
		to_chat(owner, span_warning("Sugar inhibits your abilities to function!"))
		return
	if(cortical_owner.human_host)
		to_chat(cortical_owner, span_notice("You incite fear into your host."))
		cortical_owner.human_host.Paralyze(10 SECONDS)
		StartCooldown()
		return
	var/list/potential_freezers = list()
	for(var/mob/living/carbon/human/listed_human in range(1, cortical_owner))
		if(!ishuman(listed_human)) //no nonhuman hosts
			continue
		if(listed_human.stat == DEAD) //no dead hosts
			continue
		if(considered_afk(listed_human.mind)) //no afk hosts
			continue
		potential_freezers += listed_human
	var/mob/living/carbon/human/choose_fear = tgui_input_list(cortical_owner, "Choose who you will fear!", "Fear Choice", potential_freezers)
	if(!choose_fear)
		to_chat(cortical_owner, span_warning("No selection was made!"))
		return
	if(get_dist(choose_fear, cortical_owner) > 1)
		to_chat(cortical_owner, span_warning("The chosen is too far"))
		return
	choose_fear.Paralyze(7 SECONDS)
	StartCooldown()

//to check the health of the human
/datum/action/cooldown/check_blood
	name = "Check Blood"
	cooldown_time = 5 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "blood"

/datum/action/cooldown/check_blood/Trigger()
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(cortical_owner.host_sugar())
		to_chat(owner, span_warning("Sugar inhibits your abilities to function!"))
		return
	if(!cortical_owner.human_host)
		to_chat(owner, span_warning("You must have a host to check blood!"))
		return
	var/message = ""
	message += "Brute: [cortical_owner.human_host.getBruteLoss()] "
	message += "Fire: [cortical_owner.human_host.getFireLoss()] "
	message += "Toxin: [cortical_owner.human_host.getToxLoss()] "
	message += "Oxygen: [cortical_owner.human_host.getOxyLoss()] "
	var/reagent_message = "Current Reagents:"
	for(var/check_reagents in cortical_owner.human_host.reagents.reagent_list)
		var/datum/reagent/reagent_name = check_reagents
		reagent_message += reagent_name.name
		reagent_message += ", "
	message += reagent_message
	to_chat(cortical_owner, span_notice(message))
	StartCooldown()

//to either get inside, or out, of a host
/datum/action/cooldown/choosing_host
	name = "Inhabit/Uninhabit Host"
	cooldown_time = 10 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "host"

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
		if(listed_human.has_borer())
			continue
		usable_hosts += listed_human
	var/choose_host = tgui_input_list(cortical_owner, "Choose your host!", "Host Choice", usable_hosts)
	if(!choose_host)
		to_chat(cortical_owner, span_warning("You failed to choose a host."))
		return
	var/mob/living/carbon/human/choosen_human = choose_host
	if(choosen_human.has_borer())
		to_chat(cortical_owner, span_warning("You cannot occupy a body already occupied!"))
		return
	if(!do_after(cortical_owner, 5 SECONDS, target = choose_host))
		to_chat(cortical_owner, span_warning("You and the host must be still."))
		return
	if(get_dist(choose_host, cortical_owner) > 1)
		to_chat(cortical_owner, span_warning("The host is too far away."))
		return
	cortical_owner.human_host = choose_host
	cortical_owner.forceMove(cortical_owner.human_host)
	cortical_owner.copy_languages(cortical_owner.human_host)
	StartCooldown()

//we need a way to produce offspring
/datum/action/cooldown/produce_offspring
	name = "Produce Offspring (100 chemicals)"
	cooldown_time = 1 MINUTES
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "reproduce"

/datum/action/cooldown/produce_offspring/Trigger()
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(cortical_owner.host_sugar())
		to_chat(owner, span_warning("Sugar inhibits your abilities to function!"))
		return
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
	var/turf/human_turf = get_turf(cortical_owner.human_host)
	var/mob/dead/observer/pick_candidate = pick(candidates)
	var/mob/living/simple_animal/cortical_borer/spawn_borer = new /mob/living/simple_animal/cortical_borer(human_turf)
	new /obj/effect/decal/cleanable/vomit(human_turf)
	playsound(human_turf, 'sound/effects/splat.ogg', 50, TRUE)
	spawn_borer.ckey = pick_candidate.ckey
	spawn_borer.generation = cortical_owner.generation + 1
	spawn_borer.name = "[initial(spawn_borer.name)] ([cortical_owner.generation]-[rand(100,999)])"
	spawn_borer.mind.add_antag_datum(/datum/antagonist/cortical_borer)
	to_chat(spawn_borer, span_warning("You are a cortical borer! You can fear someone to make them stop moving, but make sure to inhabit them! You only grow/heal/talk when inside a host!"))
	StartCooldown()

/datum/action/cooldown/revive_host
	name = "Revive Host (200 chemicals)"
	cooldown_time = 2 MINUTES
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "revive"

/datum/action/cooldown/revive_host/Trigger()
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(cortical_owner.host_sugar())
		to_chat(owner, span_warning("Sugar inhibits your abilities to function!"))
		return
	if(!ishuman(cortical_owner.loc))
		to_chat(cortical_owner, span_warning("You must be inside a human in order to do this!"))
		return
	if(cortical_owner.chemical_storage < 200)
		to_chat(cortical_owner, span_warning("You require at least 200 chemical units before you can reproduce!"))
		return
	cortical_owner.chemical_storage -= 200
	cortical_owner.human_host.adjustBruteLoss(-(cortical_owner.human_host.getBruteLoss()*0.5))
	cortical_owner.human_host.adjustToxLoss(-(cortical_owner.human_host.getToxLoss()*0.5))
	cortical_owner.human_host.adjustFireLoss(-(cortical_owner.human_host.getFireLoss()*0.5))
	cortical_owner.human_host.adjustOxyLoss(-(cortical_owner.human_host.getOxyLoss()*0.5))
	cortical_owner.human_host.revive()
	StartCooldown()

//check if we are inside a human
/mob/living/simple_animal/cortical_borer/proc/inside_human()
	if(!ishuman(loc))
		return FALSE
	return TRUE

/mob/living/simple_animal/cortical_borer/proc/host_sugar()
	if(human_host?.reagents?.has_reagent(/datum/reagent/consumable/sugar))
		return TRUE
	return FALSE

/mob/living/simple_animal/cortical_borer/proc/leave_host()
	if(!human_host)
		return
	var/turf/human_turf = get_turf(human_host)
	forceMove(human_turf)
	human_host = null

//borers should not be emoting
/mob/living/simple_animal/cortical_borer/emote(act, m_type, message, intentional, force_silence)
	if(human_host)
		to_chat(src, span_warning("You are not able to emote while inside a host!"))
		return FALSE
	return ..()

/mob/living/simple_animal/cortical_borer/whisper(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced)
	to_chat(src, span_warning("You are not able to whisper!"))
	return FALSE

//borers should not be talking without a host at least
/mob/living/simple_animal/cortical_borer/say(message, bubble_type, list/spans, sanitize, datum/language/language, ignore_spam, forced)
	if(!inside_human())
		to_chat(src, span_warning("You are not able to speak without a host!"))
		return
	if(host_sugar())
		to_chat(src, span_warning("Sugar inhibits your abilities to function!"))
		return
	message = sanitize(message)
	var/list/split_message = splittext(message, "")
	if(split_message[1] == ";")
		message = copytext(message, 2)
		for(var/borer in GLOB.cortical_borers)
			to_chat(borer, span_purple("Cortical Hivemind: [src] sings, \"[message]\""))
		for(var/mob/dead_mob in GLOB.dead_mob_list)
			var/link = FOLLOW_LINK(dead_mob, src)
			to_chat(dead_mob, span_purple("[link] Cortical Hivemind: [src] sings, \"[message]\""))
		return
	to_chat(human_host, span_purple("Cortical Link: [src] sings, \"[message]\""))
	to_chat(src, span_purple("Cortical Link: [src] sings, \"[message]\""))
	for(var/mob/dead_mob in GLOB.dead_mob_list)
		var/link = FOLLOW_LINK(dead_mob, src)
		to_chat(dead_mob, span_purple("[link] Cortical Hivemind: [src] sings to [human_host], \"[message]\""))

/datum/antagonist/cortical_borer
	name = "Cortical Borer"
	job_rank = ROLE_ALIEN
	show_in_antagpanel = TRUE
	prevent_roundtype_conversion = FALSE
	show_to_ghosts = TRUE

//Event (Admin Only)
/datum/round_event_control/cortical_borer
	name = "Cortical Borer Infestation"
	typepath = /datum/round_event/ghost_role/cortical_borer
	weight = 10
	min_players = 999 //so it wont spawn without admin intervention
	dynamic_should_hijack = TRUE

/datum/round_event/ghost_role/cortical_borer
	announceWhen = 400

/datum/round_event/ghost_role/cortical_borer/setup()
	announceWhen = rand(announceWhen, announceWhen + 50)

/datum/round_event/ghost_role/cortical_borer/announce(fake)
	priority_announce("Unidentified lifesigns detected coming aboard [station_name()]. Secure any exterior access, including ducting and ventilation.", "Lifesign Alert", ANNOUNCER_ALIENS)

/datum/round_event/ghost_role/cortical_borer/start()
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent in GLOB.machines)
		if(QDELETED(temp_vent))
			continue
		if(is_station_level(temp_vent.loc.z) && !temp_vent.welded)
			var/datum/pipeline/temp_vent_parent = temp_vent.parents[1]
			if(!temp_vent_parent)
				continue // No parent vent
			// Stops Cortical Borers getting stuck in small networks.
			// See: Security, Virology
			if(temp_vent_parent.other_atmosmch.len > 20)
				vents += temp_vent
	if(!vents.len)
		return MAP_ERROR
	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you want to spawn as a cortical borer?", ROLE_PAI, FALSE, 10 SECONDS, POLL_IGNORE_CORTICAL_BORER)
	if(!candidates.len)
		return NOT_ENOUGH_PLAYERS
	var/living_number = max(GLOB.player_list.len / 30, 1)
	var/choosing_number = min(candidates.len, living_number)
	for(var/repeating_code in 1 to choosing_number)
		var/mob/dead/observer/new_borer = pick(candidates)
		var/turf/vent_turf = get_turf(pick(vents))
		var/mob/living/simple_animal/cortical_borer/spawned_cb = new /mob/living/simple_animal/cortical_borer(vent_turf)
		spawned_cb.ckey = new_borer.ckey
		spawned_cb.mind.add_antag_datum(/datum/antagonist/cortical_borer)
		to_chat(spawned_cb, span_warning("You are a cortical borer! You can fear someone to make them stop moving, but make sure to inhabit them! You only grow/heal/talk when inside a host!"))
	for(var/mob/dead_mob in GLOB.dead_mob_list)
		to_chat(dead_mob, span_notice("The cortical borers have been selected, you are able to orbit them! Remember, they can reproduce!"))
