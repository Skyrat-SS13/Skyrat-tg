#define CHEMICALS_PER_UNIT 2
#define CHEMICAL_SECOND_DIVISOR (5 SECONDS)
#define OUT_OF_HOST_EGG_COST 50
#define BLOOD_CHEM_OBJECTIVE 3

// Parent of all borer actions
/datum/action/cooldown/mob_cooldown/borer
	button_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	cooldown_time = 0
	shared_cooldown = NONE
	/// How many chemicals this costs
	var/chemical_cost = 0
	/// How many chem evo points are needed to use this ability
	var/chemical_evo_points = 0
	/// How many stat evo points are needed to use this ability
	var/stat_evo_points = 0

/datum/action/cooldown/mob_cooldown/borer/New(Target, original)
	. = ..()
	var/compiled_string = ""
	if(chemical_cost)
		compiled_string += "([chemical_cost] chemical[chemical_cost == 1 ? "" : "s"])"
	if(chemical_evo_points)
		compiled_string += " ([chemical_evo_points] chemical point[chemical_evo_points == 1 ? "" : "s"])"
	if(stat_evo_points)
		compiled_string += " ([stat_evo_points] stat point[stat_evo_points == 1 ? "" : "s"])"
	name = "[initial(name)][compiled_string]"

/datum/action/cooldown/mob_cooldown/borer/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(owner.stat == DEAD)
		return FALSE
	if(cortical_owner.chemical_storage < chemical_cost)
		cortical_owner.balloon_alert(cortical_owner, "need [chemical_cost] chemicals")
		return FALSE
	if(cortical_owner.chemical_evolution < chemical_evo_points)
		cortical_owner.balloon_alert(cortical_owner, "need [chemical_evo_points] chemical points")
		return FALSE
	if(cortical_owner.stat_evolution < stat_evo_points)
		cortical_owner.balloon_alert(cortical_owner, "need [stat_evo_points] stat points")
		return FALSE

	return . == FALSE ? FALSE : TRUE //. can be null, true, or false. There's a difference between null and false here

//inject chemicals into your host
/datum/action/cooldown/mob_cooldown/borer/inject_chemical
	name = "Open Chemical Injector"
	button_icon_state = "chemical"
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/borer/inject_chemical/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(!cortical_owner.human_host)
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	ui_interact(owner)

/datum/action/cooldown/mob_cooldown/borer/inject_chemical/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BorerChem", name)
		ui.open()

/datum/action/cooldown/mob_cooldown/borer/inject_chemical/ui_data(mob/user)
	var/list/data = list()
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	data["amount"] = cortical_owner.injection_rate_current
	data["energy"] = cortical_owner.chemical_storage / CHEMICALS_PER_UNIT
	data["maxEnergy"] = cortical_owner.max_chemical_storage / CHEMICALS_PER_UNIT
	data["borerTransferAmounts"] = cortical_owner.injection_rates_unlocked
	data["onCooldown"] = !COOLDOWN_FINISHED(cortical_owner, injection_cooldown)
	data["notEnoughChemicals"] = ((cortical_owner.injection_rate_current * CHEMICALS_PER_UNIT) > cortical_owner.chemical_storage) ? TRUE : FALSE

	var/chemicals[0]
	for(var/reagent in cortical_owner.known_chemicals)
		var/datum/reagent/temp = GLOB.chemical_reagents_list[reagent]
		if(temp)
			var/chemname = temp.name
			chemicals.Add(list(list("title" = chemname, "id" = ckey(temp.name))))
	data["chemicals"] = chemicals

	return data

