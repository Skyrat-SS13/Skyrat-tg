//inject chemicals into your host
/datum/action/cooldown/inject_chemical
	name = "Inject 5u Chemical (10 chemicals)"
	cooldown_time = 1 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "chemical"

/datum/action/cooldown/inject_chemical/Trigger(trigger_flags)
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
		return
	cortical_owner.reagent_holder.reagents.add_reagent(choice, 5, added_purity = 1)
	cortical_owner.reagent_holder.reagents.trans_to(cortical_owner.human_host, 30, methods = INGEST)
	to_chat(cortical_owner.human_host, span_warning("You feel something cool inside of you!"))
	var/turf/human_turf = get_turf(cortical_owner.human_host)
	var/datum/reagent/reagent_name = initial(choice)
	var/logging_text = "[key_name(cortical_owner)] injected [key_name(cortical_owner.human_host)] with [reagent_name] at [loc_name(human_turf)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	cortical_owner.human_host.log_message(logging_text, LOG_GAME)
	StartCooldown()

/datum/action/cooldown/choose_focus
	name = "Choose Focus (5 stat points)"
	cooldown_time = 1 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "getfocus"

/datum/action/cooldown/choose_focus/Trigger(trigger_flags)
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		to_chat(cortical_owner, span_warning("You require a host to upgrade!"))
		return
	if(cortical_owner.host_sugar())
		to_chat(owner, span_warning("Sugar inhibits your abilities to function!"))
		return
	if(cortical_owner.stat_evolution < 5)
		to_chat(owner, span_warning("You do not have 5 upgrade points for a focus!"))
		return
	cortical_owner.stat_evolution -= 5
	var/list/focus_list = list("Head focus", "Chest focus", "Arm focus", "Leg focus")
	for(var/focus in focus_list)
		switch(focus)
			if("Head focus")
				if(cortical_owner.body_focus & FOCUS_HEAD)
					focus_list -= focus
			if("Chest focus")
				if(cortical_owner.body_focus & FOCUS_CHEST)
					focus_list -= focus
			if("Arm focus")
				if(cortical_owner.body_focus & FOCUS_ARMS)
					focus_list -= focus
			if("Leg focus")
				if(cortical_owner.body_focus & FOCUS_LEGS)
					focus_list -= focus
	if(!length(focus_list))
		to_chat(owner, span_warning("You already have all focuses!"))
		cortical_owner.stat_evolution += 5
		return
	var/focus_choice = tgui_input_list(cortical_owner, "Choose your focus!", "Focus Choice", focus_list)
	if(!focus_choice)
		to_chat(owner, span_warning("You did not choose a focus."))
		cortical_owner.stat_evolution += 5
		return
	switch(focus_choice)
		if("Head focus")
			cortical_owner.body_focus |= FOCUS_HEAD
		if("Chest focus")
			cortical_owner.body_focus |= FOCUS_CHEST
		if("Arm focus")
			cortical_owner.body_focus |= FOCUS_ARMS
		if("Leg focus")
			cortical_owner.body_focus |= FOCUS_LEGS
	borer_focus_remove(cortical_owner.human_host)
	borer_focus_add(cortical_owner.human_host)
	StartCooldown()

/datum/action/cooldown/learn_bloodchemical
	name = "Learn Chemical from Blood (5 chemical points)"
	cooldown_time = 1 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "bloodchem"

/datum/action/cooldown/learn_bloodchemical/Trigger(trigger_flags)
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		to_chat(cortical_owner, span_warning("You require a host to upgrade!"))
		return
	if(cortical_owner.host_sugar())
		to_chat(owner, span_warning("Sugar inhibits your abilities to function!"))
		return
	if(cortical_owner.human_host.reagents.reagent_list.len <= 0)
		to_chat(owner, span_warning("There are no reagents inside the host!"))
		return
	if(cortical_owner.chemical_evolution < 5)
		to_chat(owner, span_warning("You do not have 5 upgrade points for a focus!"))
		return
	cortical_owner.chemical_evolution -= 5
	var/datum/reagent/reagent_choice = tgui_input_list(cortical_owner, "Choose a chemical to learn.", "Chemical Selection", cortical_owner.human_host.reagents.reagent_list)
	if(!reagent_choice)
		to_chat(owner, span_warning("No selection made!"))
		cortical_owner.chemical_evolution += 5
		return
	if(locate(reagent_choice) in cortical_owner.known_chemicals)
		to_chat(owner, span_warning("You already know this chemical!"))
		cortical_owner.chemical_evolution += 5
		return
	cortical_owner.known_chemicals += reagent_choice.type
	cortical_owner.blood_chems_learned++
	if(cortical_owner.blood_chems_learned == 5)
		GLOB.successful_blood_chem += 1
	to_chat(owner, span_notice("You have learned [initial(reagent_choice.name)]"))
	StartCooldown()

//become stronger by learning new chemicals
/datum/action/cooldown/upgrade_chemical
	name = "Learn New Chemical"
	cooldown_time = 1 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "bloodlevel"

