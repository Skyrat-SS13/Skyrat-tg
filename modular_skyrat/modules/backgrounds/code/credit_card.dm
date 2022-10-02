/obj/item/card/id/credit_card
	name = "unassigned credit card"
	desc = "Provides access to the assigned credit account."
	icon = 'modular_skyrat/modules/backgrounds/icons/credit_cards.dmi'
	icon_state = "credit_card_generic"
	registered_age = null

/obj/item/card/id/credit_card/update_label()
	if(!registered_account)
		name = initial(name)
		return

	var/account_holder = registered_account.account_holder
	var/length = length(registered_account.account_holder)

	name = "[account_holder][findtext(account_holder, "s", length, length) ? "'" : "'s"] credit card"