/datum/action/cooldown/mob_cooldown/borer/inject_chemical/ui_act(action, params)
	. = ..()
	if(.)
		return
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	switch(action)
		if("amount")
			var/target = text2num(params["target"])
			if(target in cortical_owner.injection_rates)
				cortical_owner.injection_rate_current = target
				. = TRUE
		if("inject")
			if(!iscorticalborer(usr) || !COOLDOWN_FINISHED(cortical_owner, injection_cooldown))
				return
			if(cortical_owner.host_sugar())
				owner.balloon_alert(owner, "cannot function with sugar in host")
				return
			var/reagent_name = params["reagent"]
			var/reagent = GLOB.name2reagent[reagent_name]
			if(!(reagent in cortical_owner.known_chemicals))
				return

			cortical_owner.reagent_holder.reagents.add_reagent(reagent, cortical_owner.injection_rate_current, added_purity = 1)
			cortical_owner.reagent_holder.reagents.trans_to(cortical_owner.human_host, cortical_owner.injection_rate_current, methods = INGEST)

			to_chat(cortical_owner.human_host, span_warning("You feel something cool inside of you and a dull ache in your head!"))
			cortical_owner.chemical_storage -= cortical_owner.injection_rate_current * CHEMICALS_PER_UNIT
			COOLDOWN_START(cortical_owner, injection_cooldown, (cortical_owner.injection_rate_current / CHEMICAL_SECOND_DIVISOR))

			var/turf/human_turf = get_turf(cortical_owner.human_host)
			var/logging_text = "[key_name(cortical_owner)] injected [key_name(cortical_owner.human_host)] with [reagent_name] at [loc_name(human_turf)]"
			cortical_owner.log_message(logging_text, LOG_GAME)
			cortical_owner.human_host.log_message(logging_text, LOG_GAME)
			. = TRUE

/datum/action/cooldown/mob_cooldown/borer/inject_chemical/ui_state(mob/user)
	return GLOB.always_state

/datum/action/cooldown/mob_cooldown/borer/inject_chemical/ui_status(mob/user, datum/ui_state/state)
	if(!iscorticalborer(user))
		return UI_CLOSE

	var/mob/living/basic/cortical_borer/borer = user

	if(!borer.human_host)
		return UI_CLOSE
	return ..()

/datum/action/cooldown/mob_cooldown/borer/evolution_tree
	name = "Open Evolution Tree"
	button_icon_state = "newability"
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/borer/evolution_tree/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	ui_interact(owner)

/datum/action/cooldown/mob_cooldown/borer/evolution_tree/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BorerEvolution", name)
		ui.open()

/datum/action/cooldown/mob_cooldown/borer/evolution_tree/ui_data(mob/user)
	var/list/data = list()

	var/static/list/path_to_color = list(
		BORER_EVOLUTION_DIVEWORM = "red",
		BORER_EVOLUTION_HIVELORD = "purple",
		BORER_EVOLUTION_SYMBIOTE = "green",
		BORER_EVOLUTION_GENERAL = "label",
	)

	var/mob/living/basic/cortical_borer/cortical_owner = owner

	data["evolution_points"] = cortical_owner.stat_evolution

	for(var/datum/borer_evolution/evolution as anything in cortical_owner.get_possible_evolutions())
		if(evolution in cortical_owner.past_evolutions)
			continue

		var/list/evo_data = list()

		evo_data["path"] = evolution
		evo_data["name"] = initial(evolution.name)
		evo_data["desc"] = initial(evolution.desc)
		evo_data["gainFlavor"] = initial(evolution.gain_text)
		evo_data["cost"] = initial(evolution.evo_cost)
		evo_data["disabled"] = ((initial(evolution.evo_cost) > cortical_owner.stat_evolution) || (initial(evolution.mutually_exclusive) && cortical_owner.genome_locked))
		evo_data["evoPath"] = initial(evolution.evo_type)
		evo_data["color"] = path_to_color[initial(evolution.evo_type)] || "grey"
		evo_data["tier"] = initial(evolution.tier)
		evo_data["exclusive"] = initial(evolution.mutually_exclusive)

		data["learnableEvolution"] += list(evo_data)

	for(var/path in cortical_owner.past_evolutions)
		var/list/evo_data = list()
		var/datum/borer_evolution/found_evolution = cortical_owner.past_evolutions[path]

		evo_data["name"] = found_evolution.name
		evo_data["desc"] = found_evolution.desc
		evo_data["gainFlavor"] = found_evolution.gain_text
		evo_data["cost"] = found_evolution.evo_cost
		evo_data["evoPath"] = found_evolution.evo_type
		evo_data["color"] = path_to_color[found_evolution.evo_type] || "grey"
		evo_data["tier"] = found_evolution.tier

		data["learnedEvolution"] += list(evo_data)
	return data