/datum/action/cooldown/upgrade_chemical/Trigger(trigger_flags)
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		to_chat(cortical_owner, span_warning("You require a host to upgrade!"))
		return
	if(cortical_owner.host_sugar())
		to_chat(owner, span_warning("Sugar inhibits your abilities to function!"))
		return
	if(cortical_owner.chemical_evolution < 1)
		to_chat(owner, span_warning("You do not have any upgrade points for chemicals!"))
		return
	cortical_owner.chemical_evolution--
	if(!cortical_owner.potential_chemicals.len)
		to_chat(owner, span_warning("There are no more chemicals!"))
		cortical_owner.chemical_evolution++
		return
	var/datum/reagent/reagent_choice = tgui_input_list(cortical_owner, "Choose a chemical to learn.", "Chemical Selection", cortical_owner.potential_chemicals)
	if(!reagent_choice)
		to_chat(owner, span_warning("No selection made!"))
		cortical_owner.chemical_evolution++
		return
	cortical_owner.known_chemicals += reagent_choice
	cortical_owner.potential_chemicals -= reagent_choice
	to_chat(owner, span_notice("You have learned [initial(reagent_choice.name)]"))
	StartCooldown()

//become stronger by affecting the stats
/datum/action/cooldown/upgrade_stat
	name = "Become Stronger"
	cooldown_time = 0.5 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "level"

/datum/action/cooldown/upgrade_stat/Trigger(trigger_flags)
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		to_chat(cortical_owner, span_warning("You require a host to upgrade!"))
		return
	if(cortical_owner.host_sugar())
		to_chat(owner, span_warning("Sugar inhibits your abilities to function!"))
		return
	if(cortical_owner.stat_evolution < 1)
		to_chat(owner, span_warning("You do not have any upgrade points for stats!"))
		return
	cortical_owner.stat_evolution--
	cortical_owner.maxHealth += 10
	cortical_owner.health_regen += 0.02
	cortical_owner.max_chemical_storage += 20
	cortical_owner.chemical_regen++
	to_chat(cortical_owner, span_notice("You have grown!"))
	StartCooldown()

//go between either hiding behind tables or behind mobs
/datum/action/cooldown/toggle_hiding
	name = "Toggle Hiding"
	cooldown_time = 1 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "hide"

/datum/action/cooldown/toggle_hiding/Trigger(trigger_flags)
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

/datum/action/cooldown/fear_human/Trigger(trigger_flags)
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
		to_chat(cortical_owner.human_host, span_warning("Something moves inside of you violently!"))
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
		var/mob/living/carbon/human/singular_fear = pick(potential_freezers)
		to_chat(singular_fear, span_warning("Something glares menacingly at you!"))
		singular_fear.Paralyze(7 SECONDS)
		var/turf/human_turfone = get_turf(singular_fear)
		var/logging_text = "[key_name(cortical_owner)] feared/paralyzed [key_name(singular_fear)] at [loc_name(human_turfone)]"
		cortical_owner.log_message(logging_text, LOG_GAME)
		singular_fear.log_message(logging_text, LOG_GAME)
		StartCooldown()
		return
	var/mob/living/carbon/human/choose_fear = tgui_input_list(cortical_owner, "Choose who you will fear!", "Fear Choice", potential_freezers)
	if(!choose_fear)
		to_chat(cortical_owner, span_warning("No selection was made!"))
		return
	if(get_dist(choose_fear, cortical_owner) > 1)
		to_chat(cortical_owner, span_warning("The chosen is too far"))
		return
	to_chat(choose_fear, span_warning("Something glares menacingly at you!"))
	choose_fear.Paralyze(7 SECONDS)
	var/turf/human_turftwo = get_turf(choose_fear)
	var/logging_text = "[key_name(cortical_owner)] feared/paralyzed [key_name(choose_fear)] at [loc_name(human_turftwo)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	choose_fear.log_message(logging_text, LOG_GAME)
	StartCooldown()

//to check the health of the human
/datum/action/cooldown/check_blood
	name = "Check Blood"
	cooldown_time = 5 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "blood"

