/obj/item/crucifix
	name = "ornate crucifix"
	desc = "An ornate golden crucifix, adorned with various gemstones and tiny carvings. For some reason, it always feels warm to the touch."
	icon = 'modular_skyrat/modules/modular_items/icons/obj/items/crucifix.dmi'
	icon_state = "cross_ornate"
	lefthand_file = 'modular_skyrat/modules/modular_items/icons/mob/objmelee_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/icons/mob/objmelee_righthand.dmi'
	force = 1 //Bashing someone with a cross is not only blasphemy, but pretty useless all things considered.
	throw_speed = 3
	throw_range = 4
	throwforce = 5 //Throwing it is slightly better, because a metal object with gems flying at your face through the air is going to hurt. A lot.
	w_class = WEIGHT_CLASS_TINY

/obj/item/crucifix/Initialize()
	. = ..()
	AddComponent(/datum/component/anti_magic, FALSE, TRUE, FALSE, ITEM_SLOT_HANDS, null, FALSE) //Its a cross, so of course its Holy.
