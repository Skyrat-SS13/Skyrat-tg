/// End-round generation proc
/datum/opposing_force/proc/contractor_round_end()
	var/result = ""
	var/total_spent_rep = 0

	var/completed_contracts = contractor_hub.contracts_completed
	var/tc_total = contractor_hub.contract_TC_payed_out + contractor_hub.contract_TC_to_redeem

	var/contractor_item_icons = "" // Icons of purchases
	var/datum/antagonist/traitor/contractor_support/contractor_support_unit = contractor_hub.contractor_teammate // Set if they had a support unit

	// Get all the icons/total cost for all our items bought
	for (var/datum/contractor_item/contractor_purchase in contractor_hub.purchased_items)
		contractor_item_icons += "<span class='tooltip_container'>\[ <i class=\"fas [contractor_purchase.item_icon]\"></i><span class='tooltip_hover'><b>[contractor_purchase.name] - [contractor_purchase.cost] Rep</b><br><br>[contractor_purchase.desc]</span> \]</span>"

		total_spent_rep += contractor_purchase.cost

	if (length(contractor_hub.purchased_items))
		result += "<br>(used [total_spent_rep] Rep) "
		result += contractor_item_icons
	result += "<br>"
	if (completed_contracts > 0)
		var/plural_check = "contract[completed_contracts > 1 ? "s" : ""]"

		result += "Completed [span_greentext("[completed_contracts]")] [plural_check] for a total of \
					[span_greentext("[tc_total] TC")]!<br>"

	if(contractor_support_unit)
		var/datum/mind/partner = contractor_support_unit.owner
		result += "<b>[partner.key]</b> played <b>[partner.current.name]</b>, [partner.current.p_their()] contractor support unit.<br>"

	return result
