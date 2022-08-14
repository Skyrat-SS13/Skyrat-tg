// GENERIC
/obj/item/card/id/advanced/silver/generic
	name = "generic silver identification card"
	icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	icon_state = "card_silvergen"
	assigned_icon_state = "assigned_silver"

/obj/item/card/id/advanced/gold/generic
	name = "generic gold identification card"
	icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	icon_state = "card_goldgen"
	assigned_icon_state = "assigned_gold"

// COLOURABLE
/obj/item/card/id/advanced/colourable
	name = "colourable identification card"
	desc = "A failed prototype for customizable ID cards, it looks.. strange." // Read: I'm too lazy to implement this properly
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


// SOLFED
/obj/item/card/id/advanced/solfed
	name = "solfed identification card"
	icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	icon_state = "card_solfed"
	assigned_icon_state = "assigned_solfed"
