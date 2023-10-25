/datum/quirk/ration_system
	name = "Ration Ticket Receiver"
	desc = "Due to some circumstance of your life, you have enrolled in the ration tickets program, \
		which will halve all of your paychecks in exchange for granting you ration tickets, which can be \
		redeemed at a cargo console for food and other items."
	icon = FA_ICON_DONATE
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_HIDE_FROM_SCAN
	value = 0
	medical_record_text = "Alas, the patient struggled to scrape together enough money to pay the checkup bill."
	hardcore_value = 0

/datum/quirk/ration_system/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(!human_holder.account_id)
		return
	var/datum/bank_account/account = SSeconomy.bank_accounts_by_id["[human_holder.account_id]"]
	account.payday_modifier = 0.5
	account.gets_ration_tickets = TRUE
	to_chat(client_source.mob, span_warning("You remember, you can turn in the ration tickets your paychecks give you to a cargo console for things! Neat!"))

// Edits to bank accounts to make the above possible

/datum/bank_account
	/// Variable that tracks if this account should get ration tickets each payday
	var/gets_ration_tickets = FALSE

/datum/bank_account/payday(amount_of_paychecks, free = FALSE)
	if(!(..() && gets_ration_tickets))
		return
	make_ration_ticket()

/// Attempts to create a ration ticket book in the card holder's hand, and failing that, the drop location of the card
/datum/bank_account/proc/make_ration_ticket()
	if(!bank_cards.len)
		return
	var/obj/item/created_ticket
	for(var/obj/card in bank_cards)
		// We want to only make one ticket pr account per payday
		if(created_ticket)
			continue
		var/mob/card_holder = recursive_loc_check(card, /mob)
		if(!card_holder)
			continue
		created_ticket = new /obj/item/paper/paperslip/ration_ticket(card_holder.drop_location())
		if(ishuman(card_holder)) //If on a mob
			var/mob/living/carbon/human/human_card_holder = card_holder
			human_card_holder.put_in_hands(created_ticket)