/datum/action/cooldown/mob_cooldown/borer/evolution_tree/ui_act(action, params)
	. = ..()
	if(.)
		return
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	switch(action)
		if("evolve")
			var/datum/borer_evolution/to_evolve_path = text2path(params["path"])
			if(!ispath(to_evolve_path))
				CRASH("Cortical borer attempted to evolve with a non-evolution path! (Got: [to_evolve_path])")

			if(initial(to_evolve_path.evo_cost) > cortical_owner.stat_evolution)
				return
			if(initial(to_evolve_path.mutually_exclusive) && cortical_owner.genome_locked)
				return
			if(!cortical_owner.do_evolution(to_evolve_path))
				return

			log_borer_evolution("[key_name(owner)] gained knowledge: [initial(to_evolve_path.name)]")
			cortical_owner.stat_evolution -= initial(to_evolve_path.evo_cost)
			return TRUE

/datum/action/cooldown/mob_cooldown/borer/evolution_tree/ui_state(mob/user)
	return GLOB.always_state

/datum/action/cooldown/mob_cooldown/borer/learn_focus
	name = "Learn Focus"
	button_icon_state = "getfocus"
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/borer/learn_focus/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(!length(cortical_owner.possible_focuses))
		owner.balloon_alert(owner, "all focuses already learned")
		return
	var/list/fancy_list = list()
	for(var/datum/borer_focus/foci as anything in cortical_owner.possible_focuses)
		if(foci in cortical_owner.body_focuses)
			continue
		fancy_list["[foci.name] ([foci.cost] points)"] = foci
	var/focus_choice = tgui_input_list(cortical_owner, "Learn a focus!", "Focus Choice", fancy_list)
	if(!focus_choice)
		owner.balloon_alert(owner, "focus not chosen")
		return
	var/datum/borer_focus/picked_focus = fancy_list[focus_choice]
	if(cortical_owner.stat_evolution < picked_focus.cost)
		owner.balloon_alert(owner, "[picked_focus.cost] points required")
		return
	cortical_owner.stat_evolution -= picked_focus.cost
	cortical_owner.body_focuses += picked_focus
	picked_focus.on_add(cortical_owner.human_host, owner)
	owner.balloon_alert(owner, "focus learned successfully")
	StartCooldown()

/datum/action/cooldown/mob_cooldown/borer/learn_bloodchemical
	name = "Learn Chemical from Blood"
	button_icon_state = "bloodchem"
	chemical_evo_points = 5
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/borer/learn_bloodchemical/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(length(cortical_owner.human_host.reagents.reagent_list) <= 0)
		owner.balloon_alert(owner, "no reagents in host")
		return
	var/datum/reagent/reagent_choice = tgui_input_list(cortical_owner, "Choose a chemical to learn.", "Chemical Selection", cortical_owner.human_host.reagents.reagent_list)
	if(!reagent_choice)
		owner.balloon_alert(owner, "chemical not chosen")
		return
	if(locate(reagent_choice) in cortical_owner.known_chemicals)
		owner.balloon_alert(owner, "chemical already known")
		return
	if(locate(reagent_choice) in cortical_owner.blacklisted_chemicals)
		owner.balloon_alert(owner, "chemical blacklisted")
		return
	if(!(reagent_choice.chemical_flags & REAGENT_CAN_BE_SYNTHESIZED))
		owner.balloon_alert(owner, "cannot learn [initial(reagent_choice.name)]")
		return
	cortical_owner.chemical_evolution -= chemical_evo_points
	cortical_owner.known_chemicals += reagent_choice.type
	cortical_owner.blood_chems_learned++
	var/obj/item/organ/internal/brain/victim_brain = cortical_owner.human_host.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(victim_brain)
		cortical_owner.human_host.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5 * cortical_owner.host_harm_multiplier)
	if(cortical_owner.blood_chems_learned == BLOOD_CHEM_OBJECTIVE)
		GLOB.successful_blood_chem += 1
	owner.balloon_alert(owner, "[initial(reagent_choice.name)] learned")
	if(!HAS_TRAIT(cortical_owner.human_host, TRAIT_AGEUSIA))
		to_chat(cortical_owner.human_host, span_notice("You get a strange aftertaste of [initial(reagent_choice.taste_description)]!"))
	StartCooldown()