/datum/action/cooldown/check_blood/Trigger(trigger_flags)
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
	//shamelessly stolen from health scanner
	// the final list of strings to render
	var/render_list = list()

	// Damage specifics
	var/oxy_loss = cortical_owner.human_host.getOxyLoss()
	var/tox_loss = cortical_owner.human_host.getToxLoss()
	var/fire_loss = cortical_owner.human_host.getFireLoss()
	var/brute_loss = cortical_owner.human_host.getBruteLoss()
	var/mob_status = (cortical_owner.human_host.stat == DEAD ? span_alert("<b>Deceased</b>") : "<b>[round(cortical_owner.human_host.health/cortical_owner.human_host.maxHealth,0.01)*100]% healthy</b>")

	render_list += "[span_info("Analyzing results for [cortical_owner.human_host]:")]\n<span class='info ml-1'>Overall status: [mob_status]</span>\n"

	if(ishuman(cortical_owner.human_host))
		var/mob/living/carbon/human/humantarget = cortical_owner.human_host
		if(humantarget.undergoing_cardiac_arrest() && humantarget.stat != DEAD)
			render_list += "<span class='alert ml-1'><b>Subject suffering from heart attack: Apply defibrillation or other electric shock immediately!</b></span>\n"

	// Husk detection
	if(HAS_TRAIT_FROM(cortical_owner.human_host, TRAIT_HUSK, BURN))
		render_list += "<span class='alert ml-1'>Subject has been husked by severe burns.</span>\n"
	else if (HAS_TRAIT_FROM(cortical_owner.human_host, TRAIT_HUSK, CHANGELING_DRAIN))
		render_list += "<span class='alert ml-1'>Subject has been husked by dessication.</span>\n"
	else if(HAS_TRAIT(cortical_owner.human_host, TRAIT_HUSK))
		render_list += "<span class='alert ml-1'>Subject has been husked.</span>\n"

	if(cortical_owner.human_host.getStaminaLoss())
		render_list += "<span class='alert ml-1'>Fatigue level: [cortical_owner.human_host.getStaminaLoss()]%.</span>\n"
	if (cortical_owner.human_host.getCloneLoss())
		render_list += "<span class='alert ml-1'>Cellular damage level: [cortical_owner.human_host.getCloneLoss()].</span>\n"
	if (!cortical_owner.human_host.getorganslot(ORGAN_SLOT_BRAIN)) // kept exclusively for soul purposes
		render_list += "<span class='alert ml-1'>Subject lacks a brain.</span>\n"

	if(iscarbon(cortical_owner.human_host))
		var/mob/living/carbon/carbontarget = cortical_owner.human_host
		if(LAZYLEN(carbontarget.get_traumas()))
			var/list/trauma_text = list()
			for(var/datum/brain_trauma/trauma in carbontarget.get_traumas())
				var/trauma_desc = ""
				switch(trauma.resilience)
					if(TRAUMA_RESILIENCE_SURGERY)
						trauma_desc += "severe "
					if(TRAUMA_RESILIENCE_LOBOTOMY)
						trauma_desc += "deep-rooted "
					if(TRAUMA_RESILIENCE_WOUND)
						trauma_desc += "fracture-derived "
					if(TRAUMA_RESILIENCE_MAGIC, TRAUMA_RESILIENCE_ABSOLUTE)
						trauma_desc += "permanent "
				trauma_desc += trauma.scan_desc
				trauma_text += trauma_desc
			render_list += "<span class='alert ml-1'>Cerebral traumas detected: subject appears to be suffering from [english_list(trauma_text)].</span>\n"
		if(carbontarget.quirks.len)
			render_list += "<span class='info ml-1'>Subject Major Disabilities: [carbontarget.get_quirk_string(FALSE, CAT_QUIRK_MAJOR_DISABILITY)].</span>\n"
			render_list += "<span class='info ml-1'>Subject Minor Disabilities: [carbontarget.get_quirk_string(FALSE, CAT_QUIRK_MINOR_DISABILITY)].</span>\n"

	if (HAS_TRAIT(cortical_owner.human_host, TRAIT_IRRADIATED))
		render_list += "<span class='alert ml-1'>Subject is irradiated. Supply toxin healing.</span>\n"

	if(cortical_owner.human_host.hallucinating())
		render_list += "<span class='info ml-1'>Subject is hallucinating.</span>\n"

	//Eyes and ears
	if(iscarbon(cortical_owner.human_host))
		var/mob/living/carbon/carbontarget = cortical_owner.human_host

		// Ear status
		var/obj/item/organ/ears/ears = carbontarget.getorganslot(ORGAN_SLOT_EARS)
		if(istype(ears))
			if(HAS_TRAIT_FROM(carbontarget, TRAIT_DEAF, GENETIC_MUTATION))
				render_list = "<span class='alert ml-2'>Subject is genetically deaf.\n</span>"
			else if(HAS_TRAIT_FROM(carbontarget, TRAIT_DEAF, EAR_DAMAGE))
				render_list = "<span class='alert ml-2'>Subject is deaf from ear damage.\n</span>"
			else if(HAS_TRAIT(carbontarget, TRAIT_DEAF))
				render_list = "<span class='alert ml-2'>Subject is deaf.\n</span>"
			else
				if(ears.damage)
					render_list += "<span class='alert ml-2'>Subject has [ears.damage > ears.maxHealth ? "permanent ": "temporary "]hearing damage.\n</span>"
				if(ears.deaf)
					render_list += "<span class='alert ml-2'>Subject is [ears.damage > ears.maxHealth ? "permanently ": "temporarily "] deaf.\n</span>"

		// Eye status
		var/obj/item/organ/eyes/eyes = carbontarget.getorganslot(ORGAN_SLOT_EYES)
		if(istype(eyes))
			if(carbontarget.is_blind())
				render_list += "<span class='alert ml-2'>Subject is blind.\n</span>"
			else if(HAS_TRAIT(carbontarget, TRAIT_NEARSIGHT))
				render_list += "<span class='alert ml-2'>Subject is nearsighted.\n</span>"

	// Body part damage report
	if(iscarbon(cortical_owner.human_host))
		var/mob/living/carbon/carbontarget = cortical_owner.human_host
		var/list/damaged = carbontarget.get_damaged_bodyparts(1,1)
		if(length(damaged)>0 || oxy_loss>0 || tox_loss>0 || fire_loss>0)
			var/dmgreport = "<span class='info ml-1'>General status:</span>\
							<table class='ml-2'><tr><font face='Verdana'>\
							<td style='width:7em;'><font color='#ff0000'><b>Damage:</b></font></td>\
							<td style='width:5em;'><font color='#ff3333'><b>Brute</b></font></td>\
							<td style='width:4em;'><font color='#ff9933'><b>Burn</b></font></td>\
							<td style='width:4em;'><font color='#00cc66'><b>Toxin</b></font></td>\
							<td style='width:8em;'><font color='#00cccc'><b>Suffocation</b></font></td></tr>\
							<tr><td><font color='#ff3333'><b>Overall:</b></font></td>\
							<td><font color='#ff3333'><b>[CEILING(brute_loss,1)]</b></font></td>\
							<td><font color='#ff9933'><b>[CEILING(fire_loss,1)]</b></font></td>\
							<td><font color='#00cc66'><b>[CEILING(tox_loss,1)]</b></font></td>\
							<td><font color='#33ccff'><b>[CEILING(oxy_loss,1)]</b></font></td></tr>"

			for(var/obj/item/bodypart/limb as anything in damaged)
				dmgreport += "<tr><td><font color='#cc3333'>[capitalize(limb.name)]:</font></td>"
				dmgreport += "<td><font color='#cc3333'>[(limb.brute_dam > 0) ? "[CEILING(limb.brute_dam,1)]" : "0"]</font></td>"
				dmgreport += "<td><font color='#ff9933'>[(limb.burn_dam > 0) ? "[CEILING(limb.burn_dam,1)]" : "0"]</font></td></tr>"
			dmgreport += "</font></table>"
			render_list += dmgreport // tables do not need extra linebreak

	if(ishuman(cortical_owner.human_host))
		var/mob/living/carbon/human/humantarget = cortical_owner.human_host

		// Organ damage, missing organs
		if(humantarget.internal_organs && humantarget.internal_organs.len)
			var/render = FALSE
			var/toReport = "<span class='info ml-1'>Organs:</span>\
				<table class='ml-2'><tr>\
				<td style='width:6em;'><font color='#ff0000'><b>Organ:</b></font></td>\
				<td style='width:3em;'><font color='#ff0000'><b>Dmg</b></font></td>\
				<td style='width:12em;'><font color='#ff0000'><b>Status</b></font></td>"

			for(var/obj/item/organ/organ in humantarget.internal_organs)
				var/status = organ.get_status_text()
				if (status != "")
					render = TRUE
					toReport += "<tr><td><font color='#cc3333'>[organ.name]:</font></td>\
						<td><font color='#ff3333'>[CEILING(organ.damage,1)]</font></td>\
						<td>[status]</td></tr>"

			var/datum/species/the_dudes_species = humantarget.dna.species
			var/missing_organs = list()
			if(!humantarget.getorganslot(ORGAN_SLOT_BRAIN))
				missing_organs += "brain"
			if(!(NOBLOOD in the_dudes_species.species_traits) && !humantarget.getorganslot(ORGAN_SLOT_HEART))
				missing_organs += "heart"
			if(!(TRAIT_NOBREATH in the_dudes_species.species_traits) && !humantarget.getorganslot(ORGAN_SLOT_LUNGS))
				missing_organs += "lungs"
			if(!(TRAIT_NOMETABOLISM in the_dudes_species.species_traits) && !humantarget.getorganslot(ORGAN_SLOT_LIVER))
				missing_organs += "liver"
			if(!(NOSTOMACH in the_dudes_species.species_traits) && !humantarget.getorganslot(ORGAN_SLOT_STOMACH))
				missing_organs += "stomach"
			if(!humantarget.getorganslot(ORGAN_SLOT_EARS))
				missing_organs += "ears"
			if(!humantarget.getorganslot(ORGAN_SLOT_EYES))
				missing_organs += "eyes"

			if(length(missing_organs))
				render = TRUE
				for(var/organ in missing_organs)
					toReport += "<tr><td><font color='#cc3333'>[organ]:</font></td>\
						<td><font color='#ff3333'>["-"]</font></td>\
						<td><font color='#cc3333'>["Missing"]</font></td></tr>"

			if(render)
				render_list += toReport + "</table>" // tables do not need extra linebreak

		//Genetic stability
		if(humantarget.has_dna())
			render_list += "<span class='info ml-1'>Genetic Stability: [humantarget.dna.stability]%.</span>\n"

		// Species and body temperature
		var/datum/species/targetspecies = humantarget.dna.species
		var/mutant = humantarget.dna.check_mutation(/datum/mutation/human/hulk) \
			|| targetspecies.mutantlungs != initial(targetspecies.mutantlungs) \
			|| targetspecies.mutantbrain != initial(targetspecies.mutantbrain) \
			|| targetspecies.mutantheart != initial(targetspecies.mutantheart) \
			|| targetspecies.mutanteyes != initial(targetspecies.mutanteyes) \
			|| targetspecies.mutantears != initial(targetspecies.mutantears) \
			|| targetspecies.mutanthands != initial(targetspecies.mutanthands) \
			|| targetspecies.mutanttongue != initial(targetspecies.mutanttongue) \
			|| targetspecies.mutantliver != initial(targetspecies.mutantliver) \
			|| targetspecies.mutantstomach != initial(targetspecies.mutantstomach) \
			|| targetspecies.mutantappendix != initial(targetspecies.mutantappendix) \
			|| targetspecies.flying_species != initial(targetspecies.flying_species)

		render_list += "<span class='info ml-1'>Species: [targetspecies.name][mutant ? "-derived mutant" : ""]</span>\n"
		render_list += "<span class='info ml-1'>Core temperature: [round(humantarget.coretemperature-T0C,0.1)] &deg;C ([round(humantarget.coretemperature*1.8-459.67,0.1)] &deg;F)</span>\n"
	render_list += "<span class='info ml-1'>Body temperature: [round(cortical_owner.human_host.bodytemperature-T0C,0.1)] &deg;C ([round(cortical_owner.human_host.bodytemperature*1.8-459.67,0.1)] &deg;F)</span>\n"

	// Time of death
	if(cortical_owner.human_host.tod && (cortical_owner.human_host.stat == DEAD))
		render_list += "<span class='info ml-1'>Time of Death: [cortical_owner.human_host.tod]</span>\n"
		var/tdelta = round(world.time - cortical_owner.human_host.timeofdeath)
		render_list += "<span class='alert ml-1'><b>Subject died [DisplayTimeText(tdelta)] ago.</b></span>\n"

	// Wounds
	if(iscarbon(cortical_owner.human_host))
		var/mob/living/carbon/carbontarget = cortical_owner.human_host
		var/list/wounded_parts = carbontarget.get_wounded_bodyparts()
		for(var/i in wounded_parts)
			var/obj/item/bodypart/wounded_part = i
			render_list += "<span class='alert ml-1'><b>Physical trauma[LAZYLEN(wounded_part.wounds) > 1 ? "s" : ""] detected in [wounded_part.name]</b>"
			for(var/k in wounded_part.wounds)
				var/datum/wound/W = k
				render_list += "<div class='ml-2'>[W.name] ([W.severity_text()])\nRecommended treatment: [W.treat_text]</div>" // less lines than in woundscan() so we don't overload people trying to get basic med info
			render_list += "</span>"

	//Diseases
	for(var/thing in cortical_owner.human_host.diseases)
		var/datum/disease/D = thing
		if(!(D.visibility_flags & HIDDEN_SCANNER))
			render_list += "<span class='alert ml-1'><b>Warning: [D.form] detected</b>\n\
			<div class='ml-2'>Name: [D.name].\nType: [D.spread_text].\nStage: [D.stage]/[D.max_stages].\nPossible Cure: [D.cure_text]</div>\
			</span>" // divs do not need extra linebreak

	// Blood Level
	if(cortical_owner.human_host.has_dna())
		var/mob/living/carbon/carbontarget = cortical_owner.human_host
		var/blood_id = carbontarget.get_blood_id()
		if(blood_id)
			if(ishuman(carbontarget))
				var/mob/living/carbon/human/humantarget = carbontarget
				if(humantarget.is_bleeding())
					render_list += "<span class='alert ml-1'><b>Subject is bleeding!</b></span>\n"
			var/blood_percent = round((carbontarget.blood_volume / BLOOD_VOLUME_NORMAL)*100)
			var/blood_type = carbontarget.dna.blood_type
			if(blood_id != /datum/reagent/blood) // special blood substance
				var/datum/reagent/R = GLOB.chemical_reagents_list[blood_id]
				blood_type = R ? R.name : blood_id
			if(carbontarget.blood_volume <= BLOOD_VOLUME_SAFE && carbontarget.blood_volume > BLOOD_VOLUME_OKAY)
				render_list += "<span class='alert ml-1'>Blood level: LOW [blood_percent] %, [carbontarget.blood_volume] cl,</span> [span_info("type: [blood_type]")]\n"
			else if(carbontarget.blood_volume <= BLOOD_VOLUME_OKAY)
				render_list += "<span class='alert ml-1'>Blood level: <b>CRITICAL [blood_percent] %</b>, [carbontarget.blood_volume] cl,</span> [span_info("type: [blood_type]")]\n"
			else
				render_list += "<span class='info ml-1'>Blood level: [blood_percent] %, [carbontarget.blood_volume] cl, type: [blood_type]</span>\n"

	// Cybernetics
	if(iscarbon(cortical_owner.human_host))
		var/mob/living/carbon/carbontarget = cortical_owner.human_host
		var/cyberimp_detect
		for(var/obj/item/organ/cyberimp/CI in carbontarget.internal_organs)
			if(CI.status == ORGAN_ROBOTIC && !CI.syndicate_implant)
				cyberimp_detect += "[!cyberimp_detect ? "[CI.get_examine_string(cortical_owner)]" : ", [CI.get_examine_string(cortical_owner)]"]"
		if(cyberimp_detect)
			render_list += "<span class='notice ml-1'>Detected cybernetic modifications:</span>\n"
			render_list += "<span class='notice ml-2'>[cyberimp_detect]</span>\n"

	//shamelessly stolen from health scanner for chems
	if(istype(cortical_owner.human_host) && cortical_owner.human_host.reagents)

		// Blood reagents
		if(cortical_owner.human_host.reagents.reagent_list.len)
			render_list += "<span class='notice ml-1'>Subject contains the following reagents in their blood:</span>\n"
			for(var/r in cortical_owner.human_host.reagents.reagent_list)
				var/datum/reagent/reagent = r
				if(reagent.chemical_flags & REAGENT_INVISIBLE) //Don't show hidden chems on scanners
					continue
				render_list += "<span class='notice ml-2'>[round(reagent.volume, 0.001)] units of [reagent.name][reagent.overdosed ? "</span> - [span_boldannounce("OVERDOSING")]" : ".</span>"]\n"
		else
			render_list += "<span class='notice ml-1'>Subject contains no reagents in their blood.</span>\n"

		// Stomach reagents
		var/obj/item/organ/stomach/belly = cortical_owner.human_host.getorganslot(ORGAN_SLOT_STOMACH)
		if(belly)
			if(belly.reagents.reagent_list.len)
				render_list += "<span class='notice ml-1'>Subject contains the following reagents in their stomach:</span>\n"
				for(var/bile in belly.reagents.reagent_list)
					var/datum/reagent/bit = bile
					if(bit.chemical_flags & REAGENT_INVISIBLE) //Don't show hidden chems on scanners
						continue
					if(!belly.food_reagents[bit.type])
						render_list += "<span class='notice ml-2'>[round(bit.volume, 0.001)] units of [bit.name][bit.overdosed ? "</span> - [span_boldannounce("OVERDOSING")]" : ".</span>"]\n"
					else
						var/bit_vol = bit.volume - belly.food_reagents[bit.type]
						if(bit_vol > 0)
							render_list += "<span class='notice ml-2'>[round(bit_vol, 0.001)] units of [bit.name][bit.overdosed ? "</span> - [span_boldannounce("OVERDOSING")]" : ".</span>"]\n"
			else
				render_list += "<span class='notice ml-1'>Subject contains no reagents in their stomach.</span>\n"

		// Addictions
		if(LAZYLEN(cortical_owner.human_host.mind?.active_addictions))
			render_list += "<span class='boldannounce ml-1'>Subject is addicted to the following types of drug:</span>\n"
			for(var/datum/addiction/addiction_type as anything in cortical_owner.human_host.mind.active_addictions)
				render_list += "<span class='alert ml-2'>[initial(addiction_type.name)]</span>\n"

		// Special eigenstasium addiction
		if(cortical_owner.human_host.has_status_effect(/datum/status_effect/eigenstasium))
			render_list += "<span class='notice ml-1'>Subject is temporally unstable. Stabilising agent is recommended to reduce disturbances.</span>\n"

		// Allergies
		for(var/datum/quirk/quirky as anything in cortical_owner.human_host.quirks)
			if(istype(quirky, /datum/quirk/item_quirk/allergic))
				var/datum/quirk/item_quirk/allergic/allergies_quirk = quirky
				var/allergies = allergies_quirk.allergy_string
				render_list += "<span class='alert ml-1'>Subject is extremely allergic to the following chemicals:</span>\n"
				render_list += "<span class='alert ml-2'>[allergies]</span>\n"

		// we handled the last <br> so we don't need handholding
		to_chat(cortical_owner, examine_block(jointext(render_list, "")), trailing_newline = FALSE, type = MESSAGE_TYPE_INFO)
	StartCooldown()

