//We cap max disease symptoms at 3 at a preset severity, making them transmissible no matter our round length.
/datum/round_event/disease_outbreak/advanced/start()
	var/datum/round_event_control/disease_outbreak/advanced/disease_event = control
	afflicted += disease_event.disease_candidates
	disease_event.disease_candidates.Cut() //Clean the list after use

	if(disease_event.chosen_max_symptoms)
		max_symptoms = disease_event.chosen_max_symptoms
		disease_event.chosen_max_symptoms = null
	else
		max_symptoms = 3 //Consistent symptoms taking into account severity

	if(disease_event.chosen_severity)
		max_severity = disease_event.chosen_severity
		disease_event.chosen_severity = null
	else
		max_severity = 4 //Don't make it too severe or it won't have transmissibility

	var/datum/disease/advance/advanced_disease = new /datum/disease/advance/random(max_symptoms, max_severity)

	var/list/name_symptoms = list() //for feedback
	for(var/datum/symptom/new_symptom in advanced_disease.symptoms)
		name_symptoms += new_symptom.name

	var/mob/living/carbon/human/victim = pick_n_take(afflicted)
	if(victim.ForceContractDisease(advanced_disease, FALSE))
		message_admins("An event has triggered a random advanced virus outbreak on [ADMIN_LOOKUPFLW(victim)]! It has these symptoms: [english_list(name_symptoms)]")
		log_game("An event has triggered a random advanced virus outbreak on [key_name(victim)]! It has these symptoms: [english_list(name_symptoms)].")
		announce_to_ghosts(victim)
	else
		log_game("An event attempted to trigger a random advanced virus outbreak on [key_name(victim)], but failed.")