//become stronger by learning new chemicals
/datum/action/cooldown/mob_cooldown/borer/upgrade_chemical
	name = "Learn New Chemical"
	button_icon_state = "bloodlevel"
	chemical_evo_points = 1
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/borer/upgrade_chemical/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(!length(cortical_owner.potential_chemicals))
		owner.balloon_alert(owner, "all chemicals learned")
		return
	var/datum/reagent/reagent_choice = tgui_input_list(cortical_owner, "Choose a chemical to learn.", "Chemical Selection", cortical_owner.potential_chemicals)
	if(!reagent_choice)
		owner.balloon_alert(owner, "no chemical chosen")
		return
	cortical_owner.chemical_evolution -= chemical_evo_points
	cortical_owner.known_chemicals += reagent_choice
	cortical_owner.potential_chemicals -= reagent_choice
	var/obj/item/organ/internal/brain/victim_brain = cortical_owner.human_host.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(victim_brain)
		cortical_owner.human_host.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5 * cortical_owner.host_harm_multiplier)
	owner.balloon_alert(owner, "[initial(reagent_choice.name)] learned")
	if(!HAS_TRAIT(cortical_owner.human_host, TRAIT_AGEUSIA))
		to_chat(cortical_owner.human_host, span_notice("You get a strange aftertaste of [initial(reagent_choice.taste_description)]!"))
	StartCooldown()

//become stronger by affecting the stats
/datum/action/cooldown/mob_cooldown/borer/upgrade_stat
	name = "Become Stronger"
	button_icon_state = "level"
	stat_evo_points = 1
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/borer/upgrade_stat/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	cortical_owner.stat_evolution -= stat_evo_points
	cortical_owner.maxHealth += cortical_owner.health_per_level
	cortical_owner.health_regen += cortical_owner.health_regen_per_level
	cortical_owner.max_chemical_storage += cortical_owner.chem_storage_per_level
	cortical_owner.chemical_regen += cortical_owner.chem_regen_per_level
	cortical_owner.level += 1
	var/obj/item/organ/internal/brain/victim_brain = cortical_owner.human_host.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(victim_brain)
		cortical_owner.human_host.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10 * cortical_owner.host_harm_multiplier)
	cortical_owner.human_host.adjust_eye_blur(6 SECONDS * cortical_owner.host_harm_multiplier) //about 12 seconds' worth by default
	to_chat(cortical_owner, span_notice("You have grown!"))
	to_chat(cortical_owner.human_host, span_warning("You feel a sharp pressure in your head!"))
	StartCooldown()

//go between either hiding behind tables or behind mobs
/datum/action/cooldown/mob_cooldown/borer/toggle_hiding
	name = "Toggle Hiding"
	button_icon_state = "hide"
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/borer/toggle_hiding/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(HAS_TRAIT(cortical_owner, TRAIT_PRONE))
		SEND_SIGNAL(cortical_owner, COMSIG_MOVABLE_REMOVE_PRONE_STATE)
		cortical_owner.upgrade_flags &= ~BORER_HIDING
		owner.balloon_alert(owner, "stopped hiding")
		StartCooldown()
		return
	cortical_owner.upgrade_flags |= BORER_HIDING
	owner.balloon_alert(owner, "started hiding")
	cortical_owner.AddComponent(/datum/component/prone_mob)
	StartCooldown()

//to paralyze people
/datum/action/cooldown/mob_cooldown/borer/fear_human
	name = "Incite Fear"
	cooldown_time = 12 SECONDS
	button_icon_state = "fear"

