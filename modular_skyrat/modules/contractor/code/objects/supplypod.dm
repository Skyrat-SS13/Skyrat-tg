/obj/structure/closet/supplypod/extractionpod
	var/datum/contractor_hub/contract_hub
	var/datum/syndicate_contract/tied_contract
	var/recieving = FALSE

/obj/structure/closet/supplypod/extractionpod/Destroy()
	if(!recieving)
		return ..()
	to_chat(tied_contract.contract.owner, "<BR>[span_userdanger("Extraction pod destroyed. Contract aborted.")]")
	var/contract_id = tied_contract.id
	if (contract_hub.current_contract == tied_contract)
		contract_hub.current_contract = null
	tied_contract = null
	contract_hub.assigned_contracts[contract_id].status = CONTRACT_STATUS_ABORTED
	if (contract_hub.current_contract == tied_contract)
		contract_hub.current_contract = null
	contract_hub = null
	return ..()

/obj/structure/closet/supplypod/extractionpod/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	if(recieving && (atom_integrity <= 0))
		to_chat(tied_contract.contract.owner, "<BR>[span_userdanger("Extraction pod destroyed. Contract aborted.")]")
		var/contract_id = tied_contract.id
		if (contract_hub.current_contract == tied_contract)
			contract_hub.current_contract = null
		tied_contract = null
		contract_hub.assigned_contracts[contract_id].status = CONTRACT_STATUS_ABORTED
		if (contract_hub.current_contract == tied_contract)
			contract_hub.current_contract = null
		contract_hub = null
	return ..()
