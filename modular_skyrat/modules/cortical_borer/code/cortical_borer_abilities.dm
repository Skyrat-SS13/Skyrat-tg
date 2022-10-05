#define CHEMICALS_PER_UNIT 2
#define CHEMICAL_SECOND_DIVISOR 5 SECONDS

// Parent of all borer actions
/datum/action/cooldown/borer
	icon_icon = 'modular_skyrat/modules/cortical_borer/icons/actions.dmi'
	cooldown_time = 1 SECONDS

/datum/action/cooldown/borer/Trigger(trigger_flags, atom/target)
	. = ..()
	if(!iscorticalborer(owner))
		to_chat(owner, span_warning("You must be a cortical borer to use this action!"))
		return FALSE
	if(owner.stat == DEAD)
		return FALSE

	return . == FALSE ? FALSE : TRUE //. can be null, true, or false. There's a difference between null and false here

//inject chemicals into your host
/datum/action/cooldown/borer/inject_chemical
	name = "Open Chemical Injector"
	button_icon_state = "chemical"

/datum/action/cooldown/borer/inject_chemical/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.human_host)
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	ui_interact(owner)

/datum/action/cooldown/borer/inject_chemical/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "BorerChem", name)
		ui.open()

/datum/action/cooldown/borer/inject_chemical/ui_data(mob/user)
	var/data = list()
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
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

/datum/action/cooldown/borer/inject_chemical/ui_act(action, params)
	. = ..()
	if(.)
		return
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	switch(action)
		if("amount")
			var/target = text2num(params["target"])
			if(target in cortical_owner.injection_rates)
				cortical_owner.injection_rate_current = target
				. = TRUE
		if("inject")
			if(!iscorticalborer(usr) || !COOLDOWN_FINISHED(cortical_owner, injection_cooldown))
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

/datum/action/cooldown/borer/inject_chemical/ui_state(mob/user)
	return GLOB.always_state

/datum/action/cooldown/borer/inject_chemical/ui_status(mob/user, datum/ui_state/state)
	if(!iscorticalborer(user))
		return UI_CLOSE
	var/mob/living/simple_animal/cortical_borer/borer = user
	if(!borer.human_host)
		return UI_CLOSE
	return ..()

/datum/action/cooldown/borer/learn_focus
	name = "Learn Focus"
	button_icon_state = "getfocus"

/datum/action/cooldown/borer/learn_focus/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
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

/datum/action/cooldown/borer/learn_bloodchemical
	name = "Learn Chemical from Blood (5 chemical points)"
	button_icon_state = "bloodchem"

/datum/action/cooldown/borer/learn_bloodchemical/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(length(cortical_owner.human_host.reagents.reagent_list) <= 0)
		owner.balloon_alert(owner, "no reagents in host")
		return
	if(cortical_owner.chemical_evolution < 5)
		owner.balloon_alert(owner, "5 chemical points required")
		return
	cortical_owner.chemical_evolution -= 5
	var/datum/reagent/reagent_choice = tgui_input_list(cortical_owner, "Choose a chemical to learn.", "Chemical Selection", cortical_owner.human_host.reagents.reagent_list)
	if(!reagent_choice)
		owner.balloon_alert(owner, "chemical not chosen")
		cortical_owner.chemical_evolution += 5
		return
	if(locate(reagent_choice) in cortical_owner.known_chemicals)
		owner.balloon_alert(owner, "chemical already known")
		cortical_owner.chemical_evolution += 5
		return
	if(locate(reagent_choice) in cortical_owner.blacklisted_chemicals)
		to_chat(owner, span_warning("Your physiology is incompatible with this chemical - your host must find it elsewhere!"))
		cortical_owner.chemical_evolution += 5
		return
	if(!(reagent_choice.chemical_flags & REAGENT_CAN_BE_SYNTHESIZED))
		owner.balloon_alert(owner, "cannot learn [initial(reagent_choice.name)]")
		cortical_owner.chemical_evolution += 5
		return
	cortical_owner.known_chemicals += reagent_choice.type
	cortical_owner.blood_chems_learned++
	var/obj/item/organ/internal/brain/victim_brain = cortical_owner.human_host.getorganslot(ORGAN_SLOT_BRAIN)
	if(victim_brain)
		cortical_owner.human_host.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5)
	if(cortical_owner.blood_chems_learned == 5)
		GLOB.successful_blood_chem += 1
	owner.balloon_alert(owner, "[initial(reagent_choice.name)] learned")
	to_chat(cortical_owner.human_host, span_notice("You get a strange aftertaste of [initial(reagent_choice.taste_description)]!"))
	StartCooldown()

