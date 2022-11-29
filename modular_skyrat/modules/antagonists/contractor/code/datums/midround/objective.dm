/datum/objective/contractor_total
	name = "contractor"
	explanation_text = "Complete at least %CONTRACTNUM% contract%S%."
	martyr_compatible = TRUE
	/// How many contracts are needed, rand(1, 3)
	var/contracts_needed

/datum/objective/contractor_total/New(text)
	. = ..()
	contracts_needed = rand(1, 3)
	explanation_text = replacetext(explanation_text, "%CONTRACTNUM%", contracts_needed)
	explanation_text = replacetext(explanation_text, "%S%", (contracts_needed > 1 ? "s" : ""))

/datum/objective/contractor_total/check_completion()
	if(owner?.opposing_force?.contractor_hub.contracts_completed >= contracts_needed)
		return TRUE
	return FALSE
