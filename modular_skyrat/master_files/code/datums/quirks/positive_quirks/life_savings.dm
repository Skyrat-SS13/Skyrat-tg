/datum/quirk/life_savings
    name = "Life Savings"
    desc = "Rich are getting richer. Either because of your smart investments or your broad connections you receive additional currency with each paycheck. Use them wisely or blow it all on drugs. They are yours after all."
    icon = FA_ICON_PIGGY_BANK
    value = 4
    hardcore_value = -4
    medical_record_text = "Patient may have a significant sum in their pocket. Maybe you should ask for some. It would be fair."
    mail_goodies = list(
        /obj/item/stack/spacecash/c100,
        /obj/item/stack/spacecash/c200,
        /obj/item/stack/spacecash/c500,
    )

/datum/quirk/life_savings/add_unique(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	if(!human_holder.account_id)
		return
	var/datum/bank_account/account = SSeconomy.bank_accounts_by_id["[human_holder.account_id]"]
	account.payday_modifier += 0.25