//become stronger by learning new chemicals
/datum/action/cooldown/borer/upgrade_chemical
	name = "Learn New Chemical"
	button_icon_state = "bloodlevel"

/datum/action/cooldown/borer/upgrade_chemical/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(cortical_owner.chemical_evolution < 1)
		owner.balloon_alert(owner, "1 chemical evolution point required")
		return
	cortical_owner.chemical_evolution--
	if(!length(cortical_owner.potential_chemicals))
		owner.balloon_alert(owner, "all chemicals learned")
		cortical_owner.chemical_evolution++
		return
	var/datum/reagent/reagent_choice = tgui_input_list(cortical_owner, "Choose a chemical to learn.", "Chemical Selection", cortical_owner.potential_chemicals)
	if(!reagent_choice)
		owner.balloon_alert(owner, "no chemical chosen")
		cortical_owner.chemical_evolution++
		return
	cortical_owner.known_chemicals += reagent_choice
	cortical_owner.potential_chemicals -= reagent_choice
	var/obj/item/organ/internal/brain/victim_brain = cortical_owner.human_host.getorganslot(ORGAN_SLOT_BRAIN)
	if(victim_brain)
		cortical_owner.human_host.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5)
	owner.balloon_alert(owner, "[initial(reagent_choice.name)] learned")
	to_chat(cortical_owner.human_host, span_notice("You get a strange aftertaste of [initial(reagent_choice.taste_description)]!"))
	StartCooldown()

//become stronger by affecting the stats
/datum/action/cooldown/borer/upgrade_stat
	name = "Become Stronger"
	button_icon_state = "level"

/datum/action/cooldown/borer/upgrade_stat/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(cortical_owner.stat_evolution < 1)
		owner.balloon_alert(owner, "1 stat evolution point required")
		return
	cortical_owner.stat_evolution--
	cortical_owner.maxHealth += 5
	cortical_owner.health_regen += 0.02
	cortical_owner.max_chemical_storage += 20
	cortical_owner.chemical_regen++
	var/obj/item/organ/internal/brain/victim_brain = cortical_owner.human_host.getorganslot(ORGAN_SLOT_BRAIN)
	if(victim_brain)
		cortical_owner.human_host.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
	cortical_owner.human_host.adjust_blurriness(3) //about 12 seconds' worth
	to_chat(cortical_owner, span_notice("You have grown!"))
	to_chat(cortical_owner.human_host, span_warning("You feel a sharp pressure in your head!"))
	StartCooldown()

//go between either hiding behind tables or behind mobs
/datum/action/cooldown/borer/toggle_hiding
	name = "Toggle Hiding"
	button_icon_state = "hide"

/datum/action/cooldown/borer/toggle_hiding/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	if(owner.layer == PROJECTILE_HIT_THRESHHOLD_LAYER)
		owner.balloon_alert(owner, "stopped hiding")
		owner.layer = BELOW_MOB_LAYER
		StartCooldown()
		return
	owner.balloon_alert(owner, "started hiding")
	owner.layer = PROJECTILE_HIT_THRESHHOLD_LAYER
	StartCooldown()

//to paralyze people
/datum/action/cooldown/borer/fear_human
	name = "Incite Fear"
	cooldown_time = 12 SECONDS
	button_icon_state = "fear"

/datum/action/cooldown/borer/fear_human/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(cortical_owner.human_host)
		owner.balloon_alert(owner, "fear incited into host")
		cortical_owner.human_host.Paralyze(10 SECONDS)
		cortical_owner.human_host.adjustStaminaLoss(100)
		cortical_owner.human_host.set_confusion_if_lower(15 SECONDS)
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
		singular_fear.adjustStaminaLoss(50)
		singular_fear.set_confusion_if_lower(9 SECONDS)
		var/turf/human_turfone = get_turf(singular_fear)
		var/logging_text = "[key_name(cortical_owner)] feared/paralyzed [key_name(singular_fear)] at [loc_name(human_turfone)]"
		cortical_owner.log_message(logging_text, LOG_GAME)
		singular_fear.log_message(logging_text, LOG_GAME)
		StartCooldown()
		return
	var/mob/living/carbon/human/choose_fear = tgui_input_list(cortical_owner, "Choose who you will fear!", "Fear Choice", potential_freezers)
	if(!choose_fear)
		owner.balloon_alert(owner, "no target chosen")
		return
	if(get_dist(choose_fear, cortical_owner) > 1)
		owner.balloon_alert(owner, "chosen target too far")
		return
	to_chat(choose_fear, span_warning("Something glares menacingly at you!"))
	owner.balloon_alert(owner, "fear incited into target")
	choose_fear.Paralyze(7 SECONDS)
	choose_fear.adjustStaminaLoss(50)
	choose_fear.set_confusion_if_lower(9 SECONDS)
	var/turf/human_turftwo = get_turf(choose_fear)
	var/logging_text = "[key_name(cortical_owner)] feared/paralyzed [key_name(choose_fear)] at [loc_name(human_turftwo)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	choose_fear.log_message(logging_text, LOG_GAME)
	StartCooldown()