/datum/action/cooldown/mob_cooldown/borer/fear_human/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(cortical_owner.human_host)
		incite_internal_fear()
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
	if(length(potential_freezers) == 1)
		incite_fear(potential_freezers[1])
		return
	var/mob/living/carbon/human/choose_fear = tgui_input_list(cortical_owner, "Choose who you will fear!", "Fear Choice", potential_freezers)
	if(!choose_fear)
		owner.balloon_alert(owner, "no target chosen")
		return
	if(get_dist(choose_fear, cortical_owner) > 1)
		owner.balloon_alert(owner, "chosen target too far")
		return
	incite_fear(choose_fear)
	StartCooldown()

/datum/action/cooldown/mob_cooldown/borer/fear_human/proc/incite_fear(mob/living/carbon/human/singular_fear)
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	to_chat(singular_fear, span_warning("Something glares menacingly at you!"))
	singular_fear.Paralyze(7 SECONDS)
	singular_fear.adjustStaminaLoss(50)
	singular_fear.set_confusion_if_lower(9 SECONDS)
	var/turf/human_turf = get_turf(singular_fear)
	var/logging_text = "[key_name(cortical_owner)] feared/paralyzed [key_name(singular_fear)] at [loc_name(human_turf)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	singular_fear.log_message(logging_text, LOG_GAME)

/datum/action/cooldown/mob_cooldown/borer/fear_human/proc/incite_internal_fear()
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	owner.balloon_alert(owner, "fear incited into host")
	cortical_owner.human_host.Paralyze(10 SECONDS)
	cortical_owner.human_host.adjustStaminaLoss(100)
	cortical_owner.human_host.set_confusion_if_lower(15 SECONDS)
	to_chat(cortical_owner.human_host, span_warning("Something moves inside of you violently!"))
	var/turf/human_turf = get_turf(cortical_owner.human_host)
	var/logging_text = "[key_name(cortical_owner)] feared/paralyzed [key_name(cortical_owner.human_host)] (internal) at [loc_name(human_turf)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	cortical_owner.human_host.log_message(logging_text, LOG_GAME)

//to check the health of the human
/datum/action/cooldown/mob_cooldown/borer/check_blood
	name = "Check Blood"
	cooldown_time = 5 SECONDS
	button_icon_state = "blood"
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/borer/check_blood/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(!cortical_owner.human_host)
		owner.balloon_alert(owner, "host required")
		return
	healthscan(owner, cortical_owner.human_host, advanced = TRUE) // :thinking:
	chemscan(owner, cortical_owner.human_host)
	StartCooldown()

//you can force your host to speak... dont abuse this
/datum/action/cooldown/mob_cooldown/borer/force_speak
	name = "Force Host Speak"
	cooldown_time = 30 SECONDS
	button_icon_state = "speak"
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/borer/force_speak/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "must be in a host")
		return
	var/borer_message = input(cortical_owner, "What would you like to force your host to say?", "Force Speak") as message|null
	if(!borer_message)
		owner.balloon_alert(owner, "no message given")
		return
	borer_message = sanitize(borer_message)
	var/mob/living/carbon/human/cortical_host = cortical_owner.human_host
	to_chat(cortical_host, span_boldwarning("Your voice moves without your permission!"))
	var/obj/item/organ/internal/brain/victim_brain = cortical_owner.human_host.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(victim_brain)
		cortical_owner.human_host.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2 * cortical_owner.host_harm_multiplier)
	cortical_host.say(message = borer_message, forced = TRUE)
	var/turf/human_turf = get_turf(cortical_owner.human_host)
	var/logging_text = "[key_name(cortical_owner)] forced [key_name(cortical_owner.human_host)] to say [borer_message] at [loc_name(human_turf)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	cortical_owner.human_host.log_message(logging_text, LOG_GAME)
	StartCooldown()

