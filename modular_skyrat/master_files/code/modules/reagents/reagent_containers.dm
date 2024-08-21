/obj/item/reagent_containers/click_alt(mob/living/user)
	if(length(possible_transfer_amounts) <= 2) // If there's only two choices, just swap between them.
		change_transfer_amount(user, FORWARD)
		return CLICK_ACTION_SUCCESS
	var/transfer_amount = tgui_input_list(user, "Amount per transfer from this:", "[src]", possible_transfer_amounts, amount_per_transfer_from_this)
	if(isnull(transfer_amount))
		return NONE
	amount_per_transfer_from_this = transfer_amount
	to_chat(user, span_notice("[src]'s transfer amount is now [amount_per_transfer_from_this] unit\s."))
	return CLICK_ACTION_SUCCESS