//to either get inside, or out, of a host
/datum/action/cooldown/choosing_host
	name = "Inhabit/Uninhabit Host"
	cooldown_time = 10 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "host"

/datum/action/cooldown/choosing_host/Trigger(trigger_flags)
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner

	//having a host means we need to leave them then
	if(cortical_owner.human_host)
		if(cortical_owner.host_sugar())
			to_chat(owner, span_warning("Sugar inhibits your abilities to function!"))
			return
		to_chat(cortical_owner, span_notice("You forcefully detach from the host."))
		to_chat(cortical_owner.human_host, span_notice("Something carefully tickles your inner ear..."))
		var/obj/item/organ/borer_body/borer_organ = locate() in cortical_owner.human_host.internal_organs
		//log the interaction
		var/turf/human_turfone = get_turf(cortical_owner.human_host)
		var/logging_text = "[key_name(cortical_owner)] left [key_name(cortical_owner.human_host)] at [loc_name(human_turfone)]"
		cortical_owner.log_message(logging_text, LOG_GAME)
		cortical_owner.human_host.log_message(logging_text, LOG_GAME)
		if(borer_organ)
			borer_organ.Remove(cortical_owner.human_host)
		cortical_owner.human_host = null
		StartCooldown()
		return

	//we dont have a host so lets inhabit one
	var/list/usable_hosts = list()
	for(var/mob/living/carbon/human/listed_human in range(1, cortical_owner))
		// no non-human hosts
		if(!ishuman(listed_human))
			continue
		// cannot have multiple borers (for now)
		if(listed_human.has_borer())
			continue
		// hosts need to be organic
		if(!(listed_human.dna.species.inherent_biotypes & MOB_ORGANIC) && cortical_owner.organic_restricted)
			continue
		// hosts need to be organic
		if(!(listed_human.mob_biotypes & MOB_ORGANIC) && cortical_owner.organic_restricted)
			continue
		//hosts cannot be changelings
		if(listed_human.mind)
			var/datum/antagonist/changeling/changeling = listed_human.mind.has_antag_datum(/datum/antagonist/changeling)
			if(changeling && cortical_owner.changeling_restricted)
				continue
		usable_hosts += listed_human

	//if the list of possible hosts is one, just go straight in, no choosing
	if(length(usable_hosts) == 1)
		var/mob/living/carbon/human/singular_host = pick(usable_hosts)
		if(singular_host.has_borer())
			to_chat(cortical_owner, span_warning("You cannot occupy a body already occupied!"))
			return
		if(!do_after(cortical_owner, 5 SECONDS, target = singular_host))
			to_chat(cortical_owner, span_warning("You and the host must be still."))
			return
		if(get_dist(singular_host, cortical_owner) > 1)
			to_chat(cortical_owner, span_warning("The host is too far away."))
			return
		cortical_owner.human_host = singular_host
		cortical_owner.forceMove(cortical_owner.human_host)
		to_chat(cortical_owner.human_host, span_notice("A chilling sensation goes down your spine..."))
		cortical_owner.copy_languages(cortical_owner.human_host)
		var/obj/item/organ/borer_body/borer_organ = new(cortical_owner.human_host)
		borer_organ.Insert(cortical_owner.human_host)
		var/turf/human_turftwo = get_turf(cortical_owner.human_host)
		var/logging_text = "[key_name(cortical_owner)] went into [key_name(cortical_owner.human_host)] at [loc_name(human_turftwo)]"
		cortical_owner.log_message(logging_text, LOG_GAME)
		cortical_owner.human_host.log_message(logging_text, LOG_GAME)
		StartCooldown()
		return

	//if the list of possible host is more than one, allow choosing a host
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
	to_chat(cortical_owner.human_host, span_notice("A chilling sensation goes down your spine..."))
	cortical_owner.copy_languages(cortical_owner.human_host)
	var/obj/item/organ/borer_body/borer_organ = new(cortical_owner.human_host)
	borer_organ.Insert(cortical_owner.human_host)
	var/turf/human_turfthree = get_turf(cortical_owner.human_host)
	var/logging_text = "[key_name(cortical_owner)] went into [key_name(cortical_owner.human_host)] at [loc_name(human_turfthree)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	cortical_owner.human_host.log_message(logging_text, LOG_GAME)
	StartCooldown()

