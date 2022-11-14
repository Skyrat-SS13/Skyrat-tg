//We cap max disease symptoms at 5
//and we only add symptoms every 30 minutes instead of 10, since our rounds are longer
/datum/round_event/disease_outbreak/advanced/start()
	var/datum/round_event_control/disease_outbreak/advanced/disease_event = control
	afflicted += disease_event.disease_candidates
	disease_event.disease_candidates.Cut() //Clean the list after use

	if(disease_event.chosen_max_symptoms)
		max_symptoms = disease_event.chosen_max_symptoms
		disease_event.chosen_max_symptoms = null
	else
		max_symptoms = 3 + max(FLOOR((world.time - control.earliest_start)/18000, 1),0) //3 symptoms at 20 minutes, plus 1 per 30 minutes.
		max_symptoms = clamp(max_symptoms, 3, 5) //Capping the virus symptoms prevents the event from becoming "smite one poor player with an -12 transmission hell virus" after a certain round length.

	if(disease_event.chosen_severity)
		max_severity = disease_event.chosen_severity
		disease_event.chosen_severity = null
	else
		max_severity = 3 + max(FLOOR((world.time - control.earliest_start)/18000, 1),0) //Max severity doesn't need clamping

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
