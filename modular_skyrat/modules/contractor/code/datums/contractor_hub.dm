/datum/contractor_hub
	/// How much reputation the contractor has
	var/contract_rep = 0
	/// What contractor items can be purchased
	var/list/hub_items = list()
	/// List of what the contractor's purchased
	var/list/purchased_items = list()
	/// Static of contractor_item subtypes
	var/static/list/contractor_items = typecacheof(/datum/contractor_item, ignore_root_path = TRUE)
	/// Current index number for contract IDs
	var/start_index = 1

/// Generates a list of all valid hub items to set for purchase
/datum/contractor_hub/proc/create_hub_items()
	for(var/path in contractor_items)
		var/datum/contractor_item/contractor_item = new path

		hub_items.Add(contractor_item)

/datum/contractor_hub/proc/create_single_contract(datum/mind/owner, contract_payout_tier)
	var/datum/syndicate_contract/contract_to_add = new(owner, assigned_targets, contract_payout_tier)

	assigned_targets.Add(contract_to_add.contract.target)

	contract_to_add.id = start_index
	assigned_contracts.Add(contract_to_add)
	start_index++