//to check the health of the human
/datum/action/cooldown/borer/check_blood
	name = "Check Blood"
	cooldown_time = 5 SECONDS
	button_icon_state = "blood"

/datum/action/cooldown/borer/check_blood/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(!cortical_owner.human_host)
		owner.balloon_alert(owner, "host required")
		return
	cortical_owner.human_host.bleed(3)
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

	if(cortical_owner.human_host.has_status_effect(/datum/status_effect/hallucination))
		render_list += "<span class='info ml-1'>Subject is hallucinating.</span>\n"

	//Eyes and ears
	if(iscarbon(cortical_owner.human_host))
		var/mob/living/carbon/carbontarget = cortical_owner.human_host

		// Ear status
		var/obj/item/organ/internal/ears/ears = carbontarget.getorganslot(ORGAN_SLOT_EARS)
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
		var/obj/item/organ/internal/eyes/eyes = carbontarget.getorganslot(ORGAN_SLOT_EYES)
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
		for(var/obj/item/organ/internal/cyberimp/CI in carbontarget.internal_organs)
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
		var/obj/item/organ/internal/stomach/belly = cortical_owner.human_host.getorganslot(ORGAN_SLOT_STOMACH)
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
/datum/action/cooldown/borer/choosing_host
	name = "Inhabit/Uninhabit Host"
	cooldown_time = 10 SECONDS
	button_icon_state = "host"

/datum/action/cooldown/borer/choosing_host/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner

	//having a host means we need to leave them then
	if(cortical_owner.human_host)
		if(cortical_owner.host_sugar())
			owner.balloon_alert(owner, "cannot function with sugar in host")
			return
		owner.balloon_alert(owner, "detached from host")
		to_chat(cortical_owner.human_host, span_notice("Something carefully tickles your inner ear..."))
		var/obj/item/organ/internal/borer_body/borer_organ = locate() in cortical_owner.human_host.internal_organs
		//log the interaction
		var/turf/human_turfone = get_turf(cortical_owner.human_host)
		var/logging_text = "[key_name(cortical_owner)] left [key_name(cortical_owner.human_host)] at [loc_name(human_turfone)]"
		cortical_owner.log_message(logging_text, LOG_GAME)
		cortical_owner.human_host.log_message(logging_text, LOG_GAME)
		if(borer_organ)
			borer_organ.Remove(cortical_owner.human_host)
		cortical_owner.forceMove(human_turfone)
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
			owner.balloon_alert(owner, "target already occupied")
			return
		if(!do_after(cortical_owner, 6 SECONDS, target = singular_host))
			owner.balloon_alert(owner, "you and target must be still")
			return
		if(get_dist(singular_host, cortical_owner) > 1)
			owner.balloon_alert(owner, "target too far away")
			return
		cortical_owner.human_host = singular_host
		cortical_owner.forceMove(cortical_owner.human_host)
		to_chat(cortical_owner.human_host, span_notice("A chilling sensation goes down your spine..."))
		cortical_owner.copy_languages(cortical_owner.human_host)
		var/obj/item/organ/internal/borer_body/borer_organ = new(cortical_owner.human_host)
		borer_organ.borer = owner
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
		owner.balloon_alert(owner, "no target selected")
		return
	var/mob/living/carbon/human/choosen_human = choose_host
	if(choosen_human.has_borer())
		owner.balloon_alert(owner, "target already occupied")
		return
	if(!do_after(cortical_owner, 6 SECONDS, target = choose_host))
		owner.balloon_alert(owner, "you and target must be still")
		return
	if(get_dist(choose_host, cortical_owner) > 1)
		owner.balloon_alert(owner, "target too far away")
		return
	cortical_owner.human_host = choose_host
	cortical_owner.forceMove(cortical_owner.human_host)
	to_chat(cortical_owner.human_host, span_notice("A chilling sensation goes down your spine..."))
	cortical_owner.copy_languages(cortical_owner.human_host)
	var/obj/item/organ/internal/borer_body/borer_organ = new(cortical_owner.human_host)
	borer_organ.borer = owner
	borer_organ.Insert(cortical_owner.human_host)
	var/turf/human_turfthree = get_turf(cortical_owner.human_host)
	var/logging_text = "[key_name(cortical_owner)] went into [key_name(cortical_owner.human_host)] at [loc_name(human_turfthree)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	cortical_owner.human_host.log_message(logging_text, LOG_GAME)
	owner.balloon_alert(owner, "entered host")
	StartCooldown()