//you can force your host to speak... dont abuse this
/datum/action/cooldown/force_speak
	name = "Force Host Speak"
	cooldown_time = 30 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "speak"

/datum/action/cooldown/force_speak/Trigger(trigger_flags)
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
	if(!cortical_owner.inside_human())
		to_chat(cortical_owner, span_warning("You must be inside a human in order to do this!"))
		return
	var/borer_message = input(cortical_owner, "What would you like to force your host to say?", "Force Speak") as message|null
	if(!borer_message)
		to_chat(cortical_owner, span_warning("No message given!"))
		return
	borer_message = sanitize(borer_message)
	var/mob/living/carbon/human/cortical_host = cortical_owner.human_host
	to_chat(cortical_host, span_boldwarning("Your voice moves without your permission!"))
	cortical_host.say(message = borer_message, forced = TRUE)
	var/turf/human_turf = get_turf(cortical_owner.human_host)
	var/logging_text = "[key_name(cortical_owner)] forced [key_name(cortical_owner.human_host)] to say [borer_message] at [loc_name(human_turf)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	cortical_owner.human_host.log_message(logging_text, LOG_GAME)
	StartCooldown()

//we need a way to produce offspring
/datum/action/cooldown/produce_offspring
	name = "Produce Offspring (100 chemicals)"
	cooldown_time = 1 MINUTES
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "reproduce"

