// Is this all it takes for easy forgery without agent cards? Nice.
// Two non-modular edits to examine and examine_more.

// For name and age removals, /datum/computer_file/program/card_mod/ui_act and /obj/item/card/id/advanced/chameleon/attack_self were modified.

#define OPTION_YES "Yes"
#define OPTION_NO "No"

/obj/item/card/id/update_label()
	name = "[assignment] access card"
	// Done here cause update label is called literally every time it needs to change the ID name.
	// I'm not willing to introduce 50+ nonmodular changes, so this seems appropriate.
	registered_name = null
	registered_age = null

/obj/item/card/id/CtrlShiftClick(mob/user)
	..()
	if(!can_interact(user))
		return
	if(!registered_account)
		user.show_message(span_warning("There's no account assigned to this ID!"))
		return
	if(tgui_alert(user, "Reset the assigned account on this ID?", "Account Reset", list(OPTION_YES, OPTION_NO)) != OPTION_YES)
		return

	// clear_account is shitcode, and doesn't remove the card from bank_cards.
	registered_account.bank_cards -= src
	clear_account()

/obj/item/card/id/examine(mob/user)
	. = ..()

	if(!user.can_read(src))
		return

	if(registered_account)
		. += "To clear the account on this card, you can Ctrl-Shift-Click on the card to clear the attached account."

#undef OPTION_YES
#undef OPTION_NO
