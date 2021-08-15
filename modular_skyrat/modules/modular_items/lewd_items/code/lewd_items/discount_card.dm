//Debug item, but plz leave it alone. It's unobtainable and could be used by me for some events. Or as reward from some weird god, who knows.
/obj/item/lustwish_discount
	name = "LustWish elite card"
	desc = "Strange card with a blue lamia on back side." //yes, this is card with my character on back side. Cameo.
	icon_state = "lustwish_discount"
	inhand_icon_state = "lustwish_discount"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	w_class = WEIGHT_CLASS_TINY

//code for showing that we have something IlLeGaL
/obj/item/lustwish_discount/attack_self(mob/user, modifiers)
	.=..()
	to_chat(loc, "<span class='notice'>[user] shows a lustwish elite card</span>")
	return
