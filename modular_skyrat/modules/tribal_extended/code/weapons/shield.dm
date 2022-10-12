/obj/item/shield/riot/goliath
	name = "goliath shield"
	desc = "A shield made from interwoven plates of goliath hide."
	icon = 'modular_skyrat/modules/tribal_extended/icons/shields.dmi'
	icon_state = "goliath_shield"
	lefthand_file = 'modular_skyrat/modules/tribal_extended/icons/shields_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/tribal_extended/icons/shields_righthand.dmi'
	worn_icon = 'modular_skyrat/modules/tribal_extended/icons/back.dmi'
	worn_icon_state = "goliath_shield"
	inhand_icon_state = "goliath_shield"
	transparent = FALSE
	max_integrity = 200
	w_class = WEIGHT_CLASS_BULKY

/obj/item/shield/riot/goliath/shatter(mob/living/carbon/human/owner)
	playsound(owner, 'sound/effects/bang.ogg', 50)
	new /obj/item/stack/sheet/animalhide/goliath_hide(get_turf(src))
	qdel(src)
