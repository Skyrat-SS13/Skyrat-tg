/obj/item/air_refresher
	name = "air refresher"
	desc = "A bottle packed with sickly strong fragrance, with an easy to use pressurized release nozzle."
	icon = 'modular_skyrat/modules/pollution/icons/air_refresher.dmi'
	icon_state = "air_refresher"
	inhand_icon_state = "cleaner"
	worn_icon_state = "spraybottle"
	lefthand_file = 'icons/mob/inhands/equipment/custodial_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/custodial_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	item_flags = NOBLUDGEON
	var/uses_remaining = 20

/obj/item/air_refresher/examine(mob/user)
	. = ..()
	if(uses_remaining)
		. += "It has [uses_remaining] use\s left."
	else
		. += "It is empty."

/obj/item/air_refresher/afterattack(atom/attacked, mob/user, proximity)
	. = ..()
	if(.)
		return
	if(uses_remaining <= 0)
		to_chat(user, span_warning("\The [src] is empty!"))
		return TRUE
	uses_remaining--
	var/turf/aimed_turf = get_turf(attacked)
	aimed_turf.PolluteTurf(/datum/pollutant/fragrance/air_refresher, 200)
	user.visible_message(span_notice("[user] sprays the air around with \the [src]."), span_notice("You spray the air around with \the [src]."))
	user.changeNext_move(CLICK_CD_RANGE*2)
	playsound(aimed_turf, 'sound/effects/spray2.ogg', 50, TRUE, -6)
	return TRUE