//we need a way to produce offspring
/datum/action/cooldown/mob_cooldown/borer/produce_offspring
	name = "Produce Offspring"
	cooldown_time = 1 MINUTES
	button_icon_state = "reproduce"
	chemical_cost = 100
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/borer/produce_offspring/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(!(cortical_owner.upgrade_flags & BORER_ALONE_PRODUCTION) && !cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	cortical_owner.chemical_storage -= chemical_cost
	if((cortical_owner.upgrade_flags & BORER_ALONE_PRODUCTION) && !cortical_owner.inside_human())
		no_host_egg()
		StartCooldown()
		return
	produce_egg()
	var/obj/item/organ/internal/brain/victim_brain = cortical_owner.human_host.get_organ_slot(ORGAN_SLOT_BRAIN)
	if(victim_brain)
		cortical_owner.human_host.adjustOrganLoss(ORGAN_SLOT_BRAIN, 25 * cortical_owner.host_harm_multiplier)
		var/eggroll = rand(1,100)
		if(eggroll <= 75)
			switch(eggroll)
				if(1 to 34)
					cortical_owner.human_host.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_BASIC)
				if(35 to 60)
					cortical_owner.human_host.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_SURGERY)
				if(61 to 71)
					cortical_owner.human_host.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_SURGERY)
				if(72 to 75)
					cortical_owner.human_host.gain_trauma_type(BRAIN_TRAUMA_SEVERE, TRAUMA_RESILIENCE_LOBOTOMY)
	to_chat(cortical_owner.human_host, span_warning("Your brain begins to hurt..."))
	var/turf/borer_turf = get_turf(cortical_owner)
	new /obj/effect/decal/cleanable/vomit(borer_turf)
	playsound(borer_turf, 'sound/effects/splat.ogg', 50, TRUE)
	var/logging_text = "[key_name(cortical_owner)] gave birth at [loc_name(borer_turf)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	owner.balloon_alert(owner, "egg laid")
	StartCooldown()

/datum/action/cooldown/mob_cooldown/borer/produce_offspring/proc/no_host_egg()
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	cortical_owner.health = max(cortical_owner.health, 1, cortical_owner.health -= OUT_OF_HOST_EGG_COST)
	produce_egg()
	var/turf/borer_turf = get_turf(cortical_owner)
	new/obj/effect/decal/cleanable/blood/splatter(borer_turf)
	playsound(borer_turf, 'sound/effects/splat.ogg', 50, TRUE)
	var/logging_text = "[key_name(cortical_owner)] gave birth alone at [loc_name(borer_turf)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	owner.balloon_alert(owner, "egg laid")

/datum/action/cooldown/mob_cooldown/borer/produce_offspring/proc/produce_egg()
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	var/turf/borer_turf = get_turf(cortical_owner)
	var/obj/effect/mob_spawn/ghost_role/borer_egg/spawned_egg = new /obj/effect/mob_spawn/ghost_role/borer_egg(borer_turf)
	spawned_egg.generation = (cortical_owner.generation + 1)
	cortical_owner.children_produced++
	if(cortical_owner.children_produced == GLOB.objective_egg_egg_number)
		GLOB.successful_egg_number += 1

//revive your host
/datum/action/cooldown/mob_cooldown/borer/revive_host
	name = "Revive Host"
	cooldown_time = 2 MINUTES
	button_icon_state = "revive"
	chemical_cost = 200
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/borer/revive_host/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	cortical_owner.chemical_storage -= chemical_cost
	if(cortical_owner.human_host.getBruteLoss())
		cortical_owner.human_host.adjustBruteLoss(-(cortical_owner.human_host.getBruteLoss()*0.5))
	if(cortical_owner.human_host.getToxLoss())
		cortical_owner.human_host.adjustToxLoss(-(cortical_owner.human_host.getToxLoss()*0.5))
	if(cortical_owner.human_host.getFireLoss())
		cortical_owner.human_host.adjustFireLoss(-(cortical_owner.human_host.getFireLoss()*0.5))
	if(cortical_owner.human_host.getOxyLoss())
		cortical_owner.human_host.adjustOxyLoss(-(cortical_owner.human_host.getOxyLoss()*0.5))
	if(cortical_owner.human_host.blood_volume < BLOOD_VOLUME_BAD)
		cortical_owner.human_host.blood_volume = BLOOD_VOLUME_BAD
	for(var/obj/item/organ/internal/internal_target in cortical_owner.human_host.organs)
		internal_target.apply_organ_damage(-internal_target.damage * 0.5)
	cortical_owner.human_host.revive()
	to_chat(cortical_owner.human_host, span_boldwarning("Your heart jumpstarts!"))
	owner.balloon_alert(owner, "host revived")
	var/turf/human_turf = get_turf(cortical_owner.human_host)
	var/logging_text = "[key_name(cortical_owner)] revived [key_name(cortical_owner.human_host)] at [loc_name(human_turf)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	cortical_owner.human_host.log_message(logging_text, LOG_GAME)
	StartCooldown()

