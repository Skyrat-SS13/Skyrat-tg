// Is this all it takes for easy forgery without agent cards? Nice.
// Two non-modular edits to inspect and inspect_more.

#define OPTION_YES "Yes"
#define OPTION_NO "No"

/obj/item/card/id/update_label()
	name = "[assignment] access card"

/obj/item/card/id/CtrlShiftClick(mob/user)
	..()
	if(!registered_account || !can_interact(user) || tgui_alert(user, "Reset the assigned account on this ID?", "Account Reset", list(OPTION_YES, OPTION_NO)) != OPTION_YES)
		return

	// clear_account is shitcode, and doesn't remove the card from bank_cards.
	registered_account.bank_cards -= src
	clear_account()

/obj/item/card/id/examine(mob/user)
	. = ..()

	if(!user.can_read(src))
		return

	if(registered_account)
		. += "To clear the account on this card, you can Ctrl-Alt-Click on the card to clear the attached account."

#undef OPTION_YES
#undef OPTION_NO
