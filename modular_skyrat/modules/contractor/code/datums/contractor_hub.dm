/datum/contractor_hub
	/// How much reputation the contractor has
	var/contract_rep = 0
	/// What contractor items can be purchased
	var/list/hub_items = list()
	/// List of what the contractor's purchased
	var/list/purchased_items = list()
	/// Static of contractor_item subtypes
	var/static/list/contractor_items = subtypesof(/datum/contractor_item)
	/// Reference to the current contract datum
	var/datum/syndicate_contract/current_contract
	/// List of all contract datums the contractor has available
	var/list/datum/syndicate_contract/assigned_contracts = list()
	/// used as a blacklist to make sure we're not assigning targets already assigned
	var/list/assigned_targets = list()
	/// NUmber of how many contracts you've done
	var/contracts_completed = 0
	/// How many TC you've paid out in contracts
	var/contract_paid_out = 0
	/// Amount of TC that has yet to be redeemed
	var/contract_TC_to_redeem = 0

/datum/contractor_hub/proc/create_hub_items()
	for(var/path in contractor_items)
		var/datum/contractor_item/contractor_item = new path

		hub_items.Add(contractor_item)

/datum/contractor_hub/proc/create_contracts(datum/mind/owner)

	// 6 initial contracts
	var/list/to_generate = list(
		CONTRACT_PAYOUT_LARGE,
		CONTRACT_PAYOUT_MEDIUM,
		CONTRACT_PAYOUT_MEDIUM,
		CONTRACT_PAYOUT_SMALL,
		CONTRACT_PAYOUT_SMALL,
		CONTRACT_PAYOUT_SMALL
	)

	//What the fuck
	if(length(to_generate) > length(GLOB.data_core.locked))
		to_generate.Cut(1, length(GLOB.data_core.locked))

	// We don't want the sum of all the payouts to be under this amount
	var/lowest_TC_threshold = 30

	var/total = 0
	var/lowest_paying_sum = 0
	var/datum/syndicate_contract/lowest_paying_contract

	// Randomise order, so we don't have contracts always in payout order.
	to_generate = shuffle(to_generate)

	// Support contract generation happening multiple times
	var/start_index = 1
	if (assigned_contracts.len != 0)
		start_index = assigned_contracts.len + 1

	// Generate contracts, and find the lowest paying.
	for(var/i in 1 to to_generate.len)
		var/datum/syndicate_contract/contract_to_add = new(owner, assigned_targets, to_generate[i])
		var/contract_payout_total = contract_to_add.contract.payout + contract_to_add.contract.payout_bonus

		assigned_targets.Add(contract_to_add.contract.target)

		if (!lowest_paying_contract || (contract_payout_total < lowest_paying_sum))
			lowest_paying_sum = contract_payout_total
			lowest_paying_contract = contract_to_add

		total += contract_payout_total
		contract_to_add.id = start_index
		assigned_contracts.Add(contract_to_add)

		start_index++

	// If the threshold for TC payouts isn't reached, boost the lowest paying contract
	if (total < lowest_TC_threshold)
		lowest_paying_contract.contract.payout_bonus += (lowest_TC_threshold - total)