//to ask if a host is willing
/datum/action/cooldown/mob_cooldown/borer/willing_host
	name = "Willing Host"
	cooldown_time = 2 MINUTES
	button_icon_state = "willing"
	chemical_cost = 150
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/borer/willing_host/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	for(var/ckey_check in GLOB.willing_hosts)
		if(ckey_check == cortical_owner.human_host.ckey)
			owner.balloon_alert(owner, "host already willing")
			return
	owner.balloon_alert(owner, "asking host...")
	cortical_owner.chemical_storage -= chemical_cost
	var/host_choice = tgui_input_list(cortical_owner.human_host,"Do you accept to be a willing host?", "Willing Host Request", list("Yes", "No"))
	if(host_choice != "Yes")
		owner.balloon_alert(owner, "host not willing!")
		StartCooldown()
		return
	owner.balloon_alert(owner, "host willing!")
	to_chat(cortical_owner.human_host, span_notice("You have accepted being a willing host!"))
	GLOB.willing_hosts += cortical_owner.human_host.ckey
	StartCooldown()

/datum/action/cooldown/mob_cooldown/borer/stealth_mode
	name = "Stealth Mode"
	cooldown_time = 2 MINUTES
	button_icon_state = "hiding"
	chemical_cost = 100
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/borer/stealth_mode/Trigger(trigger_flags, atom/target)
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	var/in_stealth = (cortical_owner.upgrade_flags & BORER_STEALTH_MODE)
	if(in_stealth)
		chemical_cost = 0
	else
		chemical_cost = initial(chemical_cost)
	. = ..()
	if(!.)
		return FALSE
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	owner.balloon_alert(owner, "stealth mode [in_stealth ? "disabled" : "enabled"]")
	cortical_owner.chemical_storage -= chemical_cost
	if(in_stealth)
		cortical_owner.upgrade_flags &= ~BORER_STEALTH_MODE
	else
		cortical_owner.upgrade_flags |= BORER_STEALTH_MODE


	StartCooldown()

/datum/action/cooldown/mob_cooldown/borer/empowered_offspring
	name = "Produce Empowered Offspring"
	cooldown_time = 1 MINUTES
	button_icon_state = "reproduce"
	chemical_cost = 150
	click_to_activate = FALSE

/datum/action/cooldown/mob_cooldown/borer/empowered_offspring/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/basic/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.human_host.stat != DEAD)
		owner.balloon_alert(owner, "host not dead")
		return

	cortical_owner.chemical_storage -= chemical_cost
	var/turf/borer_turf = get_turf(cortical_owner)
	var/obj/item/bodypart/chest/chest = cortical_owner.human_host.get_bodypart(BODY_ZONE_CHEST)
	if((!chest || IS_ORGANIC_LIMB(chest)) && !cortical_owner.human_host.get_organ_by_type(/obj/item/organ/internal/empowered_borer_egg))
		var/obj/item/organ/internal/empowered_borer_egg/spawned_egg = new(cortical_owner.human_host)
		spawned_egg.generation = (cortical_owner.generation + 1)

	cortical_owner.children_produced += 1
	if(cortical_owner.children_produced == GLOB.objective_egg_egg_number)
		GLOB.successful_egg_number += 1

	playsound(borer_turf, 'sound/effects/splat.ogg', 50, TRUE)
	var/logging_text = "[key_name(cortical_owner)] gave birth to an empowered borer at [loc_name(borer_turf)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	cortical_owner.balloon_alert(owner, "egg laid")
	StartCooldown()

#undef CHEMICALS_PER_UNIT
#undef CHEMICAL_SECOND_DIVISOR
#undef OUT_OF_HOST_EGG_COST
#undef BLOOD_CHEM_OBJECTIVE