/datum/action/cooldown/produce_offspring/Trigger(trigger_flags)
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		to_chat(cortical_owner, span_warning("You need a host to reproduce!"))
		return
	if(cortical_owner.chemical_storage < 100)
		to_chat(cortical_owner, span_warning("You require at least 100 chemical units before you can reproduce!"))
		return
	cortical_owner.chemical_storage -= 100
	var/turf/borer_turf = get_turf(cortical_owner)
	var/obj/effect/mob_spawn/ghost_role/borer_egg/spawned_egg = new /obj/effect/mob_spawn/ghost_role/borer_egg(borer_turf)
	spawned_egg.generation = (cortical_owner.generation + 1)
	cortical_owner.children_produced++
	if(cortical_owner.children_produced == GLOB.objective_egg_egg_number)
		GLOB.successful_egg_number += 1
	if(prob(25))
		cortical_owner.human_host.gain_trauma_type(BRAIN_TRAUMA_MILD, TRAUMA_RESILIENCE_BASIC)
		to_chat(cortical_owner.human_host, span_warning("Your brain begins to hurt..."))
	new /obj/effect/decal/cleanable/vomit(borer_turf)
	playsound(borer_turf, 'sound/effects/splat.ogg', 50, TRUE)
	var/logging_text = "[key_name(cortical_owner)] gave birth at [loc_name(borer_turf)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	StartCooldown()

