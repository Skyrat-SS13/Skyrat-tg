#define ID_ACCOUNT_RESET_OPTION_YES "Yes"
#define ID_ACCOUNT_RESET_OPTION_NO "No"

// Backgrounds content start.
// Is this all it takes for easy forgery without agent cards? Nice.
// For name and age removals, /datum/computer_file/program/card_mod/ui_act, /obj/item/card/id/advanced/chameleon/attack_self and tgui\packages\tgui\interfaces\NtosCard.js were modified.

/obj/item/card/id
	desc = "A card used to determine access across the station."

/obj/item/card/id/advanced
	desc = "A card used to determine access across the station. Has an integrated digital display and advanced microchips."

/datum/design/id
	desc = "A card used to determine access across the station. Has an integrated digital display and advanced microchips."

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
	if(tgui_alert(user, "Reset the assigned account on this ID?", "Account Reset", list(ID_ACCOUNT_RESET_OPTION_YES, ID_ACCOUNT_RESET_OPTION_NO)) != ID_ACCOUNT_RESET_OPTION_YES)
		return

	// clear_account is shitcode, and doesn't remove the card from bank_cards.
	registered_account.bank_cards -= src
	clear_account()

/obj/item/card/id/examine_more(mob/user)
	. = ..()

	if(!user.can_read(src))
		return

	if(registered_account)
		. += span_info("To clear the attached account from this card, you can Ctrl-Shift-Click on the card.")

// Backgrounds content end.

// GENERIC
/obj/item/card/id/advanced/silver/generic
	name = "generic silver access card"
	icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	icon_state = "card_silvergen"
	assigned_icon_state = "assigned_silver"

/obj/item/card/id/advanced/gold/generic
	name = "generic gold access card"
	icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	icon_state = "card_goldgen"
	assigned_icon_state = "assigned_gold"

// COLOURABLE
/obj/item/card/id/advanced/colourable
	name = "colourable access card"
	desc = "A failed prototype for customizable access cards, it looks.. strange." // Read: I'm too lazy to implement this properly
	icon_state = "id_card"
	assigned_icon_state = null // Built into the sprite itself.
	greyscale_config = /datum/greyscale_config/id_card
	greyscale_colors = "#FF0000#00FF00#0000FF"

/obj/item/card/id/advanced/colourable/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/gags_recolorable)

/obj/item/card/id/advanced/colourable/examine(mob/user)
	. = ..()
	. += span_info("You could change its colours with a <b>spray can</b>!")

// DS2
/obj/item/card/id/advanced/prisoner/ds2
	name = "syndicate prisoner card"
	icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	icon_state = "card_ds2prisoner"

// SOLFED
/obj/item/card/id/advanced/solfed
	name = "solfed access card"
	icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	icon_state = "card_solfed"
	assigned_icon_state = "assigned_solfed"

#undef ID_ACCOUNT_RESET_OPTION_YES
#undef ID_ACCOUNT_RESET_OPTION_NO
