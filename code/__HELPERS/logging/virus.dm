/// Logging for the creation and contraction of viruses
/proc/log_virus(text, list/data)
	logger.Log(LOG_CATEGORY_VIRUS, text, data)

/// Returns a string for admin logging uses, should describe the disease in detail
/datum/disease/proc/admin_details()
	return "[src.name] : [src.type]"

/// Describes this disease to an admin in detail (for logging)
/datum/disease/advance/admin_details()
	var/list/name_symptoms = list()
	for(var/datum/symptom/S in symptoms)
		name_symptoms += S.name
	return "[name] - sym: [english_list(name_symptoms)] re:[totalResistance()] st:[totalStealth()] ss:[totalStageSpeed()] tr:[totalTransmittable()]"