//revive your host
/datum/action/cooldown/revive_host
	name = "Revive Host (200 chemicals)"
	cooldown_time = 2 MINUTES
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "revive"

/datum/action/cooldown/revive_host/Trigger(trigger_flags)
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
	if(!cortical_owner.inside_human())
		to_chat(cortical_owner, span_warning("You must be inside a human in order to do this!"))
		return
	if(cortical_owner.chemical_storage < 200)
		to_chat(cortical_owner, span_warning("You require at least 200 chemical units before you can revive your host!"))
		return
	cortical_owner.chemical_storage -= 200
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
	cortical_owner.human_host.revive()
	to_chat(cortical_owner.human_host, span_boldwarning("Your heart jumpstarts!"))
	var/turf/human_turf = get_turf(cortical_owner.human_host)
	var/logging_text = "[key_name(cortical_owner)] revived [key_name(cortical_owner.human_host)] at [loc_name(human_turf)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	cortical_owner.human_host.log_message(logging_text, LOG_GAME)
	StartCooldown()

//certain abilities are now locked, you have to learn them
/datum/action/cooldown/learn_ability
	name = "Learn Ability (2 stat points)"
	cooldown_time = 1 SECONDS
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "newability"

/datum/action/cooldown/learn_ability/Trigger(trigger_flags)
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		to_chat(cortical_owner, span_warning("You require a host to use this action!"))
		return
	if(cortical_owner.host_sugar())
		to_chat(owner, span_warning("Sugar inhibits your abilities to function!"))
		return
	if(cortical_owner.stat_evolution < 2)
		to_chat(owner, span_warning("You do not have 2 stat points for an ability!"))
		return
	cortical_owner.stat_evolution -= 2
	var/list/abil_list = list("Produce Offspring", "Learn Chemical from Blood", "Revive Host", "Willing Host")
	for(var/ability in abil_list)
		switch(ability)
			if("Produce Offspring")
				if(locate(/datum/action/cooldown/produce_offspring) in cortical_owner.known_abilities)
					abil_list.Remove("Produce Offspring")
			if("Learn Chemical from Blood")
				if(locate(/datum/action/cooldown/learn_bloodchemical) in cortical_owner.known_abilities)
					abil_list.Remove("Learn Chemical from Blood")
			if("Revive Host")
				if(locate(/datum/action/cooldown/revive_host) in cortical_owner.known_abilities)
					abil_list.Remove("Revive Host")
			if("Willing Host")
				if(locate(/datum/action/cooldown/willing_host) in cortical_owner.known_abilities)
					abil_list.Remove("Willing Host")
	if(!length(abil_list))
		to_chat(owner, span_warning("You already have all abilities!"))
		cortical_owner.stat_evolution += 2
		return
	var/ability_choice = tgui_input_list(cortical_owner, "Choose your ability!", "Ability Choice", abil_list)
	if(!ability_choice)
		to_chat(owner, span_warning("You did not choose an ability."))
		cortical_owner.stat_evolution += 2
		return
	switch(ability_choice)
		if("Produce Offspring")
			var/datum/action/attack_action = new /datum/action/cooldown/produce_offspring()
			attack_action.Grant(cortical_owner)
			cortical_owner.known_abilities += /datum/action/cooldown/produce_offspring
			return
		if("Learn Chemical from Blood")
			var/datum/action/attack_action = new /datum/action/cooldown/learn_bloodchemical()
			attack_action.Grant(cortical_owner)
			cortical_owner.known_abilities += /datum/action/cooldown/learn_bloodchemical
			return
		if("Revive Host")
			var/datum/action/attack_action = new /datum/action/cooldown/revive_host()
			attack_action.Grant(cortical_owner)
			cortical_owner.known_abilities += /datum/action/cooldown/revive_host
			return
		if("Willing Host")
			var/datum/action/attack_action = new /datum/action/cooldown/willing_host()
			attack_action.Grant(cortical_owner)
			cortical_owner.known_abilities += /datum/action/cooldown/willing_host
			return
	StartCooldown()