//you can force your host to speak... dont abuse this
/datum/action/cooldown/borer/force_speak
	name = "Force Host Speak"
	cooldown_time = 30 SECONDS
	button_icon_state = "speak"

/datum/action/cooldown/borer/force_speak/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
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
	var/obj/item/organ/internal/brain/victim_brain = cortical_owner.human_host.getorganslot(ORGAN_SLOT_BRAIN)
	if(victim_brain)
		cortical_owner.human_host.adjustOrganLoss(ORGAN_SLOT_BRAIN, 2)
	cortical_host.say(message = borer_message, forced = TRUE)
	var/turf/human_turf = get_turf(cortical_owner.human_host)
	var/logging_text = "[key_name(cortical_owner)] forced [key_name(cortical_owner.human_host)] to say [borer_message] at [loc_name(human_turf)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	cortical_owner.human_host.log_message(logging_text, LOG_GAME)
	StartCooldown()

//we need a way to produce offspring
/datum/action/cooldown/borer/produce_offspring
	name = "Produce Offspring (100 chemicals)"
	cooldown_time = 1 MINUTES
	button_icon_state = "reproduce"

/datum/action/cooldown/borer/produce_offspring/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.chemical_storage < 100)
		owner.balloon_alert(owner, "100 chemical points required")
		return
	cortical_owner.chemical_storage -= 100
	var/turf/borer_turf = get_turf(cortical_owner)
	var/obj/effect/mob_spawn/ghost_role/borer_egg/spawned_egg = new /obj/effect/mob_spawn/ghost_role/borer_egg(borer_turf)
	spawned_egg.generation = (cortical_owner.generation + 1)
	cortical_owner.children_produced++
	if(cortical_owner.children_produced == GLOB.objective_egg_egg_number)
		GLOB.successful_egg_number += 1
	var/obj/item/organ/internal/brain/victim_brain = cortical_owner.human_host.getorganslot(ORGAN_SLOT_BRAIN)
	if(victim_brain)
		cortical_owner.human_host.adjustOrganLoss(ORGAN_SLOT_BRAIN, 25)
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
	new /obj/effect/decal/cleanable/vomit(borer_turf)
	playsound(borer_turf, 'sound/effects/splat.ogg', 50, TRUE)
	var/logging_text = "[key_name(cortical_owner)] gave birth at [loc_name(borer_turf)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	owner.balloon_alert(owner, "egg laid")
	StartCooldown()

//revive your host
/datum/action/cooldown/borer/revive_host
	name = "Revive Host (200 chemicals)"
	cooldown_time = 2 MINUTES
	button_icon_state = "revive"

/datum/action/cooldown/borer/revive_host/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.chemical_storage < 200)
		owner.balloon_alert(owner, "200 chemical points required")
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
	for(var/obj/item/organ/internal/internal_target in cortical_owner.human_host.internal_organs)
		internal_target.applyOrganDamage(-internal_target.damage * 0.5)
	cortical_owner.human_host.revive()
	to_chat(cortical_owner.human_host, span_boldwarning("Your heart jumpstarts!"))
	owner.balloon_alert(owner, "host revived")
	var/turf/human_turf = get_turf(cortical_owner.human_host)
	var/logging_text = "[key_name(cortical_owner)] revived [key_name(cortical_owner.human_host)] at [loc_name(human_turf)]"
	cortical_owner.log_message(logging_text, LOG_GAME)
	cortical_owner.human_host.log_message(logging_text, LOG_GAME)
	StartCooldown()

//certain abilities are now locked, you have to learn them
/datum/action/cooldown/borer/learn_ability
	name = "Learn Ability (2 stat points)"
	button_icon_state = "newability"

