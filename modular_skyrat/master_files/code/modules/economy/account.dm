/datum/bank_account
	/// If TRUE, then this account's payday is sent to the HoP for distribution.
	var/paid_by_hand = FALSE
	/// Averaged multiplier across the holder's selected backgrounds. Applied AFTER species multiplier.
	var/background_multiplier = 1

/datum/bank_account/payday(amount_of_paychecks, free)
	if(paid_by_hand && !free) // Paid by hand is only true in special circumstances, e.g, the illegal employment backgrounds.
		// These are free, and cargo is *paid* to ship their payment. Everyone benefits from illegal workers here.
		var/pay_amount = round(clamp(account_job.paycheck * payday_modifier, 0, PAYCHECK_CREW) * BASE_PAYCHECK_MULTIPLIER * background_multiplier)
		SSeconomy.paid_by_hand_bundle_count += rand(1, 3)
		SSeconomy.paid_by_hand_amount += pay_amount
		bank_card_talk("Your paycheck has been sent via shuttle. Please collect your approximately [pay_amount]cr paycheck at your nearest Head of Personel.") // Rough amount to allow for HoP skimming.
		return

	return ..()
