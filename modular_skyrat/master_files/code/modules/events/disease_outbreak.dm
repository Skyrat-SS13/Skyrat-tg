#define EVENT_MIN_SYMPTOMS 3
#define EVENT_MAX_SYMPTOMS 4

// We pick symptoms from a defined list (removing the really bad ones like deafness, blindness, spontaneous combustion etc.)
/datum/round_event/disease_outbreak/advanced/start()
	var/datum/round_event_control/disease_outbreak/advanced/disease_event = control
	afflicted += disease_event.disease_candidates
	disease_event.disease_candidates.Cut() // Clean the list after use

	if(disease_event.chosen_max_symptoms)
		max_symptoms = disease_event.chosen_max_symptoms
		disease_event.chosen_max_symptoms = null
	else
		max_symptoms = rand(EVENT_MIN_SYMPTOMS,EVENT_MAX_SYMPTOMS) // Pick how many symptoms

	if(disease_event.chosen_severity)
		max_severity = disease_event.chosen_severity
		disease_event.chosen_severity = null
	else
		max_severity = 5 // Don't make it too severe

	var/datum/disease/advance/advanced_disease = new /datum/disease/advance/random/event(max_symptoms, max_severity)

	var/list/name_symptoms = list() // For feedback
	for(var/datum/symptom/new_symptom in advanced_disease.symptoms)
		name_symptoms += new_symptom.name

	var/mob/living/carbon/human/victim = pick_n_take(afflicted)
	if(victim.ForceContractDisease(advanced_disease, FALSE))
		message_admins("An event has triggered a random advanced virus outbreak on [ADMIN_LOOKUPFLW(victim)]! It has these symptoms: [english_list(name_symptoms)]. Transmissibility is [advanced_disease.spread_text].")
		log_game("An event has triggered a random advanced virus outbreak on [key_name(victim)]! It has these symptoms: [english_list(name_symptoms)].")
		announce_to_ghosts(victim)
	else
		log_game("An event attempted to trigger a random advanced virus outbreak on [key_name(victim)], but failed.")

/datum/disease/advance/random/event
	name = "Experimental Disease"
	copy_type = /datum/disease/advance

/datum/round_event/disease_outbreak/setup()
	announce_when = 75

// Pick the symptoms of the generated virus.
/datum/disease/advance/random/event/New(max_symptoms, max_level = 6)
	if(!max_symptoms)
		max_symptoms = rand(1, VIRUS_SYMPTOM_LIMIT)
	var/list/datum/symptom/possible_symptoms = list(
		/datum/symptom/chills,
		/datum/symptom/choking,
		/datum/symptom/confusion,
		/datum/symptom/cough,
		/datum/symptom/disfiguration,
		/datum/symptom/dizzy,
		/datum/symptom/fever,
		/datum/symptom/flesh_eating,
		/datum/symptom/hallucigen,
		/datum/symptom/headache,
		/datum/symptom/narcolepsy,
		/datum/symptom/polyvitiligo,
		/datum/symptom/sneeze,
		/datum/symptom/vomit,
		/datum/symptom/weight_loss,
	)

	for(var/i in 1 to max_symptoms)
		var/datum/symptom/chosen_symptom = pick_n_take(possible_symptoms)
		if(chosen_symptom)
			var/datum/symptom/new_symptom = new chosen_symptom
			symptoms += new_symptom
	Refresh()

	name = "Sample #[rand(1,10000)]"

// Assign the properties for the virus
/datum/disease/advance/random/event/AssignProperties()
	visibility_flags |= HIDDEN_SCANNER
	var/transmissibility = rand(1, 10)
	addtimer(CALLBACK(src, PROC_REF(MakeVisible)), 140 SECONDS) // One life loop is 2 seconds, so this number is double announce_when

	if(properties?.len)
		spreading_modifier = max(CEILING(0.4 * properties["transmittable"], 1), 1)
		cure_chance = clamp(7.5 - (0.5 * properties["resistance"]), 5, 10) // Can be between 5 and 10
		stage_prob = max(0.5 * properties["stage_rate"], 1)
		SetSeverity(properties["severity"])
		GenerateCure(properties)
		if(severity == DISEASE_SEVERITY_DANGEROUS)
			SetSpread(DISEASE_SPREAD_CONTACT_SKIN)

		else if(transmissibility == 10)
			SetSpread(DISEASE_SPREAD_AIRBORNE)

		else if(transmissibility >= 3)
			SetSpread(DISEASE_SPREAD_CONTACT_SKIN)

		else
			SetSpread(DISEASE_SPREAD_CONTACT_FLUIDS)
	else
		CRASH("Our properties were empty or null!")

// Reveal the virus when the level 7 announcement happens
/datum/disease/advance/random/event/proc/MakeVisible()
	visibility_flags &= ~HIDDEN_SCANNER

// Assign the spread type and give it the correct description
/datum/disease/advance/random/event/SetSpread(spread_id)
	switch(spread_id)
		if(DISEASE_SPREAD_CONTACT_FLUIDS)
			spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_FLUIDS
			spread_text = "Fluids"
		if(DISEASE_SPREAD_CONTACT_SKIN)
			spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_FLUIDS | DISEASE_SPREAD_CONTACT_SKIN
			spread_text = "On contact"
		if(DISEASE_SPREAD_AIRBORNE)
			spread_flags = DISEASE_SPREAD_BLOOD | DISEASE_SPREAD_CONTACT_FLUIDS | DISEASE_SPREAD_CONTACT_SKIN | DISEASE_SPREAD_AIRBORNE
			spread_text = "Airborne"

// Select 1 of 5 groups of potential cures
/datum/disease/advance/random/event/GenerateCure()
	if(properties?.len)
		var/res = rand(1, 5)
		if(res == oldres)
			return
		cures = list(pick(advance_cures[res]))
		oldres = res
		// Get the cure name from the cure_id
		var/datum/reagent/cure = GLOB.chemical_reagents_list[cures[1]]
		cure_text = cure.name

#undef EVENT_MIN_SYMPTOMS
#undef EVENT_MAX_SYMPTOMS