/datum/action/cooldown/borer/learn_ability/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(cortical_owner.stat_evolution < 2)
		owner.balloon_alert(owner, "2 stat points required")
		return
	cortical_owner.stat_evolution -= 2
	var/list/abil_list = list("Produce Offspring", "Learn Chemical from Blood", "Revive Host", "Willing Host", "Upgrade Injection")
	for(var/ability in abil_list)
		switch(ability)
			if("Produce Offspring")
				if(locate(/datum/action/cooldown/borer/produce_offspring) in cortical_owner.known_abilities)
					abil_list.Remove("Produce Offspring")
			if("Learn Chemical from Blood")
				if(locate(/datum/action/cooldown/borer/learn_bloodchemical) in cortical_owner.known_abilities)
					abil_list.Remove("Learn Chemical from Blood")
			if("Revive Host")
				if(locate(/datum/action/cooldown/borer/revive_host) in cortical_owner.known_abilities)
					abil_list.Remove("Revive Host")
			if("Willing Host")
				if(locate(/datum/action/cooldown/borer/willing_host) in cortical_owner.known_abilities)
					abil_list.Remove("Willing Host")
			if("Upgrade Injection")
				if(length(cortical_owner.injection_rates_unlocked) >= length(cortical_owner.injection_rates))
					abil_list.Remove("Upgrade Injection")
	if(!length(abil_list))
		owner.balloon_alert(owner, "all abilites learned")
		cortical_owner.stat_evolution += 2
		return
	var/ability_choice = tgui_input_list(cortical_owner, "Choose your ability!", "Ability Choice", abil_list)
	if(!ability_choice)
		owner.balloon_alert(owner, "ability not selected")
		cortical_owner.stat_evolution += 2
		return
	owner.balloon_alert(owner, "ability learned")
	switch(ability_choice)
		if("Produce Offspring")
			var/datum/action/attack_action = new /datum/action/cooldown/borer/produce_offspring()
			attack_action.Grant(cortical_owner)
			cortical_owner.known_abilities += /datum/action/cooldown/borer/produce_offspring
			return
		if("Learn Chemical from Blood")
			var/datum/action/attack_action = new /datum/action/cooldown/borer/learn_bloodchemical()
			attack_action.Grant(cortical_owner)
			cortical_owner.known_abilities += /datum/action/cooldown/borer/learn_bloodchemical
			return
		if("Revive Host")
			var/datum/action/attack_action = new /datum/action/cooldown/borer/revive_host()
			attack_action.Grant(cortical_owner)
			cortical_owner.known_abilities += /datum/action/cooldown/borer/revive_host
			return
		if("Willing Host")
			var/datum/action/attack_action = new /datum/action/cooldown/borer/willing_host()
			attack_action.Grant(cortical_owner)
			cortical_owner.known_abilities += /datum/action/cooldown/borer/willing_host
			return
		if("Upgrade Injection")
			if(length(cortical_owner.injection_rates_unlocked) >= length(cortical_owner.injection_rates)) // Extra insurance
				owner.balloon_alert(owner, "injection already maximized")
				return
			cortical_owner.injection_rates_unlocked += cortical_owner.injection_rates[length(cortical_owner.injection_rates_unlocked) + 1]
	StartCooldown()

//to ask if a host is willing
/datum/action/cooldown/borer/willing_host
	name = "Willing Host (150 chemicals)"
	cooldown_time = 2 MINUTES
	button_icon_state = "willing"

/datum/action/cooldown/borer/willing_host/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/simple_animal/cortical_borer/cortical_owner = owner
	if(!cortical_owner.inside_human())
		owner.balloon_alert(owner, "host required")
		return
	if(cortical_owner.host_sugar())
		owner.balloon_alert(owner, "cannot function with sugar in host")
		return
	if(cortical_owner.chemical_storage < 150)
		owner.balloon_alert(owner, "150 chemical points required")
		return
	for(var/ckey_check in GLOB.willing_hosts)
		if(ckey_check == cortical_owner.human_host.ckey)
			owner.balloon_alert(owner, "host already willing")
			return
	owner.balloon_alert(owner, "asking host...")
	cortical_owner.chemical_storage -= 150
	var/host_choice = tgui_input_list(cortical_owner.human_host,"Do you accept to be a willing host?", "Willing Host Request", list("Yes", "No"))
	if(host_choice != "Yes")
		owner.balloon_alert(owner, "host not willing!")
		StartCooldown()
		return
	owner.balloon_alert(owner, "host willing!")
	to_chat(cortical_owner.human_host, span_notice("You have accepted being a willing host!"))
	GLOB.willing_hosts += cortical_owner.human_host.ckey
	StartCooldown()

#undef CHEMICALS_PER_UNIT
#undef CHEMICAL_SECOND_DIVISOR