//to ask if a host is willing
/datum/action/cooldown/willing_host
	name = "Willing Host (300 chemicals)"
	cooldown_time = 2 MINUTES
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	button_icon_state = "willing"

/datum/action/cooldown/willing_host/Trigger(trigger_flags)
	if(!IsAvailable())
		to_chat(owner, span_warning("This action is still on cooldown!"))
		return
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		to_chat(cortical_owner, span_warning("You require a host to upgrade!"))
		return
	if(cortical_owner.host_sugar())
		to_chat(owner, span_warning("Sugar inhibits your abilities to function!"))
		return
	if(cortical_owner.chemical_storage < 300)
		to_chat(cortical_owner, span_warning("You require at least 300 chemical units before you can ask your host!"))
		return
	cortical_owner.chemical_storage -= 300
	for(var/ckey_check in GLOB.willing_hosts)
		if(ckey_check == cortical_owner.human_host.ckey)
			to_chat(cortical_owner, span_warning("This host is already willing, try another host!"))
			return
	to_chat(cortical_owner, span_notice("The host is being asked..."))
	var/host_choice = tgui_input_list(cortical_owner.human_host,"Do you accept to be a willing host?", "Willing Host Request", list("Yes", "No"))
	if(host_choice != "Yes")
		to_chat(cortical_owner, span_warning("The host was not willing!"))
		StartCooldown()
		return
	to_chat(cortical_owner, span_notice("The host was willing!"))
	to_chat(cortical_owner.human_host, span_notice("You have accepted being a willing host!"))
	GLOB.willing_hosts += cortical_owner.human_host.ckey
	StartCooldown()
